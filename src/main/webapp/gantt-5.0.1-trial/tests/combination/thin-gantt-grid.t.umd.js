"use strict";

StartTest(t => {
  t.beforeEach(() => Grid.destroy(...Grid.queryAll(w => !w.parent)));
  t.it('Gantt + Grid with thin bundle sanity', async t => {
    const project = new ProjectModel({
      tasks: [{
        id: 1,
        name: 'Event 1',
        startDate: '2022-02-11',
        duration: 5
      }],
      resources: [{
        id: 1,
        name: 'Resource 1'
      }],
      assignments: [{
        id: 1,
        eventId: 1,
        resourceId: 1
      }]
    });
    new Grid({
      appendTo: document.body,
      width: 1024,
      height: 350,
      columns: [{
        field: 'name',
        text: 'Event',
        width: 100
      }, {
        type: 'date',
        field: 'startDate',
        text: 'Start'
      }],
      store: project.eventStore
    });
    new Gantt({
      appendTo: document.body,
      width: 1024,
      height: 350,
      startDate: new Date(2022, 1, 11),
      endDate: new Date(2022, 2, 1),
      tickSize: 50,
      project
    });
    await project.commitAsync(); // Ensure something rendered

    t.selectorExists('.b-grid:not(.b-gantt) .b-grid-row', 'Grid row rendered');
    t.selectorExists('.b-gantt .b-grid-row', 'Scheduler row rendered'); // Ensure css worked

    t.hasApproxHeight('.b-grid:not(.b-gantt) .b-grid-cell', 45, 'Grid row has height');
    t.hasApproxWidth('.b-grid:not(.b-gantt) .b-grid-cell', 100, 'Grid cell has width');
    t.hasApproxHeight('.b-gantt .b-grid-cell', 45, 'Gantt row has height');
    t.hasApproxWidth('.b-gantt .b-grid-cell', 200, 'Gantt cell has width');
    t.isApproxPx(t.rect('.b-gantt-task').left, 455, 'Task has correct x');
    t.hasApproxWidth('.b-gantt-task', 249, 'Task has correct width');
    await t.dragBy({
      source: '.b-gantt-task',
      delta: [50, 0]
    });
    t.isApproxPx(t.rect('.b-gantt-task').left, 505, 'Task has correct x after drag');
    t.selectorExists('.b-grid:not(.b-gantt) .b-grid-cell:textEquals(02/12/2022)', 'Grid cell updated');
  });
});