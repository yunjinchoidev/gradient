"use strict";

StartTest(t => {
  function modelAscSorterFn(a, b) {
    return a.id > b.id ? 1 : -1;
  }

  t.it('Should resolve a nested parent-child cycle', async t => {
    let event1, event11, event111, dep1, dep2;
    let gantt;
    t.beforeEach(() => Gantt.destroy(gantt));
    t.it('Resolve by deactivating dependencies one by one', async t => {
      t.mockUrl('test-data', {
        delay: 100,
        responseText: JSON.stringify({
          success: true,
          tasks: {
            rows: [{
              id: 1,
              name: 'Launch SaaS Product',
              startDate: '2019-01-14',
              expanded: true,
              children: [{
                id: 11,
                name: 'Setup web server',
                duration: 10,
                startDate: '2019-01-14',
                endDate: '2019-01-23',
                expanded: true,
                children: [{
                  id: 111,
                  name: 'Install Apache',
                  startDate: '2019-01-14',
                  duration: 3,
                  endDate: '2019-01-17'
                }]
              }]
            }]
          },
          dependencies: {
            rows: [{
              id: 1,
              fromTask: 1,
              toTask: 11
            }, {
              id: 2,
              fromTask: 11,
              toTask: 111
            }]
          }
        })
      });
      const project = new ProjectModel({
        startDate: '2019-01-14',
        transport: {
          load: {
            url: 'test-data'
          }
        },
        autoLoad: true
      });
      const {
        eventStore,
        dependencyStore
      } = project;
      let eventFired = 0;
      project.on('cycle', async ({
        schedulingIssue,
        continueWithResolutionResult
      }) => {
        [dep1, dep2] = dependencyStore;
        event1 = eventStore.getById(1);
        event11 = eventStore.getById(11);
        event111 = eventStore.getById(111);
        const expectedEvents = [[event11, event111], [event1, event11, event111]];
        const expectedDependencies = [[dep2], [dep1]]; // debugger

        t.diag(`${eventFired + 1} schedulingIssue caught`);
        t.isInstanceOf(schedulingIssue, SchedulerProCycleEffect, 'proper schedulingIssue found'); // assert arrays content ignoring sorting order

        t.isDeeply(schedulingIssue.getEvents().sort(modelAscSorterFn), expectedEvents[eventFired], 'proper list of events');
        t.isDeeply(schedulingIssue.getDependencies().sort(modelAscSorterFn), expectedDependencies[eventFired], 'proper list of dependencies');
        t.isDeeply(schedulingIssue.getInvalidDependencies().sort(modelAscSorterFn), expectedDependencies[eventFired], 'proper list of invalid dependencies');
        const resolutions = schedulingIssue.getResolutions();
        t.isDeeply(resolutions, [t.any(RemoveDependencyResolution), t.any(DeactivateDependencyResolution)], 'proper resolutions found');
        eventFired++;

        if (eventFired <= 2) {
          var _resolutions$;

          (_resolutions$ = resolutions[1]) === null || _resolutions$ === void 0 ? void 0 : _resolutions$.resolve();
          continueWithResolutionResult(EffectResolutionResult.Resume);
        } else {
          t.fail('Should not be here');
          continueWithResolutionResult(EffectResolutionResult.Cancel);
        }
      });
      await t.waitForEvent(project, 'load');
      t.is(eventFired, 2, 'Conflict event has been fired twice');
      t.is(event1.startDate, new Date(2019, 0, 14), 'event #1 Start date is correct');
      t.is(event1.endDate, new Date(2019, 0, 17), 'event #1 End date is correct');
      t.is(event11.startDate, new Date(2019, 0, 14), 'event #11 Start date is correct');
      t.is(event11.endDate, new Date(2019, 0, 17), 'event #11 End date is correct');
      t.is(event111.startDate, new Date(2019, 0, 14), 'event #111 Start date is correct');
      t.is(event111.endDate, new Date(2019, 0, 17), 'event #111End date is correct');
      t.notOk(dep1.active, 'dependency #1 is inactive');
      t.notOk(dep2.active, 'dependency #2 is inactive');
      t.ok(dependencyStore.includes(dep1), 'dependency #1 is in the store');
      t.ok(dependencyStore.includes(dep2), 'dependency #2 is in the store');
    });
  });
});