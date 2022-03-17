"use strict";

StartTest(t => {
  let gantt, task;
  t.waitFor(() => {
    gantt = bryntum.query('gantt');

    if (gantt) {
      task = gantt.taskStore.first;
      return Boolean(task);
    }
  });
  t.it('Should edit child cost inline and recalculate parent cost', t => {
    t.chain(async () => {
      t.is(task.cost, 116750, 'Correct cost calculated');
    }, {
      waitForSelector: '.b-grid-cell:contains("$116750")',
      desc: 'Correct cost displayed'
    }, {
      dblClick: '.b-grid-row[data-index="2"] .b-grid-cell[data-column="cost"]',
      desc: 'Open cost column editor'
    }, {
      waitForSelector: '.b-grid-cell[data-column="cost"].b-editing',
      desc: 'Editor displayed'
    }, {
      type: '10[ENTER]',
      clearExisting: true,
      desc: 'Edit Cost'
    }, async () => {
      t.is(task.cost, 116560, 'Correct cost calculated');
    }, {
      waitForSelector: '.b-grid-cell:contains("$116560")',
      desc: 'Correct cost displayed'
    });
  });
  t.it('Should edit child cost in Task edit dialog and recalculate parent cost', t => {
    t.chain({
      rightClick: '.b-grid-row[data-index="2"] .b-grid-cell[data-column="cost"]',
      desc: 'Open cost column editor'
    }, {
      click: '.b-menu-text:contains(Edit)'
    }, {
      click: '.b-numberfield input[name=cost]'
    }, {
      type: '20',
      desc: 'Edit Cost',
      clearExisting: true
    }, {
      click: '.b-button:contains(Save)'
    }, async () => {
      t.is(task.cost, 116570, 'Correct cost calculated');
    }, {
      waitForSelector: '.b-grid-cell:contains("$116570")',
      desc: 'Correct cost displayed'
    });
  });
  t.it('Should not edit calculated parent cost', t => {
    t.chain({
      dblClick: '.b-grid-row[data-index="1"] .b-grid-cell[data-column="cost"]',
      desc: 'Try to open cost column editor'
    }, {
      waitForSelectorNotFound: '.b-grid-cell[data-column="cost"].b-editing',
      desc: 'Editor does not displayed'
    });
  });
  t.it('Should edit parent name', t => {
    t.chain({
      dblClick: '.b-grid-row[data-index="1"] .b-grid-cell[data-column="name"]',
      desc: 'Try to open name column editor'
    }, {
      waitForSelector: '.b-grid-cell[data-column="name"].b-editing',
      desc: 'Editor is displayed'
    });
  }); // Caught by monkeytest

  t.it('Should not fail on dblclick at normal subgrid', t => {
    t.chain({
      dblClick: '.b-grid-subgrid-normal',
      offset: [100, 50]
    });
  });
});