import { ProjectModel } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt;

    t.beforeEach(() => gantt?.destroy());

    t.it('Should draw dependencies after project change', async t => {
        gantt = await t.getGanttAsync();

        await gantt.await('dependenciesDrawn', false);

        gantt.project = new ProjectModel({
            enableProgressNotifications : true,
            taskStore                   : { useRawData : true },
            dependencyStore             : { useRawData : true },

            tasksData : [
                { id : 1, name : 'Task 1', startDate : new Date(2017, 0, 16), duration : 5 },
                { id : 2, name : 'Task 2', startDate : new Date(2017, 0, 16), duration : 5 }
            ],
            dependenciesData : [
                { id : 1, fromEvent : 1, toEvent : 2 }
            ]
        });

        // wait till inline data gets loaded
        await gantt.project.await('load', false);

        await gantt.await('dependenciesDrawn', false);

        t.selectorCountIs('.b-sch-dependency', 1, 'Single dependency found');
    });
});
