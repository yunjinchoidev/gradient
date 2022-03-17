import { AllColumns } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt;

    t.beforeEach(() => gantt?.destroy());

    t.it('Should be able to tab through all cells while editing', t => {
        gantt = t.getGantt({
            columns : Object.values(AllColumns).map(ColumnClass => ({ type : ColumnClass.type }))
        });

        const editableColumns = gantt.columns.visibleColumns.filter(c => gantt.features.cellEdit.getEditingContext({ row : 0, column : c }));

        t.chain(
            { waitForPropagate : gantt },

            { dblClick : '.b-grid-cell:nth-child(2)' },

            { type : '[TAB]'.repeat(editableColumns.length * 3) }, // All editable cells in three rows

            () => {
                t.pass('Tabbed through without exception');
            }
        );
    });

    t.it('Should be able to tab through all cells for new record', t => {
        gantt = t.getGantt({
            tasks : [
                {}
            ],

            columns : Object.values(AllColumns).map(ColumnClass => ({ type : ColumnClass.type }))
        });

        // TODO: Crashes during propagation, because task is empty

        const editableColumns = gantt.columns.visibleColumns.filter(c => gantt.features.cellEdit.getEditingContext({ row : 0, column : c }));

        t.chain(
            { waitForPropagate : gantt },

            { dblClick : `.b-grid-cell:nth-child(2)` },

            { type : '[TAB]'.repeat(editableColumns.lengtht * 2) }, // All editable cells in two rows

            () => {
                t.pass('Tabbed through without exception');
            }
        );
    });

    t.it('Should validate dependencies', async t => {
        gantt = await t.getGanttAsync({
            columns : [
                { type : 'name', width : 200 },
                { type : 'predecessor', width : 100 },
                { type : 'successor', width : 100 }
            ],
            startDate : '2019-05-20',
            endDate   : '2019-05-26',
            project   : {
                startDate : '2019-05-20',
                tasksData : [
                    {
                        id        : 1,
                        cls       : 'task1',
                        name      : 'Task 1',
                        startDate : '2019-05-20',
                        duration  : 1
                    },
                    {
                        id        : 2,
                        cls       : 'task2',
                        name      : 'Task 2',
                        startDate : '2019-05-20',
                        duration  : 1,
                        expanded  : true,
                        children  : [
                            {
                                id        : 21,
                                cls       : 'task21',
                                name      : 'Task 21',
                                startDate : '2019-05-20',
                                duration  : 1
                            },
                            {
                                id        : 22,
                                cls       : 'task22',
                                name      : 'Task 22',
                                startDate : '2019-05-21',
                                duration  : 1
                            }
                        ]
                    },
                    {
                        id        : 3,
                        cls       : 'task3',
                        name      : 'Task 3',
                        startDate : '2019-05-20',
                        duration  : 1
                    }
                ],

                dependenciesData : [
                    { id : 1, fromEvent : 1, toEvent : 21 },
                    { id : 2, fromEvent : 21, toEvent : 22 }
                ]
            }
        });
        const
            task1 = gantt.taskStore.getById(1),
            task3 = gantt.taskStore.getById(3);

        let dependencyField, predecessorsCell;

        t.chain(
            { waitForSelectorNotFound : '.b-readonly' },

            // Type invalid predecessor ID

            { dblclick : () => predecessorsCell = document.querySelector('.task1 [data-column=predecessors]') },

            {
                waitFor : () => {
                    if (gantt.features.cellEdit.editorContext && gantt.features.cellEdit.editorContext.editor.containsFocus) {
                        dependencyField = gantt.features.cellEdit.editorContext.editor.inputField;
                        return true;
                    }
                }
            },

            // Enter an invalid predecessor
            { type : '2[ENTER]', target : () => dependencyField.input },

            { waitForSelector : '.b-dependencyfield.b-invalid', desc : 'Editing successors started for task 1' },

            // After the toast has been and gone, task1 should have no predecessors
            next => {
                t.is(task1.predecessors.length, 0, 'No predecessors added');
                next();
            },

            { type : '[BACKSPACE]' },

            // Open the predecessors dropdown
            { type : '[DOWN]', target : () => dependencyField.input },

            // Pick predecessor from dropdown
            { click : '.b-list-item.task3 .b-to' },

            // TAB off to trigger update
            { type : '[TAB]', target : () => dependencyField.input },

            { waitFor : () => predecessorsCell.textContent === '3', desc : 'Cell content is ok' },

            // Dependency should be there
            next => {
                t.is(task1.predecessors.length, 1, 'Predecessor added');
                t.is(task1.predecessors[0].fromEvent, task3, 'Predecessor is ok');
                next();
            },

            // Go back
            { dblclick : '.task1 [data-column=predecessors]' },

            // Open the predecessors dropdown
            { type : '[DOWN]', target : () => dependencyField.input },

            // Change to 3FF by toggling the "to side"
            { click : '.b-list-item.task3 .b-to' },

            // TAB off to trigger update
            { type : '[TAB]', target : () => dependencyField.input },

            // Dependency should have changed
            () => {
                const task = gantt.taskStore.getById(1);

                t.is(task.predecessors.length, 1, 'Predecessor added');
                t.is(task.predecessors[0].fromEvent, gantt.taskStore.getById(3), 'Predecessor is ok');
                t.is(predecessorsCell.textContent, '3FF', 'Cell content is ok');
            }
        );
    });

    t.it('Should close dependency editor on escape', async t => {
        gantt = await t.getGanttAsync({
            columns : [
                { type : 'name', width : 200 },
                { type : 'predecessor', width : 100 },
                { type : 'successor', width : 100 }
            ],
            startDate : '2019-05-20',
            endDate   : '2019-05-26',
            project   : {
                startDate : '2019-05-20',
                tasksData : [
                    {
                        id        : 1,
                        cls       : 'task1',
                        name      : 'Task 1',
                        startDate : '2019-05-20',
                        duration  : 1
                    },
                    {
                        id        : 2,
                        cls       : 'task2',
                        name      : 'Task 2',
                        startDate : '2019-05-20',
                        duration  : 1
                    }
                ],

                dependenciesData : [
                    { id : 1, fromEvent : 1, toEvent : 2 }
                ]
            }
        });

        t.chain(
            { dblclick : '.task1 [data-column=predecessors]' },
            { waitForSelector : '.b-dependencyfield.b-contains-focus', desc : 'Editing predecessors started for task 1' },
            { type : '[ESC]' },
            { waitForSelectorNotFound : '.b-dependencyfield', desc : 'Editing predecessors cancelled for task 1' },

            { dblclick : '.task1 [data-column=successors]' },
            { waitForSelector : '.b-dependencyfield.b-contains-focus', desc : 'Editing successors started for task 1' },
            { type : '[ESC]' },
            { waitForSelectorNotFound : '.b-dependencyfield', desc : 'Editing successors cancelled for task 1' },

            { dblclick : '.task2 [data-column=predecessors]' },
            { waitForSelector : '.b-dependencyfield.b-contains-focus', desc : 'Editing predecessors started for task 2' },
            { type : '[ESC]' },
            { waitForSelectorNotFound : '.b-dependencyfield', desc : 'Editing predecessors cancelled for task 2' },

            { dblclick : '.task2 [data-column=successors]' },
            { waitForSelector : '.b-dependencyfield.b-contains-focus', desc : 'Editing successors started for task 2' },
            { type : '[ESC]' },
            { waitForSelectorNotFound : '.b-dependencyfield', desc : 'Editing successors cancelled for task 2' }
        );
    });

    // https://github.com/bryntum/support/issues/53
    t.it('should be possible to edit values for an auto added field', t => {
        gantt = t.getGantt({
            columns : {
                autoAddField : true,
                data         : [
                    { text : 'Foo', field : 'foo', width : 250 }, // `foo` is missing on the model
                    { type : 'name', width : 200 }
                ]
            }
        });

        const cellEdit = gantt.features.cellEdit;

        t.chain(
            { dblClick : '.b-grid-cell' },
            { type : 'qwe[ENTER]', target : '.b-editor input' },
            { waitForSelector : '.b-grid-cell:textEquals(qwe)' }, // cell value correct
            next => {
                t.is(gantt.taskStore.first.foo, 'qwe', 'Record updated correctly');

                next();
            },
            { dblClick : '.b-grid-cell' },
            { waitFor : () => cellEdit.editor.inputField.value === 'qwe' }, // editor value correct
            { type : 'asd[ENTER]', target : '.b-editor input', clearExisting : true },
            next => {
                t.is(gantt.taskStore.first.foo, 'asd', 'Record updated correctly');

                next();
            },
            { waitForSelector : '.b-grid-cell:textEquals(asd)' }, // cell value correct
            { dblClick : '.b-grid-cell' },
            { waitFor : () => cellEdit.editor.inputField.value === 'asd' } // editor value correct
        );
    });

    // https://github.com/bryntum/support/issues/53
    t.it('should be possible to edit values for a auto exposed field', t => {
        gantt = t.getGantt({
            tasks : [
                { id : 1, name : 'Task 1', foo : '' }
            ],

            columns : [
                { text : 'Foo', field : 'foo', width : 250 }, // `foo` is missing on the model
                { type : 'name', width : 200 }
            ]
        });

        const cellEdit = gantt.features.cellEdit;

        t.chain(
            { dblClick : '.b-grid-cell' },
            { type : 'qwe[ENTER]', target : '.b-editor input' },
            { waitForSelector : '.b-grid-cell:textEquals(qwe)' }, // cell value correct
            next => {
                t.is(gantt.taskStore.first.foo, 'qwe', 'Record updated correctly');

                next();
            },
            { dblClick : '.b-grid-cell' },
            { waitFor : () => cellEdit.editor.inputField.value === 'qwe' }, // editor value correct
            { type : 'asd[ENTER]', target : '.b-editor input', clearExisting : true },
            next => {
                t.is(gantt.taskStore.first.foo, 'asd', 'Record updated correctly');

                next();
            },
            { waitForSelector : '.b-grid-cell:textEquals(asd)' }, // cell value correct
            { dblClick : '.b-grid-cell' },
            { waitFor : () => cellEdit.editor.inputField.value === 'asd' } // editor value correct
        );
    });

    // https://github.com/bryntum/support/issues/95
    t.it('Start date result should match what is selected in the picker when default 24/7 calendar is used', t => {
        gantt = t.getGantt({
            columns : [
                { type : 'name', width : 200 },
                { type : 'startdate', width : 250, format : 'YYYY-MM-DD HH:mm' },
                { type : 'enddate', width : 250, format : 'YYYY-MM-DD HH:mm' }
            ]
        });

        let dateField;

        t.chain(
            { waitForSelector : '.b-grid-row[data-id=11] .b-grid-cell[data-column="startDate"]:textEquals(2017-01-16 00:00)' },
            { dblClick : '.b-grid-row[data-id=11] .b-grid-cell[data-column="startDate"]' },
            next => {
                dateField = gantt.features.cellEdit.editorContext.editor.inputField;
                t.is(dateField.input.value, '2017-01-16 00:00');
                t.isDateEqual(dateField.value, new Date(2017, 0, 16));
                next();
            },
            { click : '.b-icon-calendar' },
            { click : '[aria-label="January 17, 2017"]' },
            next => {
                t.is(dateField.input.value, '2017-01-17 00:00');
                t.isDateEqual(dateField.value, new Date(2017, 0, 17));
                next();
            },
            { type : '[ENTER]' },
            { waitForSelector : '.b-grid-row[data-id=11] .b-grid-cell[data-column="startDate"]:textEquals(2017-01-17 00:00)' }
        );
    });

    t.it('Start date result should match what is selected in the picker when business 8/5 calendar is used', t => {
        gantt = t.getGantt({
            columns : [
                { type : 'name', width : 200 },
                { type : 'startdate', width : 250, format : 'YYYY-MM-DD HH:mm' },
                { type : 'enddate', width : 250, format : 'YYYY-MM-DD HH:mm' }
            ],
            project : {
                calendar      : 'business',
                calendarsData : [{
                    id           : 'business',
                    name         : 'Business',
                    hoursPerDay  : 8,
                    daysPerWeek  : 5,
                    daysPerMonth : 20,
                    intervals    : [
                        {
                            recurrentStartDate : 'on Sat at 0:00',
                            recurrentEndDate   : 'on Mon at 0:00',
                            isWorking          : false
                        },
                        {
                            recurrentStartDate : 'every weekday at 12:00',
                            recurrentEndDate   : 'every weekday at 13:00',
                            isWorking          : false
                        },
                        {
                            recurrentStartDate : 'every weekday at 17:00',
                            recurrentEndDate   : 'every weekday at 08:00',
                            isWorking          : false
                        }
                    ]
                }]
            }
        });

        let dateField;

        t.chain(
            { waitForSelector : '.b-grid-row[data-id=11] .b-grid-cell[data-column="startDate"]:textEquals(2017-01-16 08:00)' },
            { dblClick : '.b-grid-row[data-id=11] .b-grid-cell[data-column="startDate"]' },
            next => {
                dateField = gantt.features.cellEdit.editorContext.editor.inputField;
                t.is(dateField.input.value, '2017-01-16 08:00');
                t.isDateEqual(dateField.value, new Date(2017, 0, 16, 8));
                next();
            },
            { click : '.b-icon-calendar' },
            { click : '[aria-label="January 17, 2017"]' },
            next => {
                t.is(dateField.input.value, '2017-01-17 08:00');
                t.isDateEqual(dateField.value, new Date(2017, 0, 17, 8));
                next();
            },
            { type : '[ENTER]' },
            { waitForSelector : '.b-grid-row[data-id=11] .b-grid-cell[data-column="startDate"]:textEquals(2017-01-17 08:00)' }
        );
    });

    t.it('End date result should match what is selected in the picker when default 24/7 calendar is used', t => {
        gantt = t.getGantt({
            columns : [
                { type : 'name', width : 200 },
                { type : 'startdate', width : 250, format : 'YYYY-MM-DD HH:mm' },
                { type : 'enddate', width : 250, format : 'YYYY-MM-DD HH:mm' }
            ]
        });

        let dateField;

        t.chain(
            { waitForSelector : '.b-grid-row[data-id=11] .b-grid-cell[data-column="endDate"]:textEquals(2017-01-26 00:00)' },
            { dblClick : '.b-grid-row[data-id=11] .b-grid-cell[data-column="endDate"]' },
            next => {
                dateField = gantt.features.cellEdit.editorContext.editor.inputField;
                t.is(dateField.input.value, '2017-01-26 00:00');
                t.isDateEqual(dateField.value, new Date(2017, 0, 26));
                next();
            },
            { click : '.b-icon-calendar' },
            { click : '[aria-label="January 25, 2017"]' },
            next => {
                t.is(dateField.input.value, '2017-01-25 00:00');
                t.isDateEqual(dateField.value, new Date(2017, 0, 25));
                next();
            },
            { type : '[ENTER]' },
            { waitForSelector : '.b-grid-row[data-id=11] .b-grid-cell[data-column="endDate"]:textEquals(2017-01-25 00:00)' }
        );
    });

    t.it('End date result should match what is selected in the picker when business 8/5 calendar is used', t => {
        gantt = t.getGantt({
            columns : [
                { type : 'name', width : 200 },
                { type : 'startdate', width : 250, format : 'YYYY-MM-DD HH:mm' },
                { type : 'enddate', width : 250, format : 'YYYY-MM-DD HH:mm' }
            ],
            project : {
                calendar      : 'business',
                hoursPerDay   : 8,
                daysPerWeek   : 5,
                daysPerMonth  : 20,
                calendarsData : [{
                    id        : 'business',
                    name      : 'Business',
                    intervals : [
                        {
                            recurrentStartDate : 'on Sat at 0:00',
                            recurrentEndDate   : 'on Mon at 0:00',
                            isWorking          : false
                        },
                        {
                            recurrentStartDate : 'every weekday at 12:00',
                            recurrentEndDate   : 'every weekday at 13:00',
                            isWorking          : false
                        },
                        {
                            recurrentStartDate : 'every weekday at 17:00',
                            recurrentEndDate   : 'every weekday at 08:00',
                            isWorking          : false
                        }
                    ]
                }]
            }
        });

        let dateField;

        t.chain(
            { waitForSelector : '.b-grid-row[data-id=11] .b-grid-cell[data-column="endDate"]:textEquals(2017-01-27 17:00)' },
            { dblClick : '.b-grid-row[data-id=11] .b-grid-cell[data-column="endDate"]' },
            next => {
                dateField = gantt.features.cellEdit.editorContext.editor.inputField;
                t.is(dateField.input.value, '2017-01-27 17:00');
                t.isDateEqual(dateField.value, new Date(2017, 0, 27, 17));
                next();
            },
            { click : '.b-icon-calendar' },
            { click : '[aria-label="January 26, 2017"]' },
            next => {
                t.is(dateField.input.value, '2017-01-26 17:00');
                t.isDateEqual(dateField.value, new Date(2017, 0, 26, 17));
                next();
            },
            { type : '[ENTER]' },
            { waitForSelector : '.b-grid-row[data-id=11] .b-grid-cell[data-column="endDate"]:textEquals(2017-01-26 17:00)' }
        );
    });

    // https://github.com/bryntum/support/issues/1093
    t.it('Cell date editor should respect weekStartDay config', t => {
        gantt = t.getGantt({
            columns : [
                { type : 'startdate' },
                { type : 'enddate' }
            ],
            weekStartDay : 1
        });

        t.chain(
            { doubleClick : '.b-grid-row[data-id="11"] .b-grid-cell[data-column="startDate"]' },
            { click : '.b-pickerfield .b-icon-calendar' },
            {
                waitForSelector : '.b-calendar-day-header[data-column-index="0"][data-cell-day="1"]',
                desc            : 'Week starts with correct day'
            },
            { doubleClick : '.b-grid-row[data-id="11"] .b-grid-cell[data-column="endDate"]' },
            { click : '.b-pickerfield .b-icon-calendar' },
            {
                waitForSelector : '.b-calendar-day-header[data-column-index="0"][data-cell-day="1"]',
                desc            : 'Week starts with correct day'
            }
        );
    });

    t.it('Cell date editor should respect DateHelper.weekStartDay config', t => {
        gantt = t.getGantt({
            columns : [
                { type : 'startdate' },
                { type : 'enddate' }
            ]
        });

        t.chain(
            { doubleClick : '.b-grid-row[data-id="11"] .b-grid-cell[data-column="startDate"]' },
            { click : '.b-pickerfield .b-icon-calendar' },
            {
                waitForSelector : '.b-calendar-day-header[data-column-index="0"][data-cell-day="0"]',
                desc            : 'Week starts with correct day'
            },
            { doubleClick : '.b-grid-row[data-id="11"] .b-grid-cell[data-column="endDate"]' },
            { click : '.b-pickerfield .b-icon-calendar' },
            {
                waitForSelector : '.b-calendar-day-header[data-column-index="0"][data-cell-day="0"]',
                desc            : 'Week starts with correct day'
            }
        );
    });

    t.it('Should be possible to set constraint type on task w/o constraints', t => {
        gantt = t.getGantt({
            columns : [
                { type : 'name', width : 200 },
                { type : 'constrainttype', width : 250 },
                { type : 'constraintdate', width : 250, format : 'YYYY-MM-DD HH:mm' }
            ],
            project : {
                tasksData : [
                    {
                        id        : 1,
                        cls       : 'task1',
                        name      : 'Task 1',
                        startDate : '2017-01-16',
                        duration  : 1
                    }
                ]
            }
        });

        const project       = gantt.project;

        let field;

        t.chain(
            { dblClick : '.task1 .b-grid-cell[data-column="constraintType"]' },
            {
                waitFor : () => {
                    if (gantt.features.cellEdit.editorContext && gantt.features.cellEdit.editorContext.editor.containsFocus) {
                        field = gantt.features.cellEdit.editorContext.editor.inputField;
                        return true;
                    }
                }
            },
            { type : '[DOWN]', target : () => field.input },
            { click : '.b-list-item[data-id="startnoearlierthan"]' },
            { type : '[TAB]', target : () => field.input },

            { waitFor : () => project.getEventById(1).constraintDate - (new Date(2017, 0, 16)) === 0 }
        );
    });

    t.it('Should add new 1d task (addNewAtEnd default behavior)', async t => {
        gantt = await t.getGanttAsync({
            tasks : [
                {}
            ]
        });

        t.firesOnce(gantt.taskStore, 'add');

        await t.doubleClick('.b-grid-cell');
        await t.waitForSelector('.b-textfield input');
        await t.type(null, '[ENTER]');

        await t.waitForSelector('.b-textfield input');
        t.pass('Editing new record');

        t.is(gantt.taskStore.rootNode.lastChild.name, 'New task');
    });

    t.it('Should be possible to opt out of addNewAtEnd behavior', async t => {
        gantt = t.getGantt({
            tasks : [
                {}
            ],
            features : {
                cellEdit : {
                    addNewAtEnd : false
                }
            }
        });

        t.wontFire(gantt.taskStore, 'add');

        await t.doubleClick('.b-grid-cell');
        await t.waitForSelector('.b-textfield input');
        await t.type(null, '[ENTER]');

        t.selectorNotExists('.b-textfield input');
    });

    // https://github.com/bryntum/support/issues/1678
    t.it('Should show dirty indicator for composite field columns like duration / effort', async t => {
        gantt = t.getGantt({
            showDirty : true,
            columns   : [
                { type : 'duration' },
                { type : 'effort' }
            ],
            tasks : [
                {
                    duration : 1,
                    effort   : 2
                }
            ]
        });

        gantt.taskStore.first.set({
            durationUnit : 'h',
            effort       : 10
        });

        await t.waitForSelector('[data-column="fullDuration"].b-cell-dirty:contains(1 hour)');
        await t.waitForSelector('[data-column="fullEffort"].b-cell-dirty:contains(10 hours)');
    });

    // https://github.com/bryntum/support/issues/2221
    t.it('Should calculate start/end correctly when pressing Enter in duration field of newly added task', async t => {
        gantt = t.getGantt({
            columns : [
                { type : 'name' },
                { type : 'duration' }
            ],
            tasks : []
        });

        const added = gantt.taskStore.rootNode.appendChild({ name : 'new' });

        await gantt.project.propagateAsync();

        gantt.startEditing({
            record : added,
            field  : 'name'
        });

        await t.type('.b-textfield input:focus', '[TAB]3');
        await t.type(null, '[ENTER]');

        t.is(gantt.taskStore.rootNode.firstChild.duration, 3, 'duration saved');
    });

    // https://github.com/bryntum/support/issues/2372
    t.it('Should clear invalid state of previous edit', async t => {
        gantt = await t.getGanttAsync({
            columns : [
                { type : 'name' }
            ],
            tasks : [
                {
                    id        : 1,
                    name      : 'Parent',
                    startDate : '2017-01-16',
                    duration  : 1,
                    expanded  : true,
                    children  : [
                        {
                            id        : 2,
                            name      : 'Task 2',
                            startDate : '2017-01-16',
                            duration  : 1
                        },
                        {
                            id        : 3,
                            name      : 'Task 3',
                            startDate : '2017-01-16',
                            duration  : 1
                        }
                    ]
                }
            ]
        });

        await gantt.editTask(gantt.taskStore.getById(2));

        await t.click('.b-tab:contains(Predecessors)');
        await t.click('.b-icon-add');

        // cell renderer should never output undefined before you have chosen a task
        t.assertNoDomGarbage(t);

        await t.click('.b-editor .b-combo');
        await t.type(null, '[DOWN]');
        await t.click('.b-list-item:contains(Parent)'); // invalid selection

        await t.click('.b-button:contains(Cancel)');

        await gantt.editTask(gantt.taskStore.getById(2));

        t.selectorNotExists('.b-editor', 'No cell editing after opening task editor');
    });

    // https://github.com/bryntum/support/issues/2377
    t.it('Should not allow setting end before start', async t => {
        gantt = t.getGantt({
            columns : [
                { type : 'name' },
                { id : 'end', text : 'normal end date', type : 'enddate' },
                { id : 'endWithMin', text : 'min date 2022 Jan 1st', type : 'enddate', editor : { min : new Date(2022, 0, 1) } }
            ],
            tasks : [
                {
                    id        : 1,
                    name      : 'Task',
                    startDate : '2017-01-16',
                    duration  : 3
                },
                {
                    id                : 2,
                    name              : 'Future task',
                    startDate         : '2022-01-03',
                    manuallyScheduled : true,
                    duration          : 3
                },
                {
                    id                : 3,
                    name              : 'Distant task',
                    startDate         : '2022-01-05',
                    manuallyScheduled : true,
                    duration          : 3
                }
            ]
        });

        const
            cellEdit = gantt.features.cellEdit,
            task     = gantt.taskStore.getById(1),
            task2    = gantt.taskStore.getById(2),
            task3    = gantt.taskStore.getById(3);

        await gantt.project.commitAsync();

        gantt.startEditing({
            record   : task,
            columnId : 'end'
        });

        t.is(cellEdit.editor.inputField.min, task.startDate, 'Min value set to task startDate');

        gantt.startEditing({
            record   : task,
            columnId : 'endWithMin'
        });

        t.is(cellEdit.editor.inputField.min, new Date(2022, 0, 1), 'Configured min value respected');

        gantt.startEditing({
            record   : task3,
            columnId : 'endWithMin'
        });

        t.is(cellEdit.editor.inputField.min, task3.startDate, 'Start Date > configured min');

        gantt.startEditing({
            record   : task2,
            columnId : 'endWithMin'
        });

        t.is(cellEdit.editor.inputField.min, task2.startDate, 'Start Date > configured min, but less than previously edit task start');
    });

    // https://github.com/bryntum/support/issues/3677
    t.it('Should not crash when triggering edit for a record in a collapsed parent, or in a column with Number type id', async t => {
        gantt = await t.getGanttAsync({
            columns : [
                // NOTE - we should accept column id being integer
                { id : 1, type : 'name' }
            ],
            tasks : [
                {
                    id        : 1,
                    name      : 'Task',
                    startDate : '2017-01-16',
                    duration  : 3,
                    children  : [
                        {
                            id   : 11,
                            name : 'foo'
                        }
                    ]
                }
            ]
        });

        await gantt.startEditing({
            record : gantt.taskStore.getById(1)
        });

        await t.waitForSelector('.b-editor[data-row-id="1"]');

        await gantt.startEditing({
            record : gantt.taskStore.getById(11)
        });

        await t.waitForSelector('.b-editor[data-row-id="11"]');
    });
});
