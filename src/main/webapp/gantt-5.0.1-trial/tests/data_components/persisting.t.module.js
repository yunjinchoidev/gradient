import { AjaxHelper, ProjectModel } from '../../build/gantt.module.js?457330';

/* global Gantt */
StartTest(t => {

    let gantt;

    t.beforeEach(() => Gantt.destroy(gantt));

    t.it('Should commit task store', t => {
        gantt = t.getGantt({
            overrideCrudStoreLoad : false,
            tasks                 : [
                {
                    id        : 1,
                    cls       : 'id1',
                    startDate : '2017-01-16',
                    endDate   : '2017-01-18',
                    name      : 'Task 1',
                    leaf      : true
                },
                {
                    id        : 2,
                    cls       : 'id2',
                    startDate : '2017-01-18',
                    endDate   : '2017-01-20',
                    name      : 'Task 2',
                    leaf      : true
                }
            ]
        });

        const taskStore = gantt.taskStore;

        AjaxHelper.post = (url, data) => {
            data.data.forEach(record => {
                t.notOk(Object.hasOwnProperty.call(record, 'incomingDeps'), 'Incoming deps are not persisted');
                t.notOk(Object.hasOwnProperty.call(record, 'outgoingDeps'), 'Outgoing deps are not persisted');
            });

            return Promise.resolve({ parsedJson : { success : true, data : [] } });
        };

        t.chain(
            { waitForPropagate : gantt },
            async() => {
                gantt.dependencyStore.add({ fromEvent : 1, toEvent : 2 });

                await gantt.project.propagateAsync();

                t.is(taskStore.getById(1).outgoingDeps.size, 1, '1 outgoing dep is found');
                t.is(taskStore.getById(2).incomingDeps.size, 1, '1 incoming dep is found');

                taskStore.updateUrl = 'foo';

                return taskStore.commit();
            }
        );
    });

    // https://github.com/bryntum/support/issues/1138
    t.it('Should fire hasChanges after a taskStore change that causes propagation', async t => {
        gantt = await t.getGanttAsync();

        t.firesOnce(gantt.project, 'hasChanges');

        gantt.taskStore.rootNode.firstChild.shift(1);

        // hasChanges is fired on data ready, not on refresh so cannot `await commitAsync()
        await gantt.project.await('dataReady', { checkLog : false });
    });

    // https://github.com/bryntum/support/issues/1881
    t.it('Should handle receiving only success indicator for update / delete operations', async t => {
        t.mockUrl('load.json', {
            responseText : JSON.stringify({
                success : true,
                tasks   : {
                    rows : [
                        {
                            id        : 1,
                            startDate : '2020-03-17',
                            duration  : 2
                        }
                    ]
                }
            })
        });

        t.mockUrl('update.json', {
            delay        : 1,
            responseText : JSON.stringify({
                success : true,
                type    : 'sync'
            })
        });

        let syncCount = 0;

        const project = new ProjectModel({
            autoSyncTimeout : 0,
            autoSync        : true,
            transport       : {
                load : {
                    url : 'load.json'
                },
                sync : {
                    url : 'update.json'
                }
            },
            listeners : {
                // the issue we test causes an infinite cycle
                // ..so limiting it here to avoid eating of extra resources
                beforeSync : () => syncCount < 5,
                sync       : () => syncCount++
            }
        });

        await project.load();

        const spy = t.spyOn(project, 'sync');

        project.taskStore.first.name = 'foo';

        await t.waitFor(500);

        t.expect(spy.calls.count()).toBe(1);

        t.notOk(project.crudStoreHasChanges(), 'No changes detected after successful sync');
    });
});
