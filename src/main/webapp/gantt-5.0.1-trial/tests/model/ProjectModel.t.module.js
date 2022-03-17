import { ProjectModel, StringHelper, TaskModel, TaskStore } from '../../build/gantt.module.js?457330';

describe(t => {

    let consoleMessages,
        consoleSpy,
        project;

    t.beforeEach(function() {
        ProjectModel.destroy(project);
        consoleSpy?.remove();
    });

    function initConsoleSpy(t) {
        consoleMessages = [];
        consoleSpy = t.spyOn(console, 'warn').and.callFake(m => consoleMessages.push(m));
    }

    // Helper that builds a regexp based on the passed array of lines
    function buildLinesRegExp(lines) {
        return new RegExp(StringHelper.escapeRegExp(lines.join('\n')).replace(/\s+/g, '\\s*').replace(/XXX/g, '\\S+'));
    }

    function getProjectData() {
        return {
            tasksData : [{
                startDate    : new Date(2020, 11, 21),
                duration     : 10,
                durationUnit : 'd'
            }]
        };
    }

    // https://github.com/bryntum/support/issues/3612
    t.it('Should apply taskModelClass/taskStoreClass from defaultConfig', t => {
        class MyTaskModel extends TaskModel {}

        class MyStore extends TaskStore {}

        class MyProjectModel extends ProjectModel {
            static get defaultConfig() {
                return {
                    taskModelClass : MyTaskModel,
                    taskStoreClass : MyStore
                };
            }
        }
        project = new MyProjectModel();

        t.is(project.taskModelClass, MyTaskModel, 'project taskModelClass when applied from defaultConfig');
        t.is(project.eventModelClass, MyTaskModel, 'eventModelClass is equal to taskModelClass when applied from defaultConfig');
        t.is(project.taskStoreClass, MyStore, 'taskStoreClass is applied from defaultConfig');
        t.is(project.eventStoreClass, MyStore, 'eventStoreClass is equal to taskStoreClass when applied from defaultConfig');
        t.isInstanceOf(project.taskStore, MyStore, 'task store class is correct');
    });

    // https://github.com/bryntum/support/issues/3549
    t.it('Should support resetting STM queues after load ', async t => {
        const project = new ProjectModel({
            resetUndoRedoQueuesAfterLoad : true
        });

        await project.loadInlineData({
            eventsData : [{
                id   : 1,
                name : 'foo'
            }]
        });

        const stm = project.getStm();

        stm.disabled   = false;
        stm.autoRecord = true;

        project.taskStore.getById(1).name = 'bar';
        await t.waitFor(() => stm.queue.length === 1);

        t.is(stm.queue.length, 1, 'One transaction');

        await project.loadInlineData(getProjectData());
        t.is(stm.queue.length, 0, 'Queue reset');
    });

    t.it('Setting and getting inlineData', async t => {
        const testData = {
            resourcesData : [
                { id : 1, name : 'resource 1' },
                { id : 2, name : 'resource 2' },
                { id : 3, name : 'resource 3' },
                { id : 4, name : 'resource 4' },
                { id : 5, name : 'resource 5' }
            ],
            eventsData : [
                { id : 1, name : 'event 1' },
                { id : 2, name : 'event 2' },
                { id : 3, name : 'event 3' },
                { id : 4, name : 'event 4' },
                { id : 5, name : 'event 5' },
                { id : 6, name : 'event 6' },
                { id : 7, name : 'event 7' },
                { id : 8, name : 'event 8' }
            ],
            assignmentsData : [
                { id : 1, eventId : 1, resourceId : 1 },
                { id : 2, eventId : 1, resourceId : 2 },
                { id : 3, eventId : 1, resourceId : 5 },
                { id : 4, eventId : 2, resourceId : 2 },
                { id : 5, eventId : 3, resourceId : 3 },
                { id : 6, eventId : 4, resourceId : 3 },
                { id : 7, eventId : 5, resourceId : 3 },
                { id : 8, eventId : 5, resourceId : 4 },
                { id : 9, eventId : 6, resourceId : 2 },
                { id : 10, eventId : 7, resourceId : 5 },
                { id : 11, eventId : 8, resourceId : 4 }
            ],
            dependenciesData : [
                { id : 1, from : 1, to : 5 },
                { id : 2, from : 2, to : 4 }
            ]
        };

        project = new ProjectModel();

        // Populate the stores
        project.inlineData = testData;

        // Get data back
        const inlineData = project.inlineData;

        // Check data
        t.isDeeply(inlineData.eventsData.map(event => {
            return { id : event.id, name : event.name };
        }), testData.eventsData, 'Events OK');
        t.isDeeply(inlineData.resourcesData, testData.resourcesData, 'Resources OK');
        t.isDeeply(inlineData.assignmentsData.map(assignment => {
            return { id : assignment.id, eventId : assignment.eventId, event : assignment.eventId, resourceId : assignment.resourceId, resource : assignment.resourceId };
        }), testData.assignmentsData, 'Assignments OK');
        t.isDeeply(inlineData.dependenciesData.map(dependency => {
            return { id : dependency.id, from : dependency.from, fromEvent : dependency.from, to : dependency.to, toEvent : dependency.to };
        }), testData.dependenciesData, 'Dependencies OK');

    });

    t.it('Should not fire progress event by default when not delaying calculations', async t => {
        project = new ProjectModel({ delayCalculation : false });

        t.wontFire(project, 'progress', 'Progress is not fired');

        await project.loadInlineData(getProjectData());
    });

    t.it('Should fire progress event by default', async t => {
        project = new ProjectModel();

        t.firesOk(project, {
            progress : '>0'
        });

        await project.loadInlineData(getProjectData());
    });

    // https://github.com/bryntum/support/issues/2668
    t.it('Should warn when load response format is incorrect', async t => {
        initConsoleSpy(t);

        project = new ProjectModel({
            transport : {
                load : {
                    url : 'load'
                }
            },
            validateResponse : true
        });

        t.mockUrl('load', {
            responseText : JSON.stringify({
                assignments : {
                    rows : [{
                        resourceId : 1,
                        eventId    : 1
                    }]
                },
                myTasks : {
                    rows : [{
                        id   : 1,
                        name : 'Task'
                    }]
                },
                resources : {
                    rows : [{
                        id   : 1,
                        name : 'Man'
                    }]
                }
            })
        });

        await project.load();

        t.like(consoleMessages.shift(),
            buildLinesRegExp([
                'Project load response error(s):',
                '- No "tasks" store section found. It should contain the store data.',
                'Please adjust your response to look like this:',
                '{',
                '    "tasks": {',
                '        "rows": [',
                '            ...',
                '        ]',
                '    }',
                '}',
                'Note: To disable this validation please set the "validateResponse" config to false'
            ]),
            'Correct warn message shown.'
        );

        t.mockUrl('load', {
            responseText : JSON.stringify({
                assignments : {
                    rows : [{
                        resourceId : 1,
                        eventId    : 1
                    }]
                },
                tasks : {
                    data : [{
                        id   : 1,
                        name : 'Task'
                    }]
                },
                resources : {
                    rows : [{
                        id   : 1,
                        name : 'Man'
                    }]
                }
            })
        });

        await project.load();

        t.like(consoleMessages.shift(),
            buildLinesRegExp([
                'Project load response error(s):',
                '- "tasks" store section should have a "rows" property with an array of the store records.',
                'Please adjust your response to look like this:',
                '{',
                '    "tasks": {',
                '        "rows": [',
                '            ...',
                '        ]',
                '    }',
                '}',
                'Note: To disable this validation please set the "validateResponse" config to false'
            ]),
            'Correct warn message shown.'
        );

        t.mockUrl('load', {
            responseText : JSON.stringify({
                assignments : {
                    rows : [{
                        resourceId : 1,
                        eventId    : 1
                    }]
                },
                tasks : {
                    rows : [{
                        id   : 1,
                        name : 'Task'
                    }]
                },
                resources : {
                    data : [{
                        id   : 1,
                        name : 'Man'
                    }]
                }
            })
        });

        await project.load();

        t.like(consoleMessages.shift(),
            buildLinesRegExp([
                'Project load response error(s):',
                '- "resources" store section should have a "rows" property with an array of the store records.',
                'Please adjust your response to look like this:',
                '{',
                '    "resources": {',
                '        "rows": [',
                '            ...',
                '        ]',
                '    }',
                '}',
                'Note: To disable this validation please set the "validateResponse" config to false'
            ]),
            'Correct warn message shown.'
        );
    });

    // https://github.com/bryntum/support/issues/2668
    t.it('Should warn when sync response format is incorrect', async t => {
        initConsoleSpy(t);

        t.mockUrl('load', {
            responseText : JSON.stringify({
                assignments : {
                    rows : [{
                        resourceId : 1,
                        eventId    : 1
                    }]
                },
                tasks : {
                    rows : [{
                        id   : 1,
                        name : 'Task'
                    }]
                },
                resources : {
                    rows : [{
                        id   : 1,
                        name : 'Man'
                    }]
                }
            })
        });

        project = new ProjectModel({
            transport : {
                load : {
                    url : 'load'
                },
                sync : {
                    url : 'sync'
                }
            },
            validateResponse : true
        });

        const { taskStore } = project;

        await project.load();

        t.mockUrl('sync', {
            responseText : JSON.stringify({
                success : true,
                type    : 'sync',
                tasks   : [{
                    id   : 1,
                    name : 'Task'
                }]
            })
        });

        taskStore.first.name = 'bar';

        await project.sync();

        t.like(consoleMessages.shift(),
            buildLinesRegExp([
                'Project sync response error(s):',
                '- "tasks" store section should be an Object.',
                'Please adjust your response to look like this:',
                '{',
                '    "tasks": {',
                '        ,,,',
                '    }',
                '}',
                'Note: To disable this validation please set the "validateResponse" config to false'
            ]),
            'Correct warn message shown.'
        );

        t.mockUrl('sync', {
            responseText : JSON.stringify({
                success : true,
                type    : 'sync',
                tasks   : {
                    data : [{
                        id   : 1,
                        name : 'Task'
                    }]
                }
            })
        });

        taskStore.add({});

        await project.sync();

        t.like(
            consoleMessages.shift(),
            buildLinesRegExp([
                'Project sync response error(s):',
                '- "tasks" store "rows" section should mention added record(s) #XXX sent in the request. It should contain the added records identifiers (both phantom and "real" ones assigned by the backend).',
                'Please adjust your response to look like this:',
                '{',
                '    "tasks": {',
                '        "rows": [',
                '            {',
                '                "$PhantomId": XXX,',
                '                "id": ...',
                '            }',
                '        ]',
                '    }',
                '}',
                'Note: To disable this validation please set the "validateResponse" config to false'
            ]),
            'Correct warn message shown.'
        );
    });

    // https://github.com/bryntum/support/issues/2668
    t.it('Should warn when sync response format is incorrect and supportShortSyncResponse is false', async t => {
        t.mockUrl('load', {
            responseText : JSON.stringify({
                success     : true,
                type        : 'load',
                assignments : {
                    rows : [{
                        resourceId : 1,
                        eventId    : 1
                    }]
                },
                tasks : {
                    rows : [{
                        id   : 1,
                        name : 'Task'
                    }]
                },
                resources : {
                    rows : [{
                        id   : 1,
                        name : 'Man'
                    }]
                }
            })
        });

        initConsoleSpy(t);

        project = new ProjectModel({
            supportShortSyncResponse : false,
            transport                : {
                load : {
                    url : 'load'
                },
                sync : {
                    url : 'sync'
                }
            },
            validateResponse : true
        });

        const { taskStore } = project;

        await project.load();

        t.mockUrl('sync', {
            responseText : JSON.stringify({
                tasks : [{
                    id   : 1,
                    name : 'Task'
                }]
            })
        });

        taskStore.add({});

        await project.sync();

        t.like(consoleMessages.shift(),
            buildLinesRegExp([
                'Project sync response error(s):',
                '- "tasks" store "rows" section should mention added record(s) #XXX sent in the request. It should contain the added records identifiers (both phantom and "real" ones assigned by the backend).',
                'Please adjust your response to look like this:',
                '{',
                '    "tasks": {',
                '        "rows": [',
                '            {',
                '                "$PhantomId": XXX,',
                '                "id": ...',
                '            },',
                '            ...',
                '        ]',
                '    }',
                '}',
                'Note: To disable this validation please set the "validateResponse" config to false'
            ]),
            'Correct warn message shown.'
        );

        project.revertChanges();

        taskStore.first.name = 'bar';

        await project.sync();

        t.like(consoleMessages.shift(),
            buildLinesRegExp([
                'Project sync response error(s):',
                '- "tasks" store "rows" section should mention updated record(s) #XXX sent in the request. It should contain the updated record identifiers.',
                'Please adjust your response to look like this:',
                '{',
                '    "tasks": {',
                '        "rows": [',
                '            {',
                '                "id": XXX',
                '            },',
                '            ...',
                '        ]',
                '    }',
                '}',
                'Note: Please consider enabling "supportShortSyncResponse" option to allow less detailed sync responses (https://bryntum.com/docs/gantt/api/Gantt/model/ProjectModel#config-supportShortSyncResponse)',
                'Note: To disable this validation please set the "validateResponse" config to false'
            ]),
            'Correct warn message shown.'
        );

        project.revertChanges();

        t.mockUrl('sync', {
            responseText : JSON.stringify({
                success : true,
                type    : 'sync',
                tasks   : {
                    deleted : [{
                        id   : 1,
                        name : 'Task'
                    }]
                }
            })
        });

        taskStore.remove(taskStore.first);

        await project.sync();

        t.like(consoleMessages.shift(),
            buildLinesRegExp([
                'Project sync response error(s):',
                '- "tasks" store "removed" section should mention removed record(s) #XXX sent in the request. It should contain the removed record identifiers.',
                'Please adjust your response to look like this:',
                '{',
                '    "tasks": {',
                '        "removed": [',
                '            {',
                '                "id": XXX',
                '            },',
                '            ...',
                '        ]',
                '    }',
                '}',
                'Note: Please consider enabling "supportShortSyncResponse" option to allow less detailed sync responses (https://bryntum.com/docs/gantt/api/Gantt/model/ProjectModel#config-supportShortSyncResponse)',
                'Note: To disable this validation please set the "validateResponse" config to false'
            ]),
            'Correct warn message shown.'
        );
    });

    // https://github.com/bryntum/support/issues/2668
    t.it('Should not warn when response format is incorrect if validateResponse is false', async t => {
        t.mockUrl('load', {
            responseText : JSON.stringify({
                success     : true,
                type        : 'load',
                assignments : {
                    rows : [{
                        resourceId : 1,
                        eventId    : 1
                    }]
                },
                tasks : {
                    rows : [{
                        id   : 1,
                        name : 'Task'
                    }]
                },
                resources : {
                    rows : [{
                        id   : 1,
                        name : 'Man'
                    }]
                }
            })
        });

        project = new ProjectModel({
            validateResponse : false,
            transport        : {
                load : {
                    url : 'load'
                },
                sync : {
                    url : 'sync'
                }
            },
            autoSync : false
        });

        initConsoleSpy(t);

        await project.load();

        t.mockUrl('sync', {
            responseText : JSON.stringify({
                success : true,
                type    : 'sync',
                tasks   : [{
                    id   : 1,
                    name : 'Task'
                }]
            })
        });

        project.taskStore.add({});

        await project.sync();

        t.mockUrl('load', {
            responseText : JSON.stringify({
                success     : true,
                type        : 'load',
                assignments : {
                    rows : [{
                        resourceId : 1,
                        eventId    : 1
                    }]
                },
                myTasks : {
                    rows : [{
                        id   : 1,
                        name : 'Task'
                    }]
                },
                resources : {
                    rows : [{
                        id   : 1,
                        name : 'Man'
                    }]
                }
            })
        });

        await project.load();

        t.is(consoleMessages.length, 0, 'No console warn messages');
    });

    t.it('Should not trigger batchedUpdate during calculations', async t => {
        const project = new ProjectModel(getProjectData());

        t.wontFire(project.taskStore, 'batchedUpdate');

        await project.commitAsync();

        project.taskStore.first.duration = 100;

        await project.commitAsync();
    });

    // https://github.com/bryntum/support/issues/3281
    t.it('Should relay store changes', async t => {
        let changeData = {};

        project = new ProjectModel({
            resourcesData : [
                { id : 1, name : 'resource 1' },
                { id : 2, name : 'resource 2' }
            ],
            eventsData : [
                { id : 1, name : 'event 1' },
                { id : 2, name : 'event 2' },
                { id : 3, name : 'event 3' }
            ],
            assignmentsData : [
                { id : 1, eventId : 1, resourceId : 1 },
                { id : 2, eventId : 2, resourceId : 1 }
            ],
            dependenciesData : [
                { id : 1, from : 1, to : 2 }
            ],
            timeRangesData : [
                { id : 1, name : 'Range' }
            ]
        });

        project.on({
            change({ store, action }) {
                changeData = { store, action };
            }
        });

        await project.commitAsync();

        //
        // TASKSTORE
        //

        project.taskStore.first.name = 'Changed';

        await project.commitAsync();

        t.isDeeply(changeData, { store : project.taskStore, action : 'update' }, 'Correct args for TaskStore update');

        //
        // RESOURCESTORE
        //

        project.resourceStore.first.name = 'Changed';

        await project.commitAsync();

        t.isDeeply(changeData, { store : project.resourceStore, action : 'update' }, 'Correct args for ResourceStore update');

        //
        // ASSIGNMENTSTORE
        //

        project.assignmentStore.last.resourceId = 2;

        await project.commitAsync();

        t.isDeeply(changeData, { store : project.assignmentStore, action : 'update' }, 'Correct args for AssignmentStore update');

        //
        // DEPENDENCYSTORE
        //

        project.dependencyStore.first.fromTask = 3;

        await project.commitAsync();

        t.isDeeply(changeData, { store : project.dependencyStore, action : 'update' }, 'Correct args for DependencyStore update');

        //
        // TIMERANGESTORE
        //

        project.timeRangeStore.first.name = 'Changed';

        await project.commitAsync();

        t.isDeeply(changeData, { store : project.timeRangeStore, action : 'update' }, 'Correct args for TimeRangeStore update');
    });

    // https://github.com/bryntum/support/issues/3120
    t.it('Should handle calling toJSON on empty project task store', async t => {
        const project = new ProjectModel({
            eventsData : []
        });

        t.isDeeply(project.taskStore.toJSON(), []);
    });

    // https://github.com/bryntum/support/issues/4043
    t.it('Framework friendly configs and properties should work', async t => {
        const
            tasksData = [
                { id : 1, name : 'Task 1', startDate : new Date(2020, 0, 17), duration : 2, durationUnit : 'd' },
                { id : 2, name : 'Task 2', startDate : new Date(2020, 0, 18), duration : 2, durationUnit : 'd' },
                { id : 3, name : 'Task 3', startDate : new Date(2020, 0, 19), endDate : new Date(2020, 0, 22) }
            ],
            resourcesData = [
                { id : 1, name : 'Resource 1' },
                { id : 2, name : 'Resource 2' }
            ],
            assignmentsData = [
                { id : 1, taskId : 1, resourceId : 1 },
                { id : 2, taskId : 1, resourceId : 2 },
                { id : 3, taskId : 2, resourceId : 2 }
            ],
            timeRangesData = [
                { id : 1, name : 'Range 1', startDate : new Date(2020, 0, 17), duration : 2, durationUnit : 'd' }
            ],
            dependenciesData = [
                { id : 1, from : 1, to : 2 }
            ],
            calendarsData = [
                { id : 1, startDate : new Date(2020, 0, 17), endDate : new Date(2020, 0, 19), isWorking : true }
            ];

        project = new ProjectModel({
            tasks        : tasksData,
            assignments  : assignmentsData,
            resources    : resourcesData,
            dependencies : dependenciesData,
            timeRanges   : timeRangesData,
            calendars    : calendarsData

        });

        await project.commitAsync();

        t.is(project.taskStore.count, tasksData.length, 'TaskStore populated');
        t.is(project.assignmentStore.count, assignmentsData.length, 'AssignmentStore populated');
        t.is(project.resourceStore.count, resourcesData.length, 'ResourceStore populated');
        t.is(project.dependencyStore.count, dependenciesData.length, 'DependencyStore populated');
        t.is(project.timeRangeStore.count, timeRangesData.length, 'TimeRangeStore populated');
        t.is(project.calendarManagerStore.count, calendarsData.length, 'CalendarManagerStore populated');

        t.is(project.tasks, project.taskStore.records, 'tasks getter');
        t.is(project.assignments, project.assignmentStore.records, 'assignments getter');
        t.is(project.resources, project.resourceStore.records, 'resources getter');
        t.is(project.dependencies, project.dependencyStore.records, 'dependencies getter');
        t.is(project.timeRanges, project.timeRangeStore.records, 'timeRanges getter');
        t.is(project.calendars, project.calendarManagerStore.records, 'calendars getter');

        Object.assign(project, {
            tasks        : [],
            assignments  : [],
            resources    : [],
            dependencies : [],
            timeRanges   : [],
            calendars    : []
        });

        await project.commitAsync();

        t.is(project.taskStore.count, 0, 'tasks setter');
        t.is(project.assignmentStore.count, 0, 'assignments setter');
        t.is(project.resourceStore.count, 0, 'resources setter');
        t.is(project.dependencyStore.count, 0, 'dependencies setter');
        t.is(project.timeRangeStore.count, 0, 'timeRanges setter');
        t.is(project.calendarManagerStore.count, 0, 'calendars setter');

        Object.assign(project, {
            tasks        : tasksData,
            assignments  : assignmentsData,
            resources    : resourcesData,
            dependencies : dependenciesData,
            timeRanges   : timeRangesData,
            calendars    : calendarsData

        });

        await project.commitAsync();

        t.is(project.taskStore.count, tasksData.length, 'TaskStore repopulated');
        t.is(project.assignmentStore.count, assignmentsData.length, 'AssignmentStore repopulated');
        t.is(project.resourceStore.count, resourcesData.length, 'ResourceStore repopulated');
        t.is(project.dependencyStore.count, dependenciesData.length, 'DependencyStore repopulated');
        t.is(project.timeRangeStore.count, timeRangesData.length, 'TimeRangeStore repopulated');
        t.is(project.calendarManagerStore.count, calendarsData.length, 'CalendarManagerStore repopulated');
    });

    // https://github.com/bryntum/support/issues/4113
    t.it('Should apply proper calendar when loading other data to the project', async t => {
        t.mockUrl('load1', {
            responseText : JSON.stringify({
                project : {
                    calendar     : 'a',
                    startDate    : '2021-03-21',
                    hoursPerDay  : 8,
                    daysPerWeek  : 4,
                    daysPerMonth : 16
                },
                calendars : {
                    rows : [
                        {
                            id        : 'a',
                            name      : 'AAA',
                            intervals : [
                                {
                                    recurrentStartDate : 'on Sat at 0:00',
                                    recurrentEndDate   : 'on Mon at 0:00',
                                    isWorking          : false
                                }
                            ]
                        }
                    ]
                }
            })
        });

        t.mockUrl('load2', {
            responseText : JSON.stringify({
                project : {
                    calendar     : 'b',
                    startDate    : '2021-03-22',
                    hoursPerDay  : 23,
                    daysPerWeek  : 6,
                    daysPerMonth : 24
                },
                calendars : {
                    rows : [
                        {
                            id   : 'b',
                            name : 'BBB'
                        }
                    ]
                }
            })
        });

        project = new ProjectModel();

        await project.load('load1');

        t.is(project.calendar?.id, 'a', 'project calendar is correct');
        t.is(project.startDate, new Date(2021, 2, 21), 'project startDate is correct');
        t.is(project.hoursPerDay, 8, 'project hoursPerDay is correct');
        t.is(project.daysPerWeek, 4, 'project daysPerWeek is correct');
        t.is(project.daysPerMonth, 16, 'project daysPerMonth is correct');

        t.diag('Loading other dataset to the project');

        await project.load('load2');

        t.is(project.calendar?.id, 'b', 'project calendar is correct');
        t.is(project.startDate, new Date(2021, 2, 22), 'project startDate is correct');
        t.is(project.hoursPerDay, 23, 'project hoursPerDay is correct');
        t.is(project.daysPerWeek, 6, 'project daysPerWeek is correct');
        t.is(project.daysPerMonth, 24, 'project daysPerMonth is correct');
    });
});
