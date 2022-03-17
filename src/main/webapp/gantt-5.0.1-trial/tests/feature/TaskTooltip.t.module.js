import { Gantt } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt;

    Object.assign(window, {
        Gantt
    });

    t.beforeEach(() => gantt && gantt.destroy());

    t.it('Should show task tooltip when hovering task', async t => {
        gantt = t.getGantt({
            appendTo                 : document.body,
            durationDisplayPrecision : 0
        });
        await t.waitForPropagate(gantt.project);

        const task = gantt.taskStore.getById(11);
        task.duration = 2.5;
        await t.waitForPropagate(gantt.project);

        // First down to the row
        await t.moveMouseTo('.id11');

        // Then out to the task, to not get any other tooltip in the way
        await t.moveMouseTo('.b-gantt-task.id11');

        await t.waitForSelector('.b-gantt-task-tooltip');

        t.is(document.querySelector('.b-gantt-task-title').innerText, task.name, 'Correct title');
        t.is(document.querySelector('.b-tooltip .b-right').innerText, '3 days', 'Respected durationDisplayPrecision');
    });
});
