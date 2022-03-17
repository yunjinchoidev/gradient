import { ResourceAssignmentColumn } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt;

    t.beforeEach(() => gantt && gantt.destroy());

    t.it('Should save assignments after task edit save button click', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },

            resources : t.getResourceStoreData()
        });

        const
            investigate = gantt.project.eventStore.getAt(2),
            Arcady      = gantt.project.resourceStore.getById(1);

        t.chain(
            { dblClick : '.b-gantt-task.id11' },

            { waitForSelector : '.b-taskeditor' },

            { click : '.b-tabpanel-tab:contains(Resources)' },

            { click : '.b-resourcestab .b-add-button' },

            { click : '.b-grid .b-cell-editor' },
            { type : '[DOWN]' },

            { wheel : '.b-list', deltaY : '-100' },

            { click : '.b-list-item[data-index="0"]' },

            { click : '.b-button:contains(Save)' },

            { waitForPropagate : gantt.project },

            () => {
                t.is(investigate.assignments.length, 1, 'Investigate task now has one assignment');
                t.is(investigate.assignments[0].resource, Arcady, 'Arcady is assigned to the task');
            }
        );
    });

    t.it('Should not change assignments after task edit cancel button click', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },

            resources : t.getResourceStoreData()
        });

        const investigate = gantt.project.eventStore.getAt(2);

        t.chain(
            { dblClick : '.b-gantt-task.id11' },

            { waitForSelector : '.b-taskeditor' },

            { click : '.b-tabpanel-tab:contains(Resources)' },

            { click : '.b-resourcestab .b-add-button' },

            { click : '.b-grid .b-cell-editor' },
            { type : '[DOWN]' },

            { wheel : '.b-list', deltaY : '-100' },

            { click : '.b-list-item[data-index="0"]' },

            // https://github.com/bryntum/support/issues/814
            { type : '[ENTER]' },

            { click : '.b-button:contains(Cancel)' },

            { waitForSelectorNotFound : '.b-taskeditor-editing' },

            () => {
                t.is(investigate.assignments.length, 0, 'Investigate task now has no assignments');
            }
        );
    });

    t.it('Should not cancel edit when editing a new resource assignment', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },

            resources : t.getResourceStoreData()
        });

        let editorContext;

        t.chain(
            { dblClick : '.b-gantt-task.id11' },

            { waitForSelector : '.b-taskeditor' },

            next => {
                gantt.features.taskEdit.editor.widgetMap.tabs.layout.animateCardChange = false;
                next();
            },

            { click : '.b-tabpanel-tab:contains(Resources)' },

            { click : '.b-resourcestab .b-add-button' },

            {
                waitFor : () => {
                    editorContext = gantt.features.taskEdit.editor.widgetMap.resourcesTab.widgetMap.grid.features.cellEdit.editorContext;

                    return editorContext && editorContext.editor.containsFocus;
                }
            },

            { click : () => editorContext.editor.inputField.triggers.expand.element },

            { click : () => editorContext.editor.inputField.picker.getItem(1) },

            { type : '[TAB]' },

            // Nothing should happen. The test is that editing does not finish
            // so there's no event to wait for.
            { waitFor : 500 },

            () => {
                editorContext = gantt.features.taskEdit.editor.widgetMap.resourcesTab.widgetMap.grid.features.cellEdit.editorContext;

                t.ok(editorContext && editorContext.editor.containsFocus);
            }
        );
    });

    t.it('Should not show already assigned resources in the resource combo picker', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },

            resources : t.getResourceStoreData()
        });

        const
            investigate = gantt.project.eventStore.getAt(2),
            Arcady      = gantt.project.resourceStore.getById(1);

        investigate.assign(Arcady);

        t.chain(
            { dblClick : '.b-gantt-task.id11' },

            { waitForSelector : '.b-taskeditor' },

            { click : '.b-tabpanel-tab:contains(Resources)' },

            { dblclick : '.b-resources-tab .b-grid .b-grid-cell' },
            { click : '.b-grid .b-cell-editor' },
            { type : '[DOWN]' },

            next => {
                t.selectorExists('.b-list-item:textEquals(Arcady)', 'Arcady not filtered out since he is the resource of the assignment being edited');
                next();
            },
            { type : '[ESCAPE]' },

            { click : '.b-resourcestab .b-add-button' },

            { click : '.b-grid .b-cell-editor' },
            { type : '[DOWN]' },

            next => {
                t.selectorNotExists('.b-list-item:textEquals(Arcady)', 'Arcady filtered out since he is already assigned');
            }
        );
    });

    t.it('Should mark newly added assignments as added records', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            resources : t.getResourceStoreData()
        });

        t.chain(
            { dblClick : '.b-gantt-task.id12' },
            { click : '.b-tabpanel-tab:contains(Resources)' },
            { click : '.b-resourcestab .b-add-button' },
            { click : '.b-cell-editor .b-fieldtrigger' },
            { click : '.b-list-item[data-id="1"]' },
            { click : '[data-ref="saveButton"]' },
            { waitForPropagate : gantt.project },
            () => {
                t.is(gantt.assignmentStore.added.count, 1, 'Should have one record added');
                t.is(gantt.assignmentStore.modified.count, 0, 'Should have no records modified');
            }
        );
    });

    // https://github.com/bryntum/support/issues/858
    t.it('Should not send removed dummy assignment record to server', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            resources : t.getResourceStoreData()
        });

        t.chain(
            { diag : 'Add dummy assignment record and cancel changes' },
            { dblClick : '.b-gantt-task.id12' },
            { click : '.b-tabpanel-tab:contains(Resources)' },
            { click : '.b-resourcestab .b-add-button' },
            { click : '[data-ref="cancelButton"]' },

            { diag : 'Add assignment record and save changes' },
            { dblClick : '.b-gantt-task.id13' },
            { click : '.b-tabpanel-tab:contains(Resources)' },
            { click : '.b-resourcestab .b-add-button' },
            { click : '.b-cell-editor .b-fieldtrigger' },
            { click : '.b-list-item[data-id="1"]' },
            { click : '[data-ref="saveButton"]' },

            { waitForPropagate : gantt.project },
            () => {
                t.is(gantt.assignmentStore.added.count, 1, 'Should have one record added');
                t.is(gantt.assignmentStore.modified.count, 0, 'Should have no records modified');
                t.is(gantt.assignmentStore.removed.count, 0, 'Should have no records removed');
            }
        );
    });

    // https://github.com/bryntum/support/issues/968
    t.it('Should not crash when edit a task after saving new resources', async t => {
        let phantomId, resourcesTab;

        t.mockUrl('/syncUrl', () => {
            return {
                responseText : JSON.stringify({
                    success     : true,
                    assignments : {
                        rows : [
                            { id : 9000, $PhantomId : phantomId }
                        ]
                    }
                })
            };
        });

        gantt = await t.getGanttAsync({
            project : {
                transport : {
                    sync : {
                        url : '/syncUrl'
                    }
                },
                resourcesData : t.getResourceStoreData()
            },
            features : {
                taskTooltip : false
            }
        });

        t.chain(
            { dblClick : '.b-gantt-task.id11', desc : 'Edit task' },
            { click : '.b-tabpanel-tab:contains(Resources)' },
            { click : '.b-resourcestab .b-add-button' },
            { click : '.b-cell-editor .b-fieldtrigger', desc : 'Add assignment record' },
            { click : '.b-list-item[data-id="1"]' },

            async() => {
                resourcesTab = gantt.features.taskEdit.editor.widgetMap.resourcesTab;
                phantomId = resourcesTab.grid.store.last.id;
            },

            { click : '[data-ref="saveButton"]', desc : 'Save changes' },

            { waitForSelectorNotFound : '.b-gantt-taskeditor', desc : 'Editor closed' },

            { waitForPropagate : gantt.project },

            () => gantt.project.sync(),

            { dblClick : '.b-gantt-task.id11', desc : 'Edit task again' },

            next => {
                t.waitForRowsVisible(resourcesTab.grid, next);
            },

            () => {
                t.is(resourcesTab.grid.selectedRecord.id, 9000, 'Record is selected');
                t.ok(resourcesTab.grid.selectedRecordCollection.indices.id.get(9000), 'Indices updated');
            }
        );
    });

    // https://github.com/bryntum/support/issues/1131
    t.it('Should not crash when edit a task after canceling new resources', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            tasks : [
                {
                    id           : 1,
                    startDate    : '2020-02-03T00:00:00',
                    duration     : 1,
                    durationUnit : 'd'
                },
                {
                    id           : 2,
                    startDate    : '2020-02-03T00:00:00',
                    duration     : 1,
                    durationUnit : 'd'
                }
            ],
            resources : [
                { id : 1, name : 'Celia' }
            ],
            assignments : [
                { id : 1, event : 1, resource : 1 }
            ],
            dependencies : [
                { id : 1, fromEvent : 1, toEvent : 2 }
            ]
        });

        t.chain(
            { dblClick : '[data-task-id="2"]', desc : 'Edit task' },
            { click : '.b-tabpanel-tab:contains(Resources)' },
            { click : '.b-resourcestab .b-add-button' },
            { click : '.b-cell-editor .b-fieldtrigger', desc : 'Add assignment record' },
            { click : '.b-list-item[data-id="1"]' },
            { click : '[data-ref="cancelButton"]', desc : 'Cancel changes' },

            { dblClick : '[data-task-id="2"]', desc : 'Edit task again' },
            { click : '.b-tabpanel-tab:contains(Resources)' },
            { click : '.b-resourcestab .b-add-button' },
            { click : '.b-cell-editor .b-fieldtrigger', desc : 'Add assignment record' },
            { click : '.b-list-item[data-id="1"]' },
            { click : '[data-ref="saveButton"]', desc : 'Save changes, no errors' }
        );
    });

    // https://github.com/bryntum/support/issues/1148
    t.it('Should save changes and close task editor when cell editing is in progress', async t => {
        gantt = await t.getGanttAsync({
            project : {
                resourcesData : t.getResourceStoreData()
            },
            features : {
                taskTooltip : false,
                taskEdit    : {
                    editorConfig : {
                        calculateMask      : 'L{calculateMask}',
                        // Removing the delay is not required to reproduce the issue, but that illustrates that the calculating mask appears and blocks access to the buttons.
                        calculateMaskDelay : null
                    }
                }
            }
        });

        t.chain(
            { dblClick : '.b-gantt-task.id11', desc : 'Edit task' },
            { click : '.b-tabpanel-tab:contains(Resources)', desc : 'Open Resources Tab' },
            { click : '.b-resourcestab .b-add-button', desc : 'Add dummy resource record' },
            { click : '.b-cell-editor .b-fieldtrigger', desc : 'Open resources' },
            { click : '.b-list-item[data-id="1"]', desc : 'Select resource' },
            { click : '[data-ref="saveButton"]', desc : 'Save changes' },
            { waitForSelectorNotFound : '.b-gantt-taskeditor', desc : 'Editor is closed' }
        );
    });

    t.it('Should cancel changes and close task editor when cell editing is in progress', async t => {
        gantt = await t.getGanttAsync({
            project : {
                resourcesData : t.getResourceStoreData()
            },
            features : {
                taskTooltip : false,
                taskEdit    : {
                    editorConfig : {
                        calculateMask      : 'L{calculateMask}',
                        // Removing the delay is not required to reproduce the issue, but that illustrates that the calculating mask appears and blocks access to the buttons.
                        calculateMaskDelay : null
                    }
                }
            }
        });

        t.chain(
            { dblClick : '.b-gantt-task.id11', desc : 'Edit task' },
            { click : '.b-tabpanel-tab:contains(Resources)', desc : 'Open Resources Tab' },
            { click : '.b-resourcestab .b-add-button', desc : 'Add dummy resource record' },
            { click : '.b-cell-editor .b-fieldtrigger', desc : 'Open resources' },
            { click : '.b-list-item[data-id="1"]', desc : 'Select resource' },
            { click : '[data-ref="cancelButton"]', desc : 'Cancel changes' },
            { waitForSelectorNotFound : '.b-gantt-taskeditor', desc : 'Editor is closed' }
        );
    });

    t.it('Should delete record and close task editor when cell editing is in progress', async t => {
        gantt = await t.getGanttAsync({
            project : {
                resourcesData : t.getResourceStoreData()
            },
            features : {
                taskTooltip : false,
                taskEdit    : {
                    editorConfig : {
                        calculateMask      : 'L{calculateMask}',
                        // Removing the delay is not required to reproduce the issue, but that illustrates that the calculating mask appears and blocks access to the buttons.
                        calculateMaskDelay : null
                    }
                }
            }
        });

        t.chain(
            { dblClick : '.b-gantt-task.id11', desc : 'Edit task' },
            { click : '.b-tabpanel-tab:contains(Resources)', desc : 'Open Resources Tab' },
            { click : '.b-resourcestab .b-add-button', desc : 'Add dummy resource record' },
            { click : '.b-cell-editor .b-fieldtrigger', desc : 'Open resources' },
            { click : '.b-list-item[data-id="1"]', desc : 'Select resource' },
            { click : '[data-ref="deleteButton"]', desc : 'Delete record' },
            { click : '[data-ref="okButton"]', desc : 'Confirm deleting' },
            { waitForSelectorNotFound : '.b-gantt-taskeditor', desc : 'Editor is closed' }
        );
    });

    // https://github.com/bryntum/support/issues/3484
    t.it('Should handle resource store being grouped', async t => {
        gantt = t.getGantt({
            project : {
                resourceStore : {
                    groupers : [
                        { field : 'name', ascending : true }
                    ],
                    data : [
                        { id : 1, name : 'Mike Bentley' },
                        { id : 2, name : 'Dave Jones' }
                    ]
                }
            },

            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true,
                    width       : 100
                }
            ]
        });

        await t.doubleClick('.b-gantt-task.id11');
        await t.click('.b-tabpanel-tab:contains(Resources)');
        await t.click('.b-resourcestab .b-add-button');
        await t.click('.b-cell-editor .b-fieldtrigger');

        t.selectorExists('.b-list.b-grouped .b-list-item-group-header:contains(Mike)', 'Group header rendered');
        t.selectorExists('.b-list.b-grouped .b-list-item-group-header:contains(Dave)', 'Group header rendered');
    });
});
