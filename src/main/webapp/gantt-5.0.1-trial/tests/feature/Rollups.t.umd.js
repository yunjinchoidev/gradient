"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    gantt && !gantt.isDestroyed && gantt.destroy();
  });
  t.it('Rollups should render child tasks under parent task bar', async t => {
    gantt = t.getGantt({
      appendTo: document.body,
      startDate: '2019-07-07',
      endDate: '2019-07-29',
      features: {
        rollups: true
      },
      rowHeight: 70,
      project: {
        startDate: '2019-07-07',
        duration: 30,
        eventsData: [{
          id: 1,
          name: 'Project A',
          duration: 30,
          expanded: true,
          children: [{
            id: 11,
            name: 'Child 1',
            duration: 1,
            rollup: true,
            cls: 'child1'
          }, {
            id: 12,
            name: 'Child 2',
            duration: 5,
            rollup: true,
            cls: 'child1'
          }, {
            id: 13,
            name: 'Child 3',
            duration: 0,
            rollup: true,
            cls: 'child1'
          }]
        }],
        dependenciesData: [{
          id: 1,
          fromEvent: 12,
          toEvent: 13
        }]
      }
    });
    const taskStore = gantt.taskStore,
          projectA = taskStore.first,
          child1 = projectA.children[0];
    t.chain({
      waitForPropagate: gantt
    }, // Move in from the right, not diagonally from 0, 0 which would be the default.
    {
      moveMouseTo: '.b-task-rollup[data-index="2"]',
      offset: ['100%+60', '50%']
    }, {
      moveMouseTo: '.b-task-rollup[data-index="2"]',
      offset: ['50%+1', '50%']
    }, // Only over the Child 3 milestone
    {
      waitForSelector: '.b-tooltip:contains(Child 3):not(:contains(Child 1)):not(:contains(Child 2))'
    }, {
      moveMouseTo: '.b-task-rollup[data-index="1"]'
    }, // Only over Child 2
    {
      waitForSelector: '.b-tooltip:contains(Child 2):not(:contains(Child 1)):not(:contains(Child 3))'
    }, {
      moveMouseTo: '.b-task-rollup[data-index="0"]'
    }, // We're over child 1 *and* child 2 now, not child 3
    {
      waitForSelector: '.b-tooltip:contains(Child 1):contains(Child 2):not(:contains(Child 3))'
    }, {
      moveMouseTo: [0, 0]
    }, async () => {
      projectA.removeChild(child1);
      await projectA.commitAsync();
    }, {
      waitForSelectorNotFound: '.b-task-rollup[data-index="2"]',
      desc: 'Rollups are trimmed on child remove'
    }, async () => {
      projectA.insertChild(child1, projectA.children[0]);
      await projectA.commitAsync();
    }, {
      waitForSelector: '.b-task-rollup[data-index="2"]',
      desc: 'Rollups are added on child add'
    });
  });
  t.it('Rollups should render child tasks when parent is collapsed', async t => {
    gantt = t.getGantt({
      startDate: '2019-07-07',
      endDate: '2019-07-29',
      features: {
        rollups: true
      },
      project: {
        startDate: '2019-07-07',
        duration: 30,
        eventsData: [{
          id: 1,
          name: 'Project A',
          duration: 30,
          expanded: false,
          children: [{
            id: 11,
            name: 'Child 1',
            duration: 1,
            rollup: true
          }]
        }]
      }
    });
    await t.waitForSelector('[data-rollup-task-id="11"]');
    t.pass('task #11 rollup showed up');
  });
  t.it('Should not render rollup for tasks starting after timeaxis end date', async t => {
    gantt = t.getGantt({
      startDate: '2017-01-15',
      endDate: '2017-02-26',
      features: {
        rollups: true
      },
      project: {
        startDate: '2017-01-08',
        duration: 80,
        eventsData: [{
          id: 1,
          name: 'Project A',
          startDate: '2017-01-08',
          duration: 80,
          expanded: true,
          children: [{
            id: 11,
            startDate: '2017-01-15',
            name: 'Starts before timeaxis, ends inside',
            duration: 10,
            rollup: true
          }, {
            id: 12,
            startDate: '2017-03-17',
            name: 'Starts after time axis end',
            duration: 80,
            rollup: true,
            manuallyScheduled: true
          }]
        }]
      }
    });
    await t.waitForSelector('.b-gantt-task-wrap');
    t.selectorExists('.b-task-rollup[data-rollup-task-id="11"]');
    t.selectorNotExists('.b-task-rollup[data-rollup-task-id="12"]');
  });
  t.it('Should not overlap rollup and baselines when combined', async t => {
    gantt = await t.getGanttAsync({
      startDate: '2019-07-07',
      endDate: '2019-07-29',
      features: {
        rollups: true,
        baselines: true
      },
      project: {
        startDate: '2019-07-07',
        eventsData: [{
          id: 1,
          name: 'Project A',
          rollup: true,
          expanded: true,
          baselines: [{
            startDate: '2019-07-07',
            endDate: '2019-07-10'
          }],
          children: [{
            id: 2,
            name: 'Task A',
            startDate: '2019-07-23',
            endDate: '2019-08-13',
            rollup: true
          }]
        }]
      }
    });
    const rollupElCoord = t.rect('.b-task-rollup[data-rollup-task-id="2"]'),
          baselineElCoord = t.rect('.b-task-baseline');
    t.ok(rollupElCoord.bottom < baselineElCoord.top, 'Rollup and baselines are not overlapped');
  });
  t.it('Should not render rollup for inactive tasks', async t => {
    gantt = await t.getGanttAsync({
      startDate: '2017-01-15',
      endDate: '2017-02-26',
      features: {
        rollups: true
      },
      project: {
        startDate: '2017-01-08',
        duration: 80,
        eventsData: [{
          id: 1,
          name: 'Project A',
          startDate: '2017-01-08',
          duration: 80,
          expanded: true,
          children: [{
            id: 11,
            startDate: '2017-01-15',
            name: 'Starts before timeaxis, ends inside',
            duration: 10,
            rollup: true
          }, {
            id: 12,
            startDate: '2017-01-19',
            name: 'Inactive task',
            duration: 1,
            manuallyScheduled: true,
            rollup: true,
            inactive: true
          }]
        }]
      }
    });
    await t.waitForSelector('.b-gantt-task-wrap');
    t.selectorExists('.b-task-rollup[data-rollup-task-id="11"]', 'task #11 rollup is shown');
    t.selectorNotExists('.b-task-rollup[data-rollup-task-id="12"]', 'task #12 rollup is not shown');
  });
  t.it('Should rollup inactive children to inactive parents', async t => {
    gantt = await t.getGanttAsync({
      startDate: '2017-01-15',
      endDate: '2017-02-26',
      features: {
        rollups: true
      },
      project: {
        startDate: '2017-01-08',
        duration: 80,
        eventsData: [{
          id: 1,
          name: 'Inactive Parent',
          startDate: '2017-01-08',
          duration: 80,
          expanded: true,
          inactive: true,
          children: [{
            id: 11,
            startDate: '2017-01-15',
            name: 'Starts before timeaxis, ends inside',
            duration: 10,
            inactive: true,
            rollup: true
          }, {
            id: 12,
            startDate: '2017-01-19',
            name: 'Inactive task',
            duration: 1,
            manuallyScheduled: true,
            rollup: true,
            inactive: true
          }]
        }]
      }
    });
    await t.waitForSelector('.b-gantt-task-wrap');
    t.selectorExists('.b-task-rollup.b-inactive[data-rollup-task-id="11"]', 'task #11 rollup is shown');
    t.selectorExists('.b-task-rollup.b-inactive[data-rollup-task-id="12"]', 'task #12 rollup is shown');
  }); // https://github.com/bryntum/support/issues/802

  t.it('Rollups should apply cls/style from main task', async t => {
    gantt = t.getGantt({
      appendTo: document.body,
      startDate: '2019-07-07',
      endDate: '2019-07-29',
      features: {
        rollups: true
      },

      taskRenderer({
        renderData
      }) {
        renderData.style += 'border:2px solid #000';
      },

      rowHeight: 70,
      project: {
        startDate: '2019-07-07',
        duration: 30,
        eventsData: [{
          id: 1,
          name: 'Project A',
          duration: 30,
          expanded: true,
          children: [{
            id: 11,
            name: 'Child 1',
            duration: 10,
            rollup: true,
            cls: 'child1'
          }]
        }]
      }
    });
    await t.waitForSelector('.b-task-rollup.child1');
    const borderWidth = parseInt(window.getComputedStyle(document.querySelector('.b-task-rollup.child1')).borderTopWidth);
    t.isApproxPx(borderWidth, 2, 'Style was set');
  }); // https://github.com/bryntum/support/issues/4232

  t.it('Rollups should handle lazy loaded parent nodes', async t => {
    gantt = t.getGantt({
      startDate: '2019-07-07',
      endDate: '2019-07-29',
      features: {
        rollups: true
      },
      rowHeight: 70,
      project: {
        startDate: '2019-07-07',
        duration: 30,
        eventsData: [{
          id: 10,
          name: 'Project A',
          duration: 30,
          children: true
        }, {
          id: 1,
          name: 'Project B',
          duration: 30,
          expanded: true,
          children: [{
            id: 11,
            name: 'Child 1',
            duration: 10,
            rollup: true,
            cls: 'child1'
          }]
        }]
      }
    });
    await t.waitForSelector('.b-task-rollup.child1');
  });
});