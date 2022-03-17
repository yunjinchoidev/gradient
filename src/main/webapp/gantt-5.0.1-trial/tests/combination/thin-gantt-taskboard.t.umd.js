"use strict";

StartTest(t => {
  t.beforeEach(() => TaskBoard.destroy(...TaskBoard.queryAll(w => !w.parent)));
  t.it('Gantt + TaskBoard with thin bundle sanity', async t => {
    const project = new ProjectModel({
      taskStore: {
        fields: ['status']
      },
      tasks: [{
        id: 1,
        name: 'Parent 1',
        children: [{
          id: 2,
          name: 'Event 1',
          startDate: '2022-02-11T8',
          duration: 5,
          durationUnit: 'h',
          status: 'todo'
        }, {
          id: 3,
          name: 'Event 2',
          startDate: '2022-02-11T8',
          duration: 5,
          durationUnit: 'h',
          status: 'done'
        }]
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
    new TaskBoard({
      appendTo: document.body,
      width: 1024,
      height: 350,
      columns: ['todo', 'done'],
      columnField: 'status',
      project
    });
    new Gantt({
      appendTo: document.body,
      width: 1024,
      height: 350,
      project
    });
    await project.commitAsync();
    await t.waitForSelector('.b-gantt-task');
    await t.waitForSelector('.b-taskboard-card'); // Ensure something rendered

    t.selectorCountIs('.b-taskboard-card', 2, 'TaskBoard cards rendered');
    t.selectorCountIs('.b-gantt-task', 1, 'Gantt parent task rendered'); // Ensure css worked

    t.hasApproxHeight('.b-taskboard-card', 99, 'Card has height');
    t.hasApproxWidth('.b-taskboard-card', 472, 'Card has width');
    t.hasApproxHeight('.b-gantt .b-grid-cell', 45, 'Gantt row has height');
    t.hasApproxWidth('.b-gantt .b-grid-cell', 200, 'Gantt cell has width');
    await t.click('.b-tree-expander');
    t.selectorCountIs('.b-gantt-task', 3, 'Gantt tasks rendered');
    await t.doubleClick('[data-task-id="2"] .b-gantt-task');
    await t.click('[data-ref=name] input');
    await t.type({
      text: 'Testing[ENTER]',
      clearExisting: true
    });
    await t.waitForSelector('.b-grid-cell:textEquals(Testing)');
    await t.waitForSelector('.b-taskboard-card-header:textEquals(Testing)');
    t.pass('Editing worked');
  });
});