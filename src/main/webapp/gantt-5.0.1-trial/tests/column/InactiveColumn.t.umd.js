"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(t => InactiveColumn.destroy(gantt));
  t.it('Should be possible to toggle task inactive state', async t => {
    gantt = await t.getGanttAsync({
      features: {
        nonWorkingTime: false
      },
      columns: [{
        type: InactiveColumn.type,
        width: 80
      }]
    });
    const task = gantt.taskStore.getAt(5);
    await t.waitForRowsVisible(gantt);
    await t.click('[data-id=14] [data-column=inactive] .b-checkbox');
    await t.waitForPropagate(gantt.project);
    t.ok(task.inactive, 'task got inactive');
    t.selectorExists('.b-grid-row.b-inactive[data-id=14]', 'locked grid row got b-inactive class');
    t.selectorExists('.b-gantt-task-wrap.b-inactive[data-task-id=14] .b-gantt-task', 'task bar got b-inactive class');
    t.is(gantt.taskStore.getById(2).startDate, gantt.project.startDate, 'successors got rescheduled');
    await t.click('[data-id=14] [data-column=inactive] .b-checkbox');
    await t.waitForPropagate(gantt.project);
    t.notOk(task.inactive, 'task is active');
    t.selectorNotExists('.b-grid-row.b-inactive[data-id=14]', 'locked grid row has no b-inactive class');
    t.selectorNotExists('.b-gantt-task-wrap.b-inactive[data-task-id=14] .b-gantt-task', 'task bar has no b-inactive class');
    t.is(gantt.taskStore.getById(2).startDate, new Date(2017, 0, 26), 'successors got rescheduled back');
  });
});