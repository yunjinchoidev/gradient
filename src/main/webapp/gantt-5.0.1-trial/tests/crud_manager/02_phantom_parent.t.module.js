import { ProjectModel, DateHelper } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let project;

    t.beforeEach(() => project?.destroy());

    t.it('Should send phantom parent id for added tasks', async t => {
        t.mockUrl('load', {
            responseText : JSON.stringify({
                success : true,
                tasks   : {
                    rows : [
                        {
                            id             : 1,
                            name           : 'Parent 1',
                            constraintType : null,
                            constraintDate : null,
                            effort         : 72,
                            duration       : 1,
                            parentIndex    : 0,
                            children       : [
                                {
                                    id             : 11,
                                    name           : 'Child 1-1',
                                    startDate      : '2020-03-20',
                                    endDate        : '2020-03-21',
                                    duration       : 1,
                                    constraintType : null,
                                    constraintDate : null,
                                    effort         : 24,
                                    parentIndex    : 0
                                }
                            ]
                        }
                    ]
                }
            })
        });

        project = new ProjectModel({
            transport : {
                load : { url : 'load' },
                sync : { url : 'sync' }
            }
        });

        await project.load();

        t.diag('Add new records');

        const parent1 = project.taskStore.getById(1);

        const child12 = parent1.appendChild({
            name     : 'Child 1-2',
            duration : 2
        });

        const newParent = parent1.parent.appendChild({
            name     : 'Parent 2',
            children : [
                {
                    name           : 'Child 2-1',
                    startDate      : '2020-03-20',
                    duration       : 2,
                    constraintType : null,
                    constraintDate : null
                },
                {
                    name           : 'Child 2-2',
                    startDate      : '2020-03-20',
                    duration       : 1,
                    constraintType : null,
                    constraintDate : null
                }
            ]
        });

        const [child21, child22] = newParent.children;

        // Child 1-2 is supposed to stretch parent
        await project.propagateAsync();

        let { tasks } = project.getChangeSetPackage();

        t.isDeeplySubset(
            [{
                id      : parent1.id,
                endDate : '2020-03-22T00:00:00' + DateHelper.getGMTOffset(parent1.endDate) //new Date(2020, 2, 22)
            }],
            tasks.updated,
            'Parent updated'
        );

        t.isDeeplySubset(
            [
                {
                    $PhantomId : child12.id,
                    parentId   : parent1.id
                },
                {
                    $PhantomId : newParent.id,
                    parentId   : null,
                    children   : undefined
                },
                {
                    $PhantomId       : child21.id,
                    $PhantomParentId : newParent.id,
                    parentId         : newParent.id
                },
                {
                    $PhantomId       : child22.id,
                    $PhantomParentId : newParent.id,
                    parentId         : newParent.id
                }
            ],
            tasks.added,
            'Task add request is ok'
        );

        t.diag('Move nodes in tree');

        const [child11] = parent1.children;

        newParent.appendChild(child11);

        parent1.appendChild(child21);

        ({ tasks } = project.getChangeSetPackage());

        t.isDeeplySubset(
            [
                {
                    id      : parent1.id,
                    endDate : '2020-03-22T00:00:00' + DateHelper.getGMTOffset(parent1.endDate) //new Date(2020, 2, 22)
                },
                {
                    id               : child11.id,
                    $PhantomParentId : newParent.id,
                    parentId         : newParent.id
                }
            ],
            tasks.updated.sort((a, b) => a.id - b.id),
            'Tasks update request is ok'
        );

        t.isDeeplySubset(
            [
                {
                    $PhantomId : child12.id,
                    parentId   : parent1.id
                },
                {
                    $PhantomId : newParent.id,
                    parentId   : null,
                    children   : undefined
                },
                {
                    $PhantomId       : child21.id,
                    $PhantomParentId : undefined,
                    parentId         : parent1.id
                },
                {
                    $PhantomId       : child22.id,
                    $PhantomParentId : newParent.id,
                    parentId         : newParent.id
                }
            ],
            tasks.added,
            'Tasks add request is ok'
        );
    });
});
