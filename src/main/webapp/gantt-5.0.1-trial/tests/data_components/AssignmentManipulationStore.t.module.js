import { AssignmentsManipulationStore, ProjectModel } from '../../build/gantt.module.js?457330';

StartTest((t) => {
    let assignmentsManipulationStore;

    t.beforeEach((t) => {
        if (assignmentsManipulationStore) {
            assignmentsManipulationStore.destroy();
            assignmentsManipulationStore = null;
        }
    });

    const getProject = () => {
        return new ProjectModel(t.getProjectData());
    };

    t.it('Should fill itself up using provided task', async t => {
        const
            project         = getProject(),
            eventStore      = project.getEventStore(),
            resourceStore   = project.getResourceStore();

        await project.commitAsync();

        const event = eventStore.getById(117);

        assignmentsManipulationStore = new AssignmentsManipulationStore({
            projectEvent : event
        });

        t.is(assignmentsManipulationStore.count, resourceStore.count, 'All resources are available for assignment');

        const assignedResourcesCount = assignmentsManipulationStore.reduce(
            (count, assignment) => {
                return count + (assignment.units > 0 ? 1 : 0);
            },
            0
        );

        t.is(assignedResourcesCount, 2, `Event ${event.id} has ${assignedResourcesCount} resources assigned`);
    });
});
