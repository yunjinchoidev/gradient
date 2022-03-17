import { DateHelper } from '../../build/gantt.module.js?457330';

/* global Gantt */
StartTest(t => {
    let gantt;

    t.beforeEach(() => Gantt.destroy(gantt));

    t.describe('Advanced form works ok', t => {
        t.it('Should be able to modify rollup field', async t => {
            gantt = await t.getGanttAsync({
                features : {
                    taskTooltip : false
                }
            });

            await t.doubleClick('[data-task-id="11"]');

            await t.click('.b-tabpanel-tab:contains(Advanced)');

            const rollupField = gantt.features.taskEdit.editor.widgetMap.rollupField;

            t.notOk(rollupField.checked, 'Field not checked');
            t.notOk(gantt.taskStore.getById(11).rollup, 'Data field false');

            await t.click('[data-ref=rollupField] label');

            t.ok(gantt.taskStore.getById(11).rollup, 'Data field true');
        });

        t.it('Should set constraints', async t => {
            gantt = await t.getGanttAsync({
                columns : [
                    { type : 'name', width : 200 },
                    { type : 'constrainttype', width : 100 },
                    { type : 'constraintdate', width : 100 }
                ],
                subGridConfigs : {
                    locked : { width : 400 }
                },
                features : {
                    taskTooltip : false
                }
            });

            const project = gantt.project;
            const task = gantt.taskStore.getById(13);
            const expectedDate = new Date(2017, 0, 15);

            t.chain(
                async() => {
                    task.constraintType = 'muststarton';
                    task.constraintDate = task.startDate;
                    return project.propagateAsync();
                },
                { dblclick : '.id13.b-gantt-task', desc : 'Edit task with constraint' },
                { click : '.b-tabpanel-tab:contains(Advanced)' },
                { click : '[name=constraintType]' },

                async() => {
                    t.hasValue('[name=constraintType]', 'Must start on', 'Constraint type value is ok');
                    t.hasValue('[name=constraintDate]', DateHelper.format(task.startDate, 'L'), 'Constraint date value is ok');
                },

                { type : 's', clearExisting : true, desc : 'Type "s" to start autocomplete' },

                {
                    // need to wait until the typed "s" will make the picker to expand the list
                    waitForSelector : '.b-list-item.b-active:contains(Start no earlier than)',
                    desc            : 'Constraint type list is expanded and first item is active'
                },

                { type : '[ENTER]', desc : 'ENTER click to submit first value in the list' },

                { waitForProjectReady : gantt, desc : 'Project is ready after constraint type is set' },

                async() => {
                    t.selectorExists('.b-gantt-taskeditor', 'Editor is shown');
                    t.ok(gantt.features.taskEdit.editor.isValid, 'Editor is valid');
                },

                { click : '[name=constraintDate]' },
                { type : '[DOWN][LEFT][ENTER][ENTER]' },

                { waitForProjectReady : gantt, desc : 'Project is ready after constraint date is set' },

                async() => {
                    t.is(task.constraintType, 'startnoearlierthan', 'Constraint type is ok');
                    t.is(task.constraintDate, expectedDate, 'Constraint date is ok');
                },

                { dblclick : '.id13.b-gantt-task', desc : 'Edit task with constraint' },
                { click : '.b-tabpanel-tab:contains(Advanced)' },
                { click : '[name=constraintType]' },

                async() => {
                    t.hasValue('[name=constraintType]', 'Start no earlier than', 'Constraint type value is ok');
                    t.hasValue('[name=constraintDate]', DateHelper.format(expectedDate, 'L'), 'Constraint date value is ok');
                },

                { click : '.b-constrainttypepicker .b-icon-remove' },
                { type : '[ENTER]' },

                { waitForPropagate : gantt.project },

                () => {
                    t.is(task.constraintType, null, 'Constraint type is ok');
                }
            );
        });

        t.it('Should set calendars', async t => {
            gantt = await t.getGanttAsync({
                columns : [
                    { type : 'name', width : 200 },
                    { type : 'calendar', width : 100 }
                ],
                subGridConfigs : {
                    locked : { width : 300 }
                },
                features : {
                    taskTooltip : false
                }
            });

            const
                project     = gantt.project,
                task        = gantt.taskStore.getById(13),
                originalEnd = task.endDate;

            await task.setCalendar('night');

            await t.doubleClick('.id13.b-gantt-task');
            t.pass('Edit task');

            await t.click('.b-tabpanel-tab:contains(Advanced)');

            await t.waitForSelector('input[name=calendar]');

            t.hasValue('input[name=calendar]', 'Night shift', 'Calendar value is ok');

            await t.click('[name=calendar]');

            await t.type(null, '[DOWN][UP][ENTER][ENTER]');

            await t.waitForPropagate(project);

            t.is(task.calendar.id, 'business', 'Calendar id is ok');
            t.notOk(task.endDate.getTime() === originalEnd.getTime(), 'Task is updated');
            t.contentLike('.id13 [data-column=calendar]', 'Business', 'Column cell value is ok');
        });

        t.it('Duration gets recalculated for a task newly made FixedEffort in task editor', async t => {
            gantt = await t.getGanttAsync({
                resources   : [{ id : 1, name : 'foo' }],
                assignments : [{ id : 1, resource : 1, event : 11 }],
                features    : {
                    taskTooltip : false
                }
            });

            let duration;

            t.chain(
                { dblclick : '[data-task-id="11"] .b-gantt-task' },

                { click : '.b-tabpanel-tab:textEquals(Advanced)' },

                // remember initial duration value
                async() => duration = gantt.taskEdit.editor.widgetMap.duration.magnitude,

                { click : '.b-schedulingmodepicker .b-icon' },

                { click : ':textEquals(Fixed Effort)' },

                { type : '[TAB]' },

                { click : '.b-tabpanel-tab:textEquals(General)' },

                { click : '.b-effortfield .b-spin-up' },
                { click : '.b-effortfield .b-spin-up' },

                {
                    waitFor : () => gantt.taskEdit.editor.widgetMap.duration.magnitude > duration,
                    desc    : 'Duration has grown'
                }
            );
        });

        // https://github.com/bryntum/support/issues/2095
        t.it('Should have only constraint types applicable available for cell and popup editors', async t => {
            gantt = await t.getGanttAsync({
                columns : [
                    { type : 'constrainttype' }
                ]
            });

            const
                task1  = gantt.store.getById(1),
                task13 = gantt.store.getById(13);

            t.chain(
                { dblclick : '.id1.b-gantt-task' },
                next => {
                    t.notOk(gantt.taskEdit.editor.widgetMap.constraintTypeField.store.find(r => !task1.run('isConstraintTypeApplicable', r.id)), 'Task 1 constraint type popup editor has only constraint types applicable');
                    next();
                },
                { click : '.b-popup-close' },
                { dblclick : '.b-grid-row.id1 [data-column="constraintType"]' },
                next => {
                    t.notOk(gantt.features.cellEdit.editor.inputField.store.find(r => !task1.run('isConstraintTypeApplicable', r.id)), 'Task 1 constraint type cell editor has only constraint types applicable');
                    next();
                },
                { dblclick : '.id13.b-gantt-task' },
                next => {
                    t.notOk(gantt.taskEdit.editor.widgetMap.constraintTypeField.store.find(r => !task13.run('isConstraintTypeApplicable', r.id)), 'Task 13 constraint type popup editor has only constraint types applicable');
                    next();
                },
                { click : '.b-popup-close' },
                { dblclick : '.b-grid-row.id13 [data-column="constraintType"]' },
                next => {
                    t.notOk(gantt.features.cellEdit.editor.inputField.store.find(r => !task13.run('isConstraintTypeApplicable', r.id)), 'Task 13 constraint type cell editor has only constraint types applicable');
                    next();
                }
            );
        });

        t.it('Just setting a constraint should not cause a conflict', t => {
            gantt = t.getGantt({
                startDate : '2021-07-09 01:00:00',
                endDate   : '2021-07-16 01:00:00',
                project   : {
                    startDate : '2021-07-09 01:00:00',
                    tasksData : [
                        { id : 1, startDate : '2021-07-09 01:00:00', duration : 1, name : 'task 1' },
                        { id : 2, startDate : '2021-07-09 01:00:00', duration : 1, name : 'task 2', cls : 'id2' }
                    ],
                    dependenciesData : [
                        { fromTask : 1, toTask : 2 }
                    ]
                },
                features : {
                    taskTooltip : false
                }
            });

            const project = gantt.project;
            const task = gantt.taskStore.getById(2);

            t.chain(
                { waitForPropagate : project },
                { dblclick : '.id2.b-gantt-task' },
                { click : '.b-tabpanel-tab:contains(Advanced)' },
                { click : '[name=constraintType]' },
                { type : 'm', clearExisting : true, desc : 'Type "m" to start autocomplete' },

                {
                    // need to wait until the typed "m" will make the picker to expand the list
                    waitForSelector : '.b-list-item.b-active:contains(Must start on)',
                    desc            : 'Constraint type list is expanded and first item is active'
                },

                { type : '[ENTER]', desc : 'ENTER click to submit first value in the list' },

                { waitFor : 100 },

                async() => {
                    t.selectorNotExists('.b-schedulerpro-issueresolutionpopup', 'No conflict resolution popup shown');
                },

                { waitForProjectReady : gantt, desc : 'Project is ready after constraint type is set' },

                async() => {
                    t.is(task.constraintType, 'muststarton', 'Constraint type is ok');
                    t.is(task.constraintDate, new Date(2021, 6, 10, 1), 'Constraint date is ok');
                }
            );
        });

        t.it('Should be able to modify `inactive` field', async t => {
            gantt = await t.getGanttAsync({
                features : {
                    taskTooltip : false
                }
            });

            const task = gantt.taskStore.getById(14);

            await t.doubleClick('[data-task-id="14"]');

            await t.click('.b-tabpanel-tab:contains(Advanced)');

            const inactiveField = gantt.features.taskEdit.editor.widgetMap.inactiveField;

            t.notOk(task.inactive, 'task is inactive');
            t.notOk(inactiveField.checked, 'inactive is not checked');

            await t.click('[data-ref=inactiveField] label');

            await t.waitForPropagate(gantt.project);

            t.ok(task.inactive, 'task got inactive');

            t.selectorExists('.b-grid-row.b-inactive[data-id=14]', 'locked grid row got b-inactive class');
            t.selectorExists('.b-gantt-task-wrap.b-inactive[data-task-id=14] .b-gantt-task', 'task bar got b-inactive class');
            t.is(gantt.taskStore.getById(2).startDate, gantt.project.startDate, 'successors got rescheduled');

            await t.click('[data-ref=inactiveField] label');

            await t.waitForPropagate(gantt.project);

            t.notOk(task.inactive, 'task is active');

            t.selectorNotExists('.b-grid-row.b-inactive[data-id=14]', 'locked grid row has no b-inactive class');
            t.selectorNotExists('.b-gantt-task-wrap.b-inactive[data-task-id=14] .b-gantt-task', 'task bar has no b-inactive class');
            t.is(gantt.taskStore.getById(2).startDate, new Date(2017, 0, 26), 'successors got rescheduled back');
        });

    });
});
