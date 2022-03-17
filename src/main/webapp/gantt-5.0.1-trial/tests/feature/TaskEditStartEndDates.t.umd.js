"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    return (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  }); // https://github.com/bryntum/support/issues/724

  t.it('Spin buttons of start/end fields skip non-working time', async t => {
    gantt = await t.getGanttAsync({
      startDate: new Date(2020, 9, 12),
      endDate: new Date(2020, 10, 25),
      project: {
        calendar: 'general',
        startDate: '2020-10-10',
        resourcesData: [{
          id: 1,
          name: 'Resource 1',
          calendar: 'foo'
        }],
        tasksData: [{
          id: 1,
          name: 'Event 1',
          startDate: '2020-10-19',
          duration: 2,
          constraintDate: '2020-10-19',
          constraintType: 'startnoearlierthan'
        }],
        assignmentsData: [{
          resource: 1,
          event: 1
        }],
        dependenciesData: [],
        calendarsData: [{
          id: 'general',
          intervals: [{
            recurrentStartDate: 'on Sat at 0:00',
            recurrentEndDate: 'on Mon at 0:00',
            isWorking: false
          }],
          children: [{
            id: 'foo',
            // assigned resource will add some extra non working days to the event
            intervals: [{
              startDate: '2020-10-15',
              endDate: '2020-10-16',
              isWorking: false
            }, {
              startDate: '2020-10-22',
              endDate: '2020-10-23',
              isWorking: false
            }]
          }]
        }]
      }
    });
    const event = gantt.project.eventStore.first;
    t.chain({
      dblClick: '.b-gantt-task'
    }, {
      diag: 'Asserting start date spinners'
    }, {
      click: '.b-start-date .b-icon-angle-left',
      desc: 'Start date -1 day'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2020, 9, 16), 'event start date is correct');
      t.is(event.endDate, new Date(2020, 9, 20), 'event end date is correct');
      t.is(event.duration, 2, 'event duration is correct');
    }, {
      click: '.b-start-date .b-icon-angle-left',
      desc: 'Start date -1 day'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2020, 9, 14), 'event start date is still correct');
      t.is(event.endDate, new Date(2020, 9, 17), 'event end date is still correct');
      t.is(event.duration, 2, 'event duration is correct');
    }, {
      click: '.b-start-date .b-icon-angle-right',
      desc: 'StartDate +1 day'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2020, 9, 16), 'event start date is updated');
      t.is(event.endDate, new Date(2020, 9, 20), 'event end date is updated');
      t.is(event.duration, 2, 'event duration is correct');
    }, {
      click: '.b-start-date .b-icon-angle-right',
      desc: 'StartDate +1 day'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2020, 9, 19), 'event start date got updated');
      t.is(event.endDate, new Date(2020, 9, 21), 'event end date got updated');
      t.is(event.duration, 2, 'event duration is correct');
    }, {
      diag: 'Asserting end date spinners'
    }, {
      click: '.b-end-date .b-icon-angle-right',
      desc: 'EndDate +1 day'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2020, 9, 19), 'event start date got updated');
      t.is(event.endDate, new Date(2020, 9, 22), 'event end date got updated');
      t.is(event.duration, 3, 'event duration is updated');
    }, {
      click: '.b-end-date .b-icon-angle-right',
      desc: 'EndDate +1 day'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2020, 9, 19), 'event start date got updated');
      t.is(event.endDate, new Date(2020, 9, 24), 'event end date got updated');
      t.is(event.duration, 4, 'event duration got updated');
    }, {
      click: '.b-end-date .b-icon-angle-right',
      desc: 'EndDate +1 day'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2020, 9, 19), 'event start date got updated');
      t.is(event.endDate, new Date(2020, 9, 27), 'event end date got updated');
      t.is(event.duration, 5, 'event duration got updated');
    }, {
      click: '.b-end-date .b-icon-angle-left',
      desc: 'EndDate -1 day'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2020, 9, 19), 'event start date got updated');
      t.is(event.endDate, new Date(2020, 9, 24), 'event end date got updated');
      t.is(event.duration, 4, 'event duration got updated');
    }, {
      click: '.b-end-date .b-icon-angle-left',
      desc: 'EndDate -1 day'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2020, 9, 19), 'event start date got updated');
      t.is(event.endDate, new Date(2020, 9, 22), 'event end date got updated');
      t.is(event.duration, 3, 'event duration is updated');
    }, {
      click: '.b-end-date .b-icon-angle-left',
      desc: 'EndDate -1 day'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2020, 9, 19), 'event start date got updated');
      t.is(event.endDate, new Date(2020, 9, 21), 'event end date got updated');
      t.is(event.duration, 2, 'event duration is correct');
    });
  });
  t.it('Start/end fields support keepTime === entered mode', async t => {
    gantt = await t.getGanttAsync({
      startDate: new Date(2021, 0, 11),
      endDate: new Date(2021, 0, 25),
      features: {
        taskEdit: {
          items: {
            generalTab: {
              items: {
                startDate: {
                  keepTime: 'entered',
                  format: 'YYYY-MM-DD HH:mm'
                },
                endDate: {
                  keepTime: 'entered',
                  format: 'YYYY-MM-DD HH:mm'
                }
              }
            },
            advancedTab: {
              items: {
                constraintDateField: {
                  keepTime: 'entered',
                  format: 'YYYY-MM-DD HH:mm'
                }
              }
            }
          }
        }
      },
      project: {
        calendar: 'general',
        startDate: '2021-01-12',
        resourcesData: [{
          id: 1,
          name: 'Resource 1',
          calendar: 'foo'
        }],
        eventsData: [{
          id: 1,
          name: 'Event 1',
          startDate: '2021-01-12',
          duration: 48,
          durationUnit: 'hours'
        }],
        assignmentsData: [{
          resource: 1,
          event: 1
        }],
        dependenciesData: [],
        calendarsData: [{
          id: 'general',
          intervals: [{
            recurrentStartDate: 'on Sat at 0:00',
            recurrentEndDate: 'on Mon at 0:00',
            isWorking: false
          }]
        }]
      }
    });
    const event = gantt.eventStore.getById(1);
    await gantt.editTask(event);
    t.chain({
      diag: 'Assert start date typing'
    }, {
      click: '[name="startDate"]',
      desc: 'Clicked startDate field'
    }, {
      type: '2021-01-12 18:45[TAB]',
      clearExisting: true,
      desc: 'Entered date'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2021, 0, 12, 18, 45), 'event start date is correct');
      t.is(event.endDate, new Date(2021, 0, 14, 18, 45), 'event end date is correct');
      t.is(event.duration, 48, 'event duration is correct');
      t.is(event.constraintDate, new Date(2021, 0, 12, 18, 45), 'event constraint date is correct');
      t.is(event.constraintType, 'startnoearlierthan', 'event constraint type is correct');
    }, {
      diag: 'Assert start date picking'
    }, {
      click: '.b-start-date .b-icon-calendar',
      desc: 'Clicked picker icon'
    }, {
      click: '[aria-label="January 14, 2021"]',
      desc: 'Clicked a date'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2021, 0, 14, 18, 45), 'event start date is correct');
      t.is(event.endDate, new Date(2021, 0, 18, 18, 45), 'event end date is correct');
      t.is(event.duration, 48, 'event duration is correct');
      t.is(event.constraintDate, new Date(2021, 0, 14, 18, 45), 'event constraint date is correct');
      t.is(event.constraintType, 'startnoearlierthan', 'event constraint type is correct');
    }, {
      diag: 'Assert end date picking'
    }, {
      click: '.b-end-date .b-icon-calendar',
      desc: 'Clicked picker icon'
    }, {
      click: '[aria-label="January 15, 2021"]',
      desc: 'Clicked a date'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2021, 0, 14, 18, 45), 'event start date is correct');
      t.is(event.endDate, new Date(2021, 0, 15, 18, 45), 'event end date is correct');
      t.is(event.duration, 24, 'event duration is correct');
      t.is(event.constraintDate, new Date(2021, 0, 14, 18, 45), 'event constraint date is correct');
      t.is(event.constraintType, 'startnoearlierthan', 'event constraint type is correct');
    }, {
      diag: 'Assert end date typing'
    }, {
      click: '[name="endDate"]',
      desc: 'Clicked endDate field'
    }, {
      type: '2021-01-17 18:45[TAB]',
      clearExisting: true,
      desc: 'Entered date'
    }, {
      waitFor: () => gantt.isEngineReady
    }, async () => {
      t.is(event.startDate, new Date(2021, 0, 14, 18, 45), 'event start date is correct');
      t.is(event.endDate, new Date(2021, 0, 16), 'event end date is correct'); // duration is: 5h15m + 24h

      t.isApprox(event.duration, 29.25, 'event duration is correct');
      t.is(event.constraintDate, new Date(2021, 0, 14, 18, 45), 'event constraint date is correct');
      t.is(event.constraintType, 'startnoearlierthan', 'event constraint type is correct');
    });
  });
});