"use strict";

/* global ProjectModel */
StartTest(t => {
  //https://github.com/bryntum/support/issues/1913
  t.it('Repopulating project stores works fine', async t => {
    t.mockUrl('foo', {
      responseText: JSON.stringify({
        success: true,
        tasks: {
          rows: [{
            id: 1,
            name: 'Test',
            startDate: '2021-04-02',
            duration: 1
          }]
        }
      })
    });
    const project = new ProjectModel({
      transport: {
        load: {
          url: 'foo'
        }
      },
      repopulateOnDataset: true,
      taskStore: {
        syncDataOnLoad: true
      }
    });
    await project.load();
    project.taskStore.data = [{
      id: 1,
      name: 'Test 2',
      startDate: '2021-04-03',
      duration: 1
    }];
  });
});