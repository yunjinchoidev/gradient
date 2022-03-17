"use strict";

/* globals ProjectModel */
StartTest(t => {
  // https://github.com/bryntum/bryntum-suite/pull/2904
  t.it('Should be no extra data to sync after auto recalculation just loaded data', async t => {
    t.mockUrl('load', {
      responseText: JSON.stringify({
        success: true,
        tasks: {
          rows: [{
            id: 11,
            name: 'task A',
            startDate: '2019-01-14',
            duration: 1,
            endDate: '2019-01-15',
            manuallyScheduled: true
          }, {
            id: 12,
            name: 'task B',
            startDate: '2019-01-15',
            duration: 1,
            endDate: '2019-01-16',
            manuallyScheduled: true
          }]
        },
        dependencies: {
          rows: [{
            id: 1,
            fromTask: 11,
            toTask: 12
          }]
        }
      })
    });
    const syncResponse = {
      success: true,
      tasks: {
        rows: [{
          id: 12,
          startDate: '2019-01-16',
          endDate: '2019-01-17'
        }]
      }
    };
    t.mockUrl('sync', {
      responseText: JSON.stringify(syncResponse)
    });
    const project = new ProjectModel({
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
    t.notOk(project.getChangeSetPackage(), 'No data in set package exists before sync');
    project.eventStore.getAt(0).set('endDate', '2019-01-18');
    const result = await project.sync();
    t.isDeeply(result, {
      response: syncResponse,
      request: t.any(Object),
      rawResponse: t.any(Object),
      responseText: JSON.stringify(syncResponse)
    }, 'sync result is correct');
    t.notOk(project.getChangeSetPackage(), 'No data in set package exists after sync');
    t.is(project.eventStore.getAt(0).get('endDate').getDate(), 18, 'Start date has been successfully updated');
  });
});