import { GanttBase, TaskModel, AjaxHelper } from '../../build/gantt.module.js?457330';

StartTest(t => {

    let ganttBase;

    window.AjaxHelper = AjaxHelper;

    t.beforeEach(t => {
        GanttBase.destroy(ganttBase);
    });

    t.it('Sanity', async t => {
        ganttBase = new GanttBase({
            appendTo  : document.body,
            width     : 800,
            height    : 600,
            startDate : new Date(2019, 8, 18),
            endDate   : new Date(2019, 8, 25),

            tasks : [
                { id : 1, name : 'Task', startDate : new Date(2019, 8, 18), duration : 2, durationUnit : 'd' }
            ]
        });

        await t.waitForSelector('.b-gantt-task');

        t.selectorExists('.b-grid-header:textEquals(Name)', 'Header rendered');
        t.selectorExists('.b-sch-header-timeaxis-cell:textEquals(S)', 'Time axis header rendered');
        t.selectorExists('.b-grid-cell:textEquals(Task)', 'Cell rendered');
        t.selectorExists('.b-gantt-task', 'Task rendered');
        // assert enabled features
        t.isDeeply(Object.entries(ganttBase.features).filter(([key, feature]) => feature).map(([key]) => key).sort(), ['dependencies', 'regionResize', 'tree'], 'Correct features included by default');
    });

    t.it('Should show progress mask when enableProgressNotifications enabled', async t => {
        ganttBase = new GanttBase({
            appendTo                 : document.body,
            width                    : 800,
            height                   : 600,
            startDate                : new Date(2020, 11, 21),
            endDate                  : new Date(2020, 11, 28),
            projectProgressThreshold : 0,
            project                  : {
                enableProgressNotifications : true,
                // Disable early rendering to get expected behaviour
                delayCalculation            : false
            }
        });

        ganttBase.project.loadInlineData({
            tasksData : [{
                startDate    : new Date(2020, 11, 21),
                duration     : 4,
                durationUnit : 'd'
            }]
        });
        await t.waitForSelector('.b-mask .b-mask-text:contains(Loading data)');

        await t.waitForSelectorNotFound('.b-mask .b-mask-text:contains(Loading data)');
    });

    t.it('Should toggle parent tasks after click on the task bar by default', async t => {
        ganttBase = new GanttBase({
            appendTo : document.body,
            height   : 200,
            project  : {
                tasksData : [
                    {
                        name      : 'parent',
                        startDate : new Date(2020, 11, 21),
                        duration  : 4,
                        children  : [{
                            startDate : new Date(2020, 11, 21),
                            name      : 'child',
                            duration  : 4
                        }]
                    }
                ]
            }
        });

        t.firesOnce(ganttBase, 'expandnode');

        await t.click('.b-gantt-task-parent');
    });

    t.it('Should NOT toggle parent tasks after click on the task bar when toggleParentTasksOnClick is set to false', async t => {
        ganttBase = new GanttBase({
            appendTo                 : document.body,
            height                   : 200,
            toggleParentTasksOnClick : false,
            project                  : {
                tasksData : [
                    {
                        name      : 'parent',
                        startDate : new Date(2020, 11, 21),
                        duration  : 4,
                        children  : [{
                            startDate : new Date(2020, 11, 21),
                            name      : 'child',
                            duration  : 4
                        }]
                    }
                ]
            }
        });

        t.wontFire(ganttBase, 'expandnode');

        await t.click('.b-gantt-task-parent');
    });

    t.it('Should be able to toggle toggleParentTasksOnClick flag during runtime', async t => {
        ganttBase = new GanttBase({
            appendTo                 : document.body,
            height                   : 200,
            toggleParentTasksOnClick : false,
            project                  : {
                tasksData : [
                    {
                        name      : 'parent',
                        startDate : new Date(2020, 11, 21),
                        duration  : 4,
                        children  : [{
                            startDate : new Date(2020, 11, 21),
                            name      : 'child',
                            duration  : 4
                        }]
                    }
                ]
            }
        });

        ganttBase.toggleParentTasksOnClick = true;
        t.firesOnce(ganttBase, 'expandnode');

        await t.click('.b-gantt-task-parent');
    });

    // https://github.com/bryntum/support/issues/416
    t.it('Should be able to map children field to different dataSource', async t => {
        class Task extends TaskModel {
            static get fields() {
                return [
                    { name : 'children', dataSource : 'theChildren' }
                ];
            }
        }

        ganttBase = new GanttBase({
            appendTo                 : document.body,
            height                   : 200,
            toggleParentTasksOnClick : false,
            project                  : {
                taskModelClass : Task,
                tasksData      : [
                    {
                        id          : 10,
                        name        : 'parent',
                        expanded    : true,
                        startDate   : new Date(2020, 11, 21),
                        theChildren : [{
                            id        : 11,
                            startDate : new Date(2020, 11, 21),
                            name      : 'child',
                            cls       : 'child',
                            duration  : 4
                        }]
                    }
                ]
            }
        });

        await t.waitForSelector('.b-gantt-task-parent');
        await t.waitForSelector('.b-gantt-task.child');

        t.is(ganttBase.taskStore.getById(10).children.length, 1, '1 child');
    });

    // https://github.com/bryntum/support/issues/3382
    t.it('Should take an earlier-than-display-range visibleDate into account when choosing date range for time axis', async t => {
        t.mockUrl('load', {
            responseText : JSON.stringify({
                revision : 1,
                tasks    : {
                    rows : t.getProjectTaskData()
                }
            })
        });

        ganttBase = new GanttBase({
            appendTo    : document.body,
            visibleDate : {
                date : new Date(2016, 4, 2)
            },
            project : {
                autoLoad  : true,
                transport : {
                    load : { url : 'load' }
                }
            }
        });

        await t.waitForSelector('.b-gantt-task');

        const range = ganttBase.visibleDateRange;

        t.is(ganttBase.startDate, new Date(2016, 4, 1), 'Gantt range startDate decided by visibleDate');
        t.is(ganttBase.endDate, new Date(2017, 0, 29), 'Gantt range endDate decided by project data');
        t.is(range.startDate, new Date(2016, 4, 2), 'View range starts at visibleDate');
        t.isGreater(range.endDate, new Date(2016, 4, 2), 'View range ends after visibleDate');
    });

    // https://github.com/bryntum/support/issues/3382
    t.it('Should take an later-than-display-range visibleDate into account when choosing date range for time axis', async t => {
        t.mockUrl('load', {
            responseText : JSON.stringify({
                revision : 1,
                tasks    : {
                    rows : t.getProjectTaskData()
                }
            })
        });

        ganttBase = new GanttBase({
            appendTo    : document.body,
            visibleDate : {
                date : new Date(2018, 4, 2)
            },
            project : {
                autoLoad  : true,
                transport : {
                    load : { url : 'load' }
                }
            }
        });

        // Wait for the project data to have taken effect.
        await t.waitFor(() => {
            return (
                ganttBase.startDate.getTime() === new Date(2017, 0, 15).getTime() &&
                ganttBase.endDate.getTime() === new Date(2018, 4, 6).getTime() &&
                ganttBase.visibleDateRange.startDate.getTime() < new Date(2018, 4, 2).getTime() &&
                ganttBase.visibleDateRange.endDate.getTime()   > new Date(2018, 4, 2).getTime()
            );
        });

        const range = ganttBase.visibleDateRange;

        t.is(ganttBase.startDate, new Date(2017, 0, 15), 'Gantt range startDate decided by project data');
        t.is(ganttBase.endDate, new Date(2018, 4, 6), 'Gantt range endDate decided by visibleDate');
        t.isLess(range.startDate, new Date(2018, 4, 2), 'View range starts before visibleDate');
        t.isGreater(range.endDate, new Date(2018, 4, 2), 'View range ends after visibleDate');
    });

    // https://github.com/bryntum/support/issues/3382
    t.it('Should take visibleDate into account when loading inline data', async t => {
        ganttBase = new GanttBase({
            appendTo : document.body,
            columns  : [
                { type : 'name' }
            ],

            viewPreset : {
                base      : 'weekAndDayLetter',
                tickWidth : 50
            },

            visibleDate : {
                date  : new Date(2017, 0, 2),
                block : 'center'
            },

            tasks : [
                { id : 1, name : 'Write docs 1', startDate : '2017-01-02', endDate : '2017-01-06', leaf : true, percentDone : 50, manuallyScheduled : true },
                { id : 2, name : 'Write docs 2', startDate : '2017-06-10', endDate : '2017-06-16', leaf : true, percentDone : 50, manuallyScheduled : true },
                { id : 3, name : 'Write docs 3', startDate : '2017-11-02', endDate : '2017-11-06', leaf : true, percentDone : 50, manuallyScheduled : true },
                { id : 4, name : 'Write docs 4', startDate : '2015-01-02', endDate : '2018-02-06', leaf : true, percentDone : 50, manuallyScheduled : true },
                { id : 5, name : 'Write docs 5', startDate : '2016-03-02', endDate : '2018-03-06', leaf : true, percentDone : 50, manuallyScheduled : true },
                { id : 6, name : 'Write docs 6', startDate : '2017-04-02', endDate : '2018-04-06', leaf : true, percentDone : 50, manuallyScheduled : true }
            ],
            assignments : [
                { id : 1, event : 1, resource : 1 },
                { id : 2, event : 1, resource : 2 }
            ],
            resources : [
                { id : 1, name : 'Celia Johnsson' },
                { id : 2, name : 'Lee Brook' },
                { id : 3, name : 'Macy von Schnitzel' }
            ]
        });

        await t.waitForSelector('.b-gantt-task');

        t.isApprox(ganttBase.viewportCenterDate, new Date(2017, 0, 2), 13 * 3600 * 1000, 'visibleDate is in center');
    });

    t.it('Inactive tasks are highlighted in the locked grid when normal part is collapsed', async t => {
        ganttBase = new GanttBase({
            appendTo : document.body,
            project  : {
                tasksData : [
                    {
                        id        : 1,
                        startDate : new Date(2021, 8, 20),
                        duration  : 1
                    }
                ]
            }
        });

        await ganttBase.project.commitAsync();

        ganttBase.getSubGrid('normal').collapse();

        const task = ganttBase.taskStore.first;

        await t.waitForRowsVisible(ganttBase);

        await task.setInactive(true);

        t.selectorExists('.b-grid-row.b-inactive[data-id=1]', 'locked grid row got b-inactive class');

        await task.setInactive(false);

        t.selectorNotExists('.b-grid-row.b-inactive[data-id=1]', 'locked grid row has no b-inactive class');
    });

    t.it('Should scroll task bar into view when scrollTaskIntoViewOnCellClick flag is set', async t => {
        ganttBase = new GanttBase({
            appendTo                      : document.body,
            startDate                     : new Date(2020, 1, 21),
            endDate                       : new Date(2020, 11, 21),
            scrollTaskIntoViewOnCellClick : true,
            height                        : 400,
            project                       : {
                tasksData : [
                    {},
                    {},
                    {},
                    {
                        name      : 'parent',
                        startDate : new Date(2020, 1, 1),
                        duration  : 4,
                        expanded  : true,
                        children  : [{
                            startDate         : new Date(2020, 6, 21),
                            name              : 'child',
                            manuallyScheduled : true,
                            duration          : 4
                        }]
                    },
                    {},
                    {},
                    {},
                    {}
                ]
            }
        });

        let horizontalScrollEndFired;

        ganttBase.timeAxisSubGrid.scrollable.on('scrollend', () => horizontalScrollEndFired = true);
        t.wontFire(ganttBase.scrollable, 'scroll');

        await t.click('.b-grid-cell:contains(child)');
        await t.waitFor(() => horizontalScrollEndFired);
        await t.waitForSelector('.b-gantt-task');

        t.elementIsTop('.b-gantt-task');
        t.is(ganttBase.scrollable.y, 0, 'Y scroll did not change');
    });

    // https://github.com/bryntum/bryntum-suite/pull/3726
    t.it('Should show outline for task only when using keyboard', async t => {
        ganttBase = new GanttBase({
            appendTo  : document.body,
            startDate : new Date(2020, 6, 21),
            endDate   : new Date(2020, 6, 29),
            project   : {
                tasksData : [
                    {
                        startDate         : new Date(2020, 6, 21),
                        name              : 'child',
                        manuallyScheduled : true,
                        duration          : 4
                    }
                ]
            }
        });

        await t.click('.b-gantt-task');

        let style = t.global.getComputedStyle(t.query('.b-gantt-task')[0]);

        t.is(style.outlineWidth, '0px', 'No outline when not using keyboard');

        await t.type(null, '[RIGHT]');

        style = t.global.getComputedStyle(t.query('.b-gantt-task')[0]);

        t.isnt(style.outlineWidth, '0px', 'Outline when using keyboard');
    });

    t.it('Should lazy load parent node with milestone', async t => {
        t.mockUrl('load', {
            responseText : JSON.stringify({
                success : true,
                data    : [{
                    startDate : '2023-01-05',
                    duration  : 0,
                    name      : 'Milestone B46',
                    nodeType  : 'milestones',
                    parentId  : '846cc579-78e0-48c4-b216-7384ca722439',
                    rollup    : 'true',
                    children  : false
                }]
            })
        });

        ganttBase = new GanttBase({
            appendTo  : document.body,
            startDate : '2023-01-05',
            endDate   : '2023-04-29',
            rowHeight : 70,
            project   : {
                startDate : '2023-01-05',
                duration  : 30,
                taskStore : {
                    readUrl : 'load'
                },
                eventsData : [
                    {
                        id        : 10,
                        name      : 'Project A',
                        startDate : '2023-01-05',
                        children  : true
                    }
                ]
            }
        });

        await t.waitForRowsVisible();

        ganttBase.toggleCollapse(ganttBase.taskStore.first);

        await t.waitForSelector('.b-milestone');
    });
});
