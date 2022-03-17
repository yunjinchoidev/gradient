import { Scheduler, Gantt } from '../../build/gantt.module.js?457330';

StartTest(t => {
    t.beforeEach(() => Scheduler.destroy(...Scheduler.queryAll(w => !w.parent)));

    t.it('Gantt + Scheduler with thin bundle sanity', async t => {
        // NOTE: Gantt & Scheduler are not supposed to be able to share a project, thus it is not tested

        const scheduler = new Scheduler({
            appendTo  : document.body,
            width     : 1024,
            height    : 350,
            startDate : new Date(2022, 1, 11),
            endDate   : new Date(2022, 2, 1),
            tickSize  : 50,
            columns   : [
                { field : 'name', text : 'Resource', width : 100 }
            ],
            project : {
                events      : [{ id : 1, name : 'Event 1', startDate : '2022-02-11', duration : 5, status : 'todo' }],
                resources   : [{ id : 1, name : 'Resource 1' }],
                assignments : [{ id : 1, eventId : 1, resourceId : 1 }]
            }
        });

        const gantt = new Gantt({
            appendTo  : document.body,
            width     : 1024,
            height    : 350,
            startDate : new Date(2022, 1, 11),
            endDate   : new Date(2022, 2, 1),
            tickSize  : 50,
            project   : {
                tasks       : [{ id : 1, name : 'Event 1', startDate : '2022-02-11', duration : 5, status : 'todo' }],
                resources   : [{ id : 1, name : 'Resource 1' }],
                assignments : [{ id : 1, eventId : 1, resourceId : 1 }]
            }
        });

        await scheduler.project.commitAsync();
        await gantt.project.commitAsync();

        await t.waitForSelector('.b-gantt-task');
        await t.waitForSelector('.b-sch-event');

        // Ensure something rendered
        t.selectorExists('.b-sch-event', 'Scheduler event rendered');
        t.selectorExists('.b-gantt-task', 'Gantt task rendered');

        // Ensure css worked
        t.isApproxPx(t.rect('.b-sch-event').left, 355, 'Event has correct x');
        t.hasApproxWidth('.b-sch-event', 249, 'Event has correct width');
        t.hasApproxHeight('.b-gantt .b-grid-cell', 45, 'Gantt row has height');
        t.hasApproxWidth('.b-gantt .b-grid-cell', 200, 'Gantt cell has width');
        t.isApproxPx(t.rect('.b-gantt-task').left, 455, 'Task has correct x');
        t.hasApproxWidth('.b-gantt-task', 249, 'Task has correct width');
    });
});
