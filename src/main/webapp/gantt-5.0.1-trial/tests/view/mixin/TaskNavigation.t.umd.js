"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  });
  t.it('Should live ok when focusing header', async t => {
    gantt = await t.getGanttAsync();
    const done = await t.livesOkAsync('No exception typing in header');
    await t.click('.b-sch-header-timeaxis-cell');
    await t.type(null, '[ENTER]');
    done();
  }); // https://github.com/bryntum/support/issues/4162

  t.it('Should focus locked grid cell when pressing left arrow on a focused task bar', async t => {
    gantt = await t.getGanttAsync();
    await t.click('.b-grid-cell:contains(Investigate)');
    t.selectorExists('.b-grid-cell.b-focused:focus');
    await t.type(null, '[RIGHT]');
    t.selectorExists('.b-gantt-task-wrap.b-active');
    await t.type(null, '[LEFT]');
    t.selectorExists('.b-grid-cell.b-focused:focus');
  });
});