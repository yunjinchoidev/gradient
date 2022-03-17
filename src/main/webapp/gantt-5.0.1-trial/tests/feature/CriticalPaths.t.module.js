/* global Gantt */
StartTest(function(t) {

    let gantt;

    t.beforeEach(() => Gantt.destroy(gantt));

    t.it('Should render critical paths', async(t) => {

        gantt = t.getGantt({
            appendTo : document.body,
            project  : {
                tasksData : [
                    { id : 1, startDate : '2016-02-01', duration : 5 },
                    { id : 2, startDate : '2016-02-01', duration : 10 },
                    { id : 3, startDate : '2016-02-12', duration : 1 },
                    { id : 4, startDate : '2016-02-01', duration : 1 },
                    { id : 5, startDate : '2016-02-02', duration : 1 },
                    { id : 6, startDate : '2016-02-13', duration : 1 },
                    { id : 7, startDate : '2016-02-15', duration : 3 },
                    { id : 8, startDate : '2016-02-16', duration : 2 },
                    { id : 9, startDate : '2016-02-16', duration : 1 },
                    { id : 10, startDate : '2016-02-17', duration : 2 },
                    { id : 11, startDate : '2016-02-18', duration : 1 }
                ],
                dependenciesData : [
                    /* DependencyType.EndToEnd */
                    { id : 23, fromEvent : 2, toEvent : 3, type : 3 },
                    { id : 45, fromEvent : 4, toEvent : 5 },
                    { id : 56, fromEvent : 5, toEvent : 6 },
                    { id : 58, fromEvent : 7, toEvent : 11 },
                    { id : 59, fromEvent : 8, toEvent : 11 },
                    { id : 60, fromEvent : 9, toEvent : 11 },
                    { id : 61, fromEvent : 10, toEvent : 11 }
                ]
            }
        });

        await gantt.project.commitAsync();

        t.chain(
            { waitForSelector : '.b-sch-dependency' },

            async() => {
                t.ok(gantt.features.criticalPaths.disabled, 'the feature is disabled by default');
                t.diag('Enabling the feature');

                gantt.features.criticalPaths.disabled = false;
            },

            () => gantt.await('dependenciesDrawn', { checkLog : false, args : { partial : true } }),

            { waitForSelector : '.b-gantt.b-gantt-critical-paths', desc : 'Critical path feature CSS class is added' },
            { waitForSelector : '.b-sch-dependency.b-critical', desc : 'Dependency got highlighted' },

            async() => {
                t.selectorCountIs('.b-gantt-task.b-critical', 2, 'two critical tasks are highlighted');
                t.selectorCountIs('.b-sch-dependency.b-critical', 1, 'one dependency is highlighted');
            },

            { drag : '[data-task-id=7]', by : [150, 0], offset : ['100%-3', 5] },

            { waitFor : 200 },

            { waitForSelector : 'polyline[depId="58"].b-sch-dependency.b-critical', desc : 'Path for task 7 was highlighted, critical path feature CSS class was added' },

            next => {
                const
                    task7PathEl = gantt.element.querySelector('polyline[depId="58"]'),
                    task11ElCoord = t.rect('[data-task-id="11"]'),
                    arrowMargin = gantt.features.dependencies.pathFinder.startArrowMargin;

                // check if the element found on point is the critical
                t.is(document.elementFromPoint(task11ElCoord.left + arrowMargin, task11ElCoord.top - 15), task7PathEl, 'The task 7 critical path is on top of task 8 normal path and fully visible');
                t.is(document.elementFromPoint(task11ElCoord.left + arrowMargin, task11ElCoord.top - 55), task7PathEl, 'The task 7 critical path is on top of task 9 normal path and fully visible');
                t.is(document.elementFromPoint(task11ElCoord.left + arrowMargin, task11ElCoord.top - 100), task7PathEl, 'The task 7 critical path is on top of task 10 normal path and fully visible');

                next();
            },

            { drag : '[data-task-id=7]', by : [-150, 0], offset : ['100%-3', 5] },

            () => gantt.await('dependenciesDrawn', false),

            { waitForSelectorNotFound : 'polyline[depId="58"].b-sch-dependency.b-critical', desc : 'Path for task 7 was not highlighted, critical path feature CSS class was removed' },

            { diag : 'Disabling the feature' },

            next => {
                t.waitForEvent(gantt, 'criticalPathsUnhighlighted', next);
                gantt.features.criticalPaths.disabled = true;
            },

            { waitForSelectorNotFound : '.b-gantt.b-gantt-critical-paths', desc : 'Critical path feature CSS class is removed' },
            { waitForSelectorNotFound : '.b-sch-dependency.b-critical', desc : 'no highlighted dependency' }
        );
    });

    // https://github.com/bryntum/support/issues/3153
    t.it('Project should return proper critical paths', async(t) => {

        t.mockUrl('test-load', {
            responseText : JSON.stringify({
                success : true,
                tasks   : {
                    rows : [
                        {
                            id        : 't1',
                            startDate : '2016-02-01',
                            duration  : 5,
                            expanded  : true,
                            children  : [
                                { id : 't11', startDate : '2016-02-01', duration : 5 },
                                { id : 't12', startDate : '2016-02-01', duration : 5 }
                            ]
                        }
                    ]
                }
            })
        });

        gantt = new Gantt({
            appendTo : document.body,

            features : {
                criticalPaths : {
                    disabled : false
                }
            },
            project : {
                autoLoad  : true,
                transport : {
                    load : {
                        url : 'test-load'
                    }
                }
            }
        });

        await gantt.project.commitAsync();

        await t.waitForSelector('.b-gantt-task-wrap[data-task-id=t1]');

        t.is(gantt.project.endDate, new Date(2016, 1, 6));

        t.isDeeply(gantt.project.criticalPaths, [
            [{ event : gantt.project.eventStore.getById('t1') }],
            [{ event : gantt.project.eventStore.getById('t11') }],
            [{ event : gantt.project.eventStore.getById('t12') }]
        ], 'proper set of critical paths');

        t.selectorCountIs('.b-gantt-task.b-critical', 3, 'three critical tasks are highlighted');
        t.selectorCountIs('.b-sch-dependency.b-critical', 0, 'no dependencies highlighted');
    });

    // https://github.com/bryntum/support/issues/3379
    t.it('Project should handle unscheduled tasks when calculating critical paths', async(t) => {
        t.mockUrl('test-load', {
            responseText : JSON.stringify({
                success : true,
                tasks   : {
                    rows : [
                        { id : 't11', startDate : '2016-02-01', duration : 5 },
                        { id : 't12' }
                    ]
                }
            })
        });

        gantt = t.getGantt({
            appendTo : document.body,

            features : {
                criticalPaths : {
                    disabled : false
                }
            },
            project : {
                autoLoad         : true,
                eventsData       : undefined,
                dependenciesData : undefined,
                calendarsData    : undefined,
                transport        : {
                    load : {
                        url : 'test-load'
                    }
                }
            }
        });

        await gantt.project.commitAsync();

        await t.waitForSelector('.b-gantt-task.b-critical');

        t.isDeeply(gantt.project.criticalPaths, [
            [{ event : gantt.project.eventStore.getById('t11') }]
        ], 'proper set of critical paths');

        t.selectorCountIs('.b-gantt-task.b-critical', 1, '1 critical task');
    });
});
