import { Gantt, ResourceStore, LocaleManager } from '../../build/gantt.module.js?457330';

StartTest(t => {

    let gantt;

    Object.assign(window, {
        Gantt,
        ResourceStore
    });

    t.beforeEach(() => gantt?.destroy());

    t.it('Should allow setting negative lag', async t => {
        gantt = await t.getGanttAsync({
            width          : 400,
            subGridConfigs : {
                locked : {
                    width : 1
                }
            },
            features : {
                taskTooltip : false
            }
        });

        t.chain(
            { dblClick : '[data-task-id="14"]' },
            { waitFor : () => gantt.features.taskEdit.editor.containsFocus },
            { click : '.b-tabpanel-tab:textEquals(Predecessors)' },
            { dblClick : '.b-grid-row[data-index=0] .b-grid-cell:textEquals(0 days)' },
            { type : '[ARROWDOWN][ENTER]' },
            { waitForSelector : '.b-grid-row[data-index=0] .b-grid-cell:textEquals(-1 days)' }
        );
    });

    // https://app.assembla.com/spaces/bryntum/tickets/8015
    t.it('Rejecting dependency removing and removing again should work', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },

            resources : t.getResourceStoreData()
        });

        const investigate = gantt.project.eventStore.getById(11);
        const assignResources = gantt.project.eventStore.getById(12);

        let iaDep;

        t.chain(
            { waitForPropagate : gantt.project },

            { dblclick : '.b-gantt-task.id11' },

            { click : '.b-tabpanel-tab:contains(Successors)' },

            { click : '.b-successorstab .b-add-button' },

            { click : '.b-grid .b-cell-editor' },
            { type : '[DOWN]' },

            { wheel : '.b-list', deltaY : '-100' },

            { click : '.b-list-item:contains(Assign resources)' },

            // https://github.com/bryntum/support/issues/814
            { type : '[ENTER]' },

            { waitForPropagate : gantt.project },

            { click : '.b-button:contains(Save)' },

            { waitForSelectorNotFound : '.b-gantt-taskeditor' },

            next => {
                // Checking for new dependency
                iaDep = gantt.project.dependencyStore.find(d => d.fromEvent === investigate && d.toEvent === assignResources);
                t.ok(iaDep, 'Dependency is found');
                next();
            },

            { dblclick : '.b-gantt-task.id11' },

            { click : '.b-tabpanel-tab:contains(Successors)' },

            { click : '.b-gantt-taskeditor .b-grid-row:contains(Assign resources)' },

            { click : '.b-successorstab .b-remove-button' },

            { waitForPropagate : gantt.project },

            { click : '.b-button:contains(Cancel)' },

            { waitForSelectorNotFound : '.b-taskeditor-editing' },

            next => {
                // Checking for new dependency
                iaDep = gantt.project.dependencyStore.find(d => d.fromEvent === investigate && d.toEvent === assignResources);
                t.ok(iaDep, 'Dependency is found');
                next();
            },

            { waitForPropagate : gantt.project },

            { dblclick : '.b-gantt-task.id11' },

            { click : '.b-tabpanel-tab:contains(Successors)' },

            { click : '.b-gantt-taskeditor .b-grid-row:contains(Assign resources)' },

            { click : '.b-successorstab .b-remove-button', desc : 'Here' },

            { waitForPropagate : gantt.project },

            { click : '.b-button:contains(Save)' },

            { waitForSelectorNotFound : '.b-taskeditor-editing' },

            () => {
                // Checking for dependency absence
                t.notOk(gantt.project.dependencyStore.includes(iaDep), 'Dependency has been removed');
                t.is(investigate.startDate, assignResources.startDate, 'Assign resources shifted back to project start');
            }
        );

    });

    // https://github.com/bryntum/support/issues/123
    t.it('Should show full list of tasks in dependency tab in TaskEditor when task store is filtered', async t => {
        gantt = await t.getGanttAsync();

        const count = gantt.taskStore.count; // 15

        gantt.taskStore.filter('name', 'Investigate');

        t.chain(
            { dblclick : '[data-task-id="11"]' },
            { click : '.b-successors-tab' },
            { click : '.b-successors-tab .b-add-button' },
            { click : '.b-icon-picker' },
            { click : '.b-list-item.id12' },
            { type : '[ENTER]' },
            { click : '.b-cell-editor .b-fieldtrigger' },
            { waitForSelector : '.b-list-item' },
            () => {
                // -1 because task cannot depend on itself
                // -1 because task already was added as successor previously
                t.selectorCountIs('.b-list-item', count - 2, 'Full list of tasks shown');
            }
        );
    });

    t.it('Should use dependencyIdField format for data', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskEdit : {
                    editorConfig : {
                        dependencyIdField : 'wbsCode'
                    }
                }
            }
        });

        t.chain(
            { dblclick : '[data-task-id="14"]' },
            { click : '.b-successors-tab' },
            { waitForSelector : '.b-successors-tab .b-grid-cell[data-column="toEvent"]:contains(Preparation work (1.2.1))' },
            { click : '.b-predecessors-tab' },
            { waitForSelector : '.b-predecessors-tab .b-grid-cell[data-column="fromEvent"]:contains(Investigate (1.1.1))' }
        );
    });

    t.it('Should show full list of tasks in dependency tab in TaskEditor when some of task nodes are collapsed', async t => {
        gantt = await t.getGanttAsync();

        const count = gantt.taskStore.count; // 15

        t.chain(
            { waitForPropagate : gantt.project },
            () => gantt.collapse(gantt.taskStore.getById(2)),
            { dblclick : '[data-task-id="11"]' },
            { click : '.b-successors-tab' },
            { click : '.b-successors-tab .b-add-button' },
            { click : '.b-icon-picker' },
            { click : '.b-list-item.id12' },
            { type : '[ENTER]' },
            { click : '.b-cell-editor .b-fieldtrigger' },
            { waitForSelector : '.b-list-item' },
            () => {
                // -1 because task cannot depend on itself
                // -1 because task already was added as successor previously
                t.selectorCountIs('.b-list-item', count - 2, 'Full list of tasks shown');
            }
        );
    });

    t.it('Should mark newly added dependencies as added records', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false,
                taskEdit    : {
                    items : {
                        predecessorsTab : {
                            items : {
                                grid : {
                                    columns : {
                                        data : {
                                            id : {
                                                hidden : false
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        });

        t.chain(
            { waitForPropagate : gantt.project },
            next => {
                gantt.project.acceptChanges();
                next();
            },
            { dblClick : '.b-gantt-task.id232' },
            { click : '.b-tabpanel-tab:contains(Predecessors)' },
            { click : '.b-predecessorstab .b-add-button' },
            { click : '.b-cell-editor .b-fieldtrigger' },
            { click : '.b-list-item[data-id="231"]' },
            { click : '[data-ref="saveButton"]' },
            { waitForPropagate : gantt.project },
            () => {
                t.is(gantt.dependencyStore.added.count, 1, 'Should have one record added');
                t.is(gantt.dependencyStore.modified.count, 0, 'Should have no records modified');
            }
        );
    });

    // https://github.com/bryntum/support/issues/812
    t.it('Adding invalid dependency should be handled properly', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            resources : t.getResourceStoreData()
        });

        t.chain(
            { waitForPropagate : gantt.project },

            { dblclick : '.b-gantt-task.id11' },

            { click : '.b-tabpanel-tab:contains(Predecessors)' },

            { click : '.b-add-button' },

            { click : '.b-grid .b-cell-editor' },
            { type : '[DOWN]' },

            { click : '.b-list-item:contains(Report to management)' },

            { click : '.b-grid', desc : 'Clicked outside to finish cell editing' },

            { moveMouseTo : '.b-grid .b-cell-editor' },

            { waitForSelector : '.b-field-error-tip:contains(Cyclic dependency)', desc : 'Proper error tooltip is found' },

            { click : '.b-button:contains(Save)' },

            { waitFor : 100 },

            { waitForSelector : '.b-gantt-taskeditor', desc : 'Task editor stays open. Since the input is invalid' },

            { click : '.b-button:contains(Cancel)' },

            { waitForSelectorNotFound : '.b-gantt-taskeditor', desc : 'Task editor closed' },

            { dblclick : '.b-gantt-task.id11' },

            { click : '.b-tabpanel-tab:contains(Predecessors)' },

            { waitForSelector : '.b-predecessors-tab .b-grid' },

            async() => {
                t.selectorNotExists('.b-predecessors-tab .b-grid-row', 'no rows left from previous task editor run');
                t.selectorNotExists('b-cell-editor', 'no cell editor left from previous task editor run');
            }
        );

    });

    t.it('Removing of invalid phantom dependency should work', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            resources : t.getResourceStoreData()
        });

        t.chain(
            { waitForPropagate : gantt.project },

            { dblclick : '.b-gantt-task.id11' },

            { click : '.b-tabpanel-tab:contains(Predecessors)' },

            { click : '.b-add-button', decs : 'Clicked to add a dependency' },

            { click : '.b-grid', desc : 'Clicked outside to finish cell editing' },

            { dblclick : '.b-grid-cell[data-column=fromEvent]', desc : 'Double Clicked to start cell editing again' },

            { click : '.b-remove-button', desc : 'Clicked to remove the dependency' },

            { click : '.b-button:contains(Cancel)' }
        );

    });

    t.it('Confirm delete dialog should be localized', async t => {
        LocaleManager.extendLocale('En', {
            TaskEdit : {
                ConfirmDeletionTitle   : 'Please confirm deletion',
                ConfirmDeletionMessage : 'Go forward?'
            }
        });

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false,
                taskEdit    : {
                    confirmDelete : true
                }
            }
        });

        t.chain(
            { waitForPropagate : gantt.project },
            { dblClick : '.b-gantt-task.id232' },
            { click : '.b-gantt-taskeditor .b-button:contains(Delete)' },
            {
                waitForSelector : '.b-messagedialog-message:contains(Go forward?)',
                desc            : 'Message text has been translated'
            },
            {
                waitForSelector : '.b-messagedialog .b-header-title:contains(Please confirm deletion)',
                desc            : 'Title text has been translated'
            }
        );
    });

    // https://github.com/bryntum/support/issues/2342
    t.it('Should be able to change successor or predecessor for a task that wont generate a cycle', async t => {
        gantt = await t.getGanttAsync();

        t.chain(
            { dblclick : '.b-gantt-task.id233' },
            { click : '.b-tabpanel-tab:contains(Successors)' },
            { dblclick : '.b-grid-row [data-column="toEvent"]' },
            { click : '.b-icon-picker' },
            { click : '.b-list-item.id3' },
            { click : '.b-button:contains(Save)' },
            { waitForProjectReady : gantt.project },
            () => {
                const
                    { eventStore } = gantt.project,
                    evtEditing     = eventStore.getById(233),
                    predecessor    = eventStore.getById(22),
                    successor      = eventStore.getById(3);

                t.is(evtEditing.dependencies.length, 2, 'Proper number of dependencies');

                t.is(evtEditing.predecessors.length, 1, 'Still proper number of predecessors');
                t.is(evtEditing.predecessors[0].fromEvent, predecessor, 'Still proper predecessor "fromEvent"');
                t.is(evtEditing.predecessors[0].toEvent, evtEditing, 'Still proper predecessor "toEvent"');

                t.is(evtEditing.successors.length, 1, 'Proper number of successors');
                t.is(evtEditing.successors[0].fromEvent, evtEditing, 'Proper successor "fromEvent"');
                t.is(evtEditing.successors[0].toEvent, successor, 'Proper successor "toEvent"');
            }
        );
    });

    // https://github.com/bryntum/support/issues/2373
    t.it('Should not remove successor column name when add invalid successor', async t => {
        gantt = await t.getGanttAsync();

        t.chain(
            { dblclick : '.b-gantt-task.id233' },
            { click : '.b-successors-tab' },
            { click : '.b-successors-tab .b-add-button' },
            { click : '.b-icon-picker' },
            { click : '.b-list-item.id22' },
            { type : '[ENTER]' },
            { waitForSelector : '.b-cell-editor[data-field="toEvent"] .b-invalid input[__lastvalue="Choose technology suite"]', desc : 'Value on combo is correct with invalid flag' },
            { click : '.b-button[data-ref="saveButton"]' },
            { waitForProjectReady : gantt.project },
            { dblclick : '.b-gantt-task.id233' },
            { waitForSelector : '[data-column="toEvent"]:contains(Follow up with customer (234))', desc : 'The current valid successor is still present' },
            next => {
                t.is(gantt.project.eventStore.getById(233).successors.length, 1, 'The invalid successor was not saved, just the valid is present');
                next();
            },
            { click : '.b-predecessors-tab' },
            { click : '.b-predecessors-tab .b-add-button' },
            { click : '.b-icon-picker' },
            { click : '.b-list-item.id234' },
            { type : '[ENTER]' },
            { waitForSelector : '.b-cell-editor[data-field="fromEvent"] .b-invalid input[__lastvalue="Follow up with customer"]', desc : 'Value on combo is correct with invalid flag' },
            { click : '.b-button[data-ref="cancelButton"]' },
            { dblclick : '.b-gantt-task.id233' },
            { waitForSelector : '[data-column="fromEvent"]:contains(Choose technology suite (22))', desc : 'The current valid predecessor is still present' },
            next => {
                t.is(gantt.project.eventStore.getById(233).predecessors.length, 1, 'The invalid predecessor was not saved, just the valid is present');
                next();
            },
            { dblclick : '.b-grid-row [data-column="fromEvent"]' },
            { click : '.b-icon-picker' },
            { click : '.b-list-item.id234' },
            { type : '[ENTER]' },
            { click : '.b-icon-picker' },
            { click : '.b-list-item.id22' },
            { click : '.b-button[data-ref="saveButton"]' },
            { waitForProjectReady : gantt.project },
            { dblclick : '.b-gantt-task.id233' },
            { waitForSelector : '[data-column="fromEvent"]:contains(Choose technology suite (22))', desc : 'Reverted to the valid predecessor' },
            next => {
                t.is(gantt.project.eventStore.getById(233).predecessors.length, 1, 'The invalid predecessor was reverted, just the valid is present');
                next();
            },
            { click : '.b-successors-tab' },
            { dblclick : '.b-grid-row [data-column="toEvent"]' },
            { click : '.b-icon-picker' },
            { click : '.b-list-item.id22' },
            { type : '[ENTER]' },
            { click : '.b-icon-picker' },
            { click : '.b-list-item.id234' },
            { click : '.b-button[data-ref="saveButton"]' },
            { waitForProjectReady : gantt.project },
            { dblclick : '.b-gantt-task.id233' },
            { waitForSelector : '[data-column="toEvent"]:contains(Follow up with customer (234))', desc : 'Reverted to the valid successor' },
            () => {
                t.is(gantt.project.eventStore.getById(233).successors.length, 1, 'The invalid successor was reverted, just the valid is present');
            }
        );
    });

    // https://github.com/bryntum/support/issues/3359
    t.it('Should show dependencyIdField in the id column', async t => {
        gantt = await t.getGanttAsync();

        await gantt.editTask(gantt.taskStore.getById(14));
        await t.click('.b-tabpanel-tab:textEquals(Predecessors)');
        gantt.features.taskEdit.editor.widgetMap.predecessorsTab.widgetMap.grid.columns.first.hidden = false;
        await t.waitForSelector('.b-grid-cell[data-column-id="id"]:textEquals(11)');
    });

    t.it('Should use correct stores after replacing project', async t => {
        gantt = await t.getGanttAsync();

        await gantt.editTask(gantt.taskStore.first);

        await t.type(null, '[ESC]');

        await gantt.project.commitAsync();

        gantt.project = {
            resourcesData : [
                { id : 1, name : 'Resource 1' }
            ],

            eventsData : [
                { id : 1, name : 'Event 1', startDate : '2020-03-23', duration : 2, percentDone : 50 },
                { id : 2, name : 'Event 2', startDate : '2020-03-24', duration : 3, percentDone : 40 }
            ],

            assignmentsData : [
                { id : 1, resource : 1, event : 1 },
                { id : 2, resource : 1, event : 2 }
            ],

            dependenciesData : [
                { id : 1, fromEvent : 1, toEvent : 2, lag : 2 }
            ]
        };

        await gantt.project.commitAsync();

        await gantt.editTask(gantt.taskStore.first);

        const { widgetMap } = gantt.features.taskEdit.editor;

        t.is(widgetMap.successorsTab.widgetMap.grid.store.masterStore, gantt.project.dependencyStore, 'Correct successors store');
        t.is(widgetMap.predecessorsTab.widgetMap.grid.store.masterStore, gantt.project.dependencyStore, 'Correct predecessors store');
        t.is(widgetMap.calendarField.store, gantt.project.calendarManagerStore, 'Correct calendar store');
        t.is(widgetMap.resourcesTab.resourceCombo.store.masterStore, gantt.project.resourceStore, 'Correct resources store');
    });
});
