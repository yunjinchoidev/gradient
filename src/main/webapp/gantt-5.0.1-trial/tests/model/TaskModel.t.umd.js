"use strict";

StartTest(t => {
  t.it('Sequence number should work', t => {
    const task = new TaskModel({
      // 0
      children: [{}, // 1
      {
        // 2
        children: [{}, // 3
        {} // 4
        ]
      }, {} // 5
      ]
    });

    function getSequence() {
      const sequence = [];
      task.traverse(t => sequence.push(t.sequenceNumber));
      return sequence;
    }

    t.isDeeply(getSequence(), [0, 1, 2, 3, 4, 5], 'Correct sequence numbers initially');
    task.firstChild.appendChild({});
    t.isDeeply(getSequence(), [0, 1, 2, 3, 4, 5, 6], 'Correct after appendChild');
    task.firstChild.insertChild(0, {});
    t.isDeeply(getSequence(), [0, 1, 2, 3, 4, 5, 6, 7], 'Correct after insertChild');
    task.firstChild.remove();
    t.isDeeply(getSequence(), [0, 1, 2, 3, 4], 'Correct after removing child');
  });
  t.it('Should handle non working time calendar config', async t => {
    const project = new ProjectModel({
      calendar: 'general',
      tasksData: [{
        id: 1,
        startDate: new Date(2019, 6, 1),
        endDate: new Date(2019, 6, 5)
      }],
      calendarsData: [{
        id: 'general',
        name: 'General',
        intervals: [{
          recurrentStartDate: 'on Sat at 0:00',
          recurrentEndDate: 'on Mon at 0:00',
          isWorking: false
        }]
      }]
    }),
          taskStore = project.taskStore,
          task = taskStore.getById(1);

    function checkTask(duration, startDate, endDate) {
      t.is(task.duration, duration, 'Correct task duration');
      t.is(task.startDate, startDate, 'Correct task startDate');
      t.is(task.endDate, endDate, 'Correct task endDate');
    }

    await project.commitAsync();
    checkTask(4, new Date(2019, 6, 1), new Date(2019, 6, 5));
    await task.setStartDate(new Date(2019, 6, 5));
    checkTask(4, new Date(2019, 6, 5), new Date(2019, 6, 11));
    await task.setStartDate(new Date(2019, 6, 8));
    checkTask(4, new Date(2019, 6, 8), new Date(2019, 6, 12));
    await task.setDuration(10);
    checkTask(10, new Date(2019, 6, 8), new Date(2019, 6, 20));
  });
  t.it('Should set percentDone to 0 when copying', t => {
    const task = new TaskModel({
      // 0
      name: 'foo',
      percentDone: 88.7878
    });
    t.is(task.renderedPercentDone, 89, 'Rounded when less than 99');
    t.is(task.renderedPercentDone, 89, 'Rounded when less than 99');
    task.percentDone = 99;
    t.is(task.renderedPercentDone, 99, 'Rounded <= less than 99');
    task.percentDone = 99.9;
    t.is(task.renderedPercentDone, 99, 'Floor if > than 99');
    task.percentDone = 100;
    t.is(task.renderedPercentDone, 100, 'Floor if > than 99');
    const copy = task.copy();
    t.is(copy.percentDone, 0, 'percentDone set to 0 for copied record');
    t.notOk(copy.isModified, 'No modifications in the copied record');
    t.ok(copy.isPhantom, 'The copied record is a phantom');
  }); //https://github.com/bryntum/support/issues/2081

  t.it('setBaseline should create dummy baselines when index is greater that number of specified baselines', t => {
    const task = new TaskModel({
      startDate: '2020-12-10',
      endDate: '2020-12-11'
    });
    task.setBaseline(2);
    t.is(task.baselines.count, 2);
  }); // https://github.com/bryntum/support/issues/2702

  t.it('Should calculate baselines dates and durations correctly', async t => {
    const tasksData = [{
      startDate: '2021-05-19T00:00:00',
      endDate: '2021-05-25T00:00:00',
      baselines: [{
        startDate: '2021-05-19T00:00:00',
        endDate: '2021-05-24T00:00:00'
      }, {
        startDate: '2021-05-19T00:00:00',
        duration: 4,
        durationUnit: 'day'
      }, {
        endDate: '2021-05-25T00:00:00',
        duration: 3,
        durationUnit: 'day'
      }]
    }];
    t.diag('Standalone task'); // Task not included in project

    const task = new TaskModel(tasksData[0]);
    let baselines = task.baselines.allRecords;
    t.is(baselines[0].duration, 5, 'Correct baselines[0] duration');
    t.is(baselines[1].endDate, new Date('2021-05-23T00:00:00'), 'Correct baselines[1] endDate');
    t.is(baselines[2].startDate, new Date('2021-05-22T00:00:00'), 'Correct baselines[2] startDate'); // Task with project

    const calendarsData = [{
      id: 'general',
      name: 'General',
      intervals: [{
        recurrentStartDate: 'on Sat at 0:00',
        recurrentEndDate: 'on Mon at 0:00',
        isWorking: false
      }]
    }];
    t.diag('Project task'); // Task in project - uses calendar for calculations

    const project = new ProjectModel({
      calendar: 'general',
      tasksData,
      calendarsData
    });
    await project.commitAsync();
    baselines = project.taskStore.first.baselines.allRecords;
    t.is(baselines[0].duration, 3, 'Correct baselines[0] duration');
    t.is(baselines[1].endDate, new Date('2021-05-25T00:00:00'), 'Correct baselines[1] endDate');
    t.is(baselines[2].startDate, new Date('2021-05-20T00:00:00'), 'Correct baselines[2] startDate');
  }); // https://github.com/bryntum/support/issues/2070

  t.it('wbsValue works correctly', async t => {
    const project = new ProjectModel({
      eventsData: [{
        id: 1,
        name: 'Task 1',
        expanded: true,
        children: [{
          id: 11,
          name: 'Task 11',
          startDate: '2020-12-11',
          duration: 1
        }, {
          id: 12,
          name: 'Task 12',
          startDate: '2020-12-11',
          duration: 1
        }]
      }]
    });
    await project.commitAsync();

    const {
      taskStore
    } = project,
          wbsValue = index => taskStore.getById(index).wbsValue.value;

    t.isDeeply(wbsValue(1), '1', 'Task 1 wbsValue is ok');
    t.isDeeply(wbsValue(11), '1.1', 'Task 11 wbsValue is ok');
    t.isDeeply(wbsValue(12), '1.2', 'Task 12 wbsValue is ok');
    taskStore.getById(12).wbsValue = '1.3';
    t.is(wbsValue(12), '1.3', 'Task 12 wbsValue is ok');
  });
  t.it('Should mark calculated fields as ignored', async t => {
    t.ok(TaskModel.nonPersistableFields.earlyStartDate, 'earlyStartDate is non persistable');
    t.ok(TaskModel.nonPersistableFields.lateStartDate, 'lateStartDate is non persistable');
    t.ok(TaskModel.nonPersistableFields.earlyEndDate, 'earlyEndDate is non persistable');
    t.ok(TaskModel.nonPersistableFields.lateEndDate, 'lateEndDate is non persistable');
    t.ok(TaskModel.nonPersistableFields.critical, 'critical is non persistable');
    TaskModel.addField({
      name: 'foo',
      persist: false
    });
    t.ok(TaskModel.nonPersistableFields.foo, 'Newly added field is non persistable');
  }); // https://github.com/bryntum/support/issues/2117

  t.it('Should not report changes existing after filtering', async t => {
    const project = new ProjectModel({
      eventsData: [{
        id: 10,
        name: 'Cave tasks',
        expanded: true,
        children: [{
          id: 4,
          name: 'Excavate',
          startDate: '2020-12-11',
          duration: 1
        }, {
          id: 5,
          name: 'Find canary bird',
          startDate: '2020-12-11',
          duration: 1
        }]
      }, {
        id: 11,
        name: 'Truck tasks',
        expanded: true,
        children: [{
          id: 1,
          name: 'Fix Truck',
          startDate: '2020-12-11',
          duration: 1
        }, {
          id: 2,
          name: 'Repair Truck',
          startDate: '2020-12-11',
          duration: 1
        }, {
          id: 3,
          name: 'Paint Truck',
          startDate: '2020-12-11',
          duration: 1
        }]
      }]
    }),
          store = project.taskStore;
    await project.commitAsync();
    store.filter(task => task.parent.name === 'Truck tasks');
    t.notOk(store.changes, 'No changes after filtering');
    store.getById(1).name = 'foo';
    store.getById(11).insertChild(store.getById(3), 0);
    t.is(store.changes.modified.length, 3, 'Reordering should record parentIndex change, 3 changes reported');
    t.isDeeply(store.changes.modified[0].modificationData, {
      id: 1,
      name: 'foo',
      parentIndex: 1
    }, 'Correct #1 change reported');
    t.isDeeply(store.changes.modified[1].modificationData, {
      id: 3,
      parentIndex: 0
    }, 'Correct #3 change reported');
    t.isDeeply(store.changes.modified[2].modificationData, {
      id: 2,
      parentIndex: 2
    }, 'Correct #2 change reported');
    store.clearFilters();
    t.is(store.changes.modified.length, 3, '3 changes reported after clearing');
    t.isDeeply(store.changes.modified[0].modificationData, {
      id: 1,
      name: 'foo',
      parentIndex: 1
    }, 'Correct #1 change reported');
    t.isDeeply(store.changes.modified[1].modificationData, {
      id: 3,
      parentIndex: 0
    }, 'Correct #3 change reported');
    t.isDeeply(store.changes.modified[2].modificationData, {
      id: 2,
      parentIndex: 2
    }, 'Correct #2 change reported');
    store.filter(task => task.parent.name === 'Truck tasks');
    t.is(store.changes.modified.length, 3, '3 changes reported after clearing');
  }); // https://github.com/bryntum/support/issues/3311

  t.it('Should serialize calendar field using its id', async t => {
    class Task extends TaskModel {}

    Task.fieldMap.calendar.alwaysWrite = true;
    const project = new ProjectModel({
      taskModelClass: Task,
      tasksData: [{
        id: 1,
        name: 'bar',
        calendar: 'general'
      }],
      calendarsData: [{
        id: 'general',
        name: 'General',
        intervals: [{
          recurrentStartDate: 'on Sat at 0:00',
          recurrentEndDate: 'on Mon at 0:00',
          isWorking: false
        }]
      }]
    });
    await project.commitAsync();
    project.taskStore.getById(1).name = 'foo';
    const changes = project.changes;
    t.is(changes.tasks.updated[0].calendar, 'general');
  });
  t.it('Setting duration on detached event in other store should trigger change', async t => {
    const task = new TaskModel(),
          store = new Store({
      data: [task]
    });
    t.firesOnce(store, 'change');
    task.fullDuration = {
      magnitude: 2,
      unit: 'days'
    }; // @ts-ignore

    t.is(task.duration, 2, 'Duration updated');
  });
  t.it('Should move task pinning dependent tasks by dependency lag', async t => {
    const project = new ProjectModel({
      startDate: '2022-01-10',
      tasksData: [{
        id: 1,
        name: 'bar',
        constraintType: 'startnoearlierthan',
        constraintDate: '2022-01-12',
        duration: 1
      }, {
        id: 2,
        duration: 1
      }, {
        id: 3,
        duration: 1
      }, {
        id: 4,
        duration: 1
      }, {
        id: 5,
        duration: 1
      }, {
        id: 6
      }, {
        id: 7
      }, {
        id: 8
      }, {
        id: 9
      }],
      dependenciesData: [{
        id: 1,
        from: 1,
        to: 2,
        type: 0
      }, {
        id: 2,
        from: 1,
        to: 3,
        type: 1
      }, {
        id: 3,
        from: 1,
        to: 4,
        type: 2
      }, {
        id: 4,
        from: 1,
        to: 5,
        type: 3
      }, {
        id: 5,
        from: 1,
        to: 6,
        type: 0
      }, {
        id: 6,
        from: 1,
        to: 7,
        type: 1
      }, {
        id: 7,
        from: 1,
        to: 8,
        type: 2
      }, {
        id: 8,
        from: 1,
        to: 9,
        type: 3
      }]
    });
    await project.commitAsync();
    const [task1, task2, task3, task4, task5, task6, task7, task8, task9] = project.taskStore.getRange();
    t.is(task1.startDate, new Date(2022, 0, 12), 'Task 1 start is ok');
    t.is(task1.endDate, new Date(2022, 0, 13), 'Task 1 end is ok');
    t.is(task2.startDate, new Date(2022, 0, 12), 'Task 2 start is ok');
    t.is(task2.endDate, new Date(2022, 0, 13), 'Task 2 end is ok');
    t.is(task3.startDate, new Date(2022, 0, 11), 'Task 3 start is ok');
    t.is(task3.endDate, new Date(2022, 0, 12), 'Task 3 end is ok');
    t.is(task4.startDate, new Date(2022, 0, 13), 'Task 4 start is ok');
    t.is(task4.endDate, new Date(2022, 0, 14), 'Task 4 end is ok');
    t.is(task5.startDate, new Date(2022, 0, 12), 'Task 5 start is ok');
    t.is(task5.endDate, new Date(2022, 0, 13), 'Task 5 end is ok');
    t.diag('Moving task should pin successors to the current position');
    await task1.moveTaskPinningSuccessors(new Date(2022, 0, 13));
    t.is(task1.startDate, new Date(2022, 0, 13), 'Task 1 start is ok');
    t.is(task1.endDate, new Date(2022, 0, 14), 'Task 1 end is ok');
    t.is(task2.startDate, new Date(2022, 0, 12), 'Task 2 start is ok');
    t.is(task2.endDate, new Date(2022, 0, 13), 'Task 2 end is ok');
    t.is(task3.startDate, new Date(2022, 0, 11), 'Task 3 start is ok');
    t.is(task3.endDate, new Date(2022, 0, 12), 'Task 3 end is ok');
    t.is(task4.startDate, new Date(2022, 0, 13), 'Task 4 start is ok');
    t.is(task4.endDate, new Date(2022, 0, 14), 'Task 4 end is ok');
    t.is(task5.startDate, new Date(2022, 0, 12), 'Task 5 start is ok');
    t.is(task5.endDate, new Date(2022, 0, 13), 'Task 5 end is ok');
    t.notOk(task6.startDate, 'Task 6 start date is not set');
    t.notOk(task7.startDate, 'Task 7 start date is not set');
    t.notOk(task8.startDate, 'Task 8 start date is not set');
    t.notOk(task9.startDate, 'Task 9 start date is not set');
  });
  t.it('Should move task pinning parent-dependent tasks by dependency lag', async t => {
    const project = new ProjectModel({
      startDate: '2022-01-10',
      tasksData: [{
        id: 1,
        expanded: true,
        children: [{
          id: 11,
          constraintType: 'startnoearlierthan',
          constraintDate: '2022-01-12',
          duration: 1
        }]
      }, {
        id: 2,
        expanded: true,
        children: [{
          id: 21,
          duration: 1
        }]
      }, {
        id: 3,
        duration: 1
      }, {
        id: 4,
        duration: 1
      }, {
        id: 5,
        duration: 1
      }],
      dependenciesData: [{
        id: 1,
        from: 1,
        to: 21,
        type: 0
      }, {
        id: 2,
        from: 1,
        to: 3,
        type: 1
      }, {
        id: 3,
        from: 1,
        to: 4,
        type: 2
      }, {
        id: 4,
        from: 1,
        to: 5,
        type: 3
      }]
    });
    await project.commitAsync();
    const [task1, task11,, task21, task3, task4, task5] = project.taskStore.getRange();
    t.is(task1.startDate, new Date(2022, 0, 12), 'Task 1 start is ok');
    t.is(task1.endDate, new Date(2022, 0, 13), 'Task 1 end is ok');
    t.is(task21.startDate, new Date(2022, 0, 12), 'Task 2 start is ok');
    t.is(task21.endDate, new Date(2022, 0, 13), 'Task 2 end is ok');
    t.is(task3.startDate, new Date(2022, 0, 11), 'Task 3 start is ok');
    t.is(task3.endDate, new Date(2022, 0, 12), 'Task 3 end is ok');
    t.is(task4.startDate, new Date(2022, 0, 13), 'Task 4 start is ok');
    t.is(task4.endDate, new Date(2022, 0, 14), 'Task 4 end is ok');
    t.is(task5.startDate, new Date(2022, 0, 12), 'Task 5 start is ok');
    t.is(task5.endDate, new Date(2022, 0, 13), 'Task 5 end is ok');
    t.diag('Moving task should pin successors to the current position');
    await task11.moveTaskPinningSuccessors(new Date(2022, 0, 13));
    t.is(task1.startDate, new Date(2022, 0, 13), 'Task 1 start is ok');
    t.is(task1.endDate, new Date(2022, 0, 14), 'Task 1 end is ok');
    t.is(task21.startDate, new Date(2022, 0, 12), 'Task 2 start is ok');
    t.is(task21.endDate, new Date(2022, 0, 13), 'Task 2 end is ok');
    t.is(task3.startDate, new Date(2022, 0, 11), 'Task 3 start is ok');
    t.is(task3.endDate, new Date(2022, 0, 12), 'Task 3 end is ok');
    t.is(task4.startDate, new Date(2022, 0, 13), 'Task 4 start is ok');
    t.is(task4.endDate, new Date(2022, 0, 14), 'Task 4 end is ok');
    t.is(task5.startDate, new Date(2022, 0, 12), 'Task 5 start is ok');
    t.is(task5.endDate, new Date(2022, 0, 13), 'Task 5 end is ok');
  });
  t.it('Should pin tasks correctly over non working time', async t => {
    const project = new ProjectModel({
      startDate: '2022-01-10',
      calendar: 'general',
      tasksData: [{
        id: 1,
        constraintType: 'startnoearlierthan',
        constraintDate: '2022-01-12',
        duration: 1
      }, {
        id: 2,
        duration: 1
      }],
      dependenciesData: [{
        id: 1,
        from: 1,
        to: 2,
        type: 2,
        lag: 4
      }],
      calendarsData: [{
        id: 'general',
        intervals: [{
          recurrentStartDate: 'on Sat at 0:00',
          recurrentEndDate: 'on Mon at 0:00',
          isWorking: false
        }]
      }]
    });
    await project.commitAsync();
    const [task1, task2] = project.taskStore.getRange();
    t.is(task1.startDate, new Date(2022, 0, 12), 'Task 1 start is ok');
    t.is(task1.endDate, new Date(2022, 0, 13), 'Task 1 end is ok');
    t.is(task2.startDate, new Date(2022, 0, 19), 'Task 2 start is ok');
    t.is(task2.endDate, new Date(2022, 0, 20), 'Task 2 end is ok');
    t.diag('Moving task should pin successors to the current position');
    await task1.moveTaskPinningSuccessors(new Date(2022, 0, 13));
    t.is(task1.startDate, new Date(2022, 0, 13), 'Task 1 start is ok');
    t.is(task1.endDate, new Date(2022, 0, 14), 'Task 1 end is ok');
    t.is(task2.startDate, new Date(2022, 0, 19), 'Task 2 start is ok');
    t.is(task2.endDate, new Date(2022, 0, 20), 'Task 2 end is ok');
  });
  t.it('Should resize task pinning dependent tasks by dependency lag', async t => {
    const project = new ProjectModel({
      startDate: '2022-01-10',
      tasksData: [{
        id: 1,
        name: 'bar',
        constraintType: 'startnoearlierthan',
        constraintDate: '2022-01-12',
        duration: 1
      }, {
        id: 2,
        duration: 1
      }, {
        id: 3,
        duration: 1
      }, {
        id: 4,
        duration: 1
      }, {
        id: 5,
        duration: 1
      }],
      dependenciesData: [{
        id: 1,
        from: 1,
        to: 2,
        type: 0
      }, {
        id: 2,
        from: 1,
        to: 3,
        type: 1
      }, {
        id: 3,
        from: 1,
        to: 4,
        type: 2
      }, {
        id: 4,
        from: 1,
        to: 5,
        type: 3
      }]
    });
    await project.commitAsync();
    const [task1, task2, task3, task4, task5] = project.taskStore.getRange();
    t.is(task1.startDate, new Date(2022, 0, 12), 'Task 1 start is ok');
    t.is(task1.endDate, new Date(2022, 0, 13), 'Task 1 end is ok');
    t.is(task2.startDate, new Date(2022, 0, 12), 'Task 2 start is ok');
    t.is(task2.endDate, new Date(2022, 0, 13), 'Task 2 end is ok');
    t.is(task3.startDate, new Date(2022, 0, 11), 'Task 3 start is ok');
    t.is(task3.endDate, new Date(2022, 0, 12), 'Task 3 end is ok');
    t.is(task4.startDate, new Date(2022, 0, 13), 'Task 4 start is ok');
    t.is(task4.endDate, new Date(2022, 0, 14), 'Task 4 end is ok');
    t.is(task5.startDate, new Date(2022, 0, 12), 'Task 5 start is ok');
    t.is(task5.endDate, new Date(2022, 0, 13), 'Task 5 end is ok');
    t.diag('Move end date, successors should be pinned');
    await task1.setEndDatePinningSuccessors(new Date(2022, 0, 14));
    t.is(task1.startDate, new Date(2022, 0, 12), 'Task 1 start is ok');
    t.is(task1.endDate, new Date(2022, 0, 14), 'Task 1 end is ok');
    t.is(task4.startDate, new Date(2022, 0, 13), 'Task 4 start is ok');
    t.is(task4.endDate, new Date(2022, 0, 14), 'Task 4 end is ok');
    t.is(task5.startDate, new Date(2022, 0, 12), 'Task 5 start is ok');
    t.is(task5.endDate, new Date(2022, 0, 13), 'Task 5 end is ok');
    t.diag('Move start date, successors should be pinned');
    await task1.setStartDatePinningSuccessors(new Date(2022, 0, 13));
    t.is(task1.startDate, new Date(2022, 0, 13), 'Task 1 start is ok');
    t.is(task1.endDate, new Date(2022, 0, 14), 'Task 1 end is ok');
    t.is(task2.startDate, new Date(2022, 0, 12), 'Task 2 start is ok');
    t.is(task2.endDate, new Date(2022, 0, 13), 'Task 2 end is ok');
    t.is(task3.startDate, new Date(2022, 0, 11), 'Task 3 start is ok');
    t.is(task3.endDate, new Date(2022, 0, 12), 'Task 3 end is ok');
  });
});