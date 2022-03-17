import { ProjectModel, SchedulerPro, Rectangle } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let scheduler, project;

    t.beforeEach(t => scheduler && scheduler.destroy && scheduler.destroy());

    async function createScheduler(t, config = {}, projectConfig = {}) {
        project = new ProjectModel(Object.assign({
            tasksData : [
                {
                    id        : 1,
                    name      : 'World domination',
                    startDate : new Date(2020, 5, 18),
                    children  : [
                        { id : 11, name : 'Imprison Batman', startDate : new Date(2020, 5, 18), duration : 4 },
                        { id : 12, name : 'Activate overcomplicated trap', duration : 4 }
                    ]
                }
            ],

            resourcesData : [
                { id : 1, name : 'Joker' },
                { id : 2, name : 'Penguin' },
                { id : 3, name : 'Riddler' }
            ],

            assignmentsData : [
                { id : 1, event : 11, resource : 1 },
                { id : 2, event : 11, resource : 2 },
                { id : 3, event : 12, resource : 1 },
                { id : 4, event : 12, resource : 3 }
            ],

            dependenciesData : [
                { id : 1, fromTask : 11, toTask : 12, lag : 1 }
            ]
        }, projectConfig));

        scheduler = new SchedulerPro(Object.assign({
            project,

            appendTo : document.body,

            columns : [
                { field : 'name', text : 'Bad guy' }
            ],

            startDate             : new Date(2020, 5, 14),
            endDate               : new Date(2020, 6, 4),
            tickSize              : 50,
            enableEventAnimations : false
        }, config));

        await project.commitAsync();

        await t.waitForSelector('.b-sch-dependency');
    }

    function assertTaskElements(t, task) {
        const atTick = task.startDate.getDate() - scheduler.startDate.getDate();

        task.assigned.forEach(assignment => {
            const bounds = Rectangle.from(scheduler.getElementFromAssignmentRecord(assignment), scheduler.timeAxisSubGridElement);
            t.is(bounds.left, atTick * 50, task.name + ' at correct x');
        });
    }

    t.it('Should render using Gantt project', async t => {
        await createScheduler(t);

        t.selectorCountIs('.b-sch-event', 4, 'Correct event element count');
        t.selectorCountIs('.b-sch-dependency', 4, 'Correct dependency element count');
    });

    t.it('Features sanity', t => {
        t.it('Drag', async t => {
            await createScheduler(t);

            t.diag('Change date');

            await t.dragBy('[data-assignment-id=1]', [50, 0]);

            await t.waitForProjectReady(project);

            const
                dragged = project.taskStore.getById(11),
                linked  = project.taskStore.getById(12);

            t.is(dragged.startDate, new Date(2020, 5, 19), 'Dragged task updated correctly');
            t.is(linked.startDate, new Date(2020, 5, 24), 'Linked task updated correctly');

            assertTaskElements(t, dragged);
            assertTaskElements(t, linked);

            t.diag('Reassign');

            await t.dragBy('[data-assignment-id=3]', [0, 60]);

            await t.waitForProjectReady(project);

            t.is(project.assignmentStore.getById(3).resource, project.resourceStore.getById(2), 'Reassigned');

            assertTaskElements(t, dragged);
            assertTaskElements(t, linked);
        });

        t.it('Resize', async t => {
            await createScheduler(t);

            await t.dragBy('[data-assignment-id=1]', [50, 0], null, null, null, false, ['100%-3', 5]);

            await t.waitForProjectReady(project);

            const
                resized = project.taskStore.getById(11),
                linked  = project.taskStore.getById(12);

            t.is(resized.startDate, new Date(2020, 5, 18), 'Resized task startDate kept');
            t.is(resized.endDate, new Date(2020, 5, 23), 'Resized task endDate updated correctly');
            t.is(linked.startDate, new Date(2020, 5, 24), 'Linked task updated correctly');
        });

        t.it('Labels', async t => {
            await createScheduler(t, {
                features : {
                    labels : {
                        left : 'name'
                    }
                }
            });

            await t.waitForProjectReady(project);

            t.selectorCountIs('.b-sch-label', 4, 'Labels found');
        });

        t.it('ResourceTimeRanges', async t => {
            await createScheduler(t, {
                features : {
                    resourceTimeRanges : true
                },

                resourceTimeRanges : [
                    { id : 1, startDate : new Date(2020, 5, 15), duration : 4, name : 'Crook Con', resourceId : 3 }
                ]
            });

            await t.waitForProjectReady(project);

            t.selectorCountIs('.b-sch-resourcetimerange', 1, 'ResourceTimeRange found');
        });

        t.it('TaskEditor', async t => {
            await createScheduler(t);

            await t.doubleClick('[data-assignment-id=1]');

            t.selectorExists('.b-gantttaskeditor', `Gantt's task editor shown`);

            await t.click('.b-start-date .b-fieldtrigger.b-icon-calendar');

            await t.click('.b-calendar-cell:contains(20)');

            await t.click('[data-ref=saveButton]');

            await t.waitForProjectReady(project);

            const
                edited = project.taskStore.getById(11),
                linked  = project.taskStore.getById(12);

            t.is(edited.startDate, new Date(2020, 5, 20), 'Edited task updated correctly');
            t.is(linked.startDate, new Date(2020, 5, 25), 'Linked task updated correctly');

            assertTaskElements(t, edited);
            assertTaskElements(t, linked);
        });
    });
});
