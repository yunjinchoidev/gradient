describe('Test buttons', function(t) {
    const
        gantt   = bryntum.query('gantt'),
        buttons = gantt.tbar.widgetMap;

    !gantt.features.taskTooltip.isDestroyed && gantt.features.taskTooltip.destroy();

    t.it('Rendering', t => {
        t.chain(
            { waitForSelector : '.b-gantt' },
            { waitForSelector : '.b-gantt-task' }
        );
    });

    t.it('Should support turning features on and off', (t) => {
        t.chain(
            { click : buttons.featuresButton.element },

            // dependencies
            { click : '.b-menu-text:textEquals(Draw dependencies)' },
            { waitForSelectorNotFound : '.b-sch-dependency' },
            { click : '.b-menu-text:textEquals(Draw dependencies)' },
            { waitForSelector : '.b-sch-dependency' },

            // labels
            { click : '.b-menu-text:textEquals(Task labels)' },
            { waitForSelectorNotFound : '.b-gantt-task-wrap:not(.b-sch-released).b-sch-label' },
            { click : '.b-menu-text:textEquals(Task labels)' },
            { waitForSelector : '.b-gantt-task-wrap .b-sch-label' },

            // project lines
            { click : '.b-menu-text:textEquals(Project lines)' },
            { waitForSelectorNotFound : '.b-gantt-project-line:textEquals(Project start)' },
            { click : '.b-menu-text:textEquals(Project lines)' },
            { waitForSelector : '.b-gantt-project-line:textEquals(Project start)' },

            // non-working time
            { click : '.b-menu-text:textEquals(Highlight non-working time)' },
            { waitForSelectorNotFound : '.b-sch-nonworkingtime' },
            { click : '.b-menu-text:textEquals(Highlight non-working time)' },
            { waitForSelector : '.b-sch-nonworkingtime' },

            // schedule collapsing
            { click : '.b-menu-text:textEquals(Hide schedule)' },
            (next) => {
                t.ok(gantt.subGrids.normal.collapsed, 'Schedule collapsed');
                next();
            },
            { click : '.b-menu-text:textEquals(Hide schedule)' },

            () => {
                t.notOk(gantt.subGrids.normal.isCollapsed, 'Schedule expanded');
            }
        );
    });

    t.it('Check toolbar buttons', (t) => {

        t.ok(gantt.element.classList.contains('b-gantt'), 'Gantt is found');

        t.willFireNTimes(gantt, 'presetchange', 3);
        t.willFireNTimes(gantt, 'timeaxischange', 5);

        const
            checkToolTip = (t, button, text, x, y, width, height) => [
                { moveMouseTo : button.element },
                { waitForSelector : `.b-tooltip:contains(${text})`, desc : 'Correct tooltip shown' }
            ];

        t.chain(
            checkToolTip(t, buttons.addTaskButton, 'Create new task', 0, 19, 127, 47),

            checkToolTip(t, buttons.editTaskButton, 'Edit selected task', 78, 19, 135, 47),

            { click : buttons.addTaskButton.element },

            { waitForSelector : 'input:focus' },

            // ENTER key on last row cell should add a new row if `addNewAtEnd` is enabled
            // Create task with name foo
            { type : 'foo[TAB]' },

            // Open task editor
            { click : buttons.editTaskButton.element },

            // rename task to bar
            { type : '[BACKSPACE][BACKSPACE][BACKSPACE]bar', target : '[name=\'name\']' },

            { click : ':textEquals(Save)' },

            (next) => {
                t.selectorNotExists('.b-grid-cell:textEquals(foo)');
                t.selectorExists('.b-grid-cell:textEquals(bar)');
                next();
            },

            { click : buttons.collapseAllButton.element },

            (next) => {
                t.is(gantt.taskStore.find(task => !task.isLeaf && task.parent === gantt.taskStore.rootNode && task.isExpanded(gantt.taskStore)), null, 'No expanded nodes found');
                next();
            },

            { click : buttons.expandAllButton.element },

            (next) => {
                t.is(gantt.taskStore.find(task => !task.isLeaf && task.parent === gantt.taskStore.rootNode && !task.isExpanded(gantt.taskStore)), null, 'No collapsed nodes found');
                next();
            },

            // These should trigger 1 timeaxischange each
            { click : buttons.zoomInButton.element },

            { click : buttons.zoomOutButton.element },

            { click : buttons.zoomToFitButton.element },

            { click : buttons.previousButton.element },

            { click : buttons.nextButton.element }
        );
    });

});
