import { TaskStore, DependencyStore, ProjectModel } from '../../build/gantt.module.js?457330';

StartTest(t => {

    let dependencyStore, taskStore, project;

    t.beforeEach(() => {
        dependencyStore?.destroy();
        dependencyStore = null;

        taskStore?.destroy();
        taskStore = null;

        project?.destroy();
        project = null;
    });

    const createStores = () => {
        dependencyStore = new DependencyStore();
        taskStore = new TaskStore({
            data : [{
                id        : 1,
                startDate : '2020-05-08',
                duration  : 1
            }, {
                id        : 2,
                startDate : '2020-05-08',
                duration  : 1
            }]
        });
    };

    t.it('Should be possible to pass task instance to from/to fields when create a new dependency', t => {
        createStores();

        const dependency = dependencyStore.add({
            from : taskStore.getById(1),
            to   : taskStore.getById(2)
        })[0];

        t.is(dependency.from, 1, 'Dependency "from" is correct');
        t.is(dependency.to, 2, 'Dependency "to" is correct');
    });

    t.it('Should be possible to pass task instance to fromEvent/toEvent fields when create a new dependency', t => {
        createStores();

        const dependency = dependencyStore.add({
            fromEvent : taskStore.getById(1),
            toEvent   : taskStore.getById(2)
        })[0];

        t.is(dependency.from, 1, 'Dependency "from" is correct');
        t.is(dependency.to, 2, 'Dependency "to" is correct');
    });

    t.it('Should be possible to pass task instance to fromTask/toTask fields when create a new dependency', t => {
        createStores();

        const dependency = dependencyStore.add({
            fromTask : taskStore.getById(1),
            toTask   : taskStore.getById(2)
        })[0];

        t.is(dependency.from, 1, 'Dependency "from" is correct');
        t.is(dependency.to, 2, 'Dependency "to" is correct');
    });

    // https://github.com/bryntum/support/issues/1633
    t.it('Should be able to consume own json', async t => {
        project = new ProjectModel({
            tasksData : [
                { id : 1 },
                { id : 2 }
            ],
            dependenciesData : [
                { id : 1, fromEvent : 1, toEvent : 2, lag : 2, lagUnit : 'hour' }
            ]
        });

        const { taskStore, dependencyStore } = project;

        await project.commitAsync();

        taskStore.add({ id : 3 });
        dependencyStore.add({ id : 2, fromEvent : taskStore.getById(2), toEvent : taskStore.getById(3) });

        await project.commitAsync();

        const json = dependencyStore.json;

        dependencyStore.json = json;

        await project.commitAsync();

        t.is(dependencyStore.last.fromEvent, taskStore.getById(2), 'Reference correct after loading json');
    });
});
