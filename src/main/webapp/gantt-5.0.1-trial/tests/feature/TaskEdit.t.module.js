import { ProjectGenerator, Duration, TaskEditor } from '../../build/gantt.module.js?457330';

StartTest((t) => {
    let gantt;

    t.beforeEach(() => gantt?.destroy());

    t.it('Should show task editor when double clicking task', t => {
        gantt = t.getGantt({
            features : {
                taskTooltip : false
            },

            resources : t.getResourceStoreData()
        });

        const investigate = gantt.taskStore.getAt(2);

        let oldWidth;

        t.is(gantt.features.taskEdit.isEditing, false, 'Not editing');

        t.chain(
            { dblClick : '.b-gantt-task.id11' },

            { waitForSelector : '.b-taskeditor' },

            async() => {
                const oldEl = gantt.getElementFromTaskRecord(investigate);

                oldWidth = oldEl.offsetWidth;

                t.is(gantt.features.taskEdit.isEditing, true, 'Editing');
                t.is(document.querySelector('.b-name input').value, gantt.taskStore.getById(11).name, 'Correct name');

                const boxes = ['save', 'cancel', 'delete'].map(ref => {
                    return t.rect(`.b-gantt-taskeditor button[data-ref="${ref}Button"]`);
                });

                t.is(boxes[0].width, boxes[1].width, 'Delete button width is ok');
                t.is(boxes[0].width, boxes[2].width, 'Cancel button width is ok');
            },

            // TODO: these were renamed need to mention them in changelog as BREAKING change
            // gantt.features.taskEdit.editor.widgetMap.fullDurationField -> gantt.features.taskEdit.editor.widgetMap.duration
            { click : () => gantt.features.taskEdit.editor.widgetMap.duration.triggers.spin.upButton },

            { click : () => gantt.features.taskEdit.editor.widgetMap.saveButton.element },

            { waitFor : () => gantt.getElementFromTaskRecord(investigate).offsetWidth > oldWidth },

            { waitForSelectorNotFound : '.b-taskeditor' },

            () => t.is(gantt.features.taskEdit.isEditing, false, 'Not editing')
        );
    });

    // https://app.assembla.com/spaces/bryntum/tickets/9416-adding-a-resource-in-the-taskeditor--then-clicking-save-throws-an-error-/
    t.it('Should not throw error when adding resource to "from" side of new dependency.', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },

            resources : t.getResourceStoreData()
        });

        t.livesOk(() => {
            t.chain(
                { moveMouseTo : '[data-task-id="231"]' },

                { moveMouseTo : '.b-sch-terminal-right' },

                { drag : '[data-task-id="231"] .b-sch-terminal-right', to : '[data-task-id="232"]', dragOnly : true },

                { moveMouseTo : '[data-task-id="232"] .b-sch-terminal-left' },

                { mouseup : null },

                { dblclick : '[data-task-id="232"]' },

                { waitForSelector : '.b-schedulerpro-taskeditor' },

                { click : '.b-tabpanel-tab:contains(Resources)' },

                { click : '.b-resourcestab .b-add-button' },

                { click : '.b-grid .b-cell-editor' },
                { type : '[DOWN]' },

                { click : '.b-list-item[data-index="0"]' },

                // https://github.com/bryntum/support/issues/814
                { type : '[ENTER]' },

                { click : '.b-button:contains(Save)' },

                { waitForPropagate : gantt.project },

                { dblclick : '[data-task-id="231"]' },

                { waitForSelector : '.b-schedulerpro-taskeditor' },

                { click : '.b-tabpanel-tab:contains(Resources)' },

                { click : '.b-resourcestab .b-add-button' },

                { click : '.b-grid .b-cell-editor' },
                { type : '[DOWN]' },

                { click : '.b-list-item[data-index="0"]' },

                { click : '.b-button:contains(Save)' },

                { waitForPropagate : gantt.project }
            );
        });
    });

    t.it('Should disable certain fields for parent tasks', t => {
        gantt = t.getGantt({
            features : {
                taskTooltip : false
            }
        });

        t.chain(
            { dblClick : '[data-task-id="1"]' },

            { waitForSelector : '.b-schedulerpro-taskeditor' },

            () => {
                const { duration, effort, endDate, percentDone } = gantt.features.taskEdit.editor.widgetMap;

                t.ok(duration.disabled, 'Duration disabled');
                t.ok(effort.disabled, 'Effort disabled');
                t.ok(endDate.disabled, 'Finish disabled');
                t.ok(percentDone.disabled, 'Percent done disabled');
            }
        );
    });

    // https://github.com/bryntum/support/issues/1992
    t.it('Should enable endDate & duration fields for manually scheduled parent tasks', async t => {
        gantt = t.getGantt({
            features : {
                taskTooltip : false
            }
        });

        const task = gantt.taskStore.getById(1);

        await task.setManuallyScheduled(true);

        t.chain(
            { dblClick : '[data-task-id="1"]' },

            { waitForSelector : '.b-schedulerpro-taskeditor' },

            () => {
                const { duration, effort, endDate, percentDone } = gantt.features.taskEdit.editor.widgetMap;

                t.notOk(duration.disabled, 'Duration is enabled');
                t.ok(effort.disabled, 'Effort disabled');
                t.notOk(endDate.disabled, 'Finish is enabled');
                t.ok(percentDone.disabled, 'Percent done disabled');
            }
        );
    });

    t.it('Should preserve scroll when cancelling changes', async(t) => {
        const config = await ProjectGenerator.generateAsync(100, 30, () => {});

        const project = t.getProject(config);

        gantt = t.getGantt({
            startDate : config.startDate,
            endDate   : config.endDate,
            project
        });

        const
            task = gantt.taskStore.getAt(gantt.taskStore.count - 1);
        let
            scroll;

        t.chain(
            { waitForPropagate : gantt },
            { waitForSelector : '.b-gantt-task' },
            async() => gantt.scrollTaskIntoView(task),
            { dblclick : () => gantt.getElementFromTaskRecord(task) },
            { waitForSelector : '.b-schedulerpro-taskeditor' },
            { click : '[data-ref="duration"] .b-spin-up' },
            next => {
                scroll = gantt.scrollTop;

                const detacher = gantt.on({
                    renderTask({ taskRecord }) {
                        if (taskRecord === task) {
                            detacher();
                            next();
                        }
                    }
                });

                t.click('.b-popup-close');
            },
            () => t.is(gantt.scrollTop, scroll, 'Scroll is intact')
        );
    });

    t.it('Should be able to show editor programmatically', async(t) => {
        const config = await ProjectGenerator.generateAsync(1, 30, () => {});

        const project = t.getProject(config);

        gantt = t.getGantt({
            startDate : config.startDate,
            endDate   : config.endDate,
            project
        });

        t.chain(
            { waitForPropagate : gantt },
            { waitForSelector : '.b-gantt-task' },

            async() => gantt.editTask(gantt.taskStore.rootNode.firstChild),

            { waitForSelector : '.b-gantt-taskeditor' }
        );
    });

    // https://app.assembla.com/spaces/bryntum/tickets/9108
    t.it('Should not report isEditing if a listener cancels the editing', async(t) => {
        gantt = t.getGantt();

        await gantt.project.commitAsync();

        t.notOk(gantt.features.taskEdit.isEditing, 'Task edit not editing initially');

        gantt.on('beforeTaskEdit', () => false);

        await gantt.editTask(gantt.taskStore.rootNode.firstChild);

        t.notOk(gantt.features.taskEdit.isEditing, 'Task edit not editing');
    });

    // https://app.assembla.com/spaces/bryntum/tickets/8276
    t.it('Should support editing an unscheduled task', async t => {
        gantt = t.getGantt();

        const added = gantt.taskStore.rootNode.appendChild({ name : 'New task' });

        // run propagation to calculate new task fields
        await gantt.project.propagateAsync();

        await gantt.editTask(added);

        t.chain(
            { waitForSelector : '.b-gantt-taskeditor' }
        );
    });

    t.it('Should not allow to set end before start date', t => {
        gantt = t.getGantt({
            project : t.getProject({
                calendar : 'general'
            })
        });

        const task = gantt.taskStore.getById(234);

        t.chain(
            { dblclick : '.b-gantt-task.id234' },

            { waitForSelector : '.b-schedulerpro-taskeditor' },

            { click : '.b-end-date .b-icon-angle-left' },

            {
                waitFor : () => task.endDate.getTime() === new Date(2017, 1, 9).getTime() && task.duration === 0,
                desc    : 'End date changed, duration is 0'
            },

            { click : '.b-end-date .b-icon-angle-left' },

            { waitForPropagate : gantt },

            {
                waitFor : () => task.endDate.getTime() === new Date(2017, 1, 9).getTime() && task.duration === 0,
                desc    : 'End date intact, duration is 0'
            },

            { type : '[DOWN][UP][ENTER]' },

            { waitForPropagate : gantt },

            {
                waitFor : () => task.endDate.getTime() === new Date(2017, 1, 9).getTime() && task.duration === 0,
                desc    : 'End date intact, duration is 0'
            },

            { click : '.b-end-date .b-icon-angle-right' },

            {
                waitFor : () => task.endDate.getTime() === new Date(2017, 1, 10).getTime() && task.duration === 1,
                desc    : 'End date changed, duration is 1'
            }
        );
    });

    t.it('Should not close on Save click if any field is invalid', async(t) => {
        gantt = t.getGantt();

        await gantt.project.commitAsync();

        gantt.taskStore.rootNode.firstChild.name = ''; // invalid
        await gantt.editTask(gantt.taskStore.rootNode.firstChild);

        gantt.features.taskEdit.save();

        t.ok(gantt.features.taskEdit.isEditing, 'Task edit still editing');
    });

    t.it('Should support disabling', t => {
        gantt = t.getGantt();

        gantt.features.taskEdit.disabled = true;

        t.chain(
            { dblClick : '.b-gantt-task' },

            async() => {
                t.selectorNotExists('.b-popup', 'Editor not shown');

                gantt.features.taskEdit.disabled = false;
            },

            { dblClick : '.b-gantt-task' },

            () => {
                t.selectorExists('.b-popup', 'Editor shown');
            }
        );
    });

    t.it('autoSync', async t => {
        let syncCallCount = 0;

        t.mockUrl('test-autosync-load', (url, params, options) => {
            return {
                responseText : JSON.stringify({
                    success   : true,
                    revision  : 1,
                    requestId : options.body.requestId,
                    tasks     : {
                        rows : t.getProjectTaskData()
                    },
                    calendars : {
                        rows : t.getProjectCalendarsData()
                    },
                    dependencies : {
                        rows : t.getProjectDependenciesData()
                    }
                })
            };
        });
        t.mockUrl('test-autosync-update', (url, params, options) => {
            const
                {
                    requestId,
                    revision,
                    tasks
                } = JSON.parse(options.body);

            syncCallCount++;

            return {
                responseText : JSON.stringify({
                    success  : true,
                    revision : revision + tasks.length,
                    requestId,
                    tasks    : {
                        rows : tasks.updated.map(t => ({ id : t.id }))
                    }
                })
            };
        });

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            project : {
                autoSync             : true,
                // the test expects autoSync to not be called before running its steps below
                silenceInitialCommit : true,
                transport            : {
                    load : {
                        url       : 'test-autosync-load',
                        paramName : 'q'
                    },
                    sync : {
                        url : 'test-autosync-update'
                    }
                }
            }
        });

        t.chain(
            { drag : '[data-task-id="11"]', offset : ['100%-5', '50%'], by : [gantt.tickSize + 5, 0] },

            // The autoSync setting worked
            { waitFor : () => syncCallCount === 1 },

            { dblClick : '[data-task-id="11"]' },

            { waitForSelector : '.b-schedulerpro-taskeditor' },

            next => {
                t.click(gantt.features.taskEdit.editor.widgetMap.endDate.triggers.forward.element, next);
            },

            // Syncing is on a timer, so wait for it to cycle
            { waitFor : gantt.project.autoSyncTimeout * 2 },

            next => {
                // That must not have synced.
                t.is(syncCallCount, 1, 'sync count is the same');

                // Cancel editing
                t.click(gantt.features.taskEdit.editor.widgetMap.cancelButton.element, next);
            },

            // Syncing is on a timer, so wait for it to cycle
            { waitFor : gantt.project.autoSyncTimeout * 2 },

            async() => {
                // That must not have synced.
                t.is(syncCallCount, 1);
            },

            // Try again, but clicking the Save button
            { dblClick : '[data-task-id="11"]' },

            { waitForSelector : '.b-schedulerpro-taskeditor' },

            next => {
                t.click(gantt.features.taskEdit.editor.widgetMap.endDate.triggers.forward.element, next);
            },

            // Syncing is on a timer, so wait for it to cycle
            { waitFor : gantt.project.autoSyncTimeout * 2 },

            next => {
                // That must not have synced.
                t.is(syncCallCount, 1);

                // Cancel editing
                t.click(gantt.features.taskEdit.editor.widgetMap.saveButton.element, next);
            },

            // Syncing is on a timer, so wait for it to cycle
            { waitFor : gantt.project.autoSyncTimeout * 2 },

            () => {
                // That must have synced.
                t.is(syncCallCount, 2);
            }
        );
    });

    // https://github.com/bryntum/support/issues/132
    t.it('Should open editor for new task if double clicking other task while editor is already open', async t => {
        gantt = t.getGantt();

        const
            added  = gantt.taskStore.rootNode.appendChild({ name : 'New task' }),
            added2 = gantt.taskStore.rootNode.appendChild({ name : 'Foo' });

        // run propagation to calculate new task fields
        await gantt.project.commitAsync();

        await gantt.editTask(added);

        t.chain(
            { waitForSelector : '.b-gantt-taskeditor' },

            async() => gantt.editTask(added2),

            { waitFor : () => document.querySelector('.b-gantt-taskeditor input[name=name]').value === 'Foo' },

            // Also should detach from project and not listen to propagation events if hidden
            // https://github.com/bryntum/support/issues/446
            async() => {
                await gantt.features.taskEdit.save();
                added2.remove();
            }
        );
    });

    t.it('Should close editor task if the edited task is removed while open', async t => {
        gantt = await t.getGanttAsync();

        const added = gantt.taskStore.rootNode.appendChild({ name : 'New task' });

        // run propagation to calculate new task fields
        await gantt.project.commitAsync();

        await gantt.editTask(added);

        await added.remove();

        await t.waitForSelectorNotFound('.b-gantt-taskeditor');
    });

    // https://github.com/bryntum/support/issues/156
    t.it('Should be able to edit name of unscheduled task with Save button', async t => {
        gantt = t.getGantt();

        gantt.taskStore.removeAll();

        const added = gantt.taskStore.rootNode.appendChild({ name : 'New' });

        // run propagation to calculate new task fields and scroll it into view
        await gantt.project.commitAsync();
        await gantt.scrollTaskIntoView(added);

        await gantt.editTask(added);

        t.chain(
            { waitForSelector : '.b-gantt-taskeditor' },

            { click : 'input[name=name]' },
            { type : 'foo' },
            { click : '.b-button:textEquals(Save)' },
            { waitForSelectorNotFound : '.b-gantt-taskeditor' },

            () => t.is(added.name, 'Newfoo')
        );
    });

    // test for fix of https://github.com/bryntum/support/issues/166 Cannot save unscheduled task with ENTER key #166
    t.it('Should be able to edit name of unscheduled task using ENTER', async t => {
        gantt = t.getGantt();

        gantt.taskStore.removeAll();

        const added = gantt.taskStore.rootNode.appendChild({ name : 'New' });

        // run propagation to calculate new task fields and scroll it into view
        await gantt.project.commitAsync();
        await gantt.scrollTaskIntoView(added);

        await gantt.editTask(added);

        t.chain(
            { waitForSelector : '.b-gantt-taskeditor' },

            { click : 'input[name=name]' },
            { type : 'foo[ENTER]' },
            { waitForSelectorNotFound : '.b-gantt-taskeditor' },

            () => t.is(added.name, 'Newfoo')
        );
    });

    // fix for https://github.com/bryntum/support/issues/155
    t.it('Task editor should be placed correctly for unscheduled task', async t => {
        gantt = t.getGantt();
        let addedTask;

        await gantt.project.commitAsync();

        t.chain(
            { dblClick : '.b-gantt-task.id1000' },

            { waitForSelector : '.b-schedulerpro-taskeditor' },
            async() => {
                // TaskEditor should be centered and aligned to task bottom
                const
                    editRect = t.rect('.b-gantt-taskeditor'),
                    taskRect = t.rect('.b-gantt-task');

                t.isApproxPx(editRect.left, taskRect.left - (editRect.width - taskRect.width) / 2, 1, 'Correct left position');
                t.isApproxPx(editRect.top, taskRect.bottom, 3.5, 'Correct top position');
            },
            { type : '[ESC]' },
            { waitForSelectorNotFound : '.b-gantt-taskeditor' },

            async() => {
                gantt.taskStore.removeAll();
                addedTask = gantt.taskStore.rootNode.appendChild({ name : 'New 1' });
                await gantt.project.commitAsync();
                await gantt.editTask(addedTask);
            },
            { waitForSelector : '.b-gantt-taskeditor' },
            () => {
                // TaskEditor should be centered to gantt
                const
                    editRect  = t.rect('.b-gantt-taskeditor'),
                    ganttRect = t.rect('.b-ganttbase');
                t.isApproxPx(editRect.left, (ganttRect.width - editRect.width) / 2, 1, 'Correct left position');
                t.isApproxPx(editRect.top, (ganttRect.height - editRect.height) / 2, 1, 'Correct top position');
            }
        );
    });

    // fix for https://github.com/bryntum/support/issues/154
    t.it('Task editor should allow to type in Duration for unscheduled task', async t => {
        gantt = t.getGantt();

        const added = gantt.taskStore.rootNode.appendChild({ name : 'New' });

        // run propagation to calculate new task fields and scroll it into view
        await gantt.project.commitAsync();
        await gantt.scrollTaskIntoView(added);

        await gantt.editTask(added);

        const
            widgetMap = gantt.features.taskEdit.editor.widgetMap;
        t.chain(
            { waitForSelector : '.b-gantt-taskeditor' },
            { click : '.b-tabpanel-tab:contains(Advanced)' },
            { click : widgetMap.constraintTypeField.triggers.expand.element, desc : 'Click expand constraints combo' },
            { click : '.b-list-item:contains(Must start on)', desc : 'Clicking Must start on item' },
            { dblclick : '.b-tabpanel-tab:contains(General)' },
            { click : widgetMap.duration.input },
            { type : '1', clearExisting : true },
            () => t.isDeeply(widgetMap.duration.value, new Duration(1, 'day'), 'Correct value for duration field "1 day"')
        );
    });

    // https://github.com/bryntum/support/issues/429
    t.it('Should hide task editor if project is reloaded while open', async t => {
        t.mockUrl('load', (url, params, options) => {
            return {
                responseText : JSON.stringify({
                    success  : true,
                    revision : 1,
                    tasks    : {
                        rows : t.getProjectTaskData()
                    },
                    calendars : {
                        rows : t.getProjectCalendarsData()
                    },
                    dependencies : {
                        rows : t.getProjectDependenciesData()
                    }
                })
            };
        });

        gantt = await t.getGanttAsync({
            project : {
                transport : {
                    load : {
                        url : 'load'
                    }
                }
            }
        });

        await gantt.editTask(gantt.project.firstChild);

        await gantt.project.load();

        t.selectorNotExists('.b-taskeditor', 'Editor hidden');
    });

    // https://github.com/bryntum/support/issues/649
    t.it('Should trigger sync upon task deletion if autoSync is true', async t => {
        t.mockUrl('sync', { responseText : '{}' });

        gantt = t.getGantt({
            project : {
                autoSync  : true,
                transport : {
                    sync : {
                        url : 'sync'
                    }
                }
            }
        });

        await gantt.project.commitAsync();

        const
            async = t.beginAsync();

        gantt.project.on('sync', () => {
            t.endAsync(async);
            t.pass('Sync happened');
        });

        await gantt.editTask(gantt.project.firstChild.firstChild);

        t.chain(
            { click : '.b-button:contains(Delete)' },
            { click : '.b-messagedialog-okbutton' }
        );
    });

    // https://bryntum.com/forum/viewtopic.php?f=52&t=13770&p=72720#p72720
    t.it('Should not create new stores after changing value which causes propagation', async t => {
        gantt = t.getGantt();

        const
            { project } = gantt,
            task        = project.firstChild.firstChild.firstChild,
            async       = t.beginAsync();

        await project.commitAsync();

        await gantt.editTask(task);

        const
            editor             = gantt.features.taskEdit.getEditor(),
            resourceGrid       = editor.widgetMap.resourcesTab.widgetMap.grid,
            resourceComboStore = resourceGrid.columns.get('resource').editor.store;

        await t.click('[data-ref=duration] .b-spin-up');

        t.waitForPropagate(project, () => {
            t.endAsync(async);
            t.is(resourceGrid.columns.get('resource').editor.store, resourceComboStore);
        });

    });

    // https://github.com/bryntum/support/issues/1093
    t.it('Event editor start and end date fields should respect weekStartDay config', t => {
        gantt = t.getGantt({
            weekStartDay : 1
        });

        t.chain(
            { doubleClick : '[data-task-id="11"]' },
            { click : '[data-ref="startDate"] .b-icon-calendar' },
            {
                waitForSelector : '.b-calendar-day-header[data-column-index="0"][data-cell-day="1"]',
                desc            : 'Start date picker week starts with correct day'
            },
            { click : '[data-ref="endDate"] .b-icon-calendar' },
            {
                waitForSelector : '.b-calendar-day-header[data-column-index="0"][data-cell-day="1"]',
                desc            : 'End date picker week starts with correct day'
            }
        );
    });

    t.it('Event editor start and end date fields should respect DateHelper.weekStartDay config', t => {
        gantt = t.getGantt();

        t.chain(
            { doubleClick : '[data-task-id="11"]' },
            { click : '[data-ref="startDate"] .b-icon-calendar' },
            {
                waitForSelector : '.b-calendar-day-header[data-column-index="0"][data-cell-day="0"]',
                desc            : 'Start date picker week starts with correct day'
            },
            { click : '[data-ref="endDate"] .b-icon-calendar' },
            {
                waitForSelector : '.b-calendar-day-header[data-column-index="0"][data-cell-day="0"]',
                desc            : 'End date picker week starts with correct day'
            }
        );
    });

    t.it('Should not be modifiable through UI if readOnly', t => {
        gantt = t.getGantt({
            readOnly  : true,
            resources : t.getResourceStoreData(),
            features  : {
                taskTooltip : false
            }
        });

        t.chain(
            { dblClick : '.b-gantt-task.id11' },

            { waitForSelector : '.b-schedulerpro-taskeditor' },

            () => {
                t.selectorExists('.b-taskeditor.b-readonly', 'Editor has b-readonly');
                t.selectorNotExists('.b-field:not(.b-readonly)', 'No non-readonly field found');
                t.selectorNotExists('.b-button:not(.b-hidden):not(.b-tabpanel-tab)', 'No visible button found');
            }
        );
    });

    t.it('Should cancel editing in an orderly manner if editor hidden', async t => {
        gantt = t.getGantt({
            features : {
                taskTooltip : false
            },
            readOnly : true,

            resources : t.getResourceStoreData()
        });

        await t.doubleClick('.b-gantt-task.id11');

        await t.waitFor(() => gantt.features.taskEdit.editor.containsFocus);

        await gantt.features.taskEdit.editor.hide();

        await t.waitFor(() => !gantt.features.taskEdit.isEditing);

        await t.doubleClick('.b-gantt-task.id11');

        // It must show after being hidden
        await t.waitFor(() => gantt.features.taskEdit.editor.containsFocus);
    });

    t.it('Should fire Popup events on Save', async t => {
        gantt = t.getGantt({
            features : {
                taskTooltip : false
            },
            resources : t.getResourceStoreData()
        });

        t.firesOnce(gantt.features.taskEdit.getEditor(), 'beforeClose');

        await t.doubleClick('.b-gantt-task.id11');

        await t.click('.b-button:contains(Save)');
    });

    // https://github.com/bryntum/support/issues/1485
    t.it('Should not anchor editor to task if it is centered', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskEdit : {
                    editorConfig : {
                        centered : true
                    }
                }
            }
        });

        t.chain(
            { dblClick : '.b-gantt-task.id11' },

            { waitForSelector : '.b-schedulerpro-taskeditor' },

            () => {
                t.notOk(gantt.features.taskEdit.editor.anchoredTo, 'Editor is not anchored to a task');
            }
        );
    });

    t.it('Should not crash if project data is replaced when editor is open', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskEdit : true
            }
        });

        const project = gantt.project;

        await gantt.editTask(project.firstChild);

        await project.loadInlineData({
            eventsData       : [],
            resourcesData    : [],
            assignmentsData  : [],
            dependenciesData : []
        });

        t.ok(gantt.features.taskEdit.editor.hidden, 'Editor hid itself as a reaction to record no longer being part ' +
            'of the taskStore');
    });

    // https://github.com/bryntum/support/issues/2095
    t.it('Should be able to hide items on the form', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskEdit : {
                    items : {
                        generalTab      : false,
                        predecessorsTab : false,
                        successorsTab   : false,
                        resourcesTab    : false,
                        notesTab        : false,
                        advancedTab     : {
                            items : {
                                calendarField          : false,
                                manuallyScheduledField : false,
                                schedulingModeField    : false,
                                effortDrivenField      : false,
                                divider                : false,
                                constraintTypeField    : false,
                                constraintDateField    : false,
                                rollupField            : false
                            }
                        }
                    }
                }
            }
        });

        t.chain(
            { dblclick : '.id1.b-gantt-task' },
            { waitForSelector : '.b-schedulerpro-taskeditor' },
            { waitForSelectorNotFound : '.b-tabpanel-tab.b-general-tab' },
            { waitForSelectorNotFound : '.b-tabpanel-tab.b-predecessors-tab' },
            { waitForSelectorNotFound : '.b-tabpanel-tab.b-successors-tab' },
            { waitForSelectorNotFound : '.b-tabpanel-tab.b-resources-tab' },
            { waitForSelectorNotFound : '.b-tabpanel-tab.b-notes-tab' },
            { click : '.b-tabpanel-tab:contains(Advanced)' },
            { waitForSelectorNotFound : '[name=calendar]', desc : 'calendarField is not visible' },
            { waitForSelectorNotFound : '[name=manuallyScheduled]', desc : 'manuallyScheduledField is not visible' },
            { waitForSelectorNotFound : '[name=schedulingMode]', desc : 'schedulingModeField is not visible' },
            { waitForSelectorNotFound : '[name=effortDriven]', desc : 'effortDrivenField is not visible' },
            { waitForSelectorNotFound : '.b-divider[data-text=Constraint]', desc : 'divider is not visible' },
            { waitForSelectorNotFound : '[name=constraintType]', desc : 'constraintTypeField is not visible' },
            { waitForSelectorNotFound : '[name=constraintDate]', desc : 'constraintDateField is not visible' },
            { waitForSelectorNotFound : '[name=rollup]', desc : 'rollupField is not visible' }
        );
    });

    // https://github.com/bryntum/support/issues/2517
    t.it('Should not throw an exception when clicking DELETE button', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskEdit : {
                    editorConfig : {
                        centered : true
                    }
                }
            }
        });

        t.chain(
            { dblClick : '.b-gantt-task.id11' },

            { waitForSelector : '.b-schedulerpro-taskeditor' },

            { click : '.b-start-date .b-icon-angle-right', desc : 'Shifted start date' },

            { click : 'button:textEquals(Delete)', desc : 'Clicked DELETE button' },

            { click : '.b-messagedialog button:textEquals(Delete)', desc : 'Clicked YES button' },

            { waitForSelectorNotFound : '.b-taskeditor', desc : 'task editor closed' },

            () => {
                t.notOk(gantt.taskStore.getById(11), 'task is deleted');
            }
        );
    });

    // https://github.com/bryntum/support/issues/2488
    t.it('Tabs should have correct height when changing hidden state on beforeTaskEditShow', async t => {
        const
            tabHeight = 257,
            threshold = 5;

        gantt = await t.getGanttAsync();

        gantt.on({
            beforeTaskEditShow({ editor }) {
                editor.widgetMap.generalTab.hidden = false;
                editor.widgetMap.predecessorsTab.hidden = false;
                editor.widgetMap.successorsTab.hidden = false;
                editor.widgetMap.resourcesTab.hidden = false;
                editor.widgetMap.advancedTab.hidden = false;
                editor.widgetMap.notesTab.hidden = false;
            },
            once : true
        });

        t.chain(
            { dblclick : '.b-gantt-task-wrap[data-task-id=11]' },
            { waitForSelector : '.b-schedulerpro-taskeditor' },
            { waitForAnimations : null },
            { click : '.b-tabpanel-tab.b-general-tab' },
            { waitForSelector : '.b-tabpanel-body' },
            async() => t.hasApproxHeight('.b-tabpanel-body', tabHeight, threshold, 'General tab has correct height'),
            { click : '.b-popup-close' },

            { dblclick : '.b-gantt-task-wrap[data-task-id=11]' },
            { waitForSelector : '.b-schedulerpro-taskeditor' },
            { click : '.b-tabpanel-tab.b-predecessors-tab' },
            { waitForAnimations : null },
            async() => t.hasApproxHeight('.b-tabpanel-body', tabHeight, threshold, 'Predecessors tab has correct height'),
            { click : '.b-popup-close' },

            { dblclick : '.b-gantt-task-wrap[data-task-id=11]' },
            { waitForSelector : '.b-schedulerpro-taskeditor' },
            { click : '.b-tabpanel-tab.b-successors-tab' },
            { waitForAnimations : null },
            async() => t.hasApproxHeight('.b-tabpanel-body', tabHeight, threshold, 'Successors tab has correct height'),
            { click : '.b-popup-close' },

            { dblclick : '.b-gantt-task-wrap[data-task-id=11]' },
            { waitForSelector : '.b-schedulerpro-taskeditor' },
            { click : '.b-tabpanel-tab.b-resources-tab' },
            { waitForAnimations : null },
            async() => t.hasApproxHeight('.b-tabpanel-body', tabHeight, threshold, 'Resources tab has correct height'),
            { click : '.b-popup-close' },

            { dblclick : '.b-gantt-task-wrap[data-task-id=11]' },
            { waitForSelector : '.b-schedulerpro-taskeditor' },
            { click : '.b-tabpanel-tab.b-advanced-tab' },
            { waitForAnimations : null },
            async() => t.hasApproxHeight('.b-tabpanel-body', tabHeight, threshold, 'Advanced tab has correct height'),
            { click : '.b-popup-close' },

            { dblclick : '.b-gantt-task-wrap[data-task-id=11]' },
            { waitForSelector : '.b-schedulerpro-taskeditor' },
            { click : '.b-tabpanel-tab.b-notes-tab' },
            { waitForAnimations : null },
            () => t.hasApproxHeight('.b-tabpanel-body', tabHeight, threshold, 'Notes tab has correct height')
        );
    });

    // https://github.com/bryntum/support/issues/2493
    t.it('New tab should have correct height when it has more items than general tab', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskEdit : {
                    items : {
                        testTab : {
                            title  : 'Test',
                            weight : 100,
                            items  : {
                                field1  : { type : 'text' },
                                field2  : { type : 'text' },
                                field3  : { type : 'text' },
                                field4  : { type : 'text' },
                                field5  : { type : 'text' },
                                field6  : { type : 'text' },
                                field7  : { type : 'text' },
                                field8  : { type : 'text' },
                                field9  : { type : 'text' },
                                field10 : { type : 'text' }
                            }
                        }
                    }
                }
            }
        });

        t.chain(
            { dblclick : '.b-gantt-task-wrap[data-task-id=11]' },
            { waitForSelector : '.b-schedulerpro-taskeditor' },
            { click : '.b-tabpanel-tab[data-item-index=1]' },
            { waitForAnimations : null },
            () => {
                // FireFox renders TextField input element differently depending on DPI Scale with the same CSS
                // Take in account real TextField height for test
                const fieldHeight = gantt.features.taskEdit.editor.widgetMap.testTab.widgetMap.field1.element.getBoundingClientRect().height;
                t.hasApproxHeight('.b-tabpanel-body', fieldHeight * 10 + 107, 3, 'New tab has correct height');
            }
        );
    });

    // https://github.com/bryntum/support/issues/2313
    t.it('Should filter all items correctly on grid editor when set filterOperator on the fly', async t => {
        gantt = await t.getGanttAsync({
            listeners : {
                beforeTaskEditShow({ editor }) {
                    const col = editor.widgetMap.successorsTab.grid.columns.get('toEvent');

                    col.editor.editable = true;
                    col.editor.filterOperator = '*';
                }
            }
        });

        t.chain(
            { dblClick : '.b-gantt-task.id11' },
            { waitForSelector : '.b-schedulerpro-taskeditor' },
            { click : '.b-successors-tab' },
            { dblClick : '.b-successors-tab .b-grid-cell[data-column="toEvent"]' },
            { type : 'customer' },
            { waitForSelector : '.b-list-item:textEquals(Customer approval (3))', desc : 'First item found.' },
            { waitForSelector : '.b-list-item:textEquals(Follow up with customer (234))', desc : 'Second item found.' },
            () => t.selectorCountIs('.b-list-item', 2, '2 items found when filter applied')
        );
    });

    // https://github.com/bryntum/support/issues/674
    t.it('Should be possible to apply custom values in "beforeTaskEditShow" event handler', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskEdit : true
            },

            listeners : {
                beforeTaskEditShow({ editor }) {
                    editor.widgetMap.percentDone.value = 99;
                }
            }
        });

        const task = gantt.project.taskStore.getById(11);

        task.percentDone = 20;

        await gantt.editTask(task);

        t.is(gantt.features.taskEdit.editor.widgetMap.percentDone.value, 99, 'Custom value has been applied correctly');
        await t.click('.b-button:contains(Save)');
        t.is(task.percentDone, 99, 'Custom value has been applied to the record');
    });

    // https://github.com/bryntum/support/issues/2543
    t.it('Should reset successors and predecessor if click on cancel button on editor', async t => {
        gantt = await t.getGanttAsync();

        const
            { store } = gantt,
            taskId    = 234,
            task      = store.getById(taskId),
            [
                predecessor,
                successor
            ]         = task.dependencies;

        t.chain(
            { dblClick : '.b-gantt-task.id234' },
            { click : '.b-predecessors-tab' },
            { dblClick : '.b-predecessors-tab .b-grid-cell[data-column="fullLag"]' },
            { type : '[UP][UP][ENTER]' },
            { click : '.b-button[data-ref="cancelButton"]' },
            { dblClick : '.b-gantt-task.id234' },
            { click : '.b-predecessors-tab' },
            { waitForSelector : `.b-predecessors-tab .b-number-cell[data-column="fullLag"]:contains(${predecessor.lag} days)`, desc : 'Predecessor lag cell was not changed' },
            async() => t.is(predecessor.lag, store.getById(taskId).dependencies[0].lag, 'Predecessor lag was not changed'),
            { dblClick : '.b-gantt-task.id234' },
            { click : '.b-successors-tab' },
            { dblClick : '.b-successors-tab .b-grid-cell[data-column="fullLag"]' },
            { type : '[UP][UP][ENTER]' },
            { click : '.b-button[data-ref="cancelButton"]' },
            { dblClick : '.b-gantt-task.id234' },
            { click : '.b-successors-tab' },
            { waitForSelector : `.b-successors-tab .b-number-cell[data-column="fullLag"]:contains(${successor.lag} days)`, desc : 'Successor lag cell was not changed' },
            () => t.is(successor.lag, store.getById(taskId).dependencies[1].lag, 'Successor lag was not changed')
        );
    });

    // https://github.com/bryntum/support/issues/3030
    t.it('Should be able to define editorClass', async t => {
        class MyTaskEditor extends TaskEditor {
            static get configurable() {
                return {
                    autoClose : false
                };
            }
        }

        gantt = await t.getGanttAsync({
            features : {
                taskEdit : {
                    editorClass : MyTaskEditor
                }
            }
        });

        await gantt.editTask(gantt.taskStore.first);

        t.isInstanceOf(gantt.features.taskEdit.editor, MyTaskEditor, 'Correct class used');
    });

    t.it('Should scroll task into view if `scrollIntoView` flag is true', async t => {
        gantt = await t.getGanttAsync({
            startDate : new Date(1999, 0, 0),
            features  : {
                taskEdit : {
                    // scrollIntoView : false
                }
            }
        });
        const task = gantt.taskStore.getById(11);

        t.firesOnce(gantt.timeAxisViewModel, 'update');
        await gantt.editTask(task);
        t.isLess(gantt.startDate, task.startDate, 'timeline start date adjusted');
        t.isGreater(gantt.endDate, task.endDate, 'timeline end date adjusted');
    });

    // https://github.com/bryntum/support/issues/997
    t.it('Should not scroll task into view if `scrollIntoView` flag is false', async t => {
        gantt = await t.getGanttAsync({
            startDate : new Date(1999, 0, 0),
            features  : {
                taskEdit : {
                    scrollIntoView : false
                }
            }
        });

        const task = gantt.taskStore.getById(11);

        t.wontFire(gantt.timeAxisViewModel, 'update');

        await gantt.editTask(task);
    });

    // https://github.com/bryntum/support/issues/3041
    t.it('Should be possible to define a type on editorConfig of TaskEdit feature', async t => {
        class MyTaskEditor extends TaskEditor {
            // Factoryable type name
            static get type() {
                return 'mytaskeditor';
            }

            static get $name() {
                return 'MyTaskEditor';
            }

            get isMyTaskEditor() {
                return true;
            }
        }

        MyTaskEditor.initClass();

        gantt = await t.getGanttAsync({
            features : {
                taskEdit : {
                    editorConfig : {
                        type : 'mytaskeditor'
                    }
                }
            }
        });

        const task = gantt.taskStore.getById(11);
        await gantt.editTask(task);
        await t.waitForElementTop('.b-gantt-taskeditor');

        const { editor } = gantt.features.taskEdit;
        t.is(editor.type, 'mytaskeditor');
        t.ok(editor.isMyTaskEditor);
    });

    // https://github.com/bryntum/support/issues/3114
    t.it('Should not scroll task into view if `scrollIntoView` flag is false', async t => {
        gantt = await t.getGanttAsync({
            startDate : new Date(1999, 0, 0),
            features  : {
                taskEdit : {
                    items : {
                        notesTab        : false,
                        predecessorsTab : true,
                        successorsTab   : true,
                        resourcesTab    : false,
                        advancedTab     : false
                    }
                }
            }
        });

        const task = gantt.taskStore.getById(11);

        await gantt.editTask(task);

        t.selectorExists('.b-predecessors-tab', 'Predecessors tab exists');
        t.selectorNotExists('.b-resources-tab', 'Resource tab not exists');
    });

    // https://github.com/bryntum/support/issues/2071
    t.it('Should treat items configured with `true` as no-op', async t => {
        gantt = await t.getGanttAsync({
            startDate : new Date(1999, 0, 0),
            features  : {
                taskEdit : {
                    items : {
                        generalTab      : false,
                        notesTab        : false,
                        predecessorsTab : false,
                        successorsTab   : false,
                        resourcesTab    : false,
                        advancedTab     : {
                            items : {
                                // Should mean a no-op, defaults used
                                calendarField : true
                            }
                        }
                    }
                }
            }
        });

        const task = gantt.taskStore.getById(11);

        await gantt.editTask(task);

        t.selectorExists('.b-calendarfield', 'Calendar field exists');
    });

    t.it('Should hide task editor when task bar scrolls out of view', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            startDate : new Date(2017, 0, 16),
            endDate   : new Date(2017, 2, 31),
            resources : t.getResourceStoreData()
        });

        t.is(gantt.features.taskEdit.isEditing, false, 'Not editing');

        await t.doubleClick('.b-gantt-task-wrap[data-task-id="13"]');

        await t.waitFor(() => gantt.features.taskEdit.editor?.containsFocus);

        // Scroll event bar out of view
        await gantt.subGrids.normal.scrollable.scrollBy(300);

        // Editor must hide.
        await t.waitFor(() => !gantt.features.taskEdit.editor.isVisible);
    });

    // https://github.com/bryntum/support/issues/3296
    t.it('Should show task editor when schedule region is collapsed', async t => {
        gantt = await t.getGanttAsync({
            columns : [
                { type : 'name' },
                {},
                {}
            ],
            features : {
                taskTooltip : false
            },
            startDate : new Date(2017, 0, 16),
            endDate   : new Date(2017, 2, 31),
            resources : t.getResourceStoreData()
        });

        await gantt.subGrids.normal.collapse();

        gantt.columns.insert(gantt.columns.getAt(2), gantt.columns.getAt(0));

        await gantt.editTask(gantt.taskStore.first);

        await t.waitForSelector('.b-taskeditor');
    });

    // https://github.com/bryntum/support/issues/4295
    t.it('Should show task editor invoked from menu when schedule region is collapsed', async t => {
        gantt = await t.getGanttAsync();

        await gantt.subGrids.normal.collapse();

        await t.rightClick('.b-grid-cell');
        await t.click('.b-menuitem:contains(Edit)');

        await t.waitForSelector('.b-taskeditor');
    });

    // https://github.com/bryntum/support/issues/3628
    t.it('Should allow to provide listItemTpl to dependency tab name column editor', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskEdit : {
                    items : {
                        predecessorsTab : {
                            items : {
                                grid : {
                                    columns : {
                                        data : {
                                            name : {
                                                editor : {
                                                    listItemTpl : record => {
                                                        return 'foobar';
                                                    }
                                                }
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

        await gantt.editTask(gantt.taskStore.getById(14));
        await t.waitForSelector('.b-taskeditor');

        gantt.features.taskEdit.editor.widgetMap.tabs.activeTab = 1;

        await t.doubleClick('.b-grid-cell[data-column="fromEvent"]');
        await t.type(null, '[DOWN]');
        await t.waitForSelector('.b-list-item:contains(foobar)');
    });

    // https://github.com/bryntum/support/issues/665
    t.it('Should prevent editing readOnly task', async t => {
        gantt = await t.getGantt();

        gantt.project.taskStore.getById(12).readOnly = true;

        await t.doubleClick('[data-task-id="12"');

        t.selectorNotExists('.b-taskeditor');
    });

    // https://github.com/bryntum/support/issues/3746
    t.it('Should not show minimum value violated error', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            tasks : [{
                name           : 'New task',
                constraintType : 'startnoearlierthan',
                constraintDate : '2017-01-16T02:00:00.000',
                startDate      : '2017-01-16T02:00:00.000',
                endDate        : '2017-01-16T07:30:00.000'
            }],
            startDate : new Date(2017, 0, 16),
            endDate   : new Date(2017, 2, 31)
        });

        await gantt.editTask(gantt.project.taskStore.last);

        await t.click('[name="endDate"]');

        await t.click('[name="startDate"]');

        t.selectorNotExists('.b-invalid[data-ref="endDate"]', 'End date field is valid');
    });

    // https://github.com/bryntum/support/issues/4064
    t.it('Should not set SNET constraint when changing a predecessor lag', async t => {
        gantt = await t.getGanttAsync();

        const task = gantt.store.getById(234);

        await t.doubleClick('.b-gantt-task.id234');

        await t.click('.b-predecessors-tab');

        await t.doubleClick('.b-predecessors-tab .b-grid-cell[data-column="fullLag"]');

        await t.type(null, '[UP][UP][ENTER]');

        await t.click('.b-button:contains(Save)');

        await gantt.project.commitAsync();

        t.notOk(task.constraintType, 'No constraint type on the task');
        t.notOk(task.constraintDate, 'No constraint date on the task');
    });

});
