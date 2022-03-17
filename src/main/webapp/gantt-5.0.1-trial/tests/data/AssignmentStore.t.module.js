import { ProjectModel } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let project;

    t.beforeEach(t => project?.destroy?.());

    // https://github.com/bryntum/support/issues/1633
    t.it('Should be able to consume own json', async t => {
        project = new ProjectModel({
            tasksData : [
                { id : 1 }
            ],
            resourcesData : [
                { id : 1 },
                { id : 2 }
            ],
            assignmentsData : [
                { id : 1, event : 1, resource : 1 }
            ]
        });

        const { assignmentStore, taskStore, resourceStore } = project;

        await project.commitAsync();

        assignmentStore.add({ id : 2, event : taskStore.first, resource : resourceStore.last });

        await project.commitAsync();

        const json = assignmentStore.json;

        assignmentStore.json = json;

        await project.commitAsync();

        t.is(assignmentStore.last.event, taskStore.first, 'Reference to event correct after loading json');
        t.is(assignmentStore.last.resource, resourceStore.last, 'Reference to resource correct after loading json');
    });
});
