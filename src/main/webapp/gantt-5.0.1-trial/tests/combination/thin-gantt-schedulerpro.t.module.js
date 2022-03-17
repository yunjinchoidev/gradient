import { SchedulerPro, Gantt, ProjectModel } from '../../build/gantt.module.js?457330';

StartTest(t => {
    t.beforeEach(() => SchedulerPro.destroy(...SchedulerPro.queryAll(w => !w.parent)));

    t.it('Gantt + SchedulerPro with thin bundle sanity', async t => {
        const project = new ProjectModel({
            tasks : [
                {
                    id       : 1,
                    name     : 'Parent 1',
                    expanded : true,
                    children : [
                        { id : 2, name : 'Event 1', startDate : '2022-02-07', duration : 2 },
                        { id : 3, name : 'Event 2', startDate : '2022-02-07', duration : 2 }
                    ]
                }
            ],
            resources   : [{ id : 1, name : 'Resource 1' }],
            assignments : [
                { id : 1, eventId : 2, resourceId : 1 },
                { id : 2, eventId : 3, resourceId : 1 }
            ]
        });

        new SchedulerPro({
            appendTo  : document.body,
            width     : 1024,
            height    : 350,
            startDate : new Date(2022, 1, 6),
            endDate   : new Date(2022, 1, 12),
            columns   : [
                { field : 'name', text : 'Resource', width : 100 }
            ],
            project
        });

        new Gantt({
            appendTo  : document.body,
            width     : 1024,
            height    : 350,
            startDate : new Date(2022, 1, 6),
            endDate   : new Date(2022, 1, 12),
            project
        });

        await project.commitAsync();

        await t.waitForSelector('.b-gantt-task');
        await t.waitForSelector('.b-sch-event');

        // Ensure something rendered
        t.selectorCountIs('.b-sch-event', 2, 'Scheduler events rendered');
        t.selectorCountIs('.b-gantt-task', 3, 'Gantt tasks rendered');

        // Ensure css worked
        t.isApproxPx(t.rect('.b-sch-event').left, 236, 'Event has correct x');
        t.hasApproxWidth('.b-sch-event', 261, 'Event has correct width');
        t.hasApproxHeight('.b-gantt .b-grid-cell', 45, 'Gantt row has height');
        t.hasApproxWidth('.b-gantt .b-grid-cell', 200, 'Gantt cell has width');
        t.isApproxPx(t.rect('.b-gantt-task').left, 322, 'Task has correct x');
        t.hasApproxWidth('.b-gantt-task', 233, 'Task has correct width');

        await t.doubleClick('[data-task-id="2"] .b-gantt-task');

        await t.click('[data-ref=name] input');

        await t.type({
            text          : 'Testing[ENTER]',
            clearExisting : true
        });

        await t.waitForSelector('.b-grid-cell:textEquals(Testing)');
        await t.waitForSelector('.b-sch-event:textEquals(Testing)');

        t.pass('Editing worked');
    });
});
