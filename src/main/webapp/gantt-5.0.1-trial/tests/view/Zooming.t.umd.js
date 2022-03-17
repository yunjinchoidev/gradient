"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(t => {
    gantt && !gantt.isDestroyed && gantt.destroy();
  });
  const hourMs = 1000 * 60 * 60;
  t.it('should support zoomToFit API', async t => {
    gantt = t.getGantt({
      appendTo: document.body,
      features: {
        nonWorkingTime: false
      },
      project: {
        // set to `undefined` to overwrite the default '2017-01-16' value in `t.getProject`
        startDate: undefined,
        eventsData: [{
          id: 1,
          name: 'Steve',
          startDate: new Date(2018, 11, 1),
          endDate: new Date(2018, 11, 10)
        }]
      }
    });
    await gantt.project.commitAsync();
    gantt.zoomToFit();
    const visibleStartDate = gantt.getDateFromCoordinate(gantt.scrollLeft),
          visibleEndDate = gantt.getDateFromCoordinate(gantt.scrollLeft + gantt.timeAxisViewModel.availableSpace);
    t.isApprox(visibleStartDate.getTime(), new Date(2018, 11, 1).getTime(), hourMs, 'Start date is ok');
    t.isApprox(visibleEndDate.getTime(), new Date(2018, 11, 10).getTime(), hourMs, 'End date is ok');
  }); // https://github.com/bryntum/support/issues/559

  t.it('Should not crash if zooming with schedule collapsed', async t => {
    gantt = t.getGantt();
    await gantt.project.commitAsync();
    await gantt.subGrids.normal.collapse();
    gantt.zoomIn();
    gantt.zoomOut();
    gantt.zoomToFit();
    t.pass('No crash');
  });
  t.it('Should set project start/end as Gantt timespan after loading', async t => {
    gantt = new Gantt({
      appendTo: document.body,
      width: 800,
      tasks: [{
        id: 1,
        name: 'Task',
        startDate: new Date(2019, 8, 18),
        duration: 2,
        durationUnit: 'd'
      }, {
        id: 2,
        name: 'Later Task',
        startDate: new Date(2021, 8, 18),
        duration: 2,
        durationUnit: 'd',
        constraintType: 'muststarton',
        constraintDate: '2021-09-18'
      }]
    });
    await t.waitForSelector('.b-gantt-task');
    t.is(gantt.startDate, new Date(2019, 8, 15), 'Correct start date');
    t.is(gantt.endDate, new Date(2021, 8, 26), 'Correct end date');
  }); // https://github.com/bryntum/support/issues/2921

  t.it('Should set reasonable project start + end of the Gantt after data lacking dates', async t => {
    gantt = new Gantt({
      appendTo: document.body,
      tasks: [{
        id: 1,
        startDate: '2021-05-02',
        name: 'parent',
        expanded: true,
        children: [{
          id: 2,
          name: 'child',
          duration: 0
        }]
      }]
    });
    await t.waitForSelector('.b-gantt-task');
    t.is(gantt.startDate, new Date(2021, 4, 2), 'Correct time axis start date');
    t.is(gantt.endDate, DateHelper.add(gantt.startDate, gantt.timeAxis.defaultSpan, gantt.timeAxis.mainUnit), 'Correct time axis end date');
  });
  t.it('Should keep visible date range during zooming', async t => {
    gantt = await t.getGanttAsync();
    const {
      visibleDateRange
    } = gantt;
    gantt.zoomIn();
    t.isDeeply(gantt.visibleDateRange, visibleDateRange, 'Visible date range should remain intact right after zoom');
    await t.waitForEvent(gantt, 'horizontalScroll');
    t.isGreater(gantt.visibleDateRange.startDate, visibleDateRange.startDate, 'Start date changed');
    t.isLess(gantt.visibleDateRange.endDate, visibleDateRange.endDate, 'End date changed');
  });
});