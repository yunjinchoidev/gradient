import { Gantt, VersionHelper } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt;

    t.beforeEach(() => gantt?.destroy());

    t.it('Should get (mostly) empty app with empty config', t => {
        gantt = new Gantt();

        const str = gantt.getTestCase({ output : 'return' });

        t.is(str, `import("../../build/gantt.module.js?457330").then(module => { Object.assign(window, module);\n\nconsole.log('Gantt ${VersionHelper.getVersion('gantt')}');\n      \nconst gantt = new Gantt({\n  features: {\n    group: false,\n    tree: true,\n    regionResize: true\n  }\n});\n});`, 'Correct app');
    });

    t.it('Should inline data on project', t => {
        gantt = new Gantt();

        const
            tasksData = [{ id : 1, name : 'Event 1' }, { id : 2, name : 'Event 2' }],
            resourcesData = [{ id : 1, name : 'Resource 1' }],
            assignmentsData = [{ id : 1, eventId : 1, resourceId : 1 }],
            dependenciesData = [{ id : 1, from : 1, to : 2 }];

        gantt.project.taskStore.data = tasksData;
        gantt.project.resourceStore.data = resourcesData;
        gantt.project.assignmentStore.data = assignmentsData;
        gantt.project.dependencyStore.data = dependenciesData;

        const str = gantt.getConfigString();

        // eslint-disable-next-line no-new-func
        const obj = new Function('return ' + str)();

        t.notOk(obj.data, 'No data on gantt');
        t.notOk(obj.tasks, 'No tasks on gantt');
        t.notOk(obj.resources, 'No resources on gantt');
        t.notOk(obj.assignments, 'No assignments on gantt');
        t.notOk(obj.dependencies, 'No dependencies on gantt');

        t.isDeeply(obj.project.tasksData, tasksData, 'Tasks inline on project');
        t.isDeeply(obj.project.resourcesData, resourcesData, 'Resources inline on project');
        t.isDeeply(obj.project.assignmentsData, assignmentsData, 'Assignments inline on project');
        t.isDeeply(obj.project.dependenciesData, dependenciesData, 'Dependencies inline on project');
    });

    t.it('Should include taskRenderer', t => {
        gantt = new Gantt({
            taskRenderer() {
                return 'Hello';
            }
        });

        // eslint-disable-next-line no-new-func
        const obj = new Function('return ' + gantt.getConfigString())();

        t.is(obj.taskRenderer(), 'Hello', 'Task renderer is there');
    });
});
