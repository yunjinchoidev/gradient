import { ProjectGenerator, VersionHelper } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt;

    t.beforeEach(() => gantt?.destroy?.());

    t.it('Should render dependencies regardless of barMargin size', async t => {
        gantt = await t.getGanttAsync({
            enableEventAnimations : false,
            rowHeight             : 50,
            barMargin             : 5,
            tasks                 : [
                {
                    id                : 1,
                    name              : 'Task 1',
                    startDate         : '2017-01-23',
                    manuallyScheduled : true,
                    duration          : 1
                },
                {
                    id                : 2,
                    name              : 'Task 2',
                    startDate         : '2017-01-24',
                    manuallyScheduled : true,
                    duration          : 1
                },
                {
                    id                : 3,
                    name              : 'Task 3',
                    cls               : 'task3',
                    startDate         : '2017-01-26',
                    manuallyScheduled : true,
                    duration          : 0
                }
            ],
            dependencies : [
                { id : 1, fromEvent : 1, toEvent : 2 },
                { id : 2, fromEvent : 1, toEvent : 3 }
            ]
        });

        const dependencies = gantt.dependencies;

        t.chain(
            { waitForSelector : '.b-sch-dependency' },
            next => {
                dependencies.forEach(dep => t.assertDependency(gantt, dep, undefined, `Initial dependency (${dep.id}) check`));
                t.waitForEvent(gantt, 'dependenciesdrawn', next);
                gantt.barMargin = 10;
            },
            { waitFor : () => document.querySelector(gantt.eventSelector).offsetHeight === 30, desc : 'Task height is correct after barMargin set to 10' },
            next => {
                dependencies.forEach(dep => t.assertDependency(gantt, dep, undefined, `Dependency (${dep.id}) check after barMargin set to 10`));
                t.waitForEvent(gantt, 'dependenciesdrawn', next);
                gantt.barMargin = 20;
            },
            { waitFor : () => document.querySelector(gantt.eventSelector).offsetHeight === 10, desc : 'Task height is correct after barMargin set to 20' },
            () => {
                dependencies.forEach(dep => t.assertDependency(gantt, dep, undefined, `Dependency (${dep.id}) check after barMargin set to 20`));
            }
        );
    });

    t.it('Should not throw for invalid assignments', t => {
        gantt = t.getGantt({
            enableEventAnimations : false,
            features              : {
                dependencies : true
            },
            resources : [
                { id : 1, name : 'Albert' }
            ],
            tasks : [
                { id : 1, startDate : '2017-01-16', duration : 2 }
            ],
            assignments : [
                { id : 1, resourceId : 1, eventId : 1 }
            ]
        });

        t.livesOk(() => {
            gantt.project.getAssignmentStore().add([
                { id : 2, resourceId : 1, eventId : 2 },
                { id : 3, resourceId : 2, eventId : 1 },
                { id : 4, resourceId : 2, eventId : 2 }
            ]);
        }, 'Lives ok when adding assignment to non existent dependency');
    });

    t.it('Should correctly draw dependencies on task add/remove', async t => {
        gantt = await t.getGanttAsync({
            enableEventAnimations : false
        });

        const
            stm = gantt.project.stm,
            taskStore = gantt.taskStore;

        t.chain(
            { waitForEvent : [gantt, 'dependenciesdrawn'] },

            next => {
                stm.enable();

                t.waitForEvent(gantt, 'dependenciesdrawn', next);

                stm.startTransaction('remove');
                taskStore.getById(12).remove();
                stm.stopTransaction('remove');
            },

            { waitForPropagate : gantt },

            async() => {
                t.subTest('Dependencies are ok after removing task', t => {
                    gantt.dependencies.forEach(dep => t.assertDependency(gantt, dep));
                });

                // this will start commitAsync
                stm.undo();

                await t.waitForEvent(gantt, 'dependenciesdrawn');

                await gantt.project.commitAsync();

                // need to wait for stm to be in enabled state, because undo will turn it off/on
                await t.waitFor(() => !stm.disabled);
            },

            { waitForAnimationFrame : null },

            async() => {
                t.subTest('Dependencies are ok after undo', t => {
                    gantt.dependencies.forEach(dep => t.assertDependency(gantt, dep));
                });

                gantt.clearLog('dependenciesdrawn');

                stm.startTransaction();
                taskStore.beginBatch();
                taskStore.getById(12).remove();
                taskStore.getById(1).appendChild({ name : 'test' });
                taskStore.endBatch();
                stm.stopTransaction();

                await gantt.project.commitAsync();
                await gantt.await('dependenciesdrawn');
            },

            // Fails online but passes locally, guessing because of shorter waitFors does not give UI chance to catch up
            { waitForAnimationFrame : null },

            next => {
                t.subTest('Dependencies are ok after batching', t => {
                    gantt.dependencies.forEach(dep => t.assertDependency(gantt, dep));
                });

                t.waitForEvent(gantt, 'dependenciesdrawn', next);
                stm.undo();
            },

            { waitForAnimationFrame : null },

            () => {
                t.subTest('Dependencies are ok after undo', t => {
                    gantt.dependencies.forEach(dep => t.assertDependency(gantt, dep));
                });
            }
        );
    });

    t.it('Should avoid forced reflow during refresh', t => {
        // TODO: Going to refactor dependency rendering to use DomSync
        if (new Date() < new Date(2022, 5, 1)) {
            return;
        }

        t.fail('Snoozed test woke up');

        gantt = t.getGantt({
            enableEventAnimations : false,
            tasks                 : [
                { id : 1, startDate : '2017-01-16', duration : 1 },
                { id : 2, startDate : '2017-01-16', duration : 1 },
                { id : 3, startDate : '2017-01-16', duration : 1 },
                { id : 4, startDate : '2017-01-17', duration : 1 }
            ],
            dependencies : [
                { id : 1, fromEvent : 1, toEvent : 4 },
                { id : 2, fromEvent : 2, toEvent : 4 },
                { id : 3, fromEvent : 3, toEvent : 4 }
            ]
        });

        function setupOverrides() {
            const
                feature              = gantt.features.dependencies,
                oldGetBox            = feature.getBox,
                oldDrawDependency    = feature.drawDependency,
                oldReleaseDependency = feature.releaseDependency;

            let drawCounter   = 0,
                getBoxCounter = 0;

            feature.getBox = function() {
                if (drawCounter !== 0) {
                    t.fail('Referring to getBox after drawing dependency forces reflow');
                }
                ++getBoxCounter;
                return oldGetBox.apply(feature, arguments);
            };

            feature.drawDependency = function() {
                ++drawCounter;
                return oldDrawDependency.apply(feature, arguments);
            };

            feature.releaseDependency = function() {
                if (getBoxCounter !== 0) {
                    t.fail('Releasing dependency after filling cache forces reflow');
                }
                return oldReleaseDependency.apply(feature, arguments);
            };
        }

        t.chain(
            { waitForPropagate : gantt },
            async() => {
                gantt.project.on({
                    commit() {
                        setupOverrides();
                    },
                    once : true
                });
            },
            { drag : '.b-gantt-task', by : [50, 0] },
            { waitFor : 1000 }
        );
    });

    t.it('Should avoid forced reflow during scroll', async t => {
        const config = await ProjectGenerator.generateAsync(100, 30, () => {});

        gantt = await t.getGanttAsync({
            startDate : config.startDate,
            endDate   : config.endDate,
            project   : config
        });

        function setupOverrides() {
            const
                feature              = gantt.features.dependencies,
                oldGetBox            = feature.getBox,
                oldDrawDependency    = feature.drawDependency;

            let drawCounter = 0;

            feature.getBox = function() {
                if (drawCounter !== 0) {
                    t.fail('Referring to getBox after drawing dependency forces reflow');
                }
                return oldGetBox.apply(feature, arguments);
            };

            feature.drawDependency = function() {
                ++drawCounter;
                return oldDrawDependency.apply(feature, arguments);
            };
        }

        await t.waitForDependencies();

        setupOverrides();

        gantt.clearLog('dependenciesdrawn');

        await gantt.scrollTaskIntoView(gantt.taskStore.last);
        await gantt.await('dependenciesdrawn');
    });

    t.it('Should clear dependencies cache when clearing task store', async t => {
        gantt = await t.getGanttAsync();

        gantt.taskStore.removeAll();
        gantt.taskStore.add({});

        await gantt.project.commitAsync();

        // Dependencies, if there are any, will schedule to next animation frame
        await t.animationFrame();

        t.selectorCountIs('.b-sch-dependency', 0, 'No dependencies are rendered');
    });

    // https://github.com/bryntum/bryntum-suite/issues/122
    t.it('should not draw dependencies for removed task', t => {
        gantt = t.getGantt({
            useEventAnimations : false
        });

        t.chain(
            { waitForPropagate : gantt },

            next => {
                gantt.taskStore.getById(11).remove();
                next();
            },

            { waitForPropagate : gantt },

            { waitForAnimationFrame : null },

            () => {
                t.selectorNotExists('polyline[depId="1"]', 'Dependency line gone');
            }
        );
    });

    // https://github.com/bryntum/support/issues/139
    t.it('Dependency line between milestones shouldn\'t disappear', t => {
        gantt = t.getGantt({
            enableEventAnimations : false,
            startDate             : '2020-02-03',
            endDate               : '2020-02-09',

            project : {
                // set to `undefined` to overwrite the default '2017-01-16' value in `t.getProject`
                startDate  : undefined,
                eventsData : [
                    {
                        id        : 1,
                        name      : 'Milestone 1',
                        startDate : '2020-02-06',
                        endDate   : '2020-02-06'
                    },
                    {
                        id        : 2,
                        name      : 'Milestone 2',
                        startDate : '2020-02-06',
                        endDate   : '2020-02-06'
                    }
                ],
                dependenciesData : [
                    { id : 1, fromEvent : 1, toEvent : 2 }
                ]
            }
        });

        t.chain(
            { waitForPropagate : gantt },

            { waitForSelector : '.b-sch-dependency', desc : 'Should have dependency line' }
        );
    });

    t.it('Should update dependencies when task is partially outside the view', t => {
        gantt = t.getGantt({
            enableEventAnimations : false,
            startDate             : '2020-02-02',
            endDate               : '2020-02-09',

            project : {
                startDate  : '2020-02-08',
                eventsData : [
                    {
                        id        : 1,
                        name      : 'Task 1',
                        startDate : '2020-02-08',
                        endDate   : '2020-02-09'
                    },
                    {
                        id        : 2,
                        name      : 'Task 2',
                        startDate : '2020-02-09',
                        endDate   : '2020-02-10'
                    }
                ],
                dependenciesData : [
                    { id : 1, fromEvent : 1, toEvent : 2 }
                ]
            }
        });

        t.chain(
            { waitForPropagate : gantt },
            { drag : '[data-task-id="1"]', by : [-100, 0], dragOnly : true, desc : 'Should be draggable' },
            { waitForSelector : '.b-sch-dependency', desc : 'Should have dependency line' },
            { mouseup : null }
        );
    });

    // https://github.com/bryntum/support/issues/577
    t.it('Clean up Dependencies.updateDependenciesForTimeSpan', t => {
        if (VersionHelper.checkVersion('Scheduler', '6.0.0', '>=')) {
            t.fail('Time to clean up for 6.0.0!');
        }
    });

    t.it('Should draw dependency line correctly after adding predecessor which pushes line far out of the view', async t => {
        gantt = await t.getGanttAsync({
            height    : 200,
            width     : 800,
            startDate : '2020-07-27',
            endDate   : '2020-10-04',
            project   : {
                startDate     : '2020-07-27',
                calendar      : 'general',
                calendarsData : [
                    {
                        id        : 'general',
                        intervals : [
                            {
                                recurrentStartDate : 'on Sat at 0:00',
                                recurrentEndDate   : 'on Mon at 0:00',
                                isWorking          : false
                            }
                        ]
                    }
                ],
                eventsData : [
                    {
                        id       : 11,
                        name     : 'Child 1',
                        duration : 5
                    },
                    {
                        id       : 12,
                        name     : 'Child 2',
                        duration : 5
                    },
                    {
                        id       : 13,
                        name     : 'Child 3',
                        duration : 30
                    }
                ],
                dependenciesData : [
                    { id : 1, from : 11, to : 12 }
                ]
            }
        });

        t.chain(
            { waitForSelector : '.b-sch-dependency' },
            async() => {
                gantt.dependencyStore.add({ id : 100, from : 13, to : 11 });

                await gantt.await('dependenciesDrawn', { checkLog : false, args : { partial : true } });

                await t.waitForSelectorNotFound('.b-sch-dependency[depId="1"]');

                t.selectorCountIs('.b-sch-dependency[depId="100"]', 1, 'Dependency line for #100 is found');

                gantt.scrollTaskIntoView(gantt.taskStore.getById(11), { block : 'center' });

                await gantt.await('dependenciesDrawn', { checkLog : false });

                t.selectorCountIs('.b-sch-dependency[depId="1"]', 1, 'Dependency line for #1 is found');

                t.selectorCountIs('.b-sch-dependency[depId="100"]', 1, 'Dependency line for #100 is found');
            }
        );
    });

    t.it('Should clear dependency line after undo', async t => {
        gantt = await t.getGanttAsync({
            height    : 200,
            width     : 800,
            startDate : '2020-07-27',
            endDate   : '2020-10-04',
            project   : {
                startDate  : '2020-07-27',
                eventsData : [
                    {
                        id       : 11,
                        name     : 'Child 1',
                        duration : 5
                    },
                    {
                        id       : 12,
                        name     : 'Child 2',
                        duration : 5
                    },
                    {
                        id       : 13,
                        name     : 'Child 3',
                        duration : 5
                    }
                ],
                dependenciesData : [
                    { id : 1, from : 11, to : 12 }
                ]
            }
        });

        await t.waitForDependencies();

        const { stm } = gantt.project;

        stm.enable();

        stm.startTransaction();

        gantt.dependencyStore.add({ id : 100, from : 13, to : 12 });

        await Promise.all([
            gantt.await('dependenciesDrawn', { checkLog : false }),
            gantt.project.await('dataReady', { checkLog : false })
        ]);

        stm.stopTransaction();

        t.selectorCountIs('.b-sch-dependency[depId="1"]', 1, 'Dependency line for #1 is found');

        await t.waitForSelector('.b-sch-dependency[depId="100"]');

        stm.undo();

        await gantt.await('dependenciesDrawn', { checkLog : false });

        t.is(gantt.dependencyStore.count, 1, 'Single dependency in store');

        t.selectorCountIs('.b-sch-dependency[depId="1"]', 1, 'Dependency line for #1 is found');

        t.selectorCountIs('.b-sch-dependency[depId="100"]', 0, 'Dependency line for #100 is not found');
    });
});
