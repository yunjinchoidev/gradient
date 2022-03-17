import { ArrayHelper, ColumnStore, ResourceAssignmentColumn, ProjectModel } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt;

    t.beforeEach(() => {
        gantt?.destroy();
    });

    t.it('itemTpl is extendable', async t => {
        class MyColumn extends ResourceAssignmentColumn {
            static get type() {
                return 'mycolumn';
            }

            itemTpl() {
                return 'foo';
            }
        }

        ColumnStore.registerColumnType(MyColumn);

        const project = new ProjectModel({
            eventsData : [
                {
                    id       : 1,
                    name     : 'task 1',
                    expanded : true,
                    children : [
                        {
                            id        : 11,
                            name      : 'task 11',
                            startDate : '2020-12-28',
                            duration  : 2
                        }
                    ]
                }
            ],
            resourcesData : [
                { id : 1, name : 'al' }
            ],
            assignmentsData : [
                { id : 1, event : 1, resource : 1 },
                { id : 2, event : 11, resource : 1 }
            ]
        });

        gantt = await t.getGanttAsync({
            project,
            columns : [
                { type : 'name' },
                { type : 'mycolumn' }
            ]
        });

        t.contentLike('[data-id="1"] [data-column="assignments"]', 'foo', '1st task cell value is ok');
        t.contentLike('[data-id="11"] [data-column="assignments"]', 'foo', '2nd task cell value is ok');
    });

    t.it('Should accept itemTpl config', async t => {
        const project = new ProjectModel({
            eventsData : [
                {
                    id       : 1,
                    name     : 'task 1',
                    expanded : true,
                    children : [
                        {
                            id        : 11,
                            name      : 'task 11',
                            startDate : '2020-12-28',
                            duration  : 2
                        }
                    ]
                }
            ],
            resourcesData : [
                { id : 1, name : 'al' }
            ],
            assignmentsData : [
                { id : 1, event : 1, resource : 1 },
                { id : 2, event : 11, resource : 1 }
            ]
        });

        gantt = await t.getGanttAsync({
            project,
            columns : [
                { type : 'name' },
                { type : 'resourceassignment', itemTpl : r => r.event.name }
            ]
        });

        t.contentLike('[data-id="1"] [data-column="assignments"]', 'task 1', '1st task cell value is ok');
        t.contentLike('[data-id="11"] [data-column="assignments"]', 'task 11', '2nd task cell value is ok');
    });

    // https://github.com/bryntum/support/issues/2954
    t.it('Should support avatar tooltip template', async t => {
        let targetResourceRecord;

        gantt = await t.getGanttAsync({
            columns : [
                { type : 'name' },
                {
                    type        : 'resourceassignment',
                    showAvatars : true,
                    width       : 180,
                    avatarTooltipTemplate({ taskRecord, resourceRecord, assignmentRecord, overflowCount }) {
                        !taskRecord.isTaskModel && t.ok(taskRecord.isTaskModel, 'Correct type for taskRecord');
                        !resourceRecord.isResourceModel && t.ok(resourceRecord.isResourceModel, 'Correct type for resourceRecord');
                        !assignmentRecord.isAssignmentModel && t.ok(assignmentRecord.isAssignmentModel, 'Correct type for assignmentRecord');

                        t.is(taskRecord.id, 11, 'Correct task');
                        t.is(resourceRecord, targetResourceRecord, 'Correct resource');
                        t.is(assignmentRecord.id, resourceRecord.id, 'Correct assignment');

                        return `${resourceRecord.id}/${resourceRecord.name}${overflowCount || ''}`;
                    }
                }
            ],

            resources : ArrayHelper.populate(10, i => ({ id : i + 1, name : `Resource ${i + 1}` })),

            assignments : ArrayHelper.populate(7, i => ({ id : i + 1, event : 11, resource : i + 1 }))
        });

        t.diag('Resource 1');

        targetResourceRecord = gantt.resourceStore.getById(1);

        await t.moveMouseTo('.b-resource-avatar:textEquals(R1)');

        await t.waitForSelector('.b-tooltip:textEquals("1/Resource 1")');

        t.pass('Correct tooltip for Resource 1');

        t.diag('Resource 2');

        targetResourceRecord = gantt.resourceStore.getById(2);

        await t.moveMouseTo('.b-resource-avatar:textEquals(R2)');

        await t.waitForSelector('.b-tooltip:textEquals("2/Resource 2")');

        t.pass('Correct tooltip for Resource 2');

        t.diag('Resource 3');

        targetResourceRecord = gantt.resourceStore.getById(3);

        await t.moveMouseTo('.b-resource-avatar:textEquals(R3)');

        await t.waitForSelector('.b-tooltip:textEquals("3/Resource 3")');

        t.pass('Correct tooltip for Resource 3');

        t.diag('Resource 4');

        targetResourceRecord = gantt.resourceStore.getById(4);

        await t.moveMouseTo('.b-resource-avatar:contains(R4)');

        await t.waitForSelector('.b-tooltip:textEquals("4/Resource 43")');

        t.pass('Correct tooltip for Resource 4 (including overflow count)');
    });
});
