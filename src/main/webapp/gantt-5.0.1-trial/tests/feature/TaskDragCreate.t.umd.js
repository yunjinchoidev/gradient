"use strict";

/* global ProjectModel */
StartTest(t => {
  let gantt;
  t.beforeEach(() => gantt && gantt.destroy());
  t.it('Should be able to drag create on an unscheduled tasks row', t => {
    gantt = t.getGantt({
      appendTo: document.body,
      // task will acquire a start date from the project start, but
      // still will be unscheduled, since there's no end date
      project: new ProjectModel({
        startDate: new Date(2017, 0, 16),
        eventsData: [{
          id: 1,
          name: 'Steve'
        }]
      }),
      features: {
        taskTooltip: false,
        taskEdit: false
      }
    }); // TODO: Should not get a startDate from engine in this scenario

    t.chain({
      waitForPropagate: gantt
    }, next => {
      t.selectorNotExists('.b-gantt-task', 'No task elements found');
      t.notOk(gantt.taskStore.first.isScheduled);
      next();
    }, {
      drag: '.b-sch-timeaxis-cell',
      by: [100, 0],
      dragOnly: true
    }, {
      waitFor: () => gantt.element.querySelectorAll('.b-gantt-task').length === 1
    }, next => {
      t.selectorCountIs('.b-gantt-task', 1, 'One task element found');
      next();
    }, {
      mouseUp: null
    }, {
      waitForPropagate: gantt
    }, () => {
      t.is(gantt.taskStore.count, 1, 'No new task record created');
      t.selectorNotExists('.b-taskeditor', 'Task editing not invoked for drag-to-schedule operation');
      t.ok(gantt.taskStore.first.isScheduled);
      t.isGreater(gantt.taskStore.first.duration, 0);
    });
  });
  t.it('Should not be allowed to drag create on a scheduled tasks row', t => {
    gantt = t.getGantt({
      appendTo: document.body,
      tasks: [{
        id: 1,
        name: 'Steve',
        startDate: '2017-01-16',
        duration: 2
      }],
      features: {
        taskTooltip: false,
        taskEdit: false
      }
    });
    t.chain({
      waitForPropagate: gantt
    }, {
      drag: '.b-sch-timeaxis-cell',
      by: [100, 0],
      dragOnly: true
    }, next => {
      t.selectorNotExists('.b-sch-dragcreator-proxy', 'No drag create proxy shown');
      next();
    }, {
      mouseUp: null
    }, () => {
      t.selectorCountIs('.b-gantt-task', 1, 'Only a single task element found');
      t.is(gantt.taskStore.count, 1, 'No new task record created');
    });
  }); // https://github.com/bryntum/support/issues/3576
  // https://github.com/bryntum/support/issues/3605

  t.it('Should abort operation on ESC key', async t => {
    gantt = t.getGantt({
      tasks: [{
        id: 1,
        name: 'Steve'
      }],
      features: {
        taskTooltip: false,
        taskEdit: false
      }
    });
    const task = gantt.taskStore.getById(1);
    await gantt.taskStore.commitAsync();
    t.wontFire(gantt.taskStore, 'change');
    await t.dragBy({
      source: '.b-sch-timeaxis-cell',
      delta: [100, 0],
      dragOnly: true
    });
    await t.type(null, '[ESCAPE]');
    await t.mouseUp();
    await gantt.project.commitAsync();
    t.notOk(task.startDate, 'No startDate set');
    t.notOk(task.endDate, 'No endDate set');
    t.notOk(task.duration, 'No duration set');
    t.is(gantt.taskStore.count, 1, 'Still one task record created');
    t.selectorNotExists(gantt.unreleasedEventSelector, 'No task bar left');
  }); // https://github.com/bryntum/support/issues/3597

  t.it('Should handle drag creating on unscheduled but linked task', async t => {
    gantt = t.getGantt({
      enableEventAnimations: false,
      rowHeight: 50,
      barMargin: 5,
      tasks: [{
        id: 1,
        name: 'Task 1',
        startDate: '2017-01-23',
        duration: 1
      }, {
        id: 2,
        name: 'Task 2'
      }],
      dependencies: [{
        id: 1,
        fromEvent: 1,
        toEvent: 2
      }]
    });
    const task = gantt.taskStore.getById(2);
    await gantt.taskStore.commitAsync();
    await t.dragBy({
      source: '.b-grid-row[data-index=1] .b-sch-timeaxis-cell',
      delta: [40, 0]
    });
    t.selectorCountIs('.b-sch-dependency', 1);
    t.ok(task.isScheduled, 'Task now scheduled');
    t.is(task.startDate, new Date(2017, 1, 1), 'Task has startDate');
    t.is(task.endDate, new Date(2017, 1, 3), 'Task has endDate');
    t.is(task.duration, 2, 'Task has duration');
  }); // https://github.com/bryntum/support/issues/3464

  t.it('Should be able to drag create on an unscheduled tasks row when totalslack is used', async t => {
    gantt = t.getGantt({
      project: new ProjectModel({
        eventsData: [{
          id: 'parent',
          name: 'parent',
          children: [{
            id: 'child',
            name: 'child'
          }]
        }]
      }),
      columns: [{
        field: 'name'
      }, {
        type: 'totalslack'
      }],
      features: {
        taskTooltip: false,
        taskEdit: false
      }
    });
    await t.waitForPropagate(gantt);
    await t.click('i.b-tree-expander');
    await t.waitFor(() => gantt.isEngineReady);
    await t.dragBy({
      source: '.b-grid-row[data-index=1] .b-sch-timeaxis-cell',
      delta: [40, 0]
    });
    await t.waitForPropagate(gantt);
  });
});