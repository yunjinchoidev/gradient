import { ManuallyScheduledColumn } from '../../build/gantt.module.js?457330';

StartTest((t) => {
    let gantt;

    t.beforeEach((t) => {
        gantt && gantt.destroy();
    });

    t.it('Should be possible to edit event mode', (t) => {
        gantt = t.getGantt({
            appendTo : document.body,
            features : {
                nonWorkingTime : false
            },
            columns : [
                { type : ManuallyScheduledColumn.type, width : 80 }
            ]
        });

        const task = gantt.taskStore.getAt(5);

        t.chain(
            { waitForEvent : [gantt.project, 'load'] },
            { waitForRowsVisible : gantt },

            { click : '[data-index=5] [data-column=manuallyScheduled] .b-checkbox' },

            async() => {
                t.ok(task.manuallyScheduled, 'Manually scheduled mode is ON');

                const dependency = task.predecessors.find(d => d.from == 11);

                // remove dependency to make sure the task won't fallback
                gantt.dependencyStore.remove(dependency);

                await task.commitAsync();

                t.is(task.startDate, new Date(2017, 0, 26), 'start date is correct');
            },

            { click : '[data-index=5] [data-column=manuallyScheduled] .b-checkbox' },

            { waitForPropagate : task },

            () => {
                t.notOk(task.manuallyScheduled, 'Manually scheduled mode is OFF');
                t.is(task.startDate, new Date(2017, 0, 24), 'Start date is correct');
            }
        );
    });
});
