"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    return (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  });
  t.it('Basic resizing should work', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false
      }
    });
    await gantt.project.commitAsync();
    const task = gantt.taskStore.getById(11),
          el = gantt.getElementFromTaskRecord(task),
          initialWidth = gantt.getElementFromTaskRecord(task).offsetWidth,
          initialStart = task.startDate,
          initialEnd = task.endDate,
          initialDuration = task.duration,
          deltaX = gantt.tickSize * 2;
    t.chain({
      drag: '[data-task-id=11]',
      offset: ['100%-3', '5%'],
      by: [deltaX, 0]
    }, // Wait for drag to be finished
    {
      waitFor: () => !gantt.features.taskResize.dragging
    }, () => {
      t.is(task.startDate, initialStart, 'startDate unaffected');
      t.is(task.duration, initialDuration + 2, 'Correct duration after resize');
      t.is(task.endDate, DateHelper.add(initialEnd, 2, 'days'), 'Correct endDate after resize');
      t.isApprox(el.offsetWidth, initialWidth + deltaX, 'Correct element width after resize');
    });
  });
  t.it('Resize on the weekend should redraw the event in case of non-working time adjustment', async t => {
    gantt = await t.getGanttAsync({
      startDate: new Date(2019, 3, 15),
      project: {
        eventsData: [],
        startDate: new Date(2019, 3, 15)
      },
      features: {
        taskTooltip: false
      }
    });
    const {
      project
    } = gantt;
    await project.commitAsync(); // TODO: Remove this line after merge of #9033

    project.calendarManagerStore.getById('general').remove();
    project.calendarManagerStore.add({
      id: 'general',
      intervals: [{
        recurrentStartDate: 'on Sat at 0:00',
        recurrentEndDate: 'on Mon at 0:00',
        isWorking: false
      }]
    });
    const [task] = project.taskStore.add({
      id: 1,
      calendar: 'general',
      startDate: new Date(2019, 3, 15),
      endDate: new Date(2019, 3, 20)
    });
    await project.commitAsync(); // TODO: Project startDate seems wrong here also

    const initialStart = task.startDate,
          initialEnd = task.endDate,
          initialDuration = task.duration;
    let taskBoxRect;
    t.chain(async () => {
      taskBoxRect = t.rect('[data-task-id=1]');
    }, {
      drag: '[data-task-id=1]',
      offset: ['100%-3', '5%'],
      by: [gantt.tickSize * 1, 0]
    }, // Wait for drag to be finished
    {
      waitFor: () => !gantt.features.taskResize.dragging
    }, // Wait for event to animate back to the correct end point
    {
      waitFor: () => {
        const newRect = t.rect('[data-task-id=1]');
        return newRect.left === taskBoxRect.left && newRect.right === taskBoxRect.right;
      }
    }, async () => {
      t.is(task.startDate, initialStart, 'startDate unaffected');
      t.is(task.endDate, initialEnd, 'endDate unaffected');
      t.is(task.duration, initialDuration, 'Correct duration after resize');
      const newRect = t.rect('[data-task-id=1]');
      t.is(newRect.left, taskBoxRect.left, 'Task element did not change position');
      t.is(newRect.right, taskBoxRect.right, 'Task element did not change position');
    });
  });
  t.it('Should support resizing small elements without dragging them', async t => {
    gantt = await t.getGanttAsync({
      startDate: new Date(2019, 3, 8),
      project: {
        eventsData: [{
          id: 1,
          startDate: new Date(2019, 3, 15),
          endDate: new Date(2019, 3, 16)
        }],
        startDate: new Date(2019, 3, 8)
      },
      features: {
        taskTooltip: false
      }
    });
    t.wontFire(gantt, 'taskdragstart');
    t.chain({
      drag: '[data-task-id=1]',
      offset: ['100%-5', '5%'],
      by: [20, 0]
    }, // Wait for drag to be finished
    {
      waitFor: () => !gantt.features.taskResize.dragging
    });
  });
  t.it('Should revert drop that does not cause a data change', async t => {
    gantt = await t.getGanttAsync({
      project: {
        eventsData: [{
          id: 1,
          startDate: new Date(2019, 3, 15),
          endDate: new Date(2019, 3, 16)
        }],
        startDate: new Date(2019, 3, 8)
      },
      startDate: new Date(2019, 3, 8),
      features: {
        taskTooltip: false
      }
    });
    t.chain({
      drag: '[data-task-id=1]',
      offset: ['100%-5', '5%'],
      by: [-10, 0]
    }, // Wait for task bar to animate back to original width
    {
      waitFor: () => document.querySelector('[data-task-id="1"]').offsetWidth === 20
    }, // Wait for drag to be finished
    {
      waitFor: () => !gantt.features.taskResize.dragging
    });
  });
  t.it('Should revert drop that caused a scheduling conflict that was cancelled', async t => {
    gantt = await t.getGanttAsync({
      project: {
        startDate: new Date(2021, 5, 7),
        eventsData: [{
          id: 1,
          startDate: new Date(2021, 5, 7),
          endDate: new Date(2021, 5, 8)
        }, {
          id: 2,
          startDate: new Date(2021, 5, 8),
          endDate: new Date(2021, 5, 9),
          constraintType: 'muststarton',
          constraintDate: new Date(2021, 5, 8)
        }],
        dependenciesData: [{
          fromEvent: 1,
          toEvent: 2
        }],
        listeners: {
          schedulingConflict({
            continueWithResolutionResult
          }) {
            // cancel changes in case of a conflict
            continueWithResolutionResult('Cancel');
          }

        }
      },
      // we want to handle scheduling conflict in our custom listener
      schedulingConflictsPopup: false,
      startDate: new Date(2021, 5, 7),
      features: {
        taskTooltip: false
      }
    });
    await t.waitForSelector('[data-task-id=1]');
    const oldWidth = document.querySelector('[data-task-id="1"]').offsetWidth;
    await t.dragBy('[data-task-id=1]', [gantt.tickSize, 0], null, null, null, false, ['100%-5', '5%']);
    t.pass('task drag-resized');
    await t.click('label:textEquals(Cancel)');
    await t.waitFor(() => document.querySelector('[data-task-id="1"]').offsetWidth === oldWidth);
    t.pass('task element got back to its initial width');
  });
  t.it('TOUCH: Should show tooltip contents when resizing', async t => {
    gantt = await t.getGanttAsync({
      project: {
        eventsData: [{
          id: 1,
          startDate: new Date(2019, 3, 15),
          endDate: new Date(2019, 3, 19)
        }],
        startDate: new Date(2019, 3, 8)
      },
      startDate: new Date(2019, 3, 8),
      appendTo: document.body,
      features: {
        taskTooltip: false
      }
    });
    t.firesOnce(gantt, 'taskclick');
    t.chain({
      tap: '[data-task-id=1]'
    }, {
      touchDrag: '[data-task-id=1]',
      offset: ['100%-5', '50%'],
      by: [100, 0],
      dragOnly: true
    }, async () => t.selectorExists('.b-sch-tooltip-enddate:contains(Apr 17, 2019)'), {
      touchEnd: null
    }, // Wait for drag to be finished
    {
      waitFor: () => !gantt.features.taskResize.dragging
    });
  }); // https://github.com/bryntum/support/issues/2772

  t.it('Should not show resize cursor when feature is disabled', async t => {
    gantt = await t.getGanttAsync({
      project: {
        eventsData: [{
          id: 1,
          startDate: new Date(2019, 3, 15),
          endDate: new Date(2019, 3, 16)
        }],
        startDate: new Date(2019, 3, 8)
      },
      startDate: new Date(2019, 3, 8),
      features: {
        dependencies: false,
        taskResize: {
          disabled: true
        }
      }
    });
    await t.moveCursorTo('.b-gantt-task');
    await t.moveCursorTo('.b-gantt-task', null, null, ['100%-2', '50%']);
    await t.waitFor(1000);
    t.selectorNotExists('.b-resize-handle');
    t.selectorNotExists('.b-over-resize-handle');
    await t.moveCursorTo([0, 0]); // Now enable and ensure all works

    gantt.features.taskResize.disabled = false;
    await t.moveCursorTo('.b-gantt-task');
    await t.moveCursorTo('.b-gantt-task', null, null, ['100%-2', '50%']);
    t.selectorExists('.b-resize-handle');
    t.selectorExists('.b-over-resize-handle');
  });
  t.it('Should support using tooltipTemplate', async t => {
    gantt = await t.getGanttAsync({
      appendTo: document.body,
      startDate: new Date(2019, 3, 15),
      project: {
        startDate: new Date(2019, 3, 15),
        eventsData: [{
          id: 1,
          name: 'foo',
          startDate: new Date(2019, 3, 15),
          endDate: new Date(2019, 3, 19)
        }]
      },
      features: {
        taskResize: {
          tooltipTemplate: ({
            record,
            startDate,
            endDate
          }) => {
            t.is(record, gantt.taskStore.first, 'record ok');
            t.is(startDate, new Date(2019, 3, 15), 'Start date ok');
            t.isGreaterOrEqual(endDate, new Date(2019, 3, 19), 'End date ok');
            return record.name;
          }
        }
      }
    });
    t.chain({
      moveCursorTo: '[data-task-id=1]'
    }, {
      drag: '[data-task-id=1]',
      offset: ['100%-5', '50%'],
      by: [100, 0],
      dragOnly: true
    }, () => t.selectorExists('.b-tooltip:contains(foo)'));
  }); // https://github.com/bryntum/support/issues/2914

  t.it('Should not crash after destroying Gantt with tip config', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskResize: {
          tip: {}
        }
      }
    });
    gantt.destroy();
  });
  t.it('Should hide dependency terminals after task resize', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false
      },
      tasks: [{
        id: 11,
        expanded: true,
        children: [{
          id: 4,
          name: 'Foo',
          startDate: '2017-01-16',
          duration: 1,
          leaf: true
        }, {
          id: 5,
          name: 'Bar',
          startDate: '2017-01-17',
          duration: 1,
          leaf: true
        }]
      }],
      dependencies: [{
        from: 4,
        to: 5
      }]
    });
    await t.dragBy({
      source: '[data-task-id=4]',
      offset: ['100%-5', '50%'],
      delta: [100, 100]
    });
    t.selectorNotExists('.b-sch-terminal');
  });
  t.it('Should fire correct events', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false
      },
      tasks: [{
        id: 5,
        name: 'Bar',
        startDate: '2017-01-17',
        duration: 1,
        leaf: true
      }]
    });
    t.firesOnce(gantt, 'beforeTaskResize');
    t.firesOnce(gantt, 'taskResizeStart');
    t.firesAtLeastNTimes(gantt, 'taskPartialResize', 1);
    t.firesOnce(gantt, 'beforeTaskResizeFinalize');
    t.firesOnce(gantt, 'taskResizeEnd');
    gantt.on({
      taskResizeEnd({
        changed,
        taskRecord
      }) {
        t.ok(changed, 'changed');
        t.is(taskRecord, gantt.taskStore.first, 'taskRecord');
      }

    });
    await t.dragBy({
      source: '[data-task-id]',
      offset: ['100%-5', '50%'],
      delta: [100, 100]
    });
  }); // https://github.com/bryntum/support/issues/3750

  t.it('Resizing task end date should not set an end date constraint', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskTooltip: false
      }
    });
    await gantt.project.commitAsync();
    await t.dragBy({
      source: '[data-task-id=11]',
      offset: ['100%-5', '50%'],
      delta: [100, 0]
    });
    const task = gantt.taskStore.getById(11);
    t.notOk(task.constraintType, 'no constraint');
    t.notOk(task.constraintDate, 'no constraint date');
  });
  t.it('Should resize end date pinning successors', async t => {
    gantt = await t.getGanttAsync({
      features: {
        taskResize: {
          pinSuccessors: true
        }
      },
      project: {
        eventsData: [{
          id: 1,
          name: 'Task 1',
          expanded: true,
          children: [{
            id: 11,
            name: 'Task 11',
            duration: 1
          }, {
            id: 12,
            name: 'Task 12',
            duration: 1
          }, {
            id: 13,
            name: 'Task 13',
            duration: 1
          }]
        }],
        dependenciesData: [{
          id: 1,
          fromEvent: 11,
          toEvent: 12,
          type: 2
        }, {
          id: 2,
          fromEvent: 11,
          toEvent: 13,
          type: 3
        }]
      }
    });
    const {
      tickSize
    } = gantt,
          [,, task12, task13] = gantt.taskStore.getRange();
    await t.dragBy({
      source: '[data-task-id="11"]',
      delta: [tickSize * 2, 0],
      offset: ['100%-5', '50%'],
      options: {
        ctrlKey: true
      }
    });
    await gantt.project.commitAsync();
    t.is(task12.startDate, new Date(2017, 0, 17), 'Task 12 has not moved');
    t.is(task13.startDate, new Date(2017, 0, 16), 'Task 13 has not moved');
    await t.dragBy({
      source: '[data-task-id="11"]',
      delta: [tickSize, 0],
      offset: ['100%-5', '50%']
    });
    await gantt.project.commitAsync();
    t.is(task12.startDate, new Date(2017, 0, 18), 'Task 12 has not moved');
    t.is(task13.startDate, new Date(2017, 0, 17), 'Task 13 has not moved');
  });
});