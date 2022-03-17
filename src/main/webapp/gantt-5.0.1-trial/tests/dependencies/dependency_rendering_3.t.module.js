StartTest(t => {
    let gantt;

    t.beforeEach(() => {
        gantt && gantt.destroy();
    });

    // https://github.com/bryntum/support/issues/3645
    t.it('Should render dependencies after zoom keeping center date', async t => {
        gantt = await t.getGanttAsync({
            enableEventAnimations : false,
            rowHeight             : 50,
            barMargin             : 5,
            startDate             : '2019-01-06',
            endDate               : '2019-03-10',
            project               : {
                startDate  : '2019-01-13',
                eventsData : [
                    {
                        id        : 1,
                        name      : 'Task 1',
                        startDate : '2019-01-13',
                        duration  : 14
                    },
                    {
                        id       : 2,
                        name     : 'Task 2',
                        duration : 7
                    },
                    {
                        id       : 3,
                        name     : 'Task 3',
                        cls      : 'task3',
                        duration : 7
                    }
                ],
                dependenciesData : [
                    { id : 1, fromEvent : 1, toEvent : 2 },
                    { id : 2, fromEvent : 2, toEvent : 3 }
                ]
            },
            tbar : [
                {
                    type : 'button',
                    onClick() {
                        gantt.zoomIn();
                    }
                }
            ]
        });

        await t.waitForSelector('.b-sch-dependency');

        // When we zoom to a time span (reconfigure time axis) dependencies feature will schedule a draw and will raise
        // a flag to reset bounds cache. Draw will be scheduled about 2-3 times overall, but flag will be raised (and
        // lowered) just once.
        // In the current version this flag does not really reset anything, it just tells deps feature to recalculate
        // bounds for dependencies that are in the current view. Problem is that when draw is called first time it
        // may have incorrect information about current visible range.
        // For example: consider gantt is initially rendered without overflow it has zero scrollLeft, when zoom is
        // called time axis is reconfigured and later scrolled to the left to maintain center date. Problem is that
        // draw is scheduled _before_ horizontal scroll is changed which means first draw will be called before view
        // knows about current visible range. First draw will try to render dependencies, will not find any for the
        // current time range and then will lower the flag, leaving all the dependency bounds caches stale and incorrect.
        // It goes like:
        // zoom -> current date range points to the start of the new time span -> draw scheduled -> view is scrolled ->
        // -> draw is called with date range pointing to the start of the new span -> flag lowered -> date range
        // updated -> draw is called again but cache is not updated
        gantt.zoomToSpan({
            startDate : new Date(2018, 11, 16),
            endDate   : new Date(2019, 2, 10)
        });

        await t.waitForEvent(gantt.timeAxisSubGrid.scrollable, 'scrollEnd');

        await t.waitForSelector('.b-sch-dependency');

        t.assertDependency(gantt, gantt.dependencies[0]);
    });

    t.it('Should render dependencies after zoom NOT keeping center date', async t => {
        gantt = await t.getGanttAsync({
            enableEventAnimations : false,
            rowHeight             : 50,
            barMargin             : 5,
            startDate             : '2019-01-06',
            endDate               : '2019-03-10',
            project               : {
                startDate  : '2019-01-13',
                eventsData : [
                    {
                        id        : 1,
                        name      : 'Task 1',
                        startDate : '2019-01-13',
                        duration  : 14
                    },
                    {
                        id       : 2,
                        name     : 'Task 2',
                        duration : 7
                    },
                    {
                        id       : 3,
                        name     : 'Task 3',
                        cls      : 'task3',
                        duration : 7
                    }
                ],
                dependenciesData : [
                    { id : 1, fromEvent : 1, toEvent : 2 },
                    { id : 2, fromEvent : 2, toEvent : 3 }
                ]
            }
        });

        await t.waitForSelector('.b-sch-dependency');

        // When we zoom to a time span (reconfigure time axis) dependencies feature will schedule a draw and will raise
        // a flag to reset bounds cache. Draw will be scheduled about 2-3 times overall, but flag will be raised (and
        // lowered) just once.
        // In the current version this flag does not really reset anything, it just tells deps feature to recalculate
        // bounds for dependencies that are in the current view. Problem is that when draw is called first time it
        // may have incorrect information about current visible range.
        // For example: consider gantt is initially rendered without overflow it has zero scrollLeft, when zoom is
        // called time axis is reconfigured and later scrolled to the left to maintain center date. Problem is that
        // draw is scheduled _before_ horizontal scroll is changed which means first draw will be called before view
        // knows about current visible range. First draw will try to render dependencies, will not find any for the
        // current time range and then will lower the flag, leaving all the dependency bounds caches stale and incorrect.
        // It goes like:
        // zoom -> current date range points to the start of the new time span -> draw scheduled -> view is scrolled ->
        // -> draw is called with date range pointing to the start of the new span -> flag lowered -> date range
        // updated -> draw is called again but cache is not updated
        gantt.zoomToSpan({
            startDate  : new Date(2018, 11, 16),
            endDate    : new Date(2019, 2, 10),
            centerDate : new Date(2017, 10, 19)
        });

        await Promise.all([
            t.waitForEvent(gantt, 'visibleRangeChange'),
            t.waitForEvent(gantt, 'dependenciesDrawn')
        ]);

        t.selectorCountIs('.b-sch-dependency', 0, 'All dependencies are out of the view');

        await gantt.scrollTaskIntoView(gantt.taskStore.getById(1), { block : 'center' });

        await t.waitForSelector('.b-sch-dependency');

        t.assertDependency(gantt, gantt.dependencies[0]);
    });

    t.it('Should render end to end dependency', async t => {
        gantt = await t.getGanttAsync({
            project : {
                tasksData : [
                    {
                        id        : 1,
                        startDate : '2017-01-16',
                        duration  : 3
                    },
                    {
                        id       : 2,
                        duration : 2
                    }
                ],
                dependenciesData : [
                    { id : 1, fromEvent : 1, toEvent : 2, type : 3 }
                ]
            }
        });

        await gantt.await('dependenciesDrawn');

        t.assertDependency(gantt, gantt.dependencyStore.first);
    });
});
