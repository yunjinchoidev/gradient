"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    return (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  });
  t.it('Should support replacing columns and automatically inject timeaxis column', async t => {
    gantt = await t.getGanttAsync({
      columns: [{
        type: 'name'
      }, {
        type: 'startdate'
      }]
    });
    gantt.columns.data = [{
      type: 'name',
      width: 250
    }, {
      type: 'wbs',
      width: 250
    }];
    await t.waitForSelectorNotFound('[data-column="startDate"]');
    await t.waitForSelector('[data-column="wbsValue"]');
    t.elementIsVisible('.b-sch-timeaxis-cell');
    t.elementIsVisible('.b-gantt-task');
  });
});