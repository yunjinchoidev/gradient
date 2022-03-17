"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    return (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  });
  t.it('Should change task calendar', t => {
    gantt = t.getGantt({
      columns: [{
        type: CalendarColumn.type
      }, {
        type: StartDateColumn.type
      }, {
        type: DurationColumn.type
      }]
    });
    const {
      project
    } = gantt;
    const task = project.getEventStore().getById(11);
    let originalEnd;
    t.chain({
      waitForEvent: [project, 'load']
    }, next => {
      originalEnd = task.endDate;
      next();
    }, {
      click: '.id11 [data-column=calendar]'
    }, {
      waitForEvent: [gantt, 'startcelledit'],
      trigger: {
        type: '[ENTER]'
      }
    }, {
      type: 'b'
    }, {
      waitFor: () => gantt.features.cellEdit.editor.inputField.pickerVisible
    }, {
      type: '[ENTER]'
    }, {
      waitFor: () => gantt.features.cellEdit.editor.inputField.value === 'business'
    }, {
      waitForEvent: [gantt, 'startcelledit'],
      trigger: {
        type: '[ENTER]'
      }
    }, {
      waitForSelector: '.id11 [data-column=calendar]:contains(Business)'
    }, next => {
      const calendar = task.getCalendarManagerStore().getById('business');
      t.is(task.calendar, calendar, 'Task calendar is ok');
      t.is(task.effectiveCalendar, calendar, 'Task uses project calendar');
      next();
    }, {
      click: '.id11 [data-column=calendar]'
    }, {
      waitFor: () => gantt.features.cellEdit.editor.inputField.containsFocus
    }, next => {
      const input = document.querySelector('input[name=calendar]');
      t.is(input.value, 'Business', 'Calendar value is ok');
      next();
    }, {
      click: '.b-icon-remove'
    }, {
      type: '[ENTER]'
    }, {
      waitForPropagate: project
    }, () => {
      t.is(task.endDate, originalEnd, 'Task end date is ok');
      t.notOk(task.calendar, 'Task own calendar is cleared');
      t.is(task.effectiveCalendar, project.defaultCalendar, 'Task uses project calendar');
    });
  }); // https://github.com/bryntum/support/issues/3578

  t.it('Should support without editor', async t => {
    gantt = t.getGantt({
      columns: [{
        type: CalendarColumn.type,
        editor: false
      }]
    });
    await t.waitForSelector('.b-gantt-task');
    const task = gantt.taskStore.getById(11);
    task.calendar = task.getCalendarManagerStore().getById('business');
    await t.waitForSelector('.id11 [data-column="calendar"]:contains(Business)');
  });
});