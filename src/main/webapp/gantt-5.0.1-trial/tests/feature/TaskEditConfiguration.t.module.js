import { Grid } from '../../build/gantt.module.js?457330';

StartTest(t => {

    //region FilesTab
    class FilesTab extends Grid {
        static get $name() {
            return 'FilesTab';
        }

        // Factoryable type name
        static get type() {
            return 'custom_filestab';
        }

        static get defaultConfig() {
            return {
                title    : 'Files',
                defaults : {
                    labelWidth : 200
                },
                columns : [{
                    text       : 'Files attached to task',
                    field      : 'name',
                    htmlEncode : false,
                    renderer   : ({ record }) => `<i class="b-fa b-fa-fw b-fa-${record.data.icon}"></i>${record.data.name}`
                }]
            };
        }

        loadEvent() {
            this.store.data = [
                { name : `Image.pdf`, icon : 'image' },
                { name : `Chart.pdf`, icon : 'chart-pie' }
            ];
        }
    }

    // Register this widget type with its Factory
    FilesTab.initClass();

    //endregion FilesTab

    let gantt;

    t.beforeEach(() => gantt && gantt.destroy());

    t.it('Should support configuring extra widgets for each tab', t => {
        gantt = t.getGantt({
            features : {
                taskEdit : {
                    editorConfig : {
                        height : '40em'
                    },
                    items : {
                        generalTab : {
                            items : {
                                foo1 : { type : 'button', text : 'general' }
                            }
                        },
                        successorsTab : {
                            items : {
                                foo2 : { type : 'button', text : 'successors' }
                            }
                        },
                        predecessorsTab : {
                            items : {
                                foo3 : { type : 'button', text : 'predecessors' }
                            }
                        },
                        resourcesTab : {
                            items : {
                                foo4 : { type : 'button', text : 'resources' }
                            }
                        },
                        advancedTab : {
                            items : {
                                foo5 : { type : 'button', text : 'advanced' }
                            }
                        },
                        notesTab : {
                            items : {
                                foo6 : { type : 'button', text : 'notes' }
                            }
                        }
                    }
                }
            }
        });

        const steps = [];

        ['general', 'successors', 'predecessors', 'resources', 'advanced', 'notes'].forEach((text, i) => {
            steps.push(
                { click : `.b-tabpanel-tab:nth-child(${i + 1})` },
                { waitForSelector : `.b-${text}tab .b-button:contains(${text})` }
            );
        });

        t.chain(
            { waitForPropagate : gantt },
            async() => {
                gantt.editTask(gantt.taskStore.getById(11));
            },
            steps
        );
    });

    // https://app.assembla.com/spaces/bryntum/tickets/8785
    t.it('Should support configuring listeners', t => {
        gantt = t.getGantt({
            features : {
                taskEdit : {
                    editorConfig : {
                        listeners : {
                            beforeClose : () => {
                            }
                        }
                    }
                }
            }
        });

        const editor = gantt.features.taskEdit.getEditor();

        t.ok(editor.listeners.cancel, 'Cancel listener is present');
        t.ok(editor.listeners.delete, 'Delete listener is present');
        t.ok(editor.listeners.save, 'Save listener is present');
        t.ok(editor.listeners.beforeclose, 'BeforeClose listener is present');
    });

    t.it('Should be possible to provide tabs config to TaskEdit feature', async t => {

        gantt = t.getGantt({
            features : {
                taskTooltip : false,
                taskEdit    : {
                    editorConfig : {
                        height : '37em'
                    },
                    items : {
                        generalTab : {
                            // change title of General tab
                            title : 'Common',
                            items : {
                                foo1 : {
                                    html    : '',
                                    dataset : {
                                        text : 'Custom fields'
                                    },
                                    cls  : 'b-divider',
                                    flex : '1 0 100%'
                                },
                                deadlineField : {
                                    type  : 'datefield',
                                    name  : 'deadline',
                                    label : 'Deadline'
                                }
                            }
                        },
                        // remove Notes tab
                        notesTab : false,
                        // add custom Files tab
                        filesTab : {
                            type   : 'custom_filestab',
                            weight : 800
                        }
                    }
                }
            }
        });

        t.chain(
            { dblClick : '.b-gantt-task.id11' },

            {
                waitForSelector : '.b-taskeditor',
                desc            : 'Task editor appeared'
            },

            {
                waitForSelector : '.b-tabpanel-tab:textEquals(Common)',
                desc            : 'Renamed General -> Common tab appeared'
            },
            {
                waitForSelectorNotFound : '.b-tabpanel-tab:textEquals(Notes)',
                desc                    : 'Notes tab is removed'
            },

            next => {
                t.ok(gantt.taskEdit.editor.widgetMap.deadlineField, 'Custom Deadline field appeared');
                next();
            },

            {
                waitForSelector : '.b-tabpanel-tab :textEquals(Files)',
                desc            : 'Files tab appeared'
            },

            { click : '.b-tabpanel-tab :textEquals(Files)' },

            {
                waitFor : () => gantt.taskEdit.editor.widgetMap.tabs.activeItem.$$name === 'FilesTab',
                desc    : 'Files tab active'
            }
        );

    });

    // https://github.com/bryntum/support/issues/95
    t.it('Start date result should match what is selected in the picker when default 24/7 calendar is used', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            columns : [
                { type : 'name', width : 200 },
                { type : 'startdate', width : 250, format : 'YYYY-MM-DD HH:mm' },
                { type : 'enddate', width : 250, format : 'YYYY-MM-DD HH:mm' }
            ],
            listeners : {
                beforeTaskEditShow({ editor }) {
                    editor.widgetMap.startDate.format = 'YYYY-MM-DD HH:mm';
                    editor.widgetMap.endDate.format = 'YYYY-MM-DD HH:mm';
                }
            }
        });

        let dateField;

        t.chain(
            { waitForSelector : '.b-grid-row[data-id=11] .b-grid-cell[data-column="startDate"]:textEquals(2017-01-16 00:00)' },
            { dblClick : '.b-gantt-task.id11' },
            { waitForSelector : '.b-gantt-taskeditor .b-start-date' },
            next => {
                dateField = gantt.features.taskEdit.editor.widgetMap.startDate;
                t.is(dateField.input.value, '2017-01-16 00:00');
                t.isDateEqual(dateField.value, new Date(2017, 0, 16));
                next();
            },
            { click : '.b-gantt-taskeditor .b-start-date .b-icon-calendar' },
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

    t.it('Start date result should match what is selected in the picker when business 8/5 calendar is used', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            columns : [
                { type : 'name', width : 200 },
                { type : 'startdate', width : 160, format : 'YYYY-MM-DD HH:mm' },
                { type : 'enddate', width : 160, format : 'YYYY-MM-DD HH:mm' }
            ],
            listeners : {
                beforeTaskEditShow({ editor }) {
                    editor.widgetMap.startDate.format = 'YYYY-MM-DD HH:mm';
                    editor.widgetMap.endDate.format = 'YYYY-MM-DD HH:mm';
                }
            },
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
            { dblClick : '.b-gantt-task.id11' },
            { waitForSelector : '.b-gantt-taskeditor .b-start-date' },
            next => {
                dateField = gantt.features.taskEdit.editor.widgetMap.startDate;
                t.is(dateField.input.value, '2017-01-16 08:00');
                t.isDateEqual(dateField.value, new Date(2017, 0, 16, 8));
                next();
            },
            { click : '.b-gantt-taskeditor .b-start-date .b-icon-calendar' },
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

    t.it('End date result should match what is selected in the picker when default 24/7 calendar is used', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            columns : [
                { type : 'name', width : 200 },
                { type : 'startdate', width : 160, format : 'YYYY-MM-DD HH:mm' },
                { type : 'enddate', width : 160, format : 'YYYY-MM-DD HH:mm' }
            ],
            listeners : {
                beforeTaskEditShow({ editor }) {
                    editor.widgetMap.startDate.format = 'YYYY-MM-DD HH:mm';
                    editor.widgetMap.endDate.format = 'YYYY-MM-DD HH:mm';
                }
            }
        });

        let dateField;

        t.chain(
            { waitForSelector : '.b-grid-row[data-id=11] .b-grid-cell[data-column="endDate"]:textEquals(2017-01-26 00:00)' },
            { dblClick : '.b-gantt-task.id11' },
            { waitForSelector : '.b-gantt-taskeditor .b-end-date' },
            next => {
                dateField = gantt.features.taskEdit.editor.widgetMap.endDate;
                t.is(dateField.input.value, '2017-01-26 00:00');
                t.isDateEqual(dateField.value, new Date(2017, 0, 26));
                next();
            },
            { click : '.b-gantt-taskeditor .b-end-date .b-icon-calendar' },
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

    t.it('End date result should match what is selected in the picker when business 8/5 calendar is used', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            columns : [
                { type : 'name', width : 200 },
                { type : 'startdate', width : 250, format : 'YYYY-MM-DD HH:mm' },
                { type : 'enddate', width : 250, format : 'YYYY-MM-DD HH:mm' }
            ],
            listeners : {
                beforeTaskEditShow({ editor }) {
                    editor.widgetMap.startDate.format = 'YYYY-MM-DD HH:mm';
                    editor.widgetMap.endDate.format = 'YYYY-MM-DD HH:mm';
                }
            },
            project : {
                calendar      : 'business',
                // https://github.com/bryntum/support/issues/820
                hoursPerDay   : 8,
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
            { waitForSelector : '.b-grid-row[data-id=11] .b-grid-cell[data-column="endDate"]:textEquals(2017-01-27 17:00)' },
            { dblClick : '.b-gantt-task.id11' },
            { waitForSelector : '.b-gantt-taskeditor .b-end-date' },
            next => {
                dateField = gantt.features.taskEdit.editor.widgetMap.endDate;
                t.is(dateField.input.value, '2017-01-27 17:00');
                t.isDateEqual(dateField.value, new Date(2017, 0, 27, 17));
                next();
            },
            { click : '.b-gantt-taskeditor .b-end-date .b-icon-calendar' },
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
});
