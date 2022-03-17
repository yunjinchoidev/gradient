
StartTest(t => {
    let gantt;

    t.beforeEach(() => gantt && gantt.destroy());

    t.it('Should render dependencies', async t => {
        gantt = await t.getGanttAsync();

        t.chain(
            {
                waitFor : () => t.query('.b-sch-dependency').length === 10,
                desc    : 'Elements found for all valid dependencies'
            },
            () => gantt.dependencies.forEach(dep => t.assertDependency(gantt, dep))
        );
    });

    t.it('Should support removing dependencies feature', async t => {
        gantt = await t.getGanttAsync({
            features : {
                dependencies : false
            }
        });
    });

    t.it('Creating dependencies with D&D', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            }
        });

        const
            project = gantt.project,
            t12     = project.eventStore.getById(12),
            t13     = project.eventStore.getById(13);

        t.chain(
            async() => {
                t.is(t12.startDate, t13.startDate, 'Tasks 12 and 13 start at the same time');
            },
            { moveCursorTo : '[data-task-id=\'12\'] .b-gantt-task' },
            { waitForElementVisible : '.b-sch-terminal-right' },
            {
                drag     : '.b-sch-terminal-right',
                to       : '[data-task-id=\'13\'] .b-gantt-task',
                dragOnly : true
            },

            // https://github.com/bryntum/support/issues/1388
            { waitFor : () => t.rect('.b-sch-dependency-creation-tooltip .b-popup-header').width >= 16, desc : 'Header tooltip title content is visible when dragging from source dependency' },

            { moveCursorTo : '[data-task-id=\'13\'] .b-gantt-task .b-sch-terminal-left' },

            // https://github.com/bryntum/support/issues/1388
            { waitFor : () => t.rect('.b-sch-dependency-creation-tooltip .b-popup-header').width >= 16, desc : 'Header tooltip title content is visible when dragging to target dependency' },

            { mouseUp : null },

            { waitForPropagate : gantt },

            async() => {
                t.is(t13.startDate, t12.endDate, 'Task 13 shifted to start after Task 12 ends after dependency creation');
            }
        );
    });

    t.it('Aborting creating dependency shouldn\'t throw an exception in Gantt', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            }
        });

        const done = t.livesOkAsync('No expcetion thrown');

        t.chain(
            {
                moveCursorTo : '[data-task-id=\'12\'] .b-gantt-task'
            },
            {
                waitForElementVisible : '.b-sch-terminal-right'
            },
            {
                drag : '.b-sch-terminal-right',
                to   : '[data-task-id=\'13\'] .b-gantt-task'
            },
            done
        );
    });

    t.it('Creating: Should be valid to drop on a task bar', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            }
        });

        t.firesOnce(gantt.dependencyStore, 'add');

        t.chain(
            { moveCursorTo : '[data-task-id=\'12\'] .b-gantt-task' },
            { waitForElementVisible : '.b-sch-terminal-right' },
            {
                drag     : '.b-sch-terminal-right',
                to       : '[data-task-id=\'13\'] .b-gantt-task',
                dragOnly : true
            },
            { waitForElementVisible : '.b-tooltip .b-icon-valid' },
            { waitForElementVisible : '.b-sch-terminal.b-sch-terminal-active.b-valid[data-side=left]' },
            { mouseUp : null }
        );
    });

    t.it('Creating: Should not be valid to drop on a task bar if allowDropOnEventBar is false', async t => {
        gantt = await t.getGanttAsync({
            features : {
                taskTooltip  : false,
                dependencies : {
                    allowDropOnEventBar : false
                }
            }
        });

        t.wontFire(gantt.dependencyStore, 'add');

        t.chain(
            {
                moveCursorTo : '[data-task-id=\'12\'] .b-gantt-task'
            },
            {
                waitForElementVisible : '.b-sch-terminal-right'
            },
            {
                drag     : '.b-sch-terminal-right',
                to       : '[data-task-id=\'13\'] .b-gantt-task',
                dragOnly : true
            },
            {
                waitForElementVisible : '.b-tooltip .b-icon-invalid'
            },
            {
                mouseUp : null
            }
        );
    });

    t.it('Creating: Validating dependencies while D&D', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            },
            dependencies : []
        });

        t.chain(
            {
                moveCursorTo : '[data-task-id=\'12\'] .b-gantt-task'
            },
            {
                waitForElementVisible : '.b-sch-terminal-right'
            },
            {
                drag     : '.b-sch-terminal-right',
                to       : '[data-task-id=\'13\'] .b-gantt-task',
                dragOnly : true
            },
            {
                moveCursorTo : '[data-task-id=\'13\'] .b-gantt-task .b-sch-terminal-left'
            },
            // Happens too fast after change to validate only once per terminal
            // {
            //     waitForElementVisible : '.b-tooltip .b-icon-checking'
            // },
            {
                waitForElementVisible : '.b-tooltip .b-icon-valid'
            },
            {
                waitForElementVisible : '.b-sch-terminal-left.b-valid'
            },
            {
                mouseUp : null
            },

            { waitForSelector : '.b-sch-dependency' }
        );
    });

    t.it('Creating: Should not be valid to create dependencies between connected tasks', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            }
        });

        t.wontFire(gantt.dependencyStore, 'add');

        t.chain(
            {
                moveCursorTo : '[data-task-id=\'12\'] .b-gantt-task'
            },
            {
                waitForElementVisible : '.b-sch-terminal-right'
            },
            {
                drag     : '.b-sch-terminal-right',
                to       : '[data-task-id=\'14\'] .b-gantt-task',
                dragOnly : true
            },
            {
                moveCursorTo : '[data-task-id=\'14\'] .b-gantt-task .b-sch-terminal-left'
            },
            // Happens too fast after change to validate only once per terminal
            // {
            //     waitForElementVisible : '.b-tooltip .b-icon-checking'
            // },
            {
                waitForElementVisible : '.b-tooltip .b-icon-invalid'
            },
            {
                waitForElementVisible : '.b-sch-terminal-left.b-invalid'
            },
            {
                mouseUp : null
            }
        );
    });

    t.it('Editing dependencies', async t => {
        gantt = await t.getGanttAsync({
            columns : [{
                text  : 'Predecessors',
                field : 'predecessors',
                type  : 'dependency',
                width : 200
            }],
            features : {
                taskTooltip : false
            }
        });

        const
            { project }                    = gantt,
            multiDepTask                   = project.eventStore.find(t => t.predecessors.length === 3),
            multiDepTaskPredecessorCellCtx = {
                id    : multiDepTask.id,
                field : 'predecessors'
            },
            predecessors = multiDepTask.predecessors.slice();

        let predecessorField, tabs, dependencyGrid, predecessorPicker, durationField;

        predecessors.sort((a, b) => a.id - b.id);

        // Initial values correct
        t.is(predecessors[0].toString(true), '11');
        t.is(predecessors[1].toString(true), '12');
        t.is(predecessors[2].toString(true), '13');
        t.is(gantt.getCell(multiDepTaskPredecessorCellCtx).innerText, '11;12;13');

        t.chain(
            {
                waitFor : () => gantt.features.cellEdit.editorContext,
                trigger : { doubleclick : () => gantt.getCell(multiDepTaskPredecessorCellCtx) }
            },

            next => {
                predecessorField = gantt.features.cellEdit.editorContext.editor.inputField;

                // Field is populated correctly both in underlying Dependency record content and raw value
                t.is(predecessorField.input.value, '11;12;13');
                t.isDeeply(predecessorField.value, predecessors);

                next();
            },

            {
                // Expand the dropdown
                waitFor : () => predecessorField.picker.isVisible,
                trigger : { click : () => predecessorField.triggers.expand.element }
            },

            next => {
                t.selectorExists('.b-list-item.id11.b-selected.b-fs');
                t.selectorExists('.b-list-item.id12.b-selected.b-fs');
                t.selectorExists('.b-list-item.id13.b-selected.b-fs');
                next();
            },

            // Toggle the to side to make the relationship FF
            { click : '.b-list-item.id11.b-selected.b-fs [data-side="to"]' },

            next => {
                t.is(predecessorField.input.value, '11FF;12;13');
                next();
            },

            // Toggle the from side to make the relationship SF
            { click : '.b-list-item.id11.b-selected.b-ff [data-side="from"]' },

            next => {
                t.is(predecessorField.input.value, '11SF;12;13');
                next();
            },

            // Toggle the to side to make the relationship SS
            { click : '.b-list-item.id11.b-selected.b-sf [data-side="to"]' },

            next => {
                t.is(predecessorField.input.value, '11SS;12;13');
                next();
            },

            // Toggle the from side to make the relationship FS
            { click : '.b-list-item.id11.b-selected.b-ss [data-side="from"]' },

            next => {
                t.is(predecessorField.input.value, '11;12;13');
                next();
            },

            { click : '.b-list-item.id11.b-selected.b-fs .b-predecessor-item-text' },

            // Task 11 is no longer a predecessor
            next => {
                t.selectorNotExists('.b-list-item.id11.b-selected.b-fs');
                t.is(predecessorField.input.value, '12;13');
                next();
            },

            { click : '.b-list-item.id11 .b-predecessor-item-text' },

            // Task 11 is a predecessor again
            next => {
                t.selectorExists('.b-list-item.id11.b-selected.b-fs');
                t.is(predecessorField.input.value, '11;12;13');
                t.moveMouseTo(predecessorField.input, next);
            },

            // -----------------------

            // Double click the destination task of these three deps
            { dblclick : '.b-gantt-task-wrap[data-task-id="14"]' },

            // Select the predecessors tab of the TabPanel
            { click : '.b-tabpanel-tab.b-predecessors-tab' },

            // Begin editing the link type of the Assign resources dep
            { dblclick : '.b-grid-row[data-id="2"] .b-grid-cell[data-column="type"]' },

            // Collect widget refs
            next => {
                // All three incoming dependencies have zero lag to begin with
                t.selectorCountIs('.b-predecessors-tab .b-grid-cell:contains("0 days")', 3);

                tabs = gantt.features.taskEdit.editor.widgetMap.tabs.widgetMap;
                dependencyGrid = tabs.predecessorsTab.widgetMap.grid;
                next();
            },

            // Dropdown the link types
            next => {
                predecessorPicker = dependencyGrid.features.cellEdit.editorContext.editor.inputField;

                next();
            },

            {
                waitFor : () => predecessorPicker.picker.isVisible,
                trigger : { click : () => predecessorPicker.triggers.expand.element }
            },

            // Select the SS item
            { click : '.b-list-item[data-index="0"]' },

            // This will finish dependency type editing and start propagation, plus it will start full lag editing
            { click : '.b-grid-row[data-id="2"] .b-grid-cell[data-column="fullLag"]' },

            { waitForPropagate : gantt },

            async() => durationField = dependencyGrid.features.cellEdit.editorContext.editor.inputField,

            // Make it +1 day
            { click : () => durationField.triggers.spin.upButton },

            // Wait for the propagate of the changed value
            { waitForPropagate : gantt },

            // Editing must not have been stopped by a store reload.
            async() => t.ok(dependencyGrid.features.cellEdit.editorContext && dependencyGrid.features.cellEdit.editorContext.editor.containsFocus, 'Changing the lag did not terminate the edit'),

            // Save the edit
            { click : 'button:contains(Save)' },

            { waitForSelectorNotFound : '.b-gantt-taskeditor' },

            // Check that the cell has been updated
            { waitFor : () => gantt.getCell(multiDepTaskPredecessorCellCtx).innerText === '11;12SS+1d;13' },

            // Now lets edit that lag text
            { dblclick : gantt.getCell(multiDepTaskPredecessorCellCtx) },

            // Check that the editor has been primed with correct new textual value
            { waitFor : () => predecessorField.containsFocus && predecessorField.input.value === '11;12SS+1d;13' },

            // This just switches the lag from +1 day to -1 day
            { type : '11;12FF-1d;13[ENTER]', clearExisting : true },

            { waitForSelector : '.b-grid-row.id14 .b-grid-cell:textEquals(11;12FF-1d;13)' }
        );
    });

    t.it('Should not cancel edit when editing a new dependency', async t => {
        gantt = await t.getGanttAsync({
            columns : [{
                text  : 'Predecessors',
                field : 'predecessors',
                type  : 'dependency',
                width : 200
            }],
            features : {
                taskTooltip : false
            }
        });

        t.chain(
            { dblClick : '.b-gantt-task.id11' },

            { waitForSelector : '.b-taskeditor' },

            next => {
                gantt.features.taskEdit.editor.widgetMap.tabs.layout.animateCardChange = false;
                next();
            },

            { click : '.b-tabpanel-tab.b-successors-tab' },

            { click : '.b-successorstab .b-add-button' },

            { waitForSelector : '.b-cell-editor.b-contains-focus' },

            { click : '.b-cell-editor .b-icon-picker' },

            { click : '.b-list-item:contains(Preparation)' },

            { type : '[TAB]' },

            // Nothing should happen. The test is that editing does not finish
            // so there's no event to wait for.
            { waitFor : 500 },

            () => {
                t.selectorExists('.b-cell-editor.b-contains-focus');
            }
        );
    });

    // https://github.com/bryntum/support/issues/338
    t.it('Creating: Should not crash when moving mouse outside schedule area', async t => {

        gantt = await t.getGanttAsync({
            features : {
                taskTooltip : false
            }
        });

        t.chain(
            {
                moveCursorTo : '[data-task-id=\'12\'] .b-gantt-task'
            },
            {
                drag     : '.b-sch-terminal-right',
                to       : '.b-grid-splitter',
                dragOnly : true
            },

            { waitFor : 500, desc : 'Waiting for transition to end' }
        );
    });

    t.it('Should not throw an exception when mouse is moved out from task terminal of a removed task', async t => {
        gantt = await t.getGanttAsync({
            transitionDuration  : 500,
            useInitialAnimation : false,
            tasks               : [
                {
                    id        : 41,
                    name      : 'Task 41',
                    cls       : 'task41',
                    startDate : '2017-01-16',
                    duration  : 2,
                    leaf      : true
                }
            ]
        });

        t.chain(
            { click : '.b-gantt-task' },
            { moveCursorTo : '.b-sch-terminal' },

            { type : '[DELETE]' },

            // This step is required to reproduce the bug, no extra mouse movement needed
            next => {
                // The bug happens when the element becomes `pointer-events: none;` due to being
                // put into an animated removing state. Mouseout is triggered in a real UI,
                // so we have to explicitly fire one here.
                t.simulator.simulateEvent(document.querySelector('.b-sch-terminal'), 'mouseout');
                next();
            },

            { waitForSelectorNotFound : gantt.unreleasedEventSelector, desc : 'Task was removed' }
        );
    });

    t.it('Should redraw on TaskStore sort', async t => {
        gantt = await t.getGanttAsync();

        await t.waitForDependencies();

        gantt.taskStore.sort('name');

        await gantt.await('dependenciesDrawn', false);

        await t.waitFor(
            () => t.getSVGBox(document.querySelector('[depId="1"]')).top > 200,
            () => t.pass('Dependencies redrawn')
        );
    });

    t.it('Should draw correctly between distant milestones', async t => {
        gantt = await t.getGanttAsync({
            tasks : [
                { id : 1, name : 'Task 1', startDate : new Date(2021, 0, 1), duration : 0 },
                {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                { id : 2, name : 'Task 2', startDate : new Date(2021, 0, 1), duration : 0 }
            ],
            dependencies : [
                { from : 1, to : 2 }
            ]
        });

        await t.waitForDependencies();

        const initial = t.rect('.b-sch-dependency');

        await gantt.scrollTaskIntoView(gantt.taskStore.last);

        await t.waitForAnimationFrame();

        const afterScroll = t.rect('.b-sch-dependency');

        t.isApprox(initial.left, afterScroll.left, 0.1, 'Dependency did not move horizontally');
    });

    t.it('Should update dependency type correctly', async t => {
        gantt = await t.getGanttAsync({
            tasks : [
                {
                    id       : 1,
                    name     : 'task 1',
                    expanded : true,
                    children : [
                        { id : 11, name : 'task 11', startDate : '2020-01-20', duration : 1 },
                        { id : 12, name : 'task 12', startDate : '2020-01-20', duration : 1 }
                    ]
                }
            ],
            dependencies : []
        });

        t.chain(
            { moveMouseTo : '.b-grid-header' },  // make sure we mouseenter the task on the next step
            { moveMouseTo : '[data-task-id="11"]' },
            { drag : '.b-sch-terminal-right', to : '[data-task-id="12"]', dragOnly : true },
            { moveMouseTo : '[data-task-id="12"] .b-sch-terminal-left' },
            { mouseUp : null },
            async() => {
                const dep = gantt.dependencyStore.first;

                t.notOk(dep.fromSide, 'fromSide is not set');
                t.notOk(dep.toSide, 'toSide is not set');

                dep.type = 0;

                await Promise.all([
                    gantt.project.commitAsync(),
                    gantt.await('dependenciesDrawn')
                ]);

                t.assertDependency(gantt, dep, { fromSide : 'left', toSide : 'left' });
            }
        );
    });

    t.it('Should hide dependency terminals when mouse leaves target task bar', async t => {
        gantt = await t.getGanttAsync({
            tasks : [
                {
                    id       : 1,
                    name     : 'task 1',
                    expanded : true,
                    children : [
                        { id : 11, name : 'task 11', startDate : '2020-01-20', duration : 1 },
                        { id : 12, name : 'task 12', startDate : '2020-01-20', duration : 1 }
                    ]
                }
            ],
            dependencies : []
        });

        t.chain(
            { moveCursorTo : '[data-task-id="12"]' },
            {
                drag     : '.b-sch-terminal-right',
                to       : '[data-task-id="11"]',
                dragOnly : true
            },
            async() => {
                t.selectorCountIs('.b-sch-terminal', 2, '2 terminals shown');
            },
            { moveCursorTo : '[data-task-id="1"]' },

            async() => {
                t.selectorCountIs('.b-sch-terminal', 2, 'No terminals shown');
            },

            { moveCursorBy : [200, 0] },

            async() => {
                t.selectorCountIs('.b-sch-terminal', 0, 'No terminals shown');
            },

            { moveCursorTo : '[data-task-id="11"]' },

            async() => {
                t.mouseUp();
                t.selectorCountIs('.b-sch-terminal', 2, '2 terminals shown');
            }
        );
    });

    // https://github.com/bryntum/support/issues/3176
    t.it('Should allow configuring when to draw special dependency pointing to top of target task for Finish-to-Start links', async t => {
        gantt = await t.getGanttAsync({
            tasks : [
                { id : 11, name : 'task 11', startDate : '2020-01-20', duration : 1 },
                { id : 12, name : 'task 12', startDate : '2020-01-20', duration : 1, durationUnit : 'min' }
            ],
            dependencies : [
                { from : 11, to : 12 }
            ]
        });

        await t.waitForSelector('polyline');

        t.is(t.query('polyline')[0].points.length, 6, 'Should draw with turns if target task is too slim for drawing to top edge');

        gantt.taskStore.getById(12).duration = 1000;

        await t.waitFor({
            method : () => t.query('polyline')[0].points.length === 3,
            desc   : 'Should draw targeting top edge if target task is wider than minTargetTaskWidthToDrawToTopEdge'
        });
    });

    // https://github.com/bryntum/support/issues/3291
    t.it('Should show tooltip when hovering a dependency', async t => {
        gantt = t.getGantt({
            features : {
                taskTooltip : false
            },
            dependencyIdField : 'wbsCode',

            tasks : [
                {
                    id       : 11,
                    expanded : true,
                    children : [
                        {
                            id        : 4,
                            name      : 'Foo',
                            startDate : '2017-01-16',
                            duration  : 1,
                            leaf      : true
                        },
                        {
                            id        : 5,
                            name      : 'Bar',
                            startDate : '2017-01-17',
                            duration  : 1,
                            leaf      : true
                        }
                    ]
                }

            ],
            dependencies : [
                { from : 4, to : 5 }
            ]
        });

        await t.waitForSelector('polyline');

        t.query('polyline')[0].style.pointerEvents = 'all';
        await t.moveCursorTo('polyline', null, null, ['100%', 3]);
        await t.waitForSelector('.b-tooltip:contains(Foo 1.1)');
        await t.waitForSelector('.b-tooltip:contains(Bar 1.2)');
    });

});
