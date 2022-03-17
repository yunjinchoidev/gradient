"use strict";

function ownKeys(object, enumerableOnly) { var keys = Object.keys(object); if (Object.getOwnPropertySymbols) { var symbols = Object.getOwnPropertySymbols(object); enumerableOnly && (symbols = symbols.filter(function (sym) { return Object.getOwnPropertyDescriptor(object, sym).enumerable; })), keys.push.apply(keys, symbols); } return keys; }

function _objectSpread(target) { for (var i = 1; i < arguments.length; i++) { var source = null != arguments[i] ? arguments[i] : {}; i % 2 ? ownKeys(Object(source), !0).forEach(function (key) { _defineProperty(target, key, source[key]); }) : Object.getOwnPropertyDescriptors ? Object.defineProperties(target, Object.getOwnPropertyDescriptors(source)) : ownKeys(Object(source)).forEach(function (key) { Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key)); }); } return target; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

StartTest(t => {
  let gantt, lineFeature;
  t.resetCursorPosition = false;
  const statusDate = new Date(2019, 1, 4); // In some tests we do live updates of the view and try to use common assertion methods which rely on data.
  // Since data is not always updated we use this dates cache to let test know of the desired data state.
  // e.g. when we drag task over status date and do not release mouse button

  let dateOverrides;
  t.beforeEach(() => {
    var _gantt;

    (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
    dateOverrides = {};
  });

  function id(id) {
    return gantt.taskStore.getById(id);
  }

  function processLineBox(el) {
    const currentLineBox = t.getSVGBox(el),
          result = {
      y1: currentLineBox.top,
      y2: currentLineBox.bottom
    },
          currentAttrs = {
      x1: parseInt(el.getAttribute('x1'), 10),
      y1: parseInt(el.getAttribute('y1'), 10),
      x2: parseInt(el.getAttribute('x2'), 10),
      y2: parseInt(el.getAttribute('y2'), 10)
    };

    if (currentAttrs.x2 < currentAttrs.x1) {
      result.x1 = currentLineBox.right;
      result.x2 = currentLineBox.left;
    } else {
      result.x1 = currentLineBox.left;
      result.x2 = currentLineBox.right;
    }

    return result;
  }

  function assertLine(t, box1, box2) {
    const result = Object.keys(box1).every(key => {
      return Math.abs(Math.round(box1[key]) - Math.round(box2[key])) <= 1;
    });

    if (result) {
      t.pass('Line segment is ok');
    } else {
      t.isDeeply(box1, box2);
    }
  }

  function assertTaskLines(t, task) {
    t.diag('Asserting lines for task ' + task.name);
    const scrollLeft = gantt.scrollLeft,
          rowEl = gantt.getRowFor(task).elements.normal,
          rowBox = rowEl.getBoundingClientRect(),
          maxX = rowEl.querySelector('.b-sch-timeaxis-cell').getBoundingClientRect().right,
          statusDateX = gantt.getCoordinateFromDate(lineFeature.statusDate),
          statusLineX = (statusDateX === -1 ? gantt.timeAxisViewModel.totalSize : statusDateX) - scrollLeft + gantt.subGrids.normal.element.getBoundingClientRect().left,
          lines = document.querySelectorAll(`.b-gantt-progress-line[data-task-id="${task.id}"]`); // if the task should be rendered as a vertical Status line

    if (lineFeature.isStatusLineTask(task, dateOverrides[task.id])) {
      const element = gantt.getElementFromTaskRecord(task),
            progressBarEl = element.querySelector('.b-task-percent-bar') || element,
            barBox = progressBarEl.getBoundingClientRect(),
            linePoint = {
        x: Math.min(barBox.right, maxX),
        y: barBox.top + barBox.height / 2
      },
            lineBox1 = processLineBox(lines[0]),
            lineBox2 = processLineBox(lines[1]),
            expectedBox1 = {
        x1: statusLineX,
        y1: rowBox.top,
        x2: linePoint.x,
        y2: linePoint.y
      },
            expectedBox2 = {
        x1: linePoint.x,
        y1: linePoint.y,
        x2: statusLineX,
        y2: rowBox.bottom
      }; // Milestone assertions in a separate test below

      if (!task.isMilestone) {
        assertLine(t, lineBox1, expectedBox1);
        assertLine(t, lineBox2, expectedBox2);
      }

      t.is(lines.length, 2, 'Correct amount of lines for task');
    } else {
      // x2 - status date x, y2 - row bottom
      assertLine(t, processLineBox(lines[0]), {
        x1: statusLineX,
        y1: rowBox.top,
        x2: statusLineX,
        y2: rowBox.bottom
      });
      t.is(lines.length, 1, 'Correct amount of lines for task');
    }
  }

  function assertLines(t) {
    t.resetCursorPosition = false;
    t.subTest('Asserting all the lines', t => {
      const tasks = gantt.taskStore.getRange(),
            lines = document.querySelectorAll('.b-gantt-progress-line');
      let count = 0;
      tasks.forEach(task => {
        if (gantt.getRowFor(task)) {
          assertTaskLines(t, task);
          count += lineFeature.isStatusLineTask(task, dateOverrides[task.id]) ? 2 : 1;
        }
      });
      t.is(count, lines.length, 'All lines are checked');
    });
  }

  async function setup(config = {}) {
    gantt = await t.getGanttAsync(_objectSpread({
      features: {
        progressLine: {
          statusDate
        }
      },
      startDate: '2019-01-12',
      endDate: '2019-03-24',
      project: new ProjectModel({
        autoLoad: true,
        // Tests needs refactoring to work with early rendering
        delayCalculation: false,
        transport: {
          load: {
            url: '../examples/_datasets/launch-saas.json'
          }
        }
      }),
      taskRenderer: ({
        taskRecord,
        renderData
      }) => {
        renderData.cls.add(`id${taskRecord.id}`);
      }
    }, config));
    lineFeature = gantt.features.progressLine;
  }

  t.it('Should draw progress line', async t => {
    await setup();
    t.chain({
      waitForSelector: '.b-gantt-progress-line'
    }, next => {
      assertLines(t);
      t.waitForEvent(gantt, 'progressLineDrawn', next);
      gantt.collapse(id(2));
    }, next => {
      assertLines(t);
      t.waitForEvent(gantt, 'progressLineDrawn', next);
      gantt.expand(id(2));
    }, () => {
      assertLines(t);
    });
  });
  t.it('Tasks are reachable under progress line', async t => {
    await setup();
    t.chain({
      waitForPropagate: gantt
    }, {
      waitForSelector: '.b-gantt-progress-line',
      desc: 'Progress line found'
    }, next => {
      assertLines(t);
      next();
    }, {
      drag: '.id12 .b-task-percent-bar',
      fromOffset: ['100%', '50%'],
      by: [25, 0],
      desc: 'Drag task by the progress line'
    }, function () {
      t.is(id(12).startDate, new Date(2019, 0, 15), 'Task dragged correctly');
    });
  });
  t.it('Progress line should react on task store events', async t => {
    await setup();
    await t.waitForPropagate(gantt);
    await t.waitForSelector('.b-gantt-progress-line');
    t.diag('Set percent to 50');
    const task = id(21);
    task.setPercentDone(50);
    await gantt.await('progressLineDrawn');
    assertLines(t);
    t.diag('Set percent to 0');
    task.setPercentDone(0);
    await gantt.await('progressLineDrawn');
    assertLines(t);
    t.diag('Move task to 24');
    task.setStartDate(new Date(2019, 0, 24));
    await gantt.await('progressLineDrawn');
    assertLines(t);
    t.diag('Move task to 30');
    task.setEndDate(new Date(2019, 0, 30));
    await gantt.await('progressLineDrawn');
    assertLines(t);
    t.diag('Convert to milestone');
    const linesCount = document.querySelectorAll('.b-gantt-progress-line').length; // make sure the event still ends on the same date, by increasing the incoming dependency lag
    // this in turn ensures that only directly related progress lines will change

    id(22).duration = 0;
    Array.from(id(22).incomingDeps)[0].setLag(1);
    await gantt.await('progressLineDrawn');
    assertLines(t);
    t.is(document.querySelectorAll('.b-gantt-progress-line').length, linesCount, 'Line count is intact');
    t.diag('Set percent to 100');
    task.setPercentDone(100);
    await gantt.await('progressLineDrawn');
    assertLines(t);
    t.diag('Append child');
    id(2).appendChild([{
      id: 26,
      startDate: '2019-06-17',
      duration: 5,
      percentDone: 40
    }, {
      id: 27,
      startDate: '2019-06-18',
      duration: 0,
      percentDone: 0
    }, {
      id: 28,
      startDate: '2019-06-17',
      duration: 5,
      percentDone: 40
    }]);
    await gantt.await('progressLineDrawn');
    assertLines(t);
    t.diag('Remove task');
    gantt.taskStore.remove(id(26));
    await gantt.await('progressLineDrawn');
    assertLines(t);
    t.diag('Remove several tasks');
    gantt.taskStore.remove([id(27), id(28)]);
    await gantt.await('progressLineDrawn');
    assertLines(t);
  });
  t.it('Progress line should react to view changes', async t => {
    await setup({
      height: 300
    });
    t.chain({
      waitForPropagate: gantt
    }, {
      waitForSelector: '.b-gantt-progress-line',
      desc: 'Progress line found'
    }, next => {
      assertLines(t);
      t.waitForEvent(gantt, 'progresslinedrawn', next);
      gantt.shiftPrevious();
    }, next => {
      assertLines(t);
      t.waitForEvent(gantt.subGrids.normal.scrollable, 'scrollEnd', next);
      gantt.zoomOut();
    }, next => {
      assertLines(t);
      t.waitForEvent(gantt.subGrids.normal.scrollable, 'scrollEnd', next);
      const newViewPreset = gantt.normalizePreset('weekAndDayLetter');
      newViewPreset.options = {
        startDate: new Date(2019, 0, 13),
        endDFate: new Date(2019, 0, 27)
      };
      gantt.viewPreset = newViewPreset;
    }, next => {
      assertLines(t);
      t.waitForEvent(gantt.subGrids.normal.scrollable, 'scrollend', next);
      gantt.zoomOut();
    }, next => {
      assertLines(t);
      t.waitFor(() => gantt.scrollTop === 100, () => {
        t.waitForEvent(gantt, 'progresslinedrawn', next);
        id(12).setStartDate(new Date(2019, 0, 17));
      });
      gantt.scrollTop = 100;
    }, () => {
      assertLines(t);
    });
  });
  t.it('Should draw line correctly on vertical scroll', async t => {
    await setup();
    await t.waitForSelector('.b-gantt-progress-line');
    assertLines(t);
    gantt.scrollTop = 800;
    await gantt.scrollable.await('scrollEnd').then(() => gantt.await('progressLineDrawn'));
    assertLines(t);
  });
  t.it('Progress line is updated on drag', async t => {
    await setup({
      features: {
        progressLine: {
          statusDate
        },
        taskTooltip: false
      }
    });
    let lineEl;

    function assertLineIsTop() {
      const box = t.getSVGBox(lineEl);
      t.is(document.elementFromPoint(Math.round(box.left), Math.round(box.top)), lineEl, 'Line is on top');
    }

    t.chain({
      waitForPropagate: gantt
    }, {
      waitFor: () => document.querySelectorAll('.b-gantt-progress-line[data-task-id="11"]').length > 1
    }, {
      waitFor: 100
    }, next => {
      lineEl = document.querySelectorAll('.b-gantt-progress-line[data-task-id="11"]')[1];
      lineEl.style.pointerEvents = 'all';
      assertLineIsTop();
      next();
    }, {
      moveMouseTo: '.b-gantt-task.id11',
      offset: [10, '50%']
    }, next => {
      assertLineIsTop();
      next();
    }, {
      click: '.b-gantt-task.id11',
      offset: [10, '50%']
    }, next => {
      assertLineIsTop();
      next();
    }, {
      drag: '.b-gantt-task.id11',
      offset: [20, '50%'],
      by: [100, 0],
      dragOnly: true
    }, next => {
      assertLines(t);
      next();
    }, {
      mouseUp: null
    }, {
      drag: '.b-gantt-task.id15',
      by: [gantt.tickSize * 7, 0],
      dragOnly: true
    }, next => {
      dateOverrides[15] = new Date(2019, 1, 4);
      assertLines(t);
      next();
    }, {
      moveMouseBy: [gantt.tickSize, 0]
    }, next => {
      dateOverrides[15] = new Date(2019, 1, 5);
      assertLines(t);
      next();
    }, {
      mouseUp: null
    });
  });
  t.it('Progress line works properly on a large time axis', async t => {
    await setup();
    await t.waitForPropagate(gantt);
    await t.waitForEventOnTrigger(gantt.subGrids.normal.scrollable, 'scrollend', async () => {
      gantt.viewPreset = 'weekAndDay';
    });
    await t.waitForSelector('[data-task-id="11"]');
    t.diag('Scroll task 11 to view');
    await t.waitForEventOnTrigger(gantt, 'progresslinedrawn', async () => {
      await gantt.scrollTaskIntoView(id(11));
    });
    await t.waitForAnimationFrame(null);
    assertLines(t);
    t.diag('Scroll task 4015 to view');
    await t.waitForEventOnTrigger(gantt, 'progresslinedrawn', async () => {
      await gantt.scrollTaskIntoView(id(4015));
    });
    await t.waitForAnimationFrame(null);
    assertLines(t);
  });
  t.it('Progress line could be changed', async t => {
    await setup();
    const date = new Date(2019, 1, 6);
    t.chain({
      waitForPropagate: gantt
    }, {
      waitForSelector: '.b-gantt-progress-line'
    }, next => {
      t.waitForEvent(gantt, 'progresslinedrawn', next);
      lineFeature.statusDate = date;
    }, next => {
      t.is(lineFeature.statusDate, date, 'Status date changed');
      assertLines(t);
    });
  });
  t.it('Should support disabling', async t => {
    await setup();
    gantt.features.progressLine.disabled = true;
    t.selectorNotExists('.b-gantt-progress-line', 'No progress line');
    gantt.features.progressLine.disabled = false;
    t.chain({
      waitForSelector: '.b-gantt-progress-line',
      desc: 'Progress line found'
    });
  });
  t.it('Should redraw progress line after cancelled drag drop', async t => {
    await setup();
    t.chain({
      waitForPropagate: gantt
    }, {
      waitForSelector: '.b-gantt-progress-line',
      desc: 'Progress line found'
    }, {
      waitForSelectorNotFound: '.b-readonly'
    }, {
      drag: '.id11.b-gantt-task',
      by: [100, 0],
      dragOnly: true
    }, async () => {
      await Promise.all([gantt.await('progressLineDrawn', false), t.type(null, '[ESC]')]);
      assertLines(t);
    });
  });
  t.it('Should not crash if schedule subgrid is collapsed', async t => {
    console.log = () => {};

    gantt = t.getGantt({
      features: {
        progressLine: true
      },
      subGridConfigs: {
        locked: {
          flex: 1
        },
        normal: {
          collapsed: true
        }
      }
    });
    t.chain({
      waitForPropagate: gantt
    }, async () => t.pass('no crash'), async () => gantt.subGrids.normal.expand(), {
      waitForSelector: '.b-gantt-progress-line'
    });
  }); // https://github.com/bryntum/support/issues/3264

  t.it('Should paint line correctly for milestones', async t => {
    await setup({
      project: {
        startDate: new Date(2019, 0, 14),
        tasksData: [{
          id: 11,
          name: 'Task 11',
          startDate: '2019-01-14',
          duration: 0
        }, {
          id: 12,
          name: 'Task 12',
          startDate: '2019-02-05',
          duration: 0,
          percentDone: 100
        }, {
          id: 13,
          name: 'Task 13',
          startDate: '2019-02-24',
          duration: 0,
          percentDone: 99.9
        }, {
          id: 14,
          name: 'Task 14',
          startDate: '2019-02-24',
          duration: 0,
          percentDone: 100
        }]
      }
    });
    await t.waitForSelector('line[data-task-id=11]'); // Safari needs time to draw all lines

    await t.waitForAnimationFrame(); // Milestones are either 0 progress or fully done so we draw to either left edge or right edge of the diamond

    const task11Lines = t.query('line[data-task-id=11]'),
          task12Lines = t.query('line[data-task-id=12]'),
          task13Lines = t.query('line[data-task-id=13]'),
          task14Lines = t.query('line[data-task-id=14]');
    t.selectorCountIs('line[data-task-id=11]', 2, '2 lines for task 11 since it is NOT completed');
    t.isApprox(parseInt(task11Lines[1].getAttribute('x1'), 10), gantt.timeAxisViewModel.getPositionFromDate(gantt.taskStore.getById(11).startDate) - 15, 'Line should draw to milestone start ');
    t.is(task11Lines[0].getAttribute('x2'), task11Lines[1].getAttribute('x1'), '2 task lines should meet at same point');
    t.selectorCountIs('line[data-task-id=12]', 1, 'vertical straight line for task 12 since it is completed');
    t.isApprox(parseInt(task12Lines[0].getAttribute('x1'), 10), gantt.timeAxisViewModel.getPositionFromDate(statusDate) - 15, 'Line should draw to statusDate for completed task');
    t.selectorCountIs('line[data-task-id=13]', 2, '2 lines for task 13 since it is NOT completed');
    t.is(task13Lines[0].getAttribute('x2'), task13Lines[1].getAttribute('x1'), '2 task lines should meet at same point');
    t.isApprox(parseInt(task13Lines[1].getAttribute('x1'), 10), gantt.timeAxisViewModel.getPositionFromDate(gantt.taskStore.getById(13).startDate) - 15, 'Line should draw to milestone start ');
    t.selectorCountIs('line[data-task-id=14]', 1, 'vertical straight line for task 14 since it is completed');
    t.isApprox(parseInt(task14Lines[0].getAttribute('x1'), 10), gantt.timeAxisViewModel.getPositionFromDate(statusDate) - 15, 'Line should draw to statusDate for completed task');
  });
  t.it('Should not paint progress for inactive tasks', async t => {
    await setup({
      project: {
        startDate: '2019-01-14',
        tasksData: [{
          id: 11,
          name: 'Task 11',
          startDate: '2019-01-14',
          duration: 2
        }, {
          id: 12,
          name: 'Task 12',
          startDate: '2019-01-14',
          duration: 2,
          percentDone: 100
        }, {
          id: 13,
          name: 'Task 13',
          startDate: '2019-01-14',
          duration: 2,
          inactive: true
        }, {
          id: 14,
          name: 'Task 14',
          startDate: '2019-01-14',
          duration: 2,
          inactive: true
        }]
      }
    });
    await t.waitForSelector('line[data-task-id=11]'); // Safari needs time to draw all lines

    await t.waitForAnimationFrame(); // Milestones are either 0 progress or fully done so we draw to either left edge or right edge of the diamond

    const task11Lines = t.query('line[data-task-id=11]'),
          task12Lines = t.query('line[data-task-id=12]'),
          task13Lines = t.query('line[data-task-id=13]'),
          task14Lines = t.query('line[data-task-id=14]');
    t.selectorCountIs('line[data-task-id=11]', 2, '2 lines for task 11 since it is NOT completed');
    t.isApprox(parseInt(task11Lines[1].getAttribute('x1'), 10), gantt.timeAxisViewModel.getPositionFromDate(gantt.taskStore.getById(11).startDate), 'Line should draw to the task start since it`s not started yet');
    t.is(task11Lines[0].getAttribute('x2'), task11Lines[1].getAttribute('x1'), '2 task lines should meet at same point');
    t.selectorCountIs('line[data-task-id=12]', 1, 'vertical straight line for task 12 since it is completed');
    t.isApprox(parseInt(task12Lines[0].getAttribute('x1'), 10), gantt.timeAxisViewModel.getPositionFromDate(statusDate), 'Line should draw to statusDate for completed task');
    t.selectorCountIs('line[data-task-id=13]', 1, 'vertical straight line for task 13 since it is inactive');
    t.isApprox(parseInt(task13Lines[0].getAttribute('x1'), 10), gantt.timeAxisViewModel.getPositionFromDate(statusDate), 'Line should draw to statusDate for inactive task');
    t.selectorCountIs('line[data-task-id=14]', 1, 'vertical straight line for task 14 since it is inactive');
    t.isApprox(parseInt(task14Lines[0].getAttribute('x1'), 10), gantt.timeAxisViewModel.getPositionFromDate(statusDate), 'Line should draw to statusDate for inactive task');
  });
});