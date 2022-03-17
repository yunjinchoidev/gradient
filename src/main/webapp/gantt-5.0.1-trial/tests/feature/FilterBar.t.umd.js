"use strict";

StartTest(t => {
  let gantt, project;
  t.beforeEach(t => {
    project && project.destroy();
    gantt && gantt.destroy();
  });

  async function createGantt(config = {}) {
    project = new ProjectModel({
      tasksData: [{
        id: 1,
        name: 'Task 1',
        expanded: true,
        startDate: '2020-02-24',
        children: [{
          id: 11,
          name: 'Task 11',
          startDate: '2020-02-24',
          duration: 2,
          constraintDate: '2020-02-24',
          constraintType: 'muststarton'
        }, {
          id: 12,
          name: 'Task 12',
          startDate: '2020-02-24',
          duration: 2,
          deadlineDate: '2020-03-05'
        }, {
          id: 22,
          name: 'Task 22',
          startDate: '2020-02-24',
          duration: 2
        }, {
          id: 14,
          name: 'Task 14',
          startDate: '2020-02-24',
          duration: 3
        }]
      }],
      dependenciesData: [{
        fromEvent: 11,
        toEvent: 12
      }, {
        fromEvent: 12,
        toEvent: 13
      }, {
        fromEvent: 13,
        toEvent: 14
      }]
    });
    gantt = t.getGantt(Object.assign({
      features: {
        filterBar: true
      },
      startDate: '2020-02-24',
      dependencyIdField: 'wbsCode',
      project: config.project || project,
      columns: [{
        type: 'wbs'
      }, {
        type: 'name'
      }, {
        type: 'startdate'
      }, {
        type: 'predecessor'
      }, {
        type: 'successor'
      }]
    }, config));
    await gantt.project.commitAsync();
  } // https://github.com/bryntum/support/issues/3229


  t.it('Should be able to filter predecessor column by the configured dependencyIdField', async t => {
    await createGantt();
    await t.type('[data-column="predecessors"] input', '1.1[ENTER]');
    t.selectorCountIs('.b-gantt-task-wrap', 2, '1 parent, 1 leaf matching');
    t.isDeeply(gantt.taskStore.map(task => task.wbsCode), ['1', '1.2'], 'Correct filter result');
    await t.click('[data-column="predecessors"] .b-icon-remove');
    t.selectorCountIs('.b-gantt-task-wrap', 5, 'All rows rendered again');
  }); // https://github.com/bryntum/support/issues/3229

  t.it('Should be able to filter successor column by the configured dependencyIdField', async t => {
    await createGantt();
    await t.type('[data-column="successors"] input', '1.2[ENTER]');
    t.selectorCountIs('.b-gantt-task-wrap', 2, '1 parent, 1 leaf matching');
    t.isDeeply(gantt.taskStore.map(task => task.wbsCode), ['1', '1.1'], 'Correct filter result');
    await t.click('[data-column="successors"] .b-icon-remove');
    t.selectorCountIs('.b-gantt-task-wrap', 5, 'All rows rendered again');
  });
});