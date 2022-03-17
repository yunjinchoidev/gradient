"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    gantt && !gantt.isDestroyed && gantt.destroy();
  });
  t.it('Should support QuickFind in Gantt', async t => {
    gantt = await t.getGanttAsync({
      columns: [{
        type: 'name',
        width: 250
      }],
      features: {
        quickFind: true
      }
    });
    await t.click('.id11 .b-grid-cell');
    await t.type(null, 'a');
    await t.waitForSelector('.b-quick-hit-text:textEquals(a)');
  });
});