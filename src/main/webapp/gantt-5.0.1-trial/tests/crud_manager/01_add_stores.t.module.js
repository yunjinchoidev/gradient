import { Store } from '../../build/gantt.module.js?457330';
/* global ProjectModel */

StartTest(function(t) {

    t.it('Crud manager keeps gantt specific stores in the proper order', t => {

        const eventStore        = t.getTaskStore();
        const dependencyStore   = t.getDependencyStore();
        const resourceStore     = t.getResourceStore();
        const assignmentStore   = t.getAssignmentStore();
        const someStore1        = new Store();
        const someStore2        = new Store();

        const project = new ProjectModel({
            eventStore,
            dependencyStore,
            resourceStore,
            assignmentStore,
            crudStores : [
                { store : someStore1, storeId : 'smth1' },
                { store : someStore2, storeId : 'smth2' }
            ]
        });

        t.is(project.crudStores.length, 8, 'correct stores list length');
        t.is(project.crudStores[0].storeId, 'smth1', 'correct 0 store');
        t.is(project.crudStores[1].storeId, 'smth2', 'correct 1 store');
        t.is(project.crudStores[2].storeId, 'timeRanges', 'correct 2 store');
        t.is(project.crudStores[3].storeId, 'calendars', 'correct 3 store');
        t.is(project.crudStores[4].storeId, 'tasks', 'correct 4 store');
        t.is(project.crudStores[5].storeId, 'dependencies', 'correct 5 store');
        t.is(project.crudStores[6].storeId, 'resources', 'correct 6 store');
        t.is(project.crudStores[7].storeId, 'assignments', 'correct 7 store');
    });

    t.it('Crud manager should pick up store by its id', t => {

        const eventStore        = t.getTaskStore();
        const dependencyStore   = t.getDependencyStore();
        const resourceStore     = t.getResourceStore();
        const assignmentStore   = t.getAssignmentStore();

        new Store({ id : 'someStore' });

        const project = new ProjectModel({
            eventStore,
            dependencyStore,
            resourceStore,
            assignmentStore,
            crudStores : [
                { storeId : 'someStore' }
            ]
        });

        t.is(project.crudStores[0].storeId, 'someStore', 'correct 0 store');
    });
});
