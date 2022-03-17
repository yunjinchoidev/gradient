import { AjaxHelper } from '../../build/gantt.module.js?457330';

describe('Test buttons', t => {

    const
        gantt = bryntum.query('gantt'),
        tbar  = bryntum.fromElement(document.querySelector('.b-top-toolbar')),
        tools = tbar.widgetMap;

    // Make buttons a little smaller so that they do not overflow into the overflow menu so we can test them
    tbar.style = {
        fontSize : '80%'
    };

    !gantt.features.taskTooltip.isDestroyed && gantt.features.taskTooltip.destroy();

    // https://github.com/bryntum/support/issues/1229
    t.it('Should send task id instead of object on fields "fromTask" and "toTask" when sync', async t => {
        AjaxHelper.mockUrl('syncurl', {
            responseText : JSON.stringify({
                success : true
            })
        });

        gantt.project.transport.sync = gantt.project.transport.sync || {};
        gantt.project.transport.sync.url = 'syncurl';

        t.chain(
            { waitForPropagate : gantt },
            {
                moveCursorTo : '[data-task-id="21"] .b-gantt-task'
            },
            {
                waitForElementVisible : '.b-sch-terminal-right'
            },
            {
                drag     : '.b-sch-terminal-right',
                to       : '[data-task-id="22"] .b-gantt-task',
                dragOnly : true
            },
            {
                moveCursorTo : '[data-task-id="22"] .b-gantt-task .b-sch-terminal-right'
            },
            {
                mouseUp : null
            },

            { waitForPropagate : gantt },

            async() => {
                gantt.crudManager.on({
                    beforeSync({ pack }) {
                        const [dependency] = pack.dependencies.added;

                        t.is(dependency.fromTask, 21, 'Parameter "fromTask" is the number 21');
                        t.is(dependency.toTask, 22, 'Parameter "toTask" is the number 22');
                    }
                });

                await gantt.project.sync();
            }
        );
    });

    // https://github.com/bryntum/support/issues/244
    t.it('Deleted dependency line should not re-appear', t => {
        t.chain(
            { waitForPropagate : gantt.project },

            { waitForSelector : 'polyline[depId=4]' },

            next => {
                gantt.dependencyStore.remove([3, 4]);
                next();
            },

            { waitForSelectorNotFound : 'polyline[depId=3]' },

            { waitForSelectorNotFound : 'polyline[depId=4]' },

            next => {
                gantt.dependencyStore.add(
                    { fromEvent : 13, toEvent : 15 }
                );
                next();
            },

            // give the offending dependency line time to re-appear
            { waitFor : 10 },

            { waitForSelectorNotFound : 'polyline[depId=4]' }
        );
    });

    // https://github.com/bryntum/support/issues/1543
    t.it('Dependencies should not disappear when using critical paths', async t => {
        await t.click(tools.featuresButton.element);

        await t.click('.b-menu-text:textEquals(Critical paths)');

        await t.click('.demo-header');

        await t.waitForEventOnTrigger(gantt, 'dependenciesDrawn', async() => {
            await t.dragBy('[data-task-id="11"]', [300, 0]);
        });

        await t.waitForEventOnTrigger(gantt, 'dependenciesDrawn', () => {
            gantt.timeAxisSubGridElement.scrollLeft = 507;
        });

        await t.waitForSelector('[depId="1"]');

        await t.click(tools.featuresButton.element);

        await t.click('.b-menu-text:textEquals(Critical paths)');
    });

    // https://github.com/bryntum/support/issues/1815
    t.it('Dependencies should not disappear when filter and update project start date and clear filter', async t => {
        t.chain(
            { waitForPropagate : gantt.project },

            { waitForSelector : 'polyline[depId=2]' },

            { rightClick : '.b-grid-row[data-id="2"] [data-column="startDate"]' },

            { click : '.b-menuitem[data-ref="filterDateBefore"]' },

            { waitForSelector : 'polyline[depId=2]', desc : 'Dependency is visible after filter because source and target are visible' },

            { rightClick : '.b-grid-header[data-column="startDate"]' },

            { click : '.b-menuitem[data-ref="removeFilter"]' },

            { rightClick : '.b-grid-row[data-id="14"] [data-column="startDate"]' },

            { click : '.b-menuitem[data-ref="filterDateEquals"]' },

            { click : '.b-datefield[data-ref="startDateField"] .b-icon-calendar' },

            { click : '.b-datepicker.b-calendarpanel [data-date="2019-01-15"]' },

            { rightClick : '.b-grid-header[data-column="startDate"]' },

            { click : '.b-menuitem[data-ref="removeFilter"]' },

            { waitForSelector : 'polyline[depId=2]', desc : 'Dependency is visible after filter and update start date' }
        );
    });

    t.it('Check toolbar buttons', t => {

        t.willFireNTimes(gantt, 'presetchange', 3);
        t.willFireNTimes(gantt, 'timeaxischange', 5);

        t.chain(
            { click : tools.addTaskButton.element },

            { waitForSelector : 'input:focus' },

            // ENTER key on last row cell should add a new row if `addNewAtEnd` is enabled
            // Create task with name foo
            { type : 'foo[TAB]' },
            { waitForSelector : '.b-editor .b-startdatefield' },

            // Open task editor
            () => gantt.editTask(gantt.taskStore.last),

            // rename task to bar
            { type : '[BACKSPACE][BACKSPACE][BACKSPACE]bar', target : '[name=\'name\']' },

            { click : '.b-gantt-taskeditor :textEquals(Save)' },

            next => {
                t.selectorNotExists('.b-grid-cell:textEquals(foo)');
                t.selectorExists('.b-grid-cell:textEquals(bar)');
                next();
            },

            { click : tools.collapseAllButton.element },

            next => {
                t.is(gantt.taskStore.find(task => !task.isLeaf && task.parent === gantt.taskStore.rootNode && task.isExpanded(gantt.taskStore)), null, 'No expanded nodes found');
                next();
            },

            { click : tools.expandAllButton.element },

            next => {
                t.is(gantt.taskStore.find(task => !task.isLeaf && task.parent === gantt.taskStore.rootNode && !task.isExpanded(gantt.taskStore)), null, 'No collapsed nodes found');
                next();
            },

            // These should trigger 1 timeaxischange each
            { click : tools.zoomInButton.element },

            { click : tools.zoomOutButton.element },

            { click : tools.zoomToFitButton.element },

            { click : tools.previousButton.element },

            { click : tools.nextButton.element }
        );
    });

    t.it('Should support turning features on and off', t => {
        t.chain(
            // make sure zoom level displays days in the bottom
            // we need this to show non-working intervals
            {
                waitFor : 'Event',
                args    : [gantt, 'presetChange'],
                trigger : () => gantt.zoomToLevel(9)
            },

            { click : tools.featuresButton.element },
            // dependencies
            { click : '.b-menu-text:textEquals(Draw dependencies)' },
            { waitForSelectorNotFound : '.b-sch-dependency' },
            { click : '.b-menu-text:textEquals(Draw dependencies)' },
            { waitForSelector : '.b-sch-dependency' },
            // eof dependencies

            // critical path
            { click : '.b-menu-text:textEquals(Critical paths)' },
            { waitForSelector : '.b-gantt-critical-paths' },
            { click : '.b-menu-text:textEquals(Critical paths)' },
            { waitForSelectorNotFound : '.b-gantt-critical-paths' },
            // eof critical path

            // labels
            { click : '.b-menu-text:textEquals(Task labels)' },
            { waitForSelectorNotFound : '.b-gantt-task-wrap:not(.b-sch-released).b-sch-label' },
            { click : '.b-menu-text:textEquals(Task labels)' },
            { waitForSelector : '.b-gantt-task-wrap .b-sch-label' },
            // eof labels

            // project lines
            { click : '.b-menu-text:textEquals(Project lines)' },
            { waitForSelectorNotFound : '.b-gantt-project-line:textEquals(Project start)' },
            { click : '.b-menu-text:textEquals(Project lines)' },
            { waitForSelector : '.b-gantt-project-line:textEquals(Project start)' },
            // eof project lines

            // non-working time
            { click : '.b-menu-text:textEquals(Highlight non-working time)' },
            { waitForSelectorNotFound : '.b-sch-nonworkingtime' },
            { click : '.b-menu-text:textEquals(Highlight non-working time)' },
            { waitForSelector : '.b-sch-nonworkingtime' },
            // eof non-working time

            // Enable cell editing
            { click : '.b-menu-text:textEquals(Enable cell editing)' },
            { waitForSelectorNotFound : '.b-gantt-task-wrap:not(.b-sch-released).b-sch-label' },
            { click : '.b-menu-text:textEquals(Enable cell editing)' },
            { waitForSelector : '.b-gantt-task-wrap .b-sch-label' },
            // eof cell editing

            // Show baselines
            { waitForSelectorNotFound : '.b-has-baselines' }, // shouldn't be there if baselines are disabled
            { click : '.b-menu-text:textEquals(Show baselines)' },
            { waitForSelector : '.b-task-baseline' },
            { waitForSelector : '.b-has-baselines' }, // should be there if baselines are enabled
            { click : '.b-menu-text:textEquals(Show baselines)' },
            { waitForSelectorNotFound : '.b-milestone-wrap .b-task-baseline' },
            { waitForSelectorNotFound : '.b-has-baselines' }, // shouldn't be there if baselines are disabled
            // eof Show baselines

            // schedule collapsing
            { click : '.b-menu-text:textEquals(Hide schedule)' },
            async() => t.ok(gantt.subGrids.normal.collapsed, 'Schedule collapsed'),
            { click : '.b-menu-text:textEquals(Hide schedule)' },
            async() => t.notOk(gantt.subGrids.normal.isCollapsed, 'Schedule expanded')
            // eof schedule collapsing
        );
    });

    // Can't interact with native slider elements so calling listeners manually
    t.it('Should support changing UI settings', t => {
        tbar.onBarMarginChange({ value : 10  });
        t.is(gantt.barMargin, 10, 'Bar margin changed');

        tbar.onAnimationDurationChange({ value : 1000 });
        t.is(gantt.transitionDuration, 1000, 'Transition duration changed');

        tbar.onRowHeightChange({ value : 40, source : tbar.widgetMap.featuresButton.menu.items[0].menu.widgetMap.rowHeight });
        t.is(gantt.rowHeight, 40, 'Row height changed');
    });

    t.it('Should not reload images in avatar column on task changes', async t => {
        gantt.taskStore.getById(1000).remove();

        const [task] = gantt.taskStore.add({ name : 'New' });

        let loadedCount = 0;

        function onLoad(event) {
            // in Firefox previous test appends style tag which triggers load event
            // filter out style tag loads
            if (event.target && event.target.tagName !== 'STYLE') {
                loadedCount++;
            }
        }

        document.addEventListener('load', onLoad, true);

        gantt.resourceStore.first.imageUrl = '../_shared/images/users/dan.jpg';

        task.assign(gantt.resourceStore.first);

        t.chain(
            { waitFor : () => loadedCount === 1 },

            next => {
                task.name = 'Changed';

                next();
            },

            { waitFor : 2000, desc : 'Waiting for no images to load :)' },

            () => {
                t.is(loadedCount, 1, 'No additional load');

                document.removeEventListener('load', onLoad, true);
            }
        );
    });

    // https://github.com/bryntum/support/issues/1931
    t.it('Should translate columns and toolbar items', async t => {
        t.chain(
            { click : '.b-button[data-ref="infoButton"]' },

            { click : '.b-combo[data-ref=localeCombo]' },

            { click : '.b-list-item:contains(Русский)' },

            { waitForSelector : '.b-button[data-ref="addTaskButton"] label:contains(Создать)', desc : 'Button "Create" translated' },

            { moveMouseTo : '.b-button[data-ref="addTaskButton"]' },

            { waitForSelector : '.b-tooltip:contains(Создать новую задачу)', desc : 'Button "Create" tooltip translated' },

            { click : '.b-button[data-ref="featuresButton"]' },

            { waitForSelector : '.b-menuitem:contains(Зависимости задач)', desc : 'Menu item for "Features" button translated' },

            { moveCursorTo : '.b-menuitem:nth-child(2)' },
            { moveCursorTo : '.b-menuitem:nth-child(1)' },

            { waitForSelector : '.b-slider[data-ref="rowHeight"]:contains(Высота строки)', desc : 'Slider field for "Row height" translated' },

            { waitForSelector : '.b-grid-header[data-column="startDate"]:contains(Начало)', desc : 'Column "Start" translated' },

            { waitForSelector : '.b-datefield[data-ref="startDateField"]:contains(Старт проекта)', desc : 'Label for "Project Start" translated' },

            { waitForSelector : '.b-textfield[data-ref="filterByName"]:contains(Найти задачи по названию)', desc : 'Placeholder for "Filter" translated' },

            // https://github.com/bryntum/support/issues/2118
            { moveMouseTo : '.b-button[data-ref="undoBtn"]' },

            { waitForSelector : '.b-tooltip:contains(Отменить последнее действие)', desc : 'Button "Undo" tooltip translated' },

            { click : '.b-button[data-ref="undoBtn"]' },

            { moveMouseTo : '.b-button[data-ref="redoBtn"]' },

            { waitForSelector : '.b-tooltip:contains(Повторить последнее отмененное действие)', desc : 'Button "Redo" tooltip translated' }
        );
    });
});
