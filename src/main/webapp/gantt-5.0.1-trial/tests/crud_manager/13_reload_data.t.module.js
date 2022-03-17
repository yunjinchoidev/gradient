import { ProjectModel } from '../../build/gantt.module.js?457330';

StartTest(t => {
    t.mockUrl('loadurl', {
        delay        : 10,
        responseText : JSON.stringify({
            success   : true,
            resources : {
                rows : [
                    { id : 'r1' }
                ]
            },
            assignments : {
                rows : [
                    {
                        id       : 'a1',
                        resource : 'r1',
                        event    : 'e1'
                    }
                ]
            },
            tasks : {
                rows : [
                    {
                        id        : 'e1',
                        startDate : '2018-02-01',
                        endDate   : '2018-03-01'
                    },
                    {
                        id        : 'e2',
                        startDate : '2018-02-01',
                        endDate   : '2018-03-01'
                    }
                ]
            },
            dependencies : {
                rows : [
                    {
                        id        : 'd1',
                        fromEvent : 'e1',
                        toEvent   : 'e2'
                    }
                ]
            }
        })
    });

    t.it('Reloading data should work', async t => {

        const project = new ProjectModel({
            transport : {
                load : {
                    url : 'loadurl'
                }
            }
        });

        await project.load();

        t.is(project.dependencyStore.count, 1);
        t.is(project.eventStore.count, 2);
        t.is(project.assignmentStore.count, 1);
        t.is(project.resourceStore.count, 1);

        t.is(project.getDependencyById('d1').fromEvent, project.getEventById('e1'));
        t.is(project.getDependencyById('d1').toEvent, project.getEventById('e2'));

        t.is(project.getAssignmentById('a1').resource, project.getResourceById('r1'));
        t.is(project.getAssignmentById('a1').event, project.getEventById('e1'));

        // re-loading the same data - should give the same result
        await project.load();

        t.is(project.dependencyStore.count, 1);
        t.is(project.eventStore.count, 2);
        t.is(project.assignmentStore.count, 1);
        t.is(project.resourceStore.count, 1);

        t.is(project.getDependencyById('d1').fromEvent, project.getEventById('e1'));
        t.is(project.getDependencyById('d1').toEvent, project.getEventById('e2'));

        t.is(project.getAssignmentById('a1').resource, project.getResourceById('r1'));
        t.is(project.getAssignmentById('a1').event, project.getEventById('e1'));
    });
});
