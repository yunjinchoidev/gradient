import { Panel, TaskModel } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt;

    t.beforeEach(() => {
        if (gantt) {
            gantt.project.destroy();
            gantt.destroy();
        }
    });

    function assertPercentBarWidth(t, taskRecord) {
        const
            taskElement   = gantt.getElementFromTaskRecord(taskRecord),
            percentBar    = taskElement.querySelector('.b-task-percent-bar'),
            expectedWidth = taskElement.offsetWidth * taskRecord.percentDone / 100;

        t.isApprox(expectedWidth, percentBar.offsetWidth, `Correct percent bar width for ${taskRecord.name}, ${taskRecord.percentDone}%`);
    }

    t.it('Should render percent bars', async t => {
        gantt = t.getGantt();

        await gantt.project.commitAsync();

        const taskElements = Array.from(document.querySelectorAll('.b-gantt-task-wrap:not(.b-milestone-wrap)'));

        t.selectorExists('.b-task-percent-bar', 'Percent bar rendered');
        t.selectorCountIs('.b-task-percent-bar', taskElements.length, 'One per normal task rendered');

        // Check all widths
        taskElements.forEach(taskElement => {
            assertPercentBarWidth(t, gantt.resolveTaskRecord(taskElement));
        });
    });

    t.it('Should update percent bar when data changes', async t => {
        gantt = t.getGantt({
            enableEventAnimations : false
        });

        await gantt.project.commitAsync();

        const task = gantt.taskStore.getById(11);

        await task.setPercentDone(10);

        assertPercentBarWidth(t, task);

        await task.setPercentDone(90);

        assertPercentBarWidth(t, task);

        await task.setPercentDone(100);

        assertPercentBarWidth(t, task);
    });

    t.it('Should set percent to 0 if dragging fully to the start of the bar', async t => {
        gantt = t.getGantt();

        await gantt.project.commitAsync();

        const task = gantt.taskStore.getById(11);

        task.cls = 'foo';

        await task.setDuration(1);
        await task.setPercentDone(10);

        t.chain(
            { moveCursorTo : '.foo.b-gantt-task' },
            { drag : '.foo .b-task-percent-bar-handle', by : [-100, 0] },
            { waitForPropagate : gantt.project },

            () => {
                t.is(task.percentDone, 0);
                t.is(task.duration, 1);
            }
        );
    });

    t.it('Should be possible to resize percent bar to 100% of the task width', async t => {
        gantt = t.getGantt({
            tickSize : 40,
            features : {
                taskTooltip : false
            }
        });

        t.chain(
            { waitForPropagate : gantt },
            { moveMouseTo : '.b-gantt-task.id11' },
            { drag : '.id11 .b-task-percent-bar-handle', by : [400, 0], dragOnly : true },
            async() => {
                const
                    barEl     = document.querySelector('.id11 .b-task-percent-bar'),
                    barWidth  = barEl.offsetWidth,
                    taskWidth = barEl.parentElement.offsetWidth;

                t.is(barWidth, taskWidth, 'Percent bar size matches 100% of task width');
            },
            { moveMouseTo : '.b-gantt-task.id11', offset : [0, '50%'] },
            async() => {
                const
                    barEl     = document.querySelector('.id11 .b-task-percent-bar'),
                    barWidth  = barEl.offsetWidth;

                t.is(barWidth, 0, 'Percent bar size is ok');
            },
            { mouseUp : null }
        );
    });

    t.it('Should not show resize handle if Gantt is readOnly', async t => {
        gantt = t.getGantt({
            readOnly : true,
            features : {
                taskTooltip : false
            }
        });

        await gantt.project.commitAsync();

        const task = gantt.taskStore.getById(11);

        task.cls = 'foo';

        t.chain(
            { moveCursorTo : '.b-gantt-task.foo' },

            () => {
                t.elementIsNotVisible('.foo .b-task-percent-bar-handle', 'Handle not shown when readOnly is set');
            }
        );
    });

    t.it('Should support disabling', async t => {
        gantt = t.getGantt({
            tasks : [
                {
                    id        : 6,
                    name      : 'Task 6',
                    startDate : new Date(2011, 6, 28),
                    duration  : 5
                }
            ]
        });

        await gantt.project.commitAsync();

        gantt.features.percentBar.disabled = true;

        t.selectorNotExists('.b-task-percent-bar', 'No percent bars');

        gantt.features.percentBar.disabled = false;

        t.selectorExists('.b-task-percent-bar', 'Percent bars shown');

        gantt.features.percentBar.allowResize = false;

        t.chain(
            { moveCursorTo : '.b-gantt-task-wrap:not(.b-gantt-task-parent) .b-gantt-task' },

            next => {
                t.elementIsNotVisible('.b-task-percent-bar-handle', 'resize handle hidden');
                gantt.features.percentBar.allowResize = true;
                next();
            },
            { moveCursorTo : [0, 0] },
            { moveCursorTo : '.b-gantt-task-wrap:not(.b-gantt-task-parent) .b-gantt-task' },
            next => {
                t.elementIsVisible('.b-task-percent-bar-handle', 'resize handle visible');
            }
        );
    });

    t.it('Percent bar drag should not affect the task duration', async t => {
        const panel = new Panel({
            adopt  : document.body,
            layout : 'fit',
            items  : [
                gantt = t.getGantt({
                    appendTo : null,
                    features : {
                        taskTooltip : false
                    }
                })
            ]
        });

        const task = gantt.taskStore.getById(11);

        task.cls = 'foo';

        await task.setDuration(1);
        await task.setPercentDone(10);

        t.chain(
            { moveCursorTo : '.foo.b-gantt-task' },
            { drag : '.foo .b-task-percent-bar-handle', by : [100, 0] },
            { waitForPropagate : gantt.project },

            () => {
                t.is(task.percentDone, 100);
                t.is(task.duration, 1);
                panel.destroy();
                gantt = null;
            }
        );
    });

    // https://github.com/bryntum/support/issues/2635
    t.it('Should not render percent bar in milestone task', async t => {
        gantt = t.getGantt();

        await t.moveCursorTo('.b-milestone');

        t.selectorNotExists('.b-milestone .b-task-percent-bar-handle', 'No percent bar for milestones');
    });

    t.it('Should use custom field instead of percentDone', async t => {
        const MyTaskModel = class extends TaskModel {
            static get fields() {
                return [
                    { name : 'myPDone', type : 'number' }
                ];
            }
        };

        gantt = await t.getGanttAsync({
            project : {
                taskModelClass : MyTaskModel,
                eventsData     : [
                    {
                        id       : 1,
                        name     : 'Parent',
                        expanded : true,
                        myPDone  : 40,
                        children : [
                            {
                                id          : 11,
                                name        : 'Leaf',
                                startDate   : '2021-04-26',
                                duration    : 5,
                                percentDone : 0,
                                myPDone     : 20
                            },
                            {
                                id          : 12,
                                name        : 'Milestone',
                                startDate   : '2021-04-26',
                                duration    : 0,
                                percentDone : 0,
                                myPDone     : 50
                            }
                        ]
                    }
                ]
            },
            features : {
                percentBar : {
                    displayField : 'myPDone',
                    valueField   : 'myPDone'
                }
            }
        });

        await t.waitForSelector('.b-task-percent-bar');

        const { tickSize } = gantt;

        t.hasApproxWidth('[data-task-id="1"] .b-task-percent-bar', tickSize * 2, 1, 'Parent percent done is ok');
        t.hasApproxWidth('[data-task-id="11"] .b-task-percent-bar', tickSize, 1, 'Leaf percent done is ok');
        t.notOk(document.querySelector('[data-task-id="12"] .b-task-percent-bar'), 'Not percent bar in milestone');

        await t.moveMouseTo('[data-task-id="11"]');

        await t.dragBy({
            source : '[data-task-id="11"] .b-task-percent-bar-handle',
            delta  : [tickSize * 2, 0]
        });

        t.hasApproxWidth('[data-task-id="11"] .b-task-percent-bar', tickSize * 3, 1, 'Leaf percent done is ok');
        t.isApprox(gantt.taskStore.getById(11).myPDone, 60, 2, 'Percent done value changed');
    });
});
