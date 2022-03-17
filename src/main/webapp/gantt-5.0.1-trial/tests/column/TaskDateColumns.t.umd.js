"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(t => {
    gantt && !gantt.isDestroyed && gantt.destroy();
    gantt = t.getGantt({
      appendTo: document.body,
      id: 'gantt',
      columns: [{
        type: 'startdate'
      }, {
        type: 'enddate'
      }]
    });
  });
  t.it('Should use Gantt#displayDateFormat by default', t => {
    t.chain({
      waitForRowsVisible: gantt
    }, () => {
      const start = DateHelper.format(gantt.taskStore.first.startDate, gantt.columns.getAt(1).format),
            end = DateHelper.format(gantt.taskStore.first.endDate, gantt.columns.getAt(1).format);
      t.selectorExists(`.id1000 [data-column=startDate]:textEquals(${start})`, 'Start date rendered correctly');
      t.selectorExists(`.id1000 [data-column=endDate]:textEquals(${end})`, 'End date rendered correctly');
    });
  });
  t.it('Should update when Gantt#displayDateFormat changes', t => {
    t.chain({
      waitForRowsVisible: gantt
    }, () => {
      gantt.displayDateFormat = 'L';
      const start = DateHelper.format(gantt.taskStore.first.startDate, gantt.columns.getAt(1).format),
            end = DateHelper.format(gantt.taskStore.first.endDate, gantt.columns.getAt(1).format);
      t.selectorExists(`.id1000 [data-column=startDate]:textEquals(${start})`, 'Start date rendered correctly');
      t.selectorExists(`.id1000 [data-column=endDate]:textEquals(${end})`, 'End date rendered correctly');
    });
  });
  t.it('Should be able to specify explicit format', t => {
    t.chain({
      waitForRowsVisible: gantt
    }, () => {
      gantt.columns.get('startDate').format = 'YYYY';
      const start = gantt.taskStore.first.startDate.getFullYear(),
            end = gantt.getFormattedDate(gantt.taskStore.first.endDate);
      t.selectorExists(`.id1000 [data-column=startDate]:textEquals(${start})`, 'Start date rendered correctly');
      t.selectorExists(`.id1000 [data-column=endDate]:textEquals(${end})`, 'End date rendered correctly');
    });
  });
  t.it('Should handle project being replaced', t => {
    t.chain({
      waitForRowsVisible: gantt
    }, {
      dblClick: '[data-id="11"] .b-date-cell'
    }, async () => {
      gantt.project = new ProjectModel({
        taskStore: {
          data: [{
            name: 'foo',
            startDate: '2021-01-01',
            duration: 1
          }]
        }
      });
      await gantt.project.commitAsync();
      t.firesAtLeastNTimes(gantt.project.taskStore, 'update', 1);
    }, {
      dblClick: '.b-date-cell'
    }, {
      type: 'Jan 3, 2021[TAB]'
    }, () => {
      t.is(gantt.taskStore.first.startDate, new Date(2021, 0, 3), 'Task updated');
    });
  }); // https://github.com/bryntum/support/issues/3324

  t.it('Should disable dates before start date when editing end date', async t => {
    gantt.startDate = new Date(2021, 7, 23);
    gantt.tasks = [{
      startDate: new Date(2021, 7, 23),
      manuallyScheduled: true,
      duration: 5
    }, {
      startDate: new Date(2021, 7, 29),
      manuallyScheduled: true,
      duration: 5
    }];
    await t.doubleClick('[data-index="1"] [data-column=endDate]');
    await t.click('.b-datefield .b-icon-calendar');
    t.is(gantt.features.cellEdit.editorContext.editor.inputField.min, new Date(2021, 7, 29), 'Field: min set correctly');
    t.is(gantt.features.cellEdit.editorContext.editor.inputField.picker.minDate, new Date(2021, 7, 29), 'DatePicker: min set correctly');
    await t.click('[data-date="2021-09-02"]');
    await t.doubleClick('[data-index="0"] [data-column=endDate]');
    await t.click('.b-datefield .b-icon-calendar');
    t.is(gantt.features.cellEdit.editorContext.editor.inputField.min, new Date(2021, 7, 23), 'Field: min set correctly');
    t.is(gantt.features.cellEdit.editorContext.editor.inputField.picker.minDate, new Date(2021, 7, 23), 'DatePicker: min set correctly');
    t.selectorExists('[data-date="2021-08-22"].b-out-of-range');
    t.selectorExists('[data-date="2021-08-23"]:not(.b-out-of-range)');
    t.selectorExists('[data-date="2021-08-24"]:not(.b-out-of-range)');
    t.selectorExists('[data-date="2021-08-25"]:not(.b-out-of-range)');
    t.selectorExists('[data-date="2021-08-26"]:not(.b-out-of-range)');
    t.selectorExists('[data-date="2021-08-27"]:not(.b-out-of-range)');
    t.selectorExists('[data-date="2021-08-28"]:not(.b-out-of-range)');
  });
});