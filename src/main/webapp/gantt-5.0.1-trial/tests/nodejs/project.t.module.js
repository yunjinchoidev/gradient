import { mockUrl, ProjectModel, AjaxHelper, launchSaas } from '../../build/gantt.module.js?457330';

StartTest(t => {
    t.global.AjaxHelper = AjaxHelper;

    mockUrl(t, 'launch-saas', {
        responseText : JSON.stringify(launchSaas)
    });

    t.it('Should load project', async t => {
        const project = new ProjectModel({
            transport : {
                load : {
                    url : 'launch-saas'
                }
            }
        });

        await project.load();

        const { taskStore, dependencyStore } = project;

        const
            task11 = taskStore.getById(11),
            task15 = taskStore.getById(15),
            task14 = taskStore.getById(14);

        t.is(task11.startDate, new Date(2019, 0, 14), 'Task 11 start is ok');
        t.is(task11.endDate, new Date(2019, 0, 17), 'Task 11 end is ok');
        t.is(task11.duration, 3, 'Task 11 duration is ok');

        t.is(task14.startDate, new Date(2019, 0, 14), 'Task 14 start is ok');
        t.is(task14.endDate, new Date(2019, 0, 16), 'Task 14 end is ok');
        t.is(task14.duration, 2, 'Task 14 duration is ok');

        t.is(task15.startDate, new Date(2019, 0, 21), 'Task 15 start is ok');
        t.is(task15.endDate, new Date(2019, 0, 23), 'Task 15 end is ok');
        t.is(task15.duration, 2, 'Task 15 duration is ok');

        dependencyStore.add({
            from : 11,
            to   : 14
        });

        await project.propagateAsync();

        t.is(task14.startDate, new Date(2019, 0, 17), 'Task 14 start is ok');
        t.is(task14.endDate, new Date(2019, 0, 19), 'Task 14 end is ok');
        t.is(task14.duration, 2, 'Task 14 duration is ok');
    });
});
