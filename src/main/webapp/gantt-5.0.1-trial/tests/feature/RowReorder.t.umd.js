"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    return (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  });
  t.it('Should cancel row reordering in resolution UI if it creates a cyclic graph', t => {
    gantt = t.getGantt({
      appendTo: document.body,
      startDate: new Date(2020, 1, 1),
      endDate: new Date(2021, 1, 1),
      project: {
        startDate: new Date(2020, 1, 1),
        duration: 30,
        eventsData: [{
          id: 1,
          name: 'Project A',
          expanded: true,
          startDate: new Date(2020, 1, 1),
          children: [{
            id: 11,
            name: 'Child 1',
            startDate: new Date(2020, 1, 1),
            duration: 1,
            leaf: true
          }]
        }, {
          id: 2,
          name: 'Project B',
          startDate: new Date(2020, 1, 1),
          duration: 1,
          leaf: true
        }],
        dependenciesData: [{
          id: 1,
          fromEvent: 1,
          toEvent: 2
        }]
      }
    });
    t.chain({
      drag: '.b-grid-cell:contains(Project B)',
      to: '.b-grid-cell:contains(Child 1)',
      toOffset: [0, 2]
    }, {
      click: 'label:textEquals(Cancel)'
    }, {
      waitForSelectorNotFound: '.b-row-reordering'
    }, () => {
      t.is(gantt.taskStore.getById(2).parent, gantt.taskStore.rootNode, 'Parent of task 2 is still root task');
    });
  });
  t.it('Should handle store being cleared during finalization', async t => {
    t.mockUrl('loadurl', {
      delay: 1,
      responseText: JSON.stringify({
        success: true,
        resources: {
          rows: []
        },
        assignments: {
          rows: []
        },
        tasks: {
          rows: [{
            id: 1,
            name: 'A',
            startDate: '2018-02-01',
            endDate: '2018-03-01',
            expanded: true,
            children: [{
              id: 2,
              name: 'B',
              startDate: '2018-02-01',
              endDate: '2018-03-01'
            }, {
              id: 3,
              name: 'C',
              startDate: '2018-02-01',
              endDate: '2018-03-01'
            }]
          }]
        }
      })
    });
    gantt = await t.getGanttAsync({
      features: {
        rowReorder: {
          finalizeDelay: 1000
        }
      },
      project: {
        autoLoad: true,
        transport: {
          load: {
            url: 'loadurl'
          }
        }
      }
    });
    await t.dragBy('.b-grid-cell:contains(B)', [0, 50]);
    gantt.project.taskStore.removeAll();
    await t.waitForProjectReady(gantt);
    t.wontFire(gantt.project.taskStore, 'change');
    await t.waitForSelectorNotFound('.b-row-reordering');
  });
  t.it('Should handle store being loaded during finalization', t => {
    t.mockUrl('loadurl', {
      delay: 1,
      responseText: JSON.stringify({
        success: true,
        resources: {
          rows: []
        },
        assignments: {
          rows: []
        },
        tasks: {
          rows: [{
            id: 1,
            name: 'A',
            startDate: '2018-02-01',
            endDate: '2018-03-01',
            expanded: true,
            children: [{
              id: 2,
              name: 'B',
              startDate: '2018-02-01',
              endDate: '2018-03-01'
            }, {
              id: 3,
              name: 'C',
              startDate: '2018-02-01',
              endDate: '2018-03-01'
            }, {
              id: 4,
              name: 'd',
              startDate: '2018-02-01',
              endDate: '2018-03-01'
            }]
          }]
        }
      })
    });
    gantt = t.getGantt({
      features: {
        rowReorder: {
          finalizeDelay: 500
        }
      },
      project: {
        autoLoad: false,
        transport: {
          load: {
            url: 'loadurl'
          }
        }
      }
    });
    t.chain({
      waitForPropagate: gantt
    }, {
      drag: '.b-grid-cell:contains(Investigate)',
      by: [0, 60]
    }, next => {
      const async = t.beginAsync();
      gantt.project.load().then(() => {
        t.endAsync(async);
        t.wontFire(gantt.project.taskStore, 'change');
      });
      next();
    }, {
      waitForSelectorNotFound: '.b-row-reordering'
    });
  }); // https://github.com/bryntum/support/issues/2266

  t.it('Should display only one arrow icon on parent node', async t => {
    gantt = await t.getGanttAsync();
    t.simulator.setSpeed('speedRun');
    t.chain({
      drag: '.b-grid-cell:contains(Investigate)',
      to: '.b-grid-cell:contains(Report to management)',
      toOffset: [0, 2],
      dragOnly: true
    }, {
      waitForSelector: '.b-row-reordering-target-parent[data-id="1"]',
      desc: 'Row reordering class showing the arrow on parent node "Planing"'
    }, {
      mouseup: null
    }, {
      waitForSelectorNotFound: '.b-row-reordering'
    }, {
      drag: '.b-grid-cell:contains(Assign resources)',
      to: '.b-grid-cell:contains(Preparation work)',
      toOffset: [0, 2],
      dragOnly: true
    }, {
      waitForSelector: '.b-row-reordering-target-parent[data-id="2"]',
      desc: 'Row reordering class showing the arrow on parent node "Implementation Phase"'
    }, next => {
      t.selectorCountIs('.b-row-reordering-target-parent > .b-tree-cell', 1, 'Drag: There is just one task with reordering class applied showing the arrow');
      next();
    }, {
      mouseup: null
    }, async () => {
      t.selectorCountIs('.b-row-reordering-target-parent > .b-tree-cell', 1, 'There is just one task with reordering class applied showing the arrow');
    }, {
      waitForSelectorNotFound: '.b-row-reordering'
    }, {
      drag: '.b-grid-cell:contains(Choose technology suite)',
      to: '.b-grid-cell:contains(Step 1)',
      toOffset: [0, 2],
      dragOnly: true
    }, {
      waitForSelector: '.b-row-reordering-target-parent[data-id="23"]',
      desc: 'Row reordering class showing the arrow on parent node "Build prototype"'
    }, next => {
      t.selectorCountIs('.b-row-reordering-target-parent > .b-tree-cell', 1, 'Drag: There is just one task with reordering class applied showing the arrow');
      next();
    }, {
      mouseup: null
    }, async () => {
      t.selectorCountIs('.b-row-reordering-target-parent > .b-tree-cell', 1, 'There is just one task with reordering class applied showing the arrow');
      t.simulator.setSpeed('turboMode');
    });
  }); // https://github.com/bryntum/support/issues/2267

  t.it('Should not expand parent if drop task as sibling', async t => {
    gantt = t.getGantt({
      appendTo: document.body,
      startDate: new Date(2020, 1, 1),
      endDate: new Date(2021, 1, 1),
      project: {
        startDate: new Date(2020, 1, 1),
        duration: 30,
        eventsData: [{
          id: 1,
          name: 'Project A',
          startDate: new Date(2020, 1, 1),
          children: [{
            id: 11,
            name: 'Child 1',
            startDate: new Date(2020, 1, 1),
            duration: 1,
            leaf: true
          }]
        }, {
          id: 2,
          name: 'Project B',
          startDate: new Date(2020, 1, 1),
          duration: 1,
          leaf: true
        }, {
          id: 3,
          name: 'Project C',
          startDate: new Date(2020, 1, 1),
          duration: 1,
          leaf: true
        }]
      }
    });
    t.wontFire(gantt, 'expandNode', 'Parent node not expanded after drop record as sibling.');
    await t.dragTo({
      source: '.b-grid-cell:contains(Project C)',
      target: '.b-grid-cell:contains(Project A)',
      sourceOffset: ['50%', 20],
      targetOffset: ['50%', '100%-10']
    });
    await t.waitFor(gantt.features.rowReorder.hoverExpandTimeout);
  });
});