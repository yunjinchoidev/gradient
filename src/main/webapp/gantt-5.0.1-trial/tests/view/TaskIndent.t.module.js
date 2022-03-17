import { TaskModel } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt, project;

    t.beforeEach(() => gantt && gantt.destroy());

    async function getGantt(projectConfig) {
        projectConfig = Object.assign({
            startDate  : '2017-06-19',
            eventsData : [
                {
                    id        : 11,
                    name      : 'Node 11',
                    startDate : '2017-06-19',
                    endDate   : '2017-06-24',
                    expanded  : true,
                    children  : [
                        {
                            id        : 1,
                            name      : 'Node 1',
                            startDate : '2017-06-19',
                            endDate   : '2017-06-24'
                        },
                        {
                            id        : 2,
                            name      : 'Node 2',
                            startDate : '2017-06-19',
                            endDate   : '2017-06-24',
                            expanded  : true,
                            children  : [
                                {
                                    id        : 3,
                                    name      : 'Node 3',
                                    startDate : '2017-06-19',
                                    endDate   : '2017-06-24'
                                },
                                {
                                    id        : 4,
                                    name      : 'Node 4',
                                    startDate : '2017-06-19',
                                    endDate   : '2017-06-24'
                                },
                                {
                                    id        : 5,
                                    name      : 'Node 5',
                                    startDate : '2017-06-19',
                                    endDate   : '2017-06-24'
                                }
                            ]
                        }
                    ]
                }
            ]
        }, projectConfig);

        gantt = t.getGantt({
            height    : 700,
            appendTo  : document.body,
            project   : projectConfig,
            startDate : projectConfig.startDate
        });

        project = gantt.project;

        await project.commitAsync();

        return gantt;
    }

    t.it('Sanity', async t => {
        const
            { taskStore } = await getGantt(),
            node11    = taskStore.getById(11),
            node2     = taskStore.getById(2),
            node3     = taskStore.getById(3),
            node4     = taskStore.getById(4),
            node5     = taskStore.getById(5);

        t.notOk(node2.isLeaf, 'Task 2 is not leaf');
        t.ok(node3.isLeaf, 'Task 3 is leaf');

        // outdenting a task which should stay at the same level and get 2 children
        t.is(node3.parentIndex, 0, 'Node3 has parentIndex 0');

        await gantt.outdent(node3);

        t.is(node11.children.length, 3, 'Topmost task now has 3 child nodes');
        t.ok(node2.isLeaf, TaskModel.convertEmptyParentToLeaf, 'Task 2 is still a parent after task 3 outdent');
        t.is(node3.parentIndex, 2, 'Node3 now has parentIndex 2');

        t.isDeeply(node3.children, [node4, node5], 'Task 3 now has tasks 4 and 5 as children');

        // indenting it back - should restore the previous state

        await gantt.indent(node3);

        t.notOk(node2.isLeaf, 'Task 2 is not leaf after task 3 indent');

        t.isDeeply(node2.children.length, 1, 'Task 2 now has tasks 3 as only child');

        t.is(node3.parentIndex, 0, 'Node3 is first child of node2');

        // clearing the dirty flag()
        node3.clearChanges();

        t.notOk(node3.isModified, 'Node3 is now clean');

        // indenting node3 one more time + its children - nothing should happen
        await gantt.indent([node3, node4, node5]);

        t.isDeeply(node2.children, [node3], 'Task 2 now has task 4 as children');
        t.ok(node4.isLeaf, 'Task 4 has no children');

        t.ok(node4.isModified, 'Node4 dirty after indent');
        t.ok(node5.isModified, 'Node5 dirty after indent');
    });

    t.it('Should see 2 indented tasks in a parent stay on the same level', async t => {
        const { taskStore } = await getGantt(),
            node2     = taskStore.getById(2),
            node3     = taskStore.getById(3),
            node4     = taskStore.getById(4),
            node5     = taskStore.getById(5);

        await gantt.indent([node4, node5]);

        t.isDeeply(node3.children, [node4, node5], 'Task 3 now has tasks 4,5 as children');
        t.is(node4.parentIndex, 0);
        t.is(node5.parentIndex, 1);

        await gantt.outdent([node4, node5]);

        t.isDeeply(node2.children.map(n => {
            return n.id;
        }), [3, 4, 5], 'Task 2 now has tasks 3,4,5 as children');

        await gantt.indent([node5, node4]);

        t.isDeeply(node3.children.map(n => {
            return n.id;
        }), [4, 5], 'Task 3 now has tasks 4,5 as children, even if tasks are passed in wrong order');
    });

    /** Can't implement this test right now
    t.it('Should not indent project nodes', t => {
        var taskStore = getGantt({
            eventsData : [
                {
                    id        : 1,
                    startDate : '2010-01-04',
                    duration  : 4,
                    TaskType  : 'Gnt.model.Project'
                },
                {
                    id        : 2,
                    startDate : '2010-01-04',
                    duration  : 4,
                    TaskType  : 'Gnt.model.Project'
                }
            ]
        });

        t.wontFire(taskStore, ['update', 'datachanged', 'remove', 'add']);
        t.firesOk({
            observable : taskStore,
            events     : {
                beforeindentationchange : 1,
                indentationchange       : 1
            }
        });

        gantt.indent(taskStore.getById(2));
        gantt.outdent(taskStore.getById(2));
    });
    */

    t.it('Should handle `false` returned from taskStore#beforeOutdent listener for outdent operation', async t => {
        const { taskStore } = await getGantt({
            startDate  : '2010-01-04',
            eventsData : [
                {
                    id        : 1,
                    name      : 'Task 1',
                    startDate : '2010-01-04',
                    duration  : 4,
                    expanded  : true,
                    children  : [
                        {
                            id        : 2,
                            name      : 'Task 2',
                            startDate : '2010-01-04',
                            duration  : 4
                        }
                    ]
                }
            ]
        });

        taskStore.on({
            beforeoutdent() {
                return false;
            }
        });

        const
            storageGeneration = taskStore.storage.generation,
            node1             = taskStore.getById(1),
            node2             = taskStore.getById(2);

        t.wontFire(taskStore, ['update', 'change', 'remove', 'add']);

        await gantt.outdent(node2);

        t.is(taskStore.storage.generation, storageGeneration);
        t.notOk(node1.isLeaf);
        t.ok(node2.isLeaf);
        t.expect(node2.parent).toBe(node1);
        t.expect(node2.parentId).toBe(1);
    });

    t.it('Should handle `false` returned from taskStore#beforeIndent listener for indent operation', async t => {
        const { taskStore } = await getGantt({
            eventsData : [
                {
                    id        : 1,
                    name      : 'Task 1',
                    startDate : '2010-01-04',
                    duration  : 4
                },
                {
                    id        : 2,
                    name      : 'Task 2',
                    startDate : '2010-01-04',
                    duration  : 4
                }
            ]
        });

        taskStore.on({
            beforeindent() {
                return false;
            }
        });

        const
            storageGeneration = taskStore.storage.generation,
            node1             = taskStore.getById(1),
            node2             = taskStore.getById(2);

        t.wontFire(taskStore, ['update', 'change', 'remove', 'add']);

        await gantt.indent(node2);

        t.is(taskStore.storage.generation, storageGeneration);
        t.expect(node1.isLeaf).toBe(true);
        t.expect(node2.previousSibling.id).toBe(1);
    });

    // https://github.com/bryntum/support/issues/317
    t.it('Outdent should keep task position in tree structure', async t => {
        const
            { taskStore } = await getGantt(),
            node4     = taskStore.getById(4),
            node5     = taskStore.getById(5);

        await gantt.outdent(node4);

        t.notOk(node4.isLeaf, 'Task 4 is parent now');
        t.isDeeply(node4.children, [node5], 'Task 2 received task 5 as child');

        t.is(node4.parentIndex, 2, 'Node4 kept place after outdent');
        t.ok(node4.isExpanded(taskStore), 2, 'Node4 was expanded after outdent');
        t.ok(node4.isModified, 'Node4 dirty after outdent');
        t.ok(node5.isModified, 'Node5 dirty after outdent');
    });

    // https://github.com/bryntum/support/issues/367
    t.it('Should fire change event after indent operation', async t => {
        const
            { taskStore } = await getGantt({
                startDate  : '2020-04-01',
                eventsData : [
                    {
                        id        : 1,
                        name      : 'Task 1',
                        startDate : '2020-04-01',
                        duration  : 2,
                        inactive  : false
                    },
                    {
                        id        : 2,
                        name      : 'Task 2',
                        startDate : '2020-04-01',
                        duration  : 2,
                        inactive  : false
                    }
                ]
            }),
            task1   = taskStore.getById(1),
            task2   = taskStore.getById(2),
            changes = {};

        t.firesOk(taskStore, 'indent', 1, 'Indent event is fired');

        taskStore.on({
            change(ev) {
                changes[ev.action] = (ev.action === 'indent') ? ev.records.map(r => r.id) : {
                    [ev.record.id] : Object.keys(ev.changes)
                };
            }
        });

        taskStore.commit();

        t.notOk(task1.rawModifications, 'Task 1 is not modified');
        t.notOk(task2.rawModifications, 'Task 2 is not modified');

        await gantt.indent(task2);

        t.isDeeply(changes, {
            indent : [2],
            update : {
                2 : ['wbsValue']
            }
        }, 'Correct change events');

        t.notOk(task1.rawModifications, 'Task 1 is not modified');
        t.is(task1.children.length, 1, 'Task 1 has one children');

        t.ok(task2.rawModifications, 'Task 2 is modified');
        t.is(Object.keys(task2.rawModifications).length, 2, 'Task 2 has 2 fields modified');
        t.is(task2.rawModifications.parentIndex, 0, 'Task 2: parentIndex is correct');
        t.is(task2.rawModifications.parentId, 1, 'Task 2: parentId is correct');
    });

    t.it('Should fire change event after outdent operation', async t => {
        const
            { taskStore } = await getGantt({
                startDate  : '2020-04-01',
                eventsData : [
                    {
                        id        : 1,
                        name      : 'Task 1',
                        startDate : '2020-04-01',
                        duration  : 2,
                        expanded  : true,
                        children  : [
                            {
                                id        : 2,
                                name      : 'Task 2',
                                startDate : '2020-04-01',
                                duration  : 2
                            }
                        ]
                    }
                ]
            }),
            task1   = taskStore.getById(1),
            task2   = taskStore.getById(2),
            changes = {};

        t.firesOk(taskStore, 'outdent', 1, 'Outdent event is fired');

        taskStore.on({
            change(ev) {
                changes[ev.action] = (ev.action === 'outdent') ? ev.records.map(r => r.id) : {
                    [ev.record.id] : Object.keys(ev.changes)
                };
            }
        });

        taskStore.commit();

        t.notOk(task1.rawModifications, 'Task 1 is not modified');
        t.notOk(task2.rawModifications, 'Task 2 is not modified');

        await gantt.outdent(task2);

        t.isDeeply(changes, {
            outdent : [2],
            update  : {
                2 : ['wbsValue']
            }
        }, 'Correct change events');

        t.notOk(task1.rawModifications, 'Task 1 is not modified');
        t.is(task1.children.length, 0, 'Task 1 has no children');

        t.ok(task2.rawModifications, 'Task 2 is modified');
        t.is(Object.keys(task2.rawModifications).length, 2, 'Task 2 has 2 fields modified');
        t.is(task2.rawModifications.parentIndex, 1, 'Task 2: parentIndex is correct');
        t.is(task2.rawModifications.parentId, null, 'Task 2: parentId is correct');
    });

    t.it('Should trigger sync on indent if autoSync is true', async t => {

        let called = 0;

        const
            { taskStore } = await getGantt({
                autoSync  : true,
                transport : {
                    sync : {
                        url : 'syncurl'
                    }
                },
                listeners : {
                    beforeSync : () => {
                        called++;
                        return false;
                    }
                },
                startDate  : '2020-04-01',
                eventsData : [
                    {
                        id        : 1,
                        name      : 'Task 1',
                        startDate : '2020-04-01',
                        duration  : 2
                    },
                    {
                        id        : 2,
                        name      : 'Task 2',
                        startDate : '2020-04-01',
                        duration  : 2
                    }
                ]
            }),
            task2     = taskStore.getById(2);

        taskStore.commit();

        await gantt.indent(task2);

        t.waitFor(() => called);

        t.pass('beforeSync happened');
    });

    t.it('Should trigger sync on outdent if autoSync is true', async t => {

        let called = 0;

        const
            { taskStore } = await getGantt({
                autoSync  : true,
                transport : {
                    sync : {
                        url : 'syncurl'
                    }
                },
                listeners : {
                    beforeSync : () => {
                        called++;
                        return false;
                    }
                },
                startDate  : '2020-04-01',
                eventsData : [
                    {
                        id        : 1,
                        name      : 'Task 1',
                        startDate : '2020-04-01',
                        duration  : 2,
                        expanded  : true,
                        children  : [
                            {
                                id        : 2,
                                name      : 'Task 2',
                                startDate : '2020-04-01',
                                duration  : 2
                            }
                        ]
                    }
                ]
            }),
            task2     = taskStore.getById(2);

        taskStore.commit();

        await gantt.outdent(task2);
        await t.waitFor(() => called);

        t.ok('beforeSync happened');
    });

    t.it('Should support indenting multiple tasks', async t => {
        const
            { taskStore } = await getGantt({
                startDate  : '2020-04-01',
                eventsData : [
                    {
                        id        : 100,
                        name      : 'Task 1',
                        startDate : '2020-04-01',
                        duration  : 2,
                        expanded  : true,
                        children  : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15].map(id => ({ id : id, name : id }))
                    }
                ]
            });

        const children = taskStore.getById(100).children;

        await gantt.indent(children);

        t.is(children[0].children.length, 14, 'Should have indented all task #1 siblings');

        t.isDeeply(children[0].children.map(task => task.id), [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 'Correct order');
    });

    t.it('Should support outdenting multiple tasks', async t => {
        const
            { taskStore } = await getGantt({
                startDate  : '2020-04-01',
                eventsData : [
                    {
                        id        : 100,
                        name      : 'Task 1',
                        startDate : '2020-04-01',
                        duration  : 2,
                        expanded  : true,
                        children  : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15].map(id => ({ id : id, name : id }))
                    }
                ]
            });

        const children = taskStore.getById(100).children;

        await gantt.outdent(children);

        t.is(taskStore.rootNode.children.length, 16, 'Should have outdented all task #100 children');

        t.isDeeply(taskStore.rootNode.children.map(task => task.id), [100, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 'Correct order');
    });
});
