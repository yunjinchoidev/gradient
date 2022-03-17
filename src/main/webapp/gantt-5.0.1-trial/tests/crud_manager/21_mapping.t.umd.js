"use strict";

/* globals ProjectModel */
StartTest(t => {
  let project;
  t.beforeEach(() => ResourceModel.destroy(project)); // https://github.com/bryntum/support/issues/426

  t.it('Should load resource with invalid calendar', async t => {
    t.mockUrl('load', {
      responseText: JSON.stringify({
        tasks: {
          rows: [{
            id: 1,
            startDate: '2020-03-17',
            duration: 2
          }]
        },
        resources: {
          rows: [{
            id: 1,
            name: 'Albert',
            calendar: ''
          }]
        },
        assignments: {
          rows: [{
            id: 1,
            resource: 1,
            event: 1
          }]
        }
      })
    });
    project = new ProjectModel({
      transport: {
        load: {
          url: 'load'
        }
      }
    });
    await project.load();
    t.is(project.resourceStore.first.effectiveCalendar, project.effectiveCalendar, 'Resource calendar is ok');
  }); // https://github.com/bryntum/support/issues/424

  t.it('Resource should not throw when trying to serialize calendar field', async t => {
    t.mockUrl('load', {
      responseText: '{}'
    });
    project = new ProjectModel({
      transport: {
        sync: {
          url: 'sync'
        }
      }
    });
    const [resource] = project.resourceStore.add({
      name: 'new'
    });
    t.isDeeply(resource.persistableData, {
      id: resource.id,
      name: 'new'
    }, 'proper resource data');
    await project.commitAsync();
    t.is(resource.effectiveCalendar, project.effectiveCalendar, 'resource uses project calendar');
    const newCalendar = project.calendarManagerStore.add({
      id: 'new'
    })[0];
    resource.calendar = 'new';
    await project.commitAsync();
    t.is(resource.calendar, newCalendar, 'proper resource calendar');
    t.is(resource.effectiveCalendar, newCalendar, 'proper resource calendar found');
    t.isDeeply(resource.persistableData, {
      id: resource.id,
      name: 'new',
      calendar: newCalendar.id
    }, 'proper resource persistable data');
  }); // https://github.com/bryntum/support/issues/427

  t.it('Should map calendar field', async t => {
    class MyResource extends ResourceModel {
      static get fields() {
        return [{
          name: 'calendar',
          dataSource: 'CalendarId',
          serialize: r => r && r.id
        }];
      }

    }

    t.mockUrl('load', {
      responseText: JSON.stringify({
        project: {
          calendar: 1
        },
        calendars: {
          rows: [{
            id: 1,
            name: 'Calendar 1'
          }, {
            id: 2,
            name: 'Calendar 2'
          }]
        },
        tasks: {
          rows: [{
            id: 1,
            leaf: true,
            startDate: '2020-03-17',
            duration: 2
          }]
        },
        resources: {
          rows: [{
            id: 1,
            name: 'Albert'
          }]
        },
        assignments: {
          rows: [{
            id: 1,
            resource: 1,
            event: 1
          }]
        }
      })
    });
    project = new ProjectModel({
      resourceModelClass: MyResource,
      transport: {
        load: {
          url: 'load'
        },
        sync: {
          url: 'sync'
        }
      }
    });
    await project.load();
    t.is(project.resourceStore.first.effectiveCalendar, project.calendar, 'Resource calendar is ok');
    const [resource] = project.resourceStore.add({
      name: 'new',
      CalendarId: 2
    });
    let cancelHandlerCallCounter = 0;

    const cancelHandler = () => {
      cancelHandlerCallCounter++;
      t.pass('Sync request cancelled');
    };

    project.on({
      beforeSync({
        pack
      }) {
        t.isDeeply(pack.resources.added[0], {
          $PhantomId: resource.id,
          name: 'new',
          CalendarId: 2
        }, 'Resource add request is ok before propagation');
        return false;
      },

      syncCanceled: cancelHandler,
      once: true
    });
    await project.sync();
    await project.commitAsync();
    project.on({
      beforeSync({
        pack
      }) {
        t.isDeeply(pack.resources.added[0], {
          $PhantomId: resource.id,
          CalendarId: 2,
          name: 'new'
        }, 'Resource add request is ok after propagation');
        return false;
      },

      syncCanceled: cancelHandler,
      once: true
    });
    await project.sync();
    t.is(cancelHandlerCallCounter, 2, 'Canceled 2 times');
  });
});