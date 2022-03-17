"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(t => {
    gantt && gantt.destroy();
  });
  t.it('Should render properly', async t => {
    gantt = await t.getGanttAsync({
      id: 'gantt',
      columns: [{
        type: RollupColumn.type
      }]
    });
    t.selectorExists('[data-id=21] [data-column=rollup] input[type=checkbox]:not(:checked)', 'Preparation not checked');
    t.selectorExists('[data-id=22] [data-column=rollup] input[type=checkbox]:checked', 'Choose technology checked');
  });
  t.it('Should change rollup property', async t => {
    gantt = await t.getGanttAsync({
      id: 'gantt',
      columns: [{
        type: RollupColumn.type
      }]
    });
    await t.click('[data-index=2] [data-column=rollup]');
    t.is(gantt.taskStore.getAt(2).rollup, true, 'Switched to true');
  });
});