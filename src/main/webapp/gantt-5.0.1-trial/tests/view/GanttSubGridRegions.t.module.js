import { Gantt } from '../../build/gantt.module.js?457330';

StartTest(t => {

    let gantt;

    t.beforeEach(t => {
        Gantt.destroy(gantt);
    });

    t.it('Sanity', async t => {
        gantt = new Gantt({
            appendTo  : document.body,
            height    : 600,
            startDate : new Date(2019, 8, 18),
            endDate   : new Date(2019, 8, 25),

            columns : [
                { region : 'left', type : 'name', width : 250 },
                { region : 'middle', field : 'foo', width : 250 }
            ],
            tasks : [
                { id : 1, name : 'Task', foo : 'bar', startDate : new Date(2019, 8, 18), duration : 2, durationUnit : 'd' }
            ]
        });

        await t.waitForSelector('.b-grid-cell:contains(Task)');
        await t.waitForSelector('.b-grid-cell:contains(bar)');

        t.waitForEvent(gantt.taskStore, 'update');

        await t.dragBy({
            source : '.b-gantt-task',
            delta  : [100, 0]
        });

    });
});
