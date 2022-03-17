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
  t.it('Should populate WBS when setting inlineData', async t => {
    const projectModel = new ProjectModel({
      validateResponse: true
    });
    projectModel.inlineData = {
      eventsData: [{
        id: 1000,
        name: 'Derp',
        percentDone: 50,
        startDate: '2019-01-14',
        expanded: true,
        children: [{
          id: 1001,
          name: 'Herp',
          percentDone: 50,
          duration: 10,
          startDate: '2019-01-14',
          rollup: true,
          endDate: '2019-01-23',
          expanded: true
        }]
      }]
    };

    const getNodeText = n => `${n.name} ${n.wbsValue}`;

    await t.waitFor(() => getNodeText(projectModel.children[0]) === 'Derp 1');
    t.is(getNodeText(projectModel.children[0].children[0]), 'Herp 1.1');
    projectModel.inlineData = {
      eventsData: [{
        id: 1,
        name: 'Herp',
        percentDone: 30,
        startDate: '2019-01-01',
        children: [{
          id: 2,
          name: 'Derp',
          percentDone: 100,
          duration: 10,
          startDate: '2019-01-01',
          endDate: '2019-01-02'
        }]
      }]
    };
    await t.waitFor(() => getNodeText(projectModel.children[0]) === 'Herp 1');
    t.is(getNodeText(projectModel.children[0].children[0]), 'Derp 1.1');
  });
  t.it('Should join filtered records to engine', async t => {
    t.mockUrl('foo', {
      responseText: JSON.stringify({
        success: true,
        tasks: {
          rows: [{
            id: 1,
            name: 'Task 1',
            startDate: '2021-04-02',
            duration: 1
          }, {
            id: 2,
            name: 'Task 2',
            duration: 1
          }, {
            id: 3,
            name: 'Task 3',
            duration: 1
          }]
        },
        resources: {
          rows: [{
            id: 1,
            name: 'Resource 1'
          }, {
            id: 2,
            name: 'Resource 2'
          }, {
            id: 3,
            name: 'Resource 3'
          }]
        },
        dependencies: {
          rows: [{
            id: 1,
            fromEvent: 1,
            toEvent: 2
          }, {
            id: 2,
            fromEvent: 2,
            toEvent: 3
          }]
        },
        assignments: {
          rows: [{
            id: 1,
            resource: 1,
            event: 1
          }, {
            id: 2,
            resource: 2,
            event: 2
          }, {
            id: 3,
            resource: 3,
            event: 3
          }]
        }
      })
    });
    t.it('Delayed calculation', async t => {
      const project = new ProjectModel({
        delayCalculation: true,
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
      project.taskStore.filterBy(r => r.id !== 1);
      project.resourceStore.filterBy(r => r.id !== 2);
      project.dependencyStore.filterBy(r => r.id !== 2);
      project.assignmentStore.filterBy(r => r.id !== 3);
      await project.load();
      t.is(project.taskStore.getById(2).startDate, new Date(2021, 3, 3), 'Filtered task has effect on schedule');
      t.is(project.taskStore.getById(3).startDate, new Date(2021, 3, 4), 'Filtered dependency has effect on schedule');
      t.is(project.taskStore.getById(3).resources[0].id, 3, 'Filtered assignment has effect on schedule');
      project.destroy();
    });
    t.it('Not-Delayed calculation', async t => {
      const project = new ProjectModel({
        delayCalculation: false,
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
      project.taskStore.filterBy(r => r.id !== 1);
      project.resourceStore.filterBy(r => r.id !== 2);
      project.dependencyStore.filterBy(r => r.id !== 2);
      project.assignmentStore.filterBy(r => r.id !== 3);
      await project.load();
      t.is(project.taskStore.getById(2).startDate, new Date(2021, 3, 3), 'Filtered task has effect on schedule');
      t.is(project.taskStore.getById(3).startDate, new Date(2021, 3, 4), 'Filtered dependency has effect on schedule');
      t.is(project.taskStore.getById(3).resources[0].id, 3, 'Filtered assignment has effect on schedule');
      project.destroy();
    });
  });
});