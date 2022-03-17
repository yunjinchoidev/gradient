"use strict";

StartTest(t => {
  let timeline,
      project = t.getProject();
  t.beforeEach(t => {
    var _timeline, _project;

    (_timeline = timeline) === null || _timeline === void 0 ? void 0 : _timeline.destroy();
    timeline = null;
    (_project = project) === null || _project === void 0 ? void 0 : _project.destroy();
    project = t.getProject({
      eventsData: [{
        id: 11,
        cls: 'id11',
        name: 'Investigate',
        percentDone: 70,
        startDate: '2017-01-16',
        duration: 10,
        schedulingMode: 'FixedDuration'
      }, {
        id: 12,
        cls: 'id12',
        name: 'Assign resources',
        percentDone: 60,
        startDate: '2017-01-16',
        duration: 8,
        schedulingMode: 'FixedUnits'
      }, {
        id: 13,
        name: 'Future',
        percentDone: 50,
        startDate: '2019-02-03T00:00:00',
        duration: 1,
        manuallyScheduled: true,
        schedulingMode: 'FixedEffort'
      }]
    });
  });

  async function createTimeLine(config) {
    timeline = window.timeline = Timeline.new({
      appendTo: document.body,
      width: 700,
      enableEventAnimations: false,
      project
    }, config);
    await project.commitAsync();
  }

  t.it('Should size row height based on available subGrid body height', async t => {
    await createTimeLine();
    t.chain({
      waitFor: () => timeline.rowHeight === timeline.bodyContainer.offsetHeight,
      desc: 'Correct row height'
    });
  });
  t.it('Should show timeline start / end even if no tasks are marked showInTimeline', async t => {
    await createTimeLine();
    t.chain({
      waitForContentLike: ['.b-timeline-startdate', timeline.getFormattedDate(timeline.startDate)],
      desc: 'Start date label has correct value'
    }, {
      waitForContentLike: ['.b-timeline-enddate', timeline.getFormattedDate(timeline.endDate)],
      desc: 'End date label has correct value'
    });
  });
  t.it('Should refresh on new task added', async t => {
    await createTimeLine();
    project.taskStore.rootNode.appendChild({
      name: 'Foo',
      startDate: '2017-01-16',
      endDate: '2017-01-26',
      duration: 10,
      showInTimeline: true
    });
    await project.propagateAsync();
    t.contentLike('.b-timeline-startdate', timeline.getFormattedDate(timeline.startDate), 'Start date label has correct value');
    t.contentLike('.b-timeline-enddate', timeline.getFormattedDate(timeline.endDate), 'End date label has correct value');
    t.chain({
      waitForSelector: '.b-sch-event:contains(Foo)'
    });
  });
  t.it('Should refresh on task removed', async t => {
    await createTimeLine();
    project.taskStore.getById(11).showInTimeline = true;
    t.chain({
      waitForSelector: '.b-sch-event:contains(Investigate)'
    }, async () => {
      t.contentLike('.b-timeline-startdate', timeline.getFormattedDate(timeline.startDate), 'Start date label has correct value');
      t.contentLike('.b-timeline-enddate', timeline.getFormattedDate(timeline.endDate), 'End date label has correct value');
      project.taskStore.getById(11).remove();
    }, {
      waitForSelectorNotFound: `${timeline.unreleasedEventSelector} .b-sch-event:contains(Investigate)`
    });
  });
  t.it('Should refresh on task showInTimeline updated', async t => {
    await createTimeLine();
    project.taskStore.getById(11).showInTimeline = true;
    t.chain({
      waitForSelector: '.b-sch-event:contains(Investigate)'
    }, async () => {
      t.contentLike('.b-timeline-startdate', timeline.getFormattedDate(timeline.startDate), 'Start date label has correct value');
      t.contentLike('.b-timeline-enddate', timeline.getFormattedDate(timeline.endDate), 'End date label has correct value');
      project.taskStore.getById(11).showInTimeline = false;
    }, {
      waitForSelectorNotFound: `${timeline.unreleasedEventSelector} .b-sch-event:contains(Investigate)`
    });
  });
  t.it('Should refresh on task start/duration/ updated', async t => {
    await createTimeLine();
    const task = project.taskStore.getById(11);
    task.showInTimeline = true;
    t.chain({
      waitForSelector: '.b-sch-event:contains(Investigate)'
    }, async () => task.setDuration(1), {
      waitFor: () => timeline.eventStore.getById(task.id).duration === 1
    });
  });
  t.it('Should extend timeline if new task appears outside current range', async t => {
    await createTimeLine();
    project.taskStore.getById(13).showInTimeline = true;
    t.chain({
      waitForSelector: '.b-sch-event:contains(Future)'
    }, () => {
      t.contentLike('.b-timeline-startdate', timeline.getFormattedDate(timeline.startDate), 'Start date label has correct value');
      t.contentLike('.b-timeline-enddate', timeline.getFormattedDate(timeline.endDate), 'End date label has correct value');
      t.is(timeline.endDate.getFullYear(), 2019, 'Time axis extended');
    });
  });
  t.it('Should refresh timeline if removing all tasks from taskStore', async t => {
    await createTimeLine();
    project.taskStore.getById(11).showInTimeline = true;
    t.chain({
      waitForSelector: '.b-sch-event'
    }, next => {
      project.taskStore.removeAll();
      next();
    }, {
      waitForSelectorNotFound: timeline.unreleasedEventSelector
    });
  });
  t.it('Should refresh timeline if loading setting ´data´on the taskStore', async t => {
    await createTimeLine();
    project.taskStore.getById(11).showInTimeline = true;
    t.chain({
      waitForSelector: '.b-sch-event'
    }, next => {
      project.taskStore.data = [];
      next();
    }, {
      waitForSelectorNotFound: timeline.unreleasedEventSelector
    });
  }); // https://app.assembla.com/spaces/bryntum/tickets/9148-crash-after-resizing-task-progress-bar-in-timeline-demo/details#

  t.it('Should not crash if modifying a task percentDone inside a parent that has showInTimeline set to true', async t => {
    await createTimeLine();
    project.taskStore.removeAll();
    await project.commitAsync();
    project.taskStore.rootNode.appendChild({
      id: 1,
      name: 'Parent',
      startDate: '2017-01-16',
      duration: 1,
      leaf: false,
      showInTimeline: true,
      expanded: true,
      children: [{
        id: 2,
        name: 'Child',
        percentDone: 0,
        startDate: '2017-01-16',
        duration: 1,
        leaf: true
      }]
    });
    await project.commitAsync();
    await t.waitForSelector('.b-sch-event:contains(Parent)');
    project.taskStore.getById(2).percentDone = 100;
    await project.commitAsync();
  }); // https://github.com/bryntum/support/issues/149

  t.it('Should not remove events from timeline if taskStore parent node is collapsed', async t => {
    await createTimeLine();
    project.taskStore.rootNode.firstChild.appendChild({
      id: 2,
      name: 'Foo',
      startDate: new Date(2017, 0, 16),
      duration: 1,
      leaf: true,
      showInTimeline: true
    });
    project.taskStore.toggleCollapse(project.taskStore.rootNode.firstChild, false);
    await project.commitAsync();
    t.chain({
      waitForSelector: '.b-sch-event:contains(Foo)'
    }, () => {
      t.wontFire(timeline.eventStore, 'remove');
      project.taskStore.toggleCollapse(project.taskStore.rootNode.firstChild, true);
      t.selectorExists(`${timeline.unreleasedEventSelector} .b-sch-event:contains(Foo)`, 'Event still present after collapse');
    });
  });
  t.it('Should position milestone correctly', async t => {
    project = t.getProject({
      startDate: '2020-06-02',
      eventsData: [{
        id: 11,
        name: 'Investigate',
        startDate: '2020-06-02',
        duration: 1,
        showInTimeline: true
      }, {
        id: 12,
        name: 'Assign resources',
        startDate: '2020-06-02',
        duration: 0,
        showInTimeline: true
      }]
    });
    await project.commitAsync();
    await createTimeLine({
      project
    });
    await t.waitForSelector(timeline.unreleasedEventSelector);
    const [task1, task2] = timeline.project.eventStore.getRange(),
          task1Box = Rectangle.from(timeline.getElementFromEventRecord(task1), timeline.foregroundCanvas),
          task2Box = Rectangle.from(timeline.getElementFromEventRecord(task2), timeline.foregroundCanvas);
    t.is(task1.startDate, task2.startDate, 'Task and milestone start on the same date');
    t.isApprox(task2Box.left + task2Box.width / 2, task1Box.left, 1, 'Milestone is aligned to the event element');
  });
  t.it('Should not crash if overriding features object', async t => {
    project = t.getProject({
      startDate: '2020-06-02',
      eventsData: [{
        id: 11,
        name: 'Investigate',
        startDate: '2020-06-02',
        duration: 1,
        showInTimeline: true
      }]
    });
    await createTimeLine({
      project,
      features: {}
    });
    await t.waitForSelector(timeline.unreleasedEventSelector);
  });
  t.it('Should render to container', async t => {
    const project = t.getProject({
      eventsData: [{
        id: 1,
        startDate: '2021-04-28',
        duration: 2,
        showInTimeline: true
      }]
    });
    const container = new Container({
      appendTo: document.body,
      width: 700,
      items: [{
        type: 'timeline',
        cls: 'timeline1',
        project
      }]
    });
    const timeline2 = new Timeline({
      appendTo: document.body,
      width: 700,
      cls: 'timeline2',
      project
    });
    await project.commitAsync();
    await t.waitForSelector('.timeline1 .b-sch-event');
    await t.waitForSelector('.timeline2 .b-sch-event');
    t.selectorCountIs('.timeline1', 1, 'First timeline is rendered');
    t.selectorCountIs('.timeline1 .b-grid-row', 1, 'First timeline has single row');
    t.selectorCountIs('.timeline1 .b-sch-event', 1, 'First timeline has single event');
    t.selectorCountIs('.timeline2', 1, 'Second timeline is rendered');
    t.selectorCountIs('.timeline2 .b-grid-row', 1, 'Second timeline has single row');
    t.selectorCountIs('.timeline2 .b-sch-event', 1, 'Second timeline has single event');
    t.pass('Timeline is rendered');
    container.destroy();
    timeline2.destroy();
    project.destroy();
  }); // https://github.com/bryntum/support/issues/3454

  t.it('Should clone cls field from task', async t => {
    await createTimeLine({
      project: t.getProject({
        startDate: '2020-06-02',
        eventsData: [{
          id: 11,
          name: 'Investigate',
          startDate: '2020-06-02',
          duration: 1,
          cls: 'foo',
          showInTimeline: true
        }]
      })
    });
    await t.waitForSelector(timeline.unreleasedEventSelector + ' .foo');
  });
});