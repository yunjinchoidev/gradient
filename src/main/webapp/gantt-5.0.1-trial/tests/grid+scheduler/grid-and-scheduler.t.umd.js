"use strict";

/* global Grid, Scheduler, Gantt */
StartTest(t => {
  // Disable floating root checks for old online versions
  if (t.url.includes('online-bundles')) {
    var _window$VersionHelper, _window$bryntum$sched;

    const onlineVersionHelper = ((_window$VersionHelper = window.VersionHelper) === null || _window$VersionHelper === void 0 ? void 0 : _window$VersionHelper.scheduler) || ((_window$bryntum$sched = window.bryntum.scheduler.VersionHelper) === null || _window$bryntum$sched === void 0 ? void 0 : _window$bryntum$sched.scheduler);
    t.diag(`Online version is ${onlineVersionHelper.version}`); // Disable testing with the older online versions

    if (onlineVersionHelper.isOlderThan('4.3.0')) {
      t.pass('Test skipped until compatible version is online');
      return;
    }

    if (onlineVersionHelper.isOlderThan('4.1.0')) {
      t.assertMaxOneFloatRoot = () => {};
    }
  }

  const gridConfig = {},
        schedulerConfig = {},
        ganttConfig = {};

  switch (t.getMode()) {
    case 'umd':
      gridConfig.appendTo = 'grid-container';
      schedulerConfig.appendTo = 'scheduler-container';
      ganttConfig.appendTo = 'gantt-container';
      break;

    case 'module':
      gridConfig.appendTo = schedulerConfig.appendTo = ganttConfig.appendTo = document.body; // TODO: check if this is needed

      if (t.url.includes('online-bundles')) {
        schedulerConfig.cls = 'b-gridbase'; // Need this while online version is behind
      }

      break;
  }

  t.ok(Grid, 'Grid available');
  t.ok(Scheduler, 'Scheduler available');
  t.ok(Gantt, 'Gantt available');
  new Grid(Object.assign({
    id: 'grid',
    width: 1024,
    height: 300,
    columns: [{
      field: 'name',
      text: 'Name'
    }],
    data: [{
      name: 'Mr Fantastic'
    }]
  }, gridConfig));
  new Scheduler(Object.assign({
    id: 'scheduler',
    width: 1024,
    height: 300,
    resources: [{
      id: 1,
      name: 'The Thing'
    }],
    startDate: new Date(2019, 4, 1),
    endDate: new Date(2019, 4, 31),
    events: [{
      resourceId: 1,
      startDate: new Date(2019, 4, 21),
      duration: 2
    }]
  }, schedulerConfig));
  new Gantt(Object.assign({
    id: 'gantt',
    width: 1024,
    height: 300,
    project: {
      eventsData: [{}]
    }
  }, ganttConfig));
  t.chain({
    waitForSelector: '.b-grid#grid',
    desc: 'Grid element found'
  }, {
    waitForSelector: '.b-scheduler#scheduler',
    desc: 'Scheduler element found'
  }, {
    waitForSelector: '.b-gantt#gantt',
    desc: 'Gantt element found'
  }, {
    rightClick: '#grid .b-grid-cell',
    desc: 'Grid: trigger element added to float root'
  }, {
    rightClick: '#scheduler .b-sch-timeaxis-cell',
    desc: 'Scheduler: trigger element added to float root'
  }, {
    rightClick: '#gantt .b-sch-timeaxis-cell',
    desc: 'Gantt: trigger element added to float root'
  }, {
    waitForSelector: '.b-float-root'
  }, () => {
    t.notOk('BUNDLE_EXCEPTION' in window, 'No exception from including all 3 products');
  });
});