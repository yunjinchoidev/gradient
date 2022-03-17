"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    return (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  });
  t.it('Should not fail when all ticks are filtered out from the timeaxis', async t => {
    gantt = await t.getGanttAsync();
    await t.waitForSelector('.b-sch-dependency');
    gantt.timeAxis.filter(() => false);
    await t.waitForSelectorNotFound('.b-sch-dependency');
    t.notOk(gantt.timeAxis.count, 'No ticks in the store');
    gantt.timeAxis.clearFilters();
    await t.waitForSelector('.b-sch-dependency');
    t.ok(gantt.timeAxis.count, 'Ticks are in the store');
  });
  t.it('Should show non-working time ranges from project calendar', t => {
    const project = t.getProject({
      calendar: 'general'
    });
    gantt = t.getGantt({
      startDate: new Date(2017, 0, 14),
      endDate: new Date(2017, 0, 30),
      features: {
        nonWorkingTime: true
      },
      project
    });
    t.chain({
      waitForPropagate: project
    }, async () => {
      t.selectorCountIs('.b-grid-headers .b-sch-nonworkingtime', 5, '5 non-working ranges');
      project.calendar = project.calendarManagerStore.add({
        intervals: [{
          recurrentStartDate: 'on Tue at 0:00',
          recurrentEndDate: 'on Wed at 0:00',
          isWorking: false
        }]
      })[0];
      await project.commitAsync();
    }, async () => {
      t.selectorCountIs('.b-grid-headers .b-sch-nonworkingtime', 4, '4 non-working ranges');
      project.calendar = project.calendarManagerStore.getById('general');
      await project.commitAsync();
    }, () => {
      t.selectorCountIs('.b-grid-headers .b-sch-nonworkingtime', 5, 'non-working days are not visible');
    });
  }); // https://github.com/bryntum/support/issues/827

  t.it('Should show non-working time ranges from project calendar when data is loaded later and there are more than 500 events', async t => {
    t.mockUrl('loadurl', {
      delay: 10,
      responseText: JSON.stringify({
        success: true,
        project: {
          calendar: 'general'
        },
        calendars: {
          rows: t.getProjectCalendarsData()
        },
        tasks: {
          rows: (() => {
            const result = []; // 500 is here because EngineReplica declares projectRefreshThreshold as 500,
            // which means that 'update' event will not be fired, assuming it is enough to have 'refresh' event fired

            for (let id = 1; id <= 500; id++) {
              result.push({
                id,
                name: id,
                startDate: new Date(2017, 0, 9),
                endDate: new Date(2017, 0, 11)
              });
            }

            return result;
          })()
        }
      })
    });
    const project = new ProjectModel({
      autoLoad: false,
      transport: {
        load: {
          url: 'loadurl'
        }
      }
    });
    gantt = await t.getGanttAsync({
      startDate: new Date(2017, 0, 14),
      endDate: new Date(2017, 0, 30),
      features: {
        nonWorkingTime: true // Enabled by default

      },
      project
    });
    t.chain(async () => {
      t.selectorCountIs('.b-grid-headers .b-sch-nonworkingtime', 0, 'non-working days are not visible');
      await project.load();
    }, {
      waitForPropagate: project
    }, () => {
      t.selectorCountIs('.b-grid-headers .b-sch-nonworkingtime', 5, '5 non-working ranges');
    });
  });
  t.it('Should not show non-working time ranges shorter than the configured timeAxis unit', t => {
    const project = t.getProject({
      calendar: 'business'
    });
    gantt = t.getGantt({
      autoAdjustTimeAxis: false,
      project
    });
    const // options for `zoomToLevel` call
    zoomLevelOptions = {
      // for levels 0-8 we use this range
      0: {
        startDate: new Date(2015, 0, 9),
        endDate: new Date(2019, 0, 17)
      },
      // for levels 9-16 we use this range
      9: {
        startDate: new Date(2017, 0, 9),
        endDate: new Date(2017, 0, 17)
      },
      // for levels 17-23 we use this range
      17: {
        startDate: new Date(2017, 0, 16),
        endDate: new Date(2017, 0, 17)
      }
    },
          // expected number of non-working ranges to assert
    numberOfRangesOnZoomLevel = {
      // for levels 0-8 there should not be ranges
      0: 0,
      // for levels 9-11 there should 1 ranges
      9: 1,
      // for levels 12-16 there should 13 ranges
      12: 13,
      // for levels 17-... there should 3 ranges
      17: 3
    };
    let zoomOptions, expectedNumberOfRanges;
    t.waitForPropagate(project, () => {
      function assertZoomLevel(zoomLevel) {
        t.diag(`Asserting ${gantt.presets.getAt(zoomLevel).name} (level ${zoomLevel})`);
        t.waitForEvent(gantt, 'presetChange', () => {
          t.selectorCountIs('.b-grid-headers .b-sch-nonworkingtime', expectedNumberOfRanges, `level ${zoomLevel}: proper number of non-working ranges`);
          zoomLevel++; // if there are more levels to iterate

          if (zoomLevel <= gantt.maxZoomLevel) {
            assertZoomLevel(zoomLevel);
          }
        }); // if we need to update zoomToLevel call options starting from this level

        if (zoomLevelOptions[zoomLevel]) {
          zoomOptions = zoomLevelOptions[zoomLevel];
        } // if we need to update asserted number of ranges starting from this level


        if (zoomLevel in numberOfRangesOnZoomLevel) {
          expectedNumberOfRanges = numberOfRangesOnZoomLevel[zoomLevel];
        }

        gantt.zoomToLevel(zoomLevel, zoomOptions);
      } // Start asserting


      assertZoomLevel(0);
    });
  });
  t.it('Should show non-working time for levels having unit <= maxTimeAxisUnit only', t => {
    const project = t.getProject({
      calendar: 'business'
    });
    gantt = t.getGantt({
      autoAdjustTimeAxis: false,
      features: {
        nonWorkingTime: {
          maxTimeAxisUnit: 'hour'
        }
      },
      project
    });
    const // options for `zoomToLevel` call
    zoomLevelOptions = {
      // for levels 0-8 we use this range
      0: {
        startDate: new Date(2015, 0, 9),
        endDate: new Date(2019, 0, 17)
      },
      // for levels 9-16 we use this range
      9: {
        startDate: new Date(2017, 0, 9),
        endDate: new Date(2017, 0, 17)
      },
      // for levels 17-23 we use this range
      17: {
        startDate: new Date(2017, 0, 16),
        endDate: new Date(2017, 0, 17)
      }
    },
          // expected number of non-working ranges to assert
    numberOfRangesOnZoomLevel = {
      // for levels 0-8 there should not be ranges
      0: 0,
      // for levels 9-11 there should 1 ranges
      9: 0,
      // for levels 12-16 there should 13 ranges
      12: 13,
      // for levels 17-... there should 3 ranges
      17: 3
    };
    let zoomOptions, expectedNumberOfRanges;
    t.waitForPropagate(project, () => {
      function assertZoomLevel(zoomLevel) {
        t.diag(`Asserting ${gantt.presets.getAt(zoomLevel).name} (level ${zoomLevel})`);
        t.waitForEvent(gantt, 'presetChange', () => {
          t.selectorCountIs('.b-grid-headers .b-sch-nonworkingtime', expectedNumberOfRanges, `level ${zoomLevel}: proper number of non-working ranges`);
          zoomLevel++; // if there are more levels to iterate

          if (zoomLevel <= gantt.maxZoomLevel) {
            assertZoomLevel(zoomLevel);
          }
        }); // if we need to update zoomToLevel call options starting from this level

        if (zoomLevelOptions[zoomLevel]) {
          zoomOptions = zoomLevelOptions[zoomLevel];
        } // if we need to update asserted number of ranges starting from this level


        if (zoomLevel in numberOfRangesOnZoomLevel) {
          expectedNumberOfRanges = numberOfRangesOnZoomLevel[zoomLevel];
        }

        gantt.zoomToLevel(zoomLevel, zoomOptions);
      } // Start asserting


      assertZoomLevel(0);
    });
  }); // https://github.com/bryntum/support/issues/3255

  t.it('Should support adding `cls` field to be able to style calendar intervals', async t => {
    gantt = t.getGantt({
      startDate: new Date(2020, 2, 20),
      project: new ProjectModel({
        calendar: 'general',
        startDate: new Date(2020, 2, 1),
        calendarsData: [{
          id: 'general',
          name: 'General',
          intervals: [{
            recurrentStartDate: 'on Sat at 0:00',
            recurrentEndDate: 'on Mon at 0:00',
            isWorking: false,
            cls: 'weekends'
          }, {
            startDate: '2020-03-24',
            endDate: '2020-03-25',
            isWorking: false,
            cls: 'singleInterval'
          }]
        }]
      })
    });
    await t.waitForSelector('.b-sch-timerange.b-sch-nonworkingtime.b-sch-range.b-nonworkingtime.singleInterval');
    t.pass('CSS class added for single interval');
    await t.waitForSelector('.b-sch-timerange.b-sch-nonworkingtime.b-sch-range.b-nonworkingtime.weekends');
    t.pass('CSS class added for single interval');
  });
});