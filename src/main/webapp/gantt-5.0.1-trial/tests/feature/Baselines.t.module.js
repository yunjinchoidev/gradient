import { Baseline, TaskModel } from '../../build/gantt.module.js?457330';

StartTest(t => {

    let gantt;

    t.beforeEach(() => gantt?.destroy());

    t.it('Baseline tooltip', async t => {
        gantt = await t.getGanttAsync({
            height    : 700,
            appendTo  : document.body,
            startDate : new Date(2011, 6, 1),
            endDate   : new Date(2011, 6, 30),
            features  : {
                baselines   : true,
                taskTooltip : false
            },
            rowHeight : 60,
            project   : {
                // set to `undefined` to overwrite the default '2017-01-16' value in `t.getProject`
                startDate        : undefined,
                dependenciesData : [],
                eventsData       : [
                    {
                        id        : 1,
                        name      : 'Task 1',
                        startDate : new Date(2011, 6, 1),
                        endDate   : new Date(2011, 6, 5),
                        baselines : [{}]
                    },
                    {
                        id        : 123,
                        name      : 'Task 123',
                        startDate : new Date(2011, 6, 15),
                        endDate   : new Date(2011, 6, 23),
                        baselines : [{}],

                        children : [
                            {
                                id        : 2,
                                name      : 'Task 2',
                                startDate : new Date(2011, 6, 16),
                                endDate   : new Date(2011, 6, 20),
                                baselines : [{}]
                            },
                            {
                                id        : 3,
                                name      : 'Task 3',
                                startDate : new Date(2011, 6, 18),
                                endDate   : new Date(2011, 6, 22),
                                baselines : [{
                                // Task id 3 has slipped by one day from its baseline end date of
                                // 21 Jul and 16 days. It ends on 22nd with 17 days.
                                    endDate  : new Date(2011, 6, 21),
                                    duration : 16
                                }]
                            }
                        ]
                    },
                    {
                        id        : 4,
                        name      : 'Task 4',
                        startDate : new Date(2011, 6, 25),
                        endDate   : new Date(2011, 6, 28),
                        baselines : [{}]
                    },
                    {
                        id        : 5,
                        name      : 'Task 5',
                        startDate : new Date(2011, 6, 28),
                        endDate   : new Date(2011, 6, 28),
                        baselines : [{}]
                    },
                    {
                        id        : 6,
                        name      : 'Task 6',
                        startDate : new Date(2011, 6, 28),
                        duration  : 0,
                        baselines : [{}]
                    }
                ]
            }
        });

        // Hover the baseline element of the first task
        await t.moveMouseTo('[data-task-id="baselinesFor1"] .b-task-baseline');

        // And we should get a tip for that baseline
        await t.waitForSelector('.b-tooltip-content:contains("Task 1 (baseline 1)")');
    });

    t.it('Baseline elements restored from cache upon element recycle', async t => {
        gantt = await t.getGanttAsync({
            height    : 300,
            startDate : new Date(2011, 6, 1),
            endDate   : new Date(2011, 6, 30),
            features  : {
                baselines   : true,
                taskTooltip : false
            },
            rowHeight : 60,
            project   : {
                startDate : new Date(2011, 6, 1),
                endDate   : new Date(2011, 6, 30),
                tasksData : [
                    {
                        id        : 1,
                        name      : 'Task 1',
                        startDate : new Date(2011, 6, 1),
                        duration  : 4,
                        endDate   : new Date(2011, 6, 5),
                        baselines : [{}]
                    }
                ]
            }
        });

        await gantt.scrollTaskIntoView(gantt.taskStore.last);

        await gantt.scrollTaskIntoView(gantt.taskStore.first);

        await t.waitForSelector('[data-task-id="baselinesFor1"] .b-task-baseline');

        t.pass('Baselines for Task 1 restored');
    });

    t.it('Some tasks lack baseline', t => {
        gantt = t.getGantt({
            height    : 700,
            appendTo  : document.body,
            startDate : new Date(2011, 6, 1),
            endDate   : new Date(2011, 6, 30),
            features  : {
                baselines   : true,
                taskTooltip : false
            },
            rowHeight    : 60,
            dependencies : [],
            tasks        : [
                {
                    id        : 1,
                    name      : 'Task 1',
                    startDate : new Date(2011, 6, 1),
                    endDate   : new Date(2011, 6, 5)
                },
                {
                    id        : 123,
                    name      : 'Task 123',
                    startDate : new Date(2011, 6, 15),
                    endDate   : new Date(2011, 6, 23),
                    children  : [
                        {
                            id        : 2,
                            name      : 'Task 2',
                            startDate : new Date(2011, 6, 16),
                            endDate   : new Date(2011, 6, 20)
                        },
                        {
                            id        : 3,
                            name      : 'Task 3',
                            startDate : new Date(2011, 6, 18),
                            endDate   : new Date(2011, 6, 22),
                            baselines : [{
                            // Task id 3 has slipped by one day from its baseline end date of
                            // 21 Jul and 16 days. It ends on 22nd with 17 days.
                                endDate  : new Date(2011, 6, 21),
                                duration : 16
                            }]
                        }
                    ]
                },
                {
                    id        : 4,
                    name      : 'Task 4',
                    startDate : new Date(2011, 6, 25),
                    endDate   : new Date(2011, 6, 28)
                },
                {
                    id        : 5,
                    name      : 'Task 5',
                    startDate : new Date(2011, 6, 28),
                    endDate   : new Date(2011, 6, 28)
                },
                {
                    id        : 6,
                    name      : 'Task 6',
                    startDate : new Date(2011, 6, 28),
                    duration  : 0
                }
            ]
        });

        // Updating threw an error.
        t.livesOk(() => {
            gantt.taskStore.getById(1).startDate = new Date(2011, 6, 2);
        });
    });

    // https://github.com/bryntum/support/issues/2931
    t.it('Baseline of a milestone task where baseline was not a milestone should not show diamond ', async t => {
        gantt = await t.getGanttAsync({
            startDate : '2019-01-23',
            endDate   : '2019-01-22',
            rowHeight : 100,
            features  : {
                baselines : true
            },
            project : {
                startDate  : '2019-01-23',
                eventsData : [
                    {
                        id        : 1,
                        name      : 'Contact designers',
                        startDate : '2019-01-23',
                        duration  : 0,
                        baselines : [
                            {
                                startDate : '2019-01-22',
                                endDate   : '2019-01-22'
                            },
                            {
                                startDate : '2019-01-22',
                                endDate   : '2019-01-23'
                            }
                        ]
                    }
                ]
            }
        });

        const milestoneEls = t.query('.b-task-baseline');

        t.selectorCountIs('.b-task-baseline-milestone:first-child', 1, '1 milestone baseline task');

        // https://developer.mozilla.org/en-US/docs/Web/API/Window/getComputedStyle
        if (!t.bowser.safari) {
            t.isnt(window.getComputedStyle(milestoneEls[0], ':before').content, 'none', 'Should find diamond for 0 duration baseline');
            t.is(window.getComputedStyle(milestoneEls[1], ':before').content, 'none', 'Should NOT find diamond for regular task baseline');
        }
    });

    // https://github.com/bryntum/support/issues/435
    t.it('Should support mapping Baseline related fields', async t => {
        class MyBaseline extends Baseline {
            static get fields() {
                return [
                    { name : 'startDate', dataSource : 'StartDate', type : 'date' },
                    { name : 'endDate', dataSource : 'EndDate', type : 'date' }
                ];
            }
        }

        MyBaseline.exposeProperties();

        class MyTask extends TaskModel {
            static get fields() {
                return [
                    { name : 'baselines', dataSource : 'Baselines' }
                ];
            }

            static get defaultConfig() {
                return {
                    baselineModelClass : MyBaseline
                };
            }
        }

        gantt = await t.getGanttAsync({
            startDate : '2019-01-23',
            endDate   : '2019-01-22',
            rowHeight : 100,
            features  : {
                baselines : true
            },
            project : {
                taskModelClass : MyTask,
                startDate      : '2019-01-23',
                eventsData     : [
                    {
                        id        : 1,
                        name      : 'Contact designers',
                        startDate : '2019-01-23',
                        duration  : 2,
                        Baselines : [
                            {
                                StartDate : '2019-01-22',
                                EndDate   : '2019-01-23'
                            },
                            {
                                StartDate : '2019-01-22',
                                EndDate   : '2019-01-23'
                            }
                        ]
                    }
                ]
            }
        });

        const
            task = gantt.taskStore.first;

        t.is(task.hasBaselines, true, 'Task reports having baselines');
        t.selectorCountIs('.b-task-baseline', 2, '2 baseline tasks');

        t.is(task.baselines.first.startDate, new Date(2019, 0, 22), 'Start date read ok');
        t.is(task.baselines.first.endDate, new Date(2019, 0, 23), 'End date read ok');
    });

    // https://github.com/bryntum/support/issues/431
    t.it('Should set proper parentIndex of newly set baseline', async t => {
        gantt = await t.getGanttAsync({
            startDate : '2019-01-23',
            endDate   : '2019-01-22',
            rowHeight : 100,
            features  : {
                baselines : true
            },
            project : {
                startDate  : '2019-01-23',
                eventsData : [
                    {
                        id        : 1,
                        name      : 'Contact designers',
                        startDate : '2019-01-23',
                        duration  : 2
                    }
                ]
            }
        });

        const task = gantt.taskStore.first;

        gantt.taskStore.setBaseline(1);

        t.is(task.baselines.first.parentIndex, 0, 'Task baseline has proper parentIndex');
    });

    // https://github.com/bryntum/support/issues/3321
    t.it('Should position baselines correctly when task has no main startDate', async t => {
        gantt = t.getGantt({
            height   : 700,
            appendTo : document.body,
            features : {
                baselines : true
            },
            rowHeight : 60,
            project   : {
                tasksData : [
                    {
                        id        : 2,
                        name      : 'Task 2',
                        startDate : new Date(2017, 0, 16),
                        endDate   : new Date(2017, 0, 22),
                        leaf      : true
                    },
                    {
                        id        : 3,
                        name      : 'Task 3',
                        baselines : [{
                            startDate : new Date(2017, 0, 19),
                            endDate   : new Date(2017, 0, 25)
                        }]
                    }
                ]
            }
        });

        await t.waitForSelector('.b-baseline-wrap');

        t.isApprox(t.rect('.b-baseline-wrap').top, t.rect('.b-grid-row[data-index=1]').top + 30, 10, 'Correct top position');
    });
});
