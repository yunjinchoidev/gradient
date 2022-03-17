"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    return (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  });
  t.it('Basic dragging should work', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false
      }
    });
    const task = gantt.taskStore.getById(11),
          taskSelector = `[data-task-id=${task.id}]`,
          initialX = t.rect(taskSelector).left,
          initialStart = task.startDate,
          deltaX = gantt.tickSize * 2;
    await t.dragBy({
      source: taskSelector,
      delta: [deltaX, 0],
      dragOnly: true
    });
    t.selectorExists('.b-gantt.b-dragging-task');
    await t.mouseUp();
    t.is(task.startDate, DateHelper.add(initialStart, 2, 'days'), 'Correct startDate after drag');
    t.isApproxPx(t.rect(taskSelector).left, initialX + deltaX, 'Correct x after drag');
    await t.waitForSelectorNotFound('.b-gantt.b-dragging-task');
  });
  t.it('Dragging a parent in a big data set should work', async t => {
    const config = await ProjectGenerator.generateAsync(500, 50, () => {});
    gantt = await t.getGanttAsync({
      project: config,
      startDate: config.startDate,
      endDate: config.endDate,
      features: {
        taskTooltip: false
      }
    }); // remember initial left coordinate

    const initialPosition = Rectangle.from(document.querySelector('[data-task-id="2"]'), gantt.timeAxisSubGridElement).x;
    await t.dragBy({
      source: '[data-task-id="2"]',
      delta: [100, 0]
    });
    await gantt.project.commitAsync();
    t.isApprox(Rectangle.from(document.querySelector('[data-task-id="2"]'), gantt.timeAxisSubGridElement).x, initialPosition + 100, 'Correct position');
  });
  t.it('Dragging a task to before the project start date should fail and reset', async t => {
    const config = await ProjectGenerator.generateAsync(500, 50, () => {});
    gantt = await t.getGanttAsync({
      project: config,
      // Create space to the left to drag into
      startDate: DateHelper.add(config.startDate, -7, 'days'),
      endDate: config.endDate,
      features: {
        taskTooltip: false,
        projectLines: true
      }
    });
    const startX = document.querySelector('[data-task-id="3"]').getBoundingClientRect().left;
    t.chain( // Drag to before project start date
    {
      drag: '[data-task-id="3"]',
      by: [-100, 0],
      desc: 'Dragging to before project start date'
    }, {
      waitForPropagate: gantt.project
    }, {
      waitFor: () => document.querySelector('[data-task-id="3"]').getBoundingClientRect().left - startX < 1,
      desc: 'Task reverted to original position'
    });
  });
  t.it('Should live ok when dragging outside of timeline view', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false
      }
    });
    t.chain({
      drag: '.b-gantt-task.id12',
      to: '.id12'
    }, {
      drag: '.b-gantt-task.id12',
      to: '.b-sch-header-timeaxis-cell'
    });
  });
  t.it('Should reschedule project after task reordering', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false
      }
    });
    t.chain({
      drag: '.id13',
      to: '.id21',
      toOffset: [50, 10]
    }, {
      waitFor: () => {
        const task1 = gantt.taskStore.getById(13),
              task2 = gantt.taskStore.getById(2);
        return task1.parent === task2 && task2.startDate.getTime() === task1.startDate.getTime();
      }
    });
  });
  t.it('Dragging should drag the real task element', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false
      }
    });
    const task = gantt.taskStore.getById(11),
          taskEl = gantt.getElementFromTaskRecord(task).parentNode,
          taskSelector = `[data-task-id=${task.id}]`,
          initialX = t.rect(taskSelector).left,
          initialStart = task.startDate,
          deltaX = gantt.tickSize * 2;
    t.chain({
      drag: taskSelector,
      by: [deltaX, 0],
      dragOnly: true
    }, (next, el) => {
      const taskEls = Array.from(document.querySelectorAll('[data-task-id="11"]')); // Task element must not be duplicated

      t.is(taskEls.length, 1); // All references to a task bar must reference the real task's element.

      t.is(gantt.features.taskDrag.dragData.eventBarEls[0], taskEl);
      t.is(taskEls[0], taskEl);
      t.isApproxPx(el.getBoundingClientRect().left, initialX + deltaX, 'Correct x after drag');
      next();
    }, {
      mouseUp: null
    }, () => {
      t.is(task.startDate, DateHelper.add(initialStart, 2, 'days'), 'Correct startDate after drag');
    });
  });
  t.it('Dragging task and moving mouse over the timeline widget should not crash', async t => {
    new Timeline({
      project: t.getProject(),
      appendTo: document.body
    });
    gantt = await t.getGanttAsync();
    await t.dragTo({
      source: '.b-gantt-task',
      target: '.b-timeline'
    });
    t.pass('Did not crash');
  }); // https://github.com/bryntum/support/issues/860

  t.it('Dragging task with dependency to filtered out task should not crash', async t => {
    gantt = await t.getGanttAsync(); // This leaves one event with predecessors and successor filtered out

    gantt.taskStore.filterBy(task => task.name.match(/report/i));
    t.firesOnce(gantt, 'taskdrop');
    t.chain({
      drag: '.b-milestone-wrap',
      by: [100, 0]
    });
  }); // https://github.com/bryntum/support/issues/2773

  t.it('Should drag task with dependencies + resizing disabled', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskResize: false
      }
    });
    t.firesOnce(gantt, 'taskdrop');
    t.chain({
      drag: '.b-gantt-task',
      by: [100, 0]
    });
  });
  t.it('Should be possible to use custom tooltipTemplate', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskDrag: {
          // Custom tooltip for when an event is dragged
          tooltipTemplate: ({
            taskRecord,
            startDate: newStartDate,
            endDate: newEndDate
          }) => {
            t.is(taskRecord, taskRecord.taskStore.getById(11), 'taskRecord date ok');
            t.isGreaterOrEqual(newStartDate, startDate, 'Start date ok');
            t.isGreaterOrEqual(newEndDate, endDate, 'End date ok');
            return 'foo';
          }
        }
      }
    });
    const {
      startDate,
      endDate
    } = gantt.taskStore.getById(11);
    t.chain({
      drag: '[data-task-id="11"]',
      by: [100, 0],
      dragOnly: true
    }, () => {
      t.selectorExists('.b-tooltip:contains(foo)', 'Custom tooltip used');
    });
  }); // https://github.com/bryntum/support/issues/3599

  t.it('Should not be possible to drag when Gantt is readOnly', async t => {
    gantt = await t.getGanttAsync({
      readOnly: true
    });
    t.wontFire(gantt, 'taskDragStart');
    await t.dragBy({
      source: '[data-task-id="11"]',
      delta: [100, 0]
    });
  }); // https://github.com/bryntum/support/issues/2636

  t.it('Should finalize drop properly if dragging straight up (which results in proxy not moving)', async t => {
    gantt = await t.getGanttAsync();
    await t.dragBy({
      source: '.id12.b-gantt-task',
      delta: [0, -1.5 * gantt.rowHeight]
    });
    const taskEl = gantt.getElementFromTaskRecord(gantt.taskStore.getById(12));
    t.notOk(taskEl.retainElement, 'Not retaining task element');
    t.notOk(taskEl.parentElement.retainElement, 'Not retaining wrapper element');
  }); // https://github.com/bryntum/support/issues/3807

  t.it('Should not trigger beforeTaskDrag on mouse down', async t => {
    gantt = await t.getGanttAsync();
    t.wontFire(gantt, 'beforeTaskDrag');
    await t.click('[data-task-id="11"]');
  });
  t.it('Should fire correct events', async t => {
    gantt = await t.getGanttAsync();
    t.firesOnce(gantt, 'beforetaskdrag');
    t.firesAtLeastNTimes(gantt, 'taskDrag', 2);
    t.firesOnce(gantt, 'beforetaskdropfinalize');
    t.firesOnce(gantt, 'taskdrop');
    gantt.on('beforetaskdropfinalize', ({
      context
    }) => {
      const {
        taskRecords,
        valid
      } = context;
      t.isDeeply(taskRecords, [gantt.taskStore.getById(11)], 'taskRecords present');
      t.is(valid, true, 'valid present');
    });
    await t.dragBy({
      source: '[data-task-id="11"]',
      delta: [100, 0]
    });
  }); // https://github.com/bryntum/support/issues/665

  t.it('Should prevent dragging readOnly task', async t => {
    gantt = await t.getGanttAsync();
    gantt.project.taskStore.getById(12).readOnly = true;
    t.wontFire(gantt, 'beforeTaskDrag');
    await t.dragBy({
      source: '.id12.b-gantt-task',
      delta: [200, 0]
    });
  }); // https://github.com/bryntum/support/issues/3808

  t.it('Dragging w/ conflicts popup should not throw exception after browser looses focus', async t => {
    gantt = await t.getGanttAsync({
      startDate: new Date(2018, 1, 21, 11),
      endDate: null,
      project: {
        startDate: new Date(2018, 1, 21, 11),
        tasksData: [{
          id: 'event0',
          name: 'event0',
          startDate: new Date(2018, 1, 21, 11),
          duration: 2
        }, {
          id: 'event1',
          name: 'event1',
          startDate: new Date(2018, 1, 21, 11),
          duration: 1,
          constraintType: 'muststarton',
          constraintDate: new Date(2018, 1, 21, 11)
        }],
        dependenciesData: [{
          fromEvent: 'event0',
          toEvent: 'event1',
          type: 0
        }]
      },
      features: {
        taskTooltip: false
      }
    });
    await t.dragBy({
      source: '[data-task-id=event0]',
      delta: [gantt.tickSize * 2, 0]
    });
    await t.waitForSelector('.b-schedulerpro-issueresolutionpopup header :contains(Scheduling conflict)'); // emulate window loosing focus

    t.global.dispatchEvent(new Event('blur'));
    await t.click('button:contains(Cancel)');
  });
  t.it('Should move task pinning successors', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskDrag: {
          pinSuccessors: true
        }
      }
    });
    const {
      tickSize
    } = gantt,
          task14 = gantt.taskStore.getById(14);
    await t.dragBy({
      source: '.b-gantt-task.id12',
      delta: [tickSize * 3, 0],
      options: {
        ctrlKey: true
      }
    });
    await gantt.project.commitAsync();
    t.is(task14.startDate, new Date(2017, 0, 26), 'Task 14 is not moved');
    await t.dragBy({
      source: '.b-gantt-task.id12',
      delta: [tickSize, 0]
    });
    await gantt.project.commitAsync();
    t.is(task14.startDate, new Date(2017, 0, 27), 'Task 14 is moved');
  });
  t.it('Should update pinSuccessors', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskDrag: {
          pinSuccessors: 'alt'
        }
      }
    });
    const {
      tickSize
    } = gantt,
          task14 = gantt.taskStore.getById(14);
    await t.dragBy({
      source: '.b-gantt-task.id12',
      delta: [tickSize * 3, 0],
      options: {
        altKey: true
      }
    });
    await gantt.project.commitAsync();
    t.is(task14.startDate, new Date(2017, 0, 26), 'Task 14 is not moved');
    gantt.features.taskDrag.pinSuccessors = 'shift';
    await t.dragBy({
      source: '.b-gantt-task.id12',
      delta: [tickSize, 0],
      options: {
        shiftKey: true
      }
    });
    await gantt.project.commitAsync();
    t.is(task14.startDate, new Date(2017, 0, 26), 'Task 14 is not moved'); // Set wrong name to disable the feature

    gantt.features.taskDrag.pinSuccessors = 'sshift';
    t.is(gantt.features.taskDrag.pinSuccessors, false, 'Pinning successors is disabled');
    await t.dragBy({
      source: '.b-gantt-task.id12',
      delta: [tickSize, 0],
      options: {
        ctrlKey: true,
        shiftKey: true
      }
    });
    await gantt.project.commitAsync();
    t.is(task14.startDate, new Date(2017, 0, 27), 'Task 14 is moved');
  });
  t.it('Should be able to block a drop by setting valid to false in beforetaskdropfinalize listener', async t => {
    gantt = t.getGantt();
    t.firesOnce(gantt, 'beforetaskdropfinalize');
    t.wontFire(gantt, 'taskdrop');
    gantt.on('beforetaskdropfinalize', ({
      context
    }) => {
      context.valid = false;
    });
    await t.waitForSelector('[depId="1"]');
    const dependencyPointsBeforeDrag = Array.from(t.query('[depId="1"]')[0].points);
    await t.dragBy({
      source: '[data-task-id="11"]',
      delta: [100, 0]
    });
    await t.waitForSelectorNotFound('.b-dragging, b-invalid, .b-aborting');
    await t.waitFor(() => {
      return dependencyPointsBeforeDrag.every((point, i) => {
        const currentPoint = Array.from(t.query('[depId="1"]')[0].points)[i];
        return Math.round(currentPoint.x) === Math.round(dependencyPointsBeforeDrag[i].x) && Math.round(currentPoint.y) === Math.round(dependencyPointsBeforeDrag[i].y);
      });
    });
    t.pass('Dependency refreshed to initial state');
  });
});