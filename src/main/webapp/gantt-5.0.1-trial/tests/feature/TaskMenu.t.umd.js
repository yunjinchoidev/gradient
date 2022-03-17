"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();

    if (bryntum.queryAll('menuitem').length > 0) {
      // After gantt destroy, all menuitems must also have been destroyed
      t.is(bryntum.queryAll('menuitem').length, 0, 'Menu items all destroyed');
    }
  });
  t.it('Basic context menu works', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false,
        taskMenu: {
          items: {
            moveLeft: {
              text: 'Move left',
              icon: 'b-fa b-fa-fw b-fa-arrow-left',
              cls: 'b-separator b-move-left',

              onItem({
                taskRecord
              }) {
                taskRecord.setStartDate(DateHelper.add(taskRecord.startDate, -1, 'day'));
              }

            },
            moveRight: {
              text: 'Move right',
              icon: 'b-fa b-fa-fw b-fa-arrow-right',
              cls: 'b-move-right',

              onItem({
                taskRecord
              }) {
                taskRecord.setStartDate(DateHelper.add(taskRecord.startDate, 1, 'day'));
              }

            }
          }
        }
      }
    });
    const targetTask = gantt.taskStore.getById(11);
    t.firesOk({
      observable: gantt,
      events: {
        taskmenubeforeshow: 6,
        taskmenushow: 5,
        taskmenuitem: 5
      }
    });
    gantt.on({
      taskmenubeforeshow: () => false,
      once: true
    });
    const listeners = {
      taskmenubeforeshow: ({
        source,
        items,
        taskRecord
      }) => {
        t.describe('Assert taskmenubeforeshow event', t => {
          t.is(source, gantt, 'Source is ok'); // We should see
          // Edit
          // Add...
          // Indent
          // Outdent
          // Delete task
          // Move left
          // Move right
          // Convert to milestone

          t.is(ObjectHelper.getTruthyKeys(items).length, 8, '8 menu items');
          t.is(taskRecord, taskRecord, 'Target task is ok');
        });
      },
      taskmenushow: ({
        source,
        taskRecord,
        taskElement
      }) => {
        t.describe('Assert taskmenushow event', t => {
          t.is(source, gantt, 'Source is ok');
          t.is(taskRecord, targetTask, 'Target task is ok');
          t.is(taskElement, gantt.getElementFromTaskRecord(targetTask).parentElement, 'Element is ok');
        });
      },
      taskmenuitem: ({
        source,
        item,
        taskRecord
      }) => {
        t.describe('Assert taskmenuitem event', t => {
          t.is(source, gantt, 'Source is ok');
          t.is(item.text, 'Move right', 'Item is ok');
          t.is(taskRecord, targetTask, 'Target task is ok');
        });
      },
      once: true
    };
    let task;
    t.chain({
      contextmenu: '.b-gantt-task.id11',
      desc: 'First menu is cancelled'
    }, next => {
      gantt.on(listeners);
      next();
    }, {
      contextmenu: '.b-gantt-task.id11',
      desc: 'Move one day right'
    }, {
      click: '.b-move-right'
    }, {
      waitForPropagate: gantt
    }, next => {
      t.is(targetTask.startDate, new Date(2017, 0, 17), 'Start date moved');
      next();
    }, {
      contextmenu: '.b-gantt-task.id11',
      desc: 'Move one day left'
    }, {
      click: '.b-move-left'
    }, {
      waitForPropagate: gantt
    }, next => {
      t.is(targetTask.startDate, new Date(2017, 0, 16), 'Start date moved');
      next();
    }, {
      contextmenu: '.b-gantt-task.id11'
    }, {
      moveMouseTo: '.b-menuitem:contains(Add)',
      offset: ['99%', 1]
    }, {
      click: '.b-icon-up',
      desc: 'Add task above'
    }, next => {
      task = gantt.taskStore.changes.added[gantt.taskStore.changes.added.length - 1];
      task.cls = 'task1';
      next();
    }, {
      contextmenu: '.b-gantt-task.task1'
    }, {
      moveMouseTo: '.b-menuitem:contains(Add)',
      offset: ['99%', 1]
    }, {
      click: '.b-icon-down',
      desc: 'Add task below'
    }, next => {
      const {
        added
      } = gantt.taskStore.changes,
            task1 = added[added.length - 2],
            task2 = added[added.length - 1];
      t.is(task1.startDate, targetTask.startDate, 'New task 1 start date is ok');
      t.is(task2.startDate, targetTask.startDate, 'New task 2 start date is ok');
      next();
    }, {
      contextmenu: '.b-gantt-task.task1'
    }, {
      click: '.b-icon-edit'
    }, // focus should go to first input inside tab (not the tab bar buttons):
    {
      waitForSelector: '.b-contains-focus input'
    }, {
      type: 'foo[ENTER]'
    }, () => {
      t.is(task.name, 'New task 1foo', 'Task name is ok');
    });
  });
  t.it('Should trigger taskMenuBeforeShow, taskMenuShow, taskMenuItem events', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false,
        taskMenu: {
          items: {
            foo: {
              text: 'foo'
            }
          }
        }
      }
    });
    t.firesOk({
      observable: gantt,
      events: {
        taskmenubeforeshow: 1,
        taskmenushow: 1,
        taskmenuitem: 1
      }
    });
    t.chain({
      rightClick: '.b-gantt-task.id11'
    }, {
      click: '.b-menuitem:textEquals(foo)'
    });
  });
  t.it('Should be possible to trigger menu using API', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false,
        taskMenu: true
      }
    });

    const menu = gantt.features.taskMenu,
          getTask = id => gantt.taskStore.getById(id);

    gantt.collapse(getTask(23));
    await t.waitForSelector('.b-gantt-task');
    let task = getTask(12);
    menu.showContextMenuFor(task);
    t.selectorCountIs('.b-menuitem', 6, 'Menu was not opened');
    task = getTask(231);
    menu.showContextMenuFor(task);
    t.selectorCountIs('.b-menuitem', 6, 'Menu was not opened');
    task = getTask(21);
    menu.showContextMenuFor(task);
    t.selectorCountIs('.b-menu', 1, 'Task context menu appears');
    const taskBox = gantt.getElementFromTaskRecord(getTask(21)).getBoundingClientRect(),
          menuBox = document.querySelector('.b-menu').getBoundingClientRect();
    t.ok(taskBox.left < menuBox.left && taskBox.right > menuBox.left, 'Menu is aligned horizontally');
    t.ok(taskBox.top < menuBox.top && taskBox.bottom > menuBox.top, 'Menu is aligned vertically');
  }); // https://app.assembla.com/spaces/bryntum/tickets/9405

  t.it('Should show task context menu for cells with cell specific items provided by features', async t => {
    gantt = await t.getGanttAsync({
      features: {
        search: true,
        filter: true,
        taskMenu: true
      }
    });
    t.chain({
      rightClick: '.b-grid-cell'
    }, {
      waitForSelector: '.b-menu'
    }, () => {
      t.selectorExists('.b-menuitem[data-ref="editTask"]');
      t.selectorExists('.b-menuitem[data-ref="indent"]');
      t.selectorExists('.b-menuitem[data-ref="search"]');
      t.selectorExists('.b-menuitem[data-ref="filterStringEquals"]');
    });
  });
  t.it('CellMenu feature should be ignored, cell specific items should be supported by TaskMenu feature', async t => {
    const spy = t.spyOn(console, 'warn').and.callFake(() => {});
    gantt = await t.getGanttAsync({
      features: {
        taskMenu: {
          items: {
            bar: {
              text: 'bar'
            }
          }
        },
        cellMenu: {
          items: {
            foo: {
              text: 'foo'
            }
          }
        }
      }
    });
    t.chain({
      rightClick: '.b-grid-cell'
    }, {
      waitForSelector: '.b-menu'
    }, () => {
      t.selectorExists('.b-menuitem[data-ref="bar"]');
      t.selectorNotExists('.b-menuitem[data-ref="foo"]');
      t.expect(spy).toHaveBeenCalled(1);
      t.expect(spy).toHaveBeenCalledWith('`CellMenu` feature is ignored, when `TaskMenu` feature is enabled. If you need cell specific menu items, please configure `TaskMenu` feature items instead.');
    });
  });
  t.it('Should be possible to disable Task Edit feature and use Task menu', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false,
        taskEdit: false,
        taskMenu: true
      }
    });
    t.chain({
      rightClick: '.b-gantt-task.id11'
    }, {
      waitForSelector: '.b-menu',
      desc: 'Menu is visible'
    }, {
      waitForSelectorNotFound: '.b-menuitem[data-ref="editTask"]',
      desc: 'Edit menu item is not in the menu'
    });
  }); // https://github.com/bryntum/support/issues/1056

  t.it('Should be possible to disable Task menu for a specific column', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false,
        taskMenu: true
      },
      columns: [{
        type: 'name',
        width: 250
      }, {
        type: 'startdate',
        enableCellContextMenu: false
      }]
    });
    t.chain({
      rightClick: '.b-grid-cell[data-column="name"]'
    }, {
      waitForSelector: '.b-menu',
      desc: 'Menu is visible'
    }, {
      rightClick: '.b-grid-cell[data-column="startDate"]'
    }, {
      waitForSelectorNotFound: '.b-menu',
      desc: 'Menu is not visible'
    });
  }); // https://github.com/bryntum/support/issues/853

  t.it('Should disable "Indent" menu item for the first child', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false
      }
    });
    t.chain({
      rightClick: '[data-task-id="1000"]'
    }, {
      waitForSelector: '.b-menuitem.b-disabled[data-ref="indent"]',
      desc: 'Menu item is disabled'
    }, {
      type: '[ESC]'
    }, {
      waitForSelectorNotFound: '.b-menu',
      desc: 'Menu is hidden'
    }, {
      rightClick: '[data-task-id="2"]'
    }, {
      waitForSelector: '.b-menuitem[data-ref="indent"]',
      desc: 'Menu item is present'
    }, () => {
      t.selectorNotExists('.b-menuitem.b-disabled[data-ref="indent"]', 'Menu item not disabled');
    });
  });
  t.it('Should disable "Outdent" menu item for the first level tasks', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false
      }
    });
    t.chain({
      rightClick: '[data-task-id="1000"]'
    }, {
      waitForSelector: '.b-menuitem.b-disabled[data-ref="outdent"]',
      desc: 'Menu item is disabled'
    }, {
      type: '[ESC]'
    }, {
      waitForSelectorNotFound: '.b-menu',
      desc: 'Menu is hidden'
    }, {
      rightClick: '[data-task-id="2"]'
    }, {
      waitForSelector: '.b-menuitem[data-ref="outdent"]',
      desc: 'Menu item is present'
    }, () => {
      t.selectorNotExists('.b-menuitem.b-disabled[data-ref="outdent"]', 'Menu item not disabled');
    });
  }); // https://github.com/bryntum/support/issues/1559

  t.it('Should show task menu for empty part of timeaxis', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false
      }
    });
    t.chain({
      rightClick: '.b-sch-timeaxis-cell',
      offset: [5, '50%']
    }, {
      waitForSelector: '.b-menu',
      desc: 'Menu item is disabled'
    }, {
      type: '[ESC]'
    }, {
      waitForSelectorNotFound: '.b-menu',
      desc: 'Menu is hidden'
    });
  });
  t.it('Sanity check of default subitems', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskMenu: true
      }
    });
    t.chain({
      contextmenu: '.b-gantt-task.id11',
      desc: 'First menu is cancelled'
    }, {
      waitForSelector: '.b-menu-text',
      desc: 'A menu item is on the screen'
    }, async () => {
      t.selectorCountIs('.b-menu-text', 6, '6 menu items are on the screen');
      t.selectorExists('.b-menu-content .b-menuitem:nth-child(1):contains(Edit)', '1: Edit');
      t.selectorExists('.b-menu-content .b-menuitem:nth-child(2):contains(Add...)', '2: Add...');
      t.selectorExists('.b-menu-content .b-menuitem:nth-child(3):contains(Convert to milestone)', '3: Convert to milestone');
      t.selectorExists('.b-menu-content .b-menuitem:nth-child(4):contains(Indent)', '4: Indent');
      t.selectorExists('.b-menu-content .b-menuitem:nth-child(5):contains(Outdent)', '5: Outdent');
      t.selectorExists('.b-menu-content .b-menuitem:nth-child(6):contains(Delete)', '6: Delete');
    }, {
      moveMouseTo: '.b-icon-add',
      offset: [130, 0]
    }, {
      waitForSelector: '.b-sub-menu .b-menu-text',
      desc: 'A submenu item is on the screen'
    }, async () => {
      t.selectorCountIs('.b-sub-menu .b-menu-text', 6, '6 submenu items are on the screen');
      t.selectorExists('.b-sub-menu .b-menu-content .b-menuitem:nth-child(1):contains(Task above)', '1: Task above');
      t.selectorExists('.b-sub-menu .b-menu-content .b-menuitem:nth-child(2):contains(Task below)', '2: Task below');
      t.selectorExists('.b-sub-menu .b-menu-content .b-menuitem:nth-child(3):contains(Milestone)', '3: Milestone');
      t.selectorExists('.b-sub-menu .b-menu-content .b-menuitem:nth-child(4):contains(Subtask)', '4: Subtask');
      t.selectorExists('.b-sub-menu .b-menu-content .b-menuitem:nth-child(5):contains(Successor)', '5: Successor');
      t.selectorExists('.b-sub-menu .b-menu-content .b-menuitem:nth-child(6):contains(Predecessor)', '6: Predecessor');
    });
  });
  t.it('Sanity check of processItems', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskMenu: {
          processItems: ({
            items,
            taskRecord,
            column,
            event
          }) => {
            t.ok(items.editTask, 'Edit task item present');
            t.ok(items.add, 'Add item present');
            t.ok(items.convertToMilestone, 'Convert to milestone item present');
            t.ok(items.indent, 'Indent item present');
            t.ok(items.outdent, 'Outdent item present');
            t.ok(items.deleteTask, 'Delete task item present');
            t.ok(taskRecord.isTaskModel, 'Task record received');
            t.notOk(column, 'No column because clicked on the task element, not on grid cell');
            t.ok(event instanceof t.global.MouseEvent, 'MouseEvent received');
          }
        }
      }
    });
    const spy = t.spyOn(gantt.features.taskMenu, 'processItems').and.callThrough();
    t.chain({
      contextmenu: '.b-gantt-task.id11',
      desc: 'First menu is cancelled'
    }, {
      waitForSelector: '.b-menu-text',
      desc: 'A menu item is on the screen'
    }, async () => {
      t.expect(spy).toHaveBeenCalled(1);
    });
  }); // https://github.com/bryntum/support/issues/2297

  t.it('Should be possible to edit and disable submenu items', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskMenu: {
          items: {
            add: {
              menu: {
                addTaskAbove: false,
                successor: false,
                predecessor: false,
                addTaskBelow: {
                  text: 'Add below'
                }
              }
            }
          }
        }
      }
    });
    t.chain({
      contextmenu: '.b-gantt-task.id11',
      desc: 'First menu is cancelled'
    }, {
      waitForSelector: '.b-menu-text',
      desc: 'A menu item is on the screen'
    }, async () => {
      t.selectorCountIs('.b-menu-text', 6, '6 menu items are on the screen');
      t.selectorExists('.b-menu-content .b-menuitem:nth-child(1):contains(Edit)', '1: Edit');
      t.selectorExists('.b-menu-content .b-menuitem:nth-child(2):contains(Add...)', '2: Add...');
      t.selectorExists('.b-menu-content .b-menuitem:nth-child(3):contains(Convert to milestone)', '3: Convert to milestone');
      t.selectorExists('.b-menu-content .b-menuitem:nth-child(4):contains(Indent)', '4: Indent');
      t.selectorExists('.b-menu-content .b-menuitem:nth-child(5):contains(Outdent)', '5: Outdent');
      t.selectorExists('.b-menu-content .b-menuitem:nth-child(6):contains(Delete)', '6: Delete');
    }, {
      moveMouseTo: '.b-icon-add',
      offset: [130, 0]
    }, {
      waitForSelector: '.b-sub-menu .b-menu-text',
      desc: 'A submenu item is on the screen'
    }, async () => {
      t.selectorCountIs('.b-sub-menu .b-menu-text', 3, '3 submenu items are on the screen');
      t.selectorExists('.b-sub-menu .b-menu-content .b-menuitem:nth-child(1):contains(Add below)', '1: Add below (renamed Task below)');
      t.selectorExists('.b-sub-menu .b-menu-content .b-menuitem:nth-child(2):contains(Milestone)', '2: Milestone');
      t.selectorExists('.b-sub-menu .b-menu-content .b-menuitem:nth-child(3):contains(Subtask)', '4: Subtask');
    });
  });
  t.it('Should support being shown programmatically', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskMenu: true
      },
      listeners: {
        cellclick({
          event
        }) {
          gantt.showContextMenu(event, {
            anchor: true,
            target: event.target,
            align: 'l-r'
          });
        }

      }
    });
    await t.click('.b-tree-cell-value');
    await t.waitForSelector('.b-menu');
  }); // https://github.com/bryntum/support/issues/2834

  t.it('Should use icons defined with b-icon', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskMenu: true
      }
    });
    t.chain({
      rightClick: '.b-grid-row'
    }, {
      waitForElementVisible: '.b-icon-indent',
      desc: 'b-icon applied for indent item menu'
    }, {
      waitForElementVisible: '.b-icon-outdent',
      desc: 'b-icon applied for outdent item menu'
    }, next => {
      t.elementIsVisible('.b-icon-indent', 'Icon indent is visible');
      t.elementIsVisible('.b-icon-outdent', 'Icon outdent is visible');
      next();
    }, {
      click: '.b-menuitem[data-ref="add"]'
    }, {
      waitForElementVisible: '.b-icon-milestone:visible',
      desc: 'b-icon applied for milestone item menu'
    }, () => t.elementIsVisible('.b-icon-milestone:visible', 'Icon milestone is visible'));
  }); // https://github.com/bryntum/support/issues/3610

  t.it('Should disable any menuitems changing data when Gantt is readOnly', async t => {
    gantt = await t.getGanttAsync({
      readOnly: true,
      features: {
        taskMenu: true
      }
    });
    await t.rightClick('.b-grid-row');
    t.selectorNotExists('.b-menuitem:not(.b-disabled)');
  }); // https://github.com/bryntum/support/issues/3024

  t.it('TOUCH: Should hide context menu when task drag starts', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskMenu: true
      }
    });
    let fired;
    gantt.on('afterTaskDrop', () => fired = true);
    await t.waitForSelector('[data-task-id=11]');
    await t.waitForPropagate(gantt);
    t.touchStart('[data-task-id="11"]');
    await t.waitForSelector('.b-menu');
    await t.movePointerBy([100, 0]);
    await t.touchEnd();
    await t.waitForSelectorNotFound('.b-menu');
    await t.waitFor(() => fired);
  }); // https://github.com/bryntum/support/issues/665

  t.it('Should disable some items for readOnly task', async t => {
    gantt = await t.getGanttAsync();
    gantt.project.taskStore.getById(12).readOnly = true;
    await t.rightClick('[data-task-id="12"]');
    t.selectorExists('.b-disabled[data-ref=editTask]', 'Edit task disabled');
    t.selectorExists('.b-disabled[data-ref=convertToMilestone]', 'Convert to milestone disabled');
    t.selectorExists('.b-disabled[data-ref=indent]', 'Indent disabled');
    t.selectorExists('.b-disabled[data-ref=outdent]', 'Outdent disabled');
    t.selectorExists('.b-disabled[data-ref=deleteTask]', 'Delete task disabled');
  });
});