"use strict";

StartTest(async t => {
  // Should expose [gantt/grid/etc] on window
  await t.waitFor(() => window.gantt);
  t.it('Gantt should not be readonly', async t => {
    t.notOk(window.gantt.readOnly, 'Gantt is editable');
  });
});