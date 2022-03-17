StartTest(t => {
    let gantt;

    t.beforeEach(t => gantt?.destroy());

    t.it('Should not throw when adding a task, scrolling to it, reloading data etc', async t => {

        const rows = [];

        for (let id = 0; id <= 41; id++) {
            rows.push({ id,  duration : 1 });
        }

        t.mockUrl('load', {
            responseText : JSON.stringify({
                success : true,
                tasks   : {
                    rows
                }
            })
        });

        gantt = await t.getGanttAsync({
            height  : 160,
            project : {
                transport : {
                    load : { url : 'load' }
                }
            }
        });

        async function addTaskAndScrollToIt() {
            t.diag('Adding a task');

            const added = gantt.taskStore.rootNode.appendChild({ name : 'New task', duration : 1 });

            await gantt.project.commitAsync();

            t.diag('Scrolling to the task');

            return gantt.scrollRowIntoView(added);
        }

        await gantt.project.load();

        await addTaskAndScrollToIt();

        await gantt.project.load();

        await addTaskAndScrollToIt();

        await t.waitForTextPresent('New task');

        t.pass('New task rendered');
    });

    // https://github.com/bryntum/support/issues/2251
    t.it('Should render tasks before calculations are finished', async t => {
        let calculationsDone = false,
            rendered = false;

        gantt = t.getGantt({
            tickSize : 50,

            enableEventAnimations : false,

            project : {
                tasksData : [
                    {
                        id       : 1,
                        name     : 'Parent 1',
                        expanded : true,
                        children : [
                            { id : 11, name : 'Child 1', startDate : '2017-01-16', duration : 2, endDate : '2017-01-17' }
                        ]
                    }
                ],

                listeners : {
                    refresh({ isCalculated }) {
                        if (isCalculated) {
                            calculationsDone = true;
                            t.ok(gantt.readOnly, 'Gantt is read-only during calculation');
                        }
                    }
                }
            },

            listeners : {
                renderTask({ taskRecord }) {
                    if (taskRecord.id === 11) {
                        if (!rendered) {
                            t.notOk(calculationsDone, 'Rendered event before calculations finished');

                            t.selectorCountIs('.b-gantt-task', 1, 'Parent task not rendered');

                            // Event should have incorrect width, since data is not yet normalized
                            t.hasApproxWidth('[data-task-id="11"]', 50, 'Correct incorrect width initially');
                        }

                        rendered = true;
                    }
                }
            }
        });

        await t.waitFor(() => calculationsDone);
        t.ok(calculationsDone, 'Calculations are finished');
        t.ok(rendered, 'Tasks are rendered');

        await t.waitFor(() => !gantt.readOnly);

        t.selectorCountIs('.b-gantt-task', 2, 'Parent task rendered');
        t.hasApproxWidth('[data-task-id="11"]', 100, 'Correct width when calculation has finished');
    });
});
