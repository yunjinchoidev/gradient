"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    return (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  });

  function checkSelected(t, id) {
    t.ok(gantt.getElementFromTaskRecord(gantt.taskStore.getById(id)).classList.contains('b-task-selected'), `Task ${id} has .b-task-selected class`);
  }

  function checkUnselected(t, id) {
    t.notOk(gantt.getElementFromTaskRecord(gantt.taskStore.getById(id)).classList.contains('b-task-selected'), `Task ${id} has no .b-task-selected class`);
  }

  t.it('Should select task on row select', async t => {
    gantt = await t.getGanttAsync({
      appendTo: document.body,
      durationDisplayPrecision: 0
    });
    t.chain(async () => {
      checkUnselected(t, '1');
    }, {
      click: '.b-grid-row.id1',
      desc: 'Click on row'
    }, {
      waitForSelector: '.b-task-selected'
    }, async () => {
      checkSelected(t, '1');
    }, {
      click: '.b-grid-subgrid-normal .b-grid-row.id11',
      desc: 'Click empty space'
    }, async () => {
      checkUnselected(t, '1');
      checkSelected(t, '11');
    });
  });
  t.it('Should select row on task click', async t => {
    gantt = await t.getGanttAsync({
      appendTo: document.body,
      durationDisplayPrecision: 0
    });
    t.chain(async () => {
      checkUnselected(t, '1');
    }, {
      click: '[data-task-id="12"]',
      desc: 'Click on task'
    }, async () => {
      checkSelected(t, '12');
    }, {
      click: '[data-task-id="13"]',
      options: {
        metaKey: true,
        ctrlKey: true
      },
      desc: 'Multiselect with ctrl click on task'
    }, async () => {
      checkSelected(t, '12');
      checkSelected(t, '13');
    });
  });
  t.it('Contextmenu should preserve selection', async t => {
    gantt = await t.getGanttAsync({
      appendTo: document.body,
      durationDisplayPrecision: 0,
      features: {
        taskTooltip: false
      }
    });
    t.chain(async () => {
      checkUnselected(t, '1');
    }, {
      click: '[data-task-id="12"]',
      desc: 'Click on task 12'
    }, async () => {
      checkSelected(t, '12');
    }, {
      click: '[data-task-id="13"]',
      options: {
        metaKey: true,
        ctrlKey: true
      },
      desc: 'Ctrl+click on task 13'
    }, async () => {
      checkSelected(t, '12');
      checkSelected(t, '13');
    }, {
      contextmenu: '[data-task-id="13"]',
      desc: 'Contextmenu on a multiselection of tasks'
    }, async () => {
      checkSelected(t, '12');
      checkSelected(t, '13');
    });
  });
  t.it('Should select task and not scroll on empty space click', async t => {
    const config = await ProjectGenerator.generateAsync(100, 30, () => {});
    gantt = await t.getGanttAsync({
      appendTo: document.body,
      project: config,
      startDate: config.startDate,
      endDate: config.endDate
    });
    gantt.subGrids.normal.scrollable.x = 300;
    t.chain({
      click: '.b-grid-subgrid-normal .b-grid-row[data-index="1"]'
    }, {
      waitForSelector: '.b-task-selected'
    }, next => {
      checkSelected(t, '2');
      t.is(gantt.subGrids.normal.scrollable.x, 300, 'Scroll position preserved');
      next();
    }, {
      click: '.b-grid-subgrid-normal .b-grid-row[data-index="2"]'
    }, next => {
      t.is(gantt.subGrids.normal.scrollable.x, 300, 'Scroll position preserved'); // Scroll to check selecting invisible tasks below

      gantt.subGrids.normal.scrollable.y = 1800;
      t.notOk(gantt.getElementFromTaskRecord(gantt.taskStore.getById('58')), 'Task is not rendered');
      next();
    }, {
      click: '.b-grid-row[data-index="52"]'
    }, next => {
      // Scroll to make task visible
      gantt.subGrids.normal.scrollable.x = 1000;
      next();
    }, () => {
      checkSelected(t, '58');
    });
  }); // https://github.com/bryntum/support/issues/429

  t.it('Should update task selection if project is reloaded', async t => {
    t.mockUrl('load', (url, params, options) => {
      return {
        responseText: JSON.stringify({
          success: true,
          revision: 1,
          tasks: {
            rows: t.getProjectTaskData()
          }
        })
      };
    });
    gantt = await t.getGanttAsync({
      project: {
        transport: {
          load: {
            url: 'load'
          }
        }
      }
    });
    gantt.selectedRecord = gantt.project.firstChild;
    await gantt.project.load();
    t.is(gantt.selectedRecord, gantt.project.firstChild, 'Selected parent node still selected after project reload');
    gantt.selectedRecord = gantt.project.taskStore.getById(11);
    await gantt.project.load();
    t.is(gantt.selectedRecord, gantt.project.taskStore.getById(11), 'Selected leaf node still selected after project reload');
  }); // https://github.com/bryntum/support/issues/495

  t.it('Should not fail on ctrl/cmd drag', async t => {
    gantt = await t.getGanttAsync();
    t.chain({
      action: 'drag',
      target: '[data-task-id="11"]',
      options: {
        ctrlKey: true
      },
      by: [100, 0]
    }, () => {
      t.is(gantt.selectedRecord, gantt.taskStore.getById(11), 'Selected record is correct');
    });
  });
  t.it('Should not fail on ctrl/cmd drag in case of multiselection', async t => {
    gantt = await t.getGanttAsync();
    const task11 = gantt.taskStore.getById(11),
          task12 = gantt.taskStore.getById(12);
    t.chain({
      click: '[data-task-id="12"]',
      ctrlKey: true
    }, {
      action: 'drag',
      target: '[data-task-id="11"]',
      options: {
        ctrlKey: true
      },
      by: [100, 0]
    }, () => {
      t.is(gantt.selectedRecord, task11, 'Selected record is correct');
      t.is(gantt.selectedRecords.length, 2, 'Selection is correct');
      t.is(gantt.selectedRecords[0], task12, 'First selected record is correct');
      t.is(gantt.selectedRecords[1], task11, 'Second selected record is correct');
    });
  });
  t.it('Should clear selection classes when scrolling the view', async t => {
    gantt = await t.getGanttAsync({
      height: 300,
      tasks: [{
        id: 1,
        name: 'Task 1',
        expanded: 1,
        children: (() => {
          const result = [];

          for (let i = 1; i <= 50; i++) {
            const id = 100 + i;
            result.push({
              id,
              name: `Task ${id}`,
              startDate: '2017-01-16',
              duration: 5
            });
          }

          return result;
        })()
      }],
      tbar: [{
        type: 'button',
        text: 'scroll',

        onClick() {
          const {
            rows
          } = gantt.rowManager;
          return gantt.scrollRowIntoView(rows[rows.length - 1].id, {
            block: 'start'
          });
        }

      }]
    });
    await t.waitForSelector('.b-gantt-task');
    await t.click('.b-grid-row[data-id="101"]');
    await t.waitForSelector('.b-task-selected');
    const {
      rows
    } = gantt.rowManager;
    await gantt.scrollRowIntoView(rows[rows.length - 1].id, {
      block: 'start'
    });
    await t.waitForSelectorNotFound('.b-task-selected');
    t.pass('Selected class removed');
  });
});