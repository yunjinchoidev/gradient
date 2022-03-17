"use strict";

StartTest(t => {
  const gantt = bryntum.query('gantt');
  !gantt.features.taskTooltip.isDestroyed && gantt.features.taskTooltip.destroy();
  t.it('Check import of the mpp-file file shipped w/ the demo', t => {
    t.chain({
      waitForPropagate: gantt.project
    }, next => {
      const importButton = bryntum.fromElement(document.querySelector('.b-load-button'));
      importButton.disabled = false;
      t.click(importButton.element, next);
    }, {
      diag: 'Asserting masks & final toast'
    }, {
      waitForSelector: '.b-mask-content:contains(Importing project)',
      desc: 'Import showed up'
    }, {
      waitForSelectorNotFound: '.b-mask-content:contains(Importing project)',
      desc: 'Import mask disappeared'
    }, {
      waitForSelector: '.b-toast:contains(File imported successfully)',
      desc: 'Final toast showed up'
    }, {
      diag: 'Asserting columns'
    }, {
      waitForSelector: '.b-grid-header:contains(Name)',
      desc: '`Name` column is imported'
    }, {
      waitForSelector: '.b-grid-header:contains(Duration)',
      desc: '`Duration` column is imported'
    }, {
      waitForSelector: '.b-grid-header:contains(Start)',
      desc: '`Start` column is imported'
    }, {
      waitForSelector: '.b-grid-header:contains(Finish)',
      desc: '`Finish` column is imported'
    }, {
      waitForSelector: '.b-grid-header:contains(Assigned Resources)',
      desc: '`Assigned resources` column is imported'
    }, {
      waitForSelector: '.b-grid-header:contains(% Done)',
      desc: '`% done` column is imported'
    }, {
      diag: 'Asserting data'
    }, async () => {
      t.is(gantt.project.calendarManagerStore.count, 9, 'proper number of calendars imported');
      t.is(gantt.taskStore.count, 19, 'proper number of tasks imported');
      t.is(gantt.dependencyStore.count, 13, 'proper number of dependencies imported');
      t.is(gantt.assignmentStore.count, 21, 'proper number of assignments imported');
      t.is(gantt.resourceStore.count, 8, 'proper number of resources imported');
      t.is(gantt.taskStore.first.startDate, new Date(2012, 0, 18, 9), '1st task start date is correct');
    });
  });
});