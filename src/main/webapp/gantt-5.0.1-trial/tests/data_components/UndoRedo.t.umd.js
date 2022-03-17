"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    gantt && gantt.destroy();
  });
  t.it('Should properly schedule tasks after undo', async t => {
    gantt = await t.getGanttAsync({
      tasks: [{
        id: 1,
        startDate: '2017-01-16',
        duration: 1
      }, {
        id: 2,
        startDate: '2017-01-17',
        duration: 1
      }, {
        id: 3,
        startDate: '2017-01-18',
        duration: 1
      }, {
        id: 4,
        startDate: '2017-01-16',
        duration: 1
      }, {
        id: 5,
        startDate: '2017-01-17',
        duration: 1
      }, {
        id: 6,
        expanded: true,
        children: [{
          id: 61,
          startDate: '2017-01-18',
          duration: 1
        }]
      }],
      dependencies: [{
        fromEvent: 1,
        toEvent: 2
      }, {
        fromEvent: 2,
        toEvent: 3
      }, {
        fromEvent: 4,
        toEvent: 5
      }, {
        fromEvent: 5,
        toEvent: 61
      }]
    });
    const stm = gantt.project.getStm(); // let's track scheduling conflicts happened

    gantt.project.on('schedulingconflict', context => {
      Toast.show('Scheduling conflict has happened ..recent changes were reverted');
      t.fail('Scheduling conflict');
    });
    const event1 = gantt.taskStore.getById(1),
          event2 = gantt.taskStore.getById(2),
          event5 = gantt.taskStore.getById(5),
          event61 = gantt.taskStore.getById(61);
    t.chain({
      waitForPropagate: gantt
    }, async () => {
      stm.disabled = false;
      stm.autoRecord = true;
      await event2.setConstraint(ConstraintType.StartNoEarlierThan, new Date(2017, 1, 6));
    }, {
      waitForEvent: [stm, 'recordingstop']
    }, async () => {
      gantt.clearLog('projectRefresh');
      stm.undo();
      await gantt.project.await('stateRestoringDone');
      t.is(event1.startDate, new Date(2017, 0, 16), 'Event 1 start is ok');
      t.is(event2.startDate, new Date(2017, 0, 17), 'Event 2 start is ok');
      await event1.setConstraint(ConstraintType.StartNoEarlierThan, new Date(2017, 0, 18));
    }, {
      waitForEvent: [stm, 'recordingstop']
    }, async () => {
      t.is(event1.startDate, new Date(2017, 0, 18), 'Event 1 start is ok');
      t.is(event2.startDate, new Date(2017, 0, 19), 'Event 2 start is ok');
      await event61.setConstraint(ConstraintType.StartNoEarlierThan, new Date(2017, 1, 6));
    }, {
      waitForEvent: [stm, 'recordingstop']
    }, async () => {
      stm.undo();
      await gantt.project.await('stateRestoringDone');
      t.is(event5.startDate, new Date(2017, 0, 17), 'Event 4 start is ok');
      t.is(event61.startDate, new Date(2017, 0, 18), 'Event 51 start is ok');
      await event5.setConstraint(ConstraintType.StartNoEarlierThan, new Date(2017, 0, 20));
    }, {
      waitForEvent: [stm, 'recordingstop']
    }, async () => {
      t.is(event5.startDate, new Date(2017, 0, 20), 'Event 4 start is ok');
      t.is(event61.startDate, new Date(2017, 0, 21), 'Event 51 start is ok');
    });
  }); // https://github.com/bryntum/support/issues/975

  t.it('Should properly update store changes when REMOVE, undo, redo a SUBTASK', async t => {
    gantt = await t.getGanttAsync({
      tasks: [{
        id: 1,
        startDate: '2017-01-16',
        duration: 1
      }, {
        id: 2,
        startDate: '2017-01-16',
        duration: 1,
        expanded: true,
        children: [{
          id: 3,
          startDate: '2017-01-16',
          duration: 1
        }]
      }],
      dependencies: [],
      resources: [],
      assignments: []
    });
    const {
      project
    } = gantt,
          {
      taskStore
    } = project,
          task = taskStore.getById(3),
          stm = project.getStm();
    t.chain({
      waitForPropagate: project
    }, next => {
      project.acceptChanges();
      t.diag('Initial state');
      t.notOk(taskStore.changes, 'No changes found');
      stm.disabled = false;
      stm.startTransaction();
      t.waitForPropagate(project, next);
      taskStore.remove(task);
    }, next => {
      stm.stopTransaction();
      t.diag('After remove state');
      t.ok(taskStore.changes, 'Changes found');
      t.is(taskStore.changes.added.length, 0, 'No added records found');
      t.is(taskStore.changes.modified.length, 0, 'No modified records found');
      t.is(taskStore.changes.removed.length, 1, '1 removed record found');
      t.is(taskStore.changes.removed[0], task, 'Correct task is removed');
      next();
    }, async () => {
      stm.undo();
      await gantt.project.await('stateRestoringDone');
      t.diag('After undo state');
      t.notOk(taskStore.changes, 'No changes found');
      stm.redo();
      await gantt.project.await('stateRestoringDone');
      t.diag('After redo state');
      t.ok(taskStore.changes, 'Changes found');
      t.is(taskStore.changes.added.length, 0, 'No added records found');
      t.is(taskStore.changes.modified.length, 0, 'No modified records found');
      t.is(taskStore.changes.removed.length, 1, '1 removed record found');
      t.is(taskStore.changes.removed[0], task, 'Correct task is removed');
    });
  });
  t.it('Should properly update store changes when REMOVE, undo, redo a first level TASK', async t => {
    gantt = await t.getGanttAsync({
      tasks: [{
        id: 1,
        startDate: '2017-01-16',
        duration: 1
      }, {
        id: 2,
        startDate: '2017-01-16',
        duration: 1
      }],
      dependencies: [],
      resources: [],
      assignments: []
    });
    const {
      project
    } = gantt,
          {
      taskStore
    } = project,
          task = taskStore.getById(2),
          stm = project.getStm();
    t.chain({
      waitForPropagate: project
    }, next => {
      project.acceptChanges();
      t.diag('Initial state');
      t.notOk(taskStore.changes, 'No changes found');
      stm.disabled = false;
      stm.startTransaction();
      t.waitForPropagate(project, next);
      taskStore.remove(task);
    }, next => {
      stm.stopTransaction();
      t.diag('After remove state');
      t.ok(taskStore.changes, 'Changes found');
      t.is(taskStore.changes.added.length, 0, 'No added records found');
      t.is(taskStore.changes.modified.length, 0, 'No modified records found (root is auto created)');
      t.is(taskStore.changes.removed.length, 1, '1 removed record found');
      t.is(taskStore.changes.removed[0], task, 'Correct task is removed');
      next();
    }, async () => {
      stm.undo();
      await gantt.project.await('stateRestoringDone');
      t.diag('After undo state');
      t.notOk(taskStore.changes, 'No changes found');
      stm.redo();
      await gantt.project.await('stateRestoringDone');
      t.diag('After redo state');
      t.ok(taskStore.changes, 'Changes found');
      t.is(taskStore.changes.added.length, 0, 'No added records found');
      t.is(taskStore.changes.modified.length, 0, 'No modified records found (root is auto created)');
      t.is(taskStore.changes.removed.length, 1, '1 removed record found');
      t.is(taskStore.changes.removed[0], task, 'Correct task is removed');
    });
  });
  t.it('Should properly update store changes when MOVE, undo, redo a first level TASK', async t => {
    gantt = await t.getGanttAsync({
      tasks: [{
        id: 1,
        startDate: '2017-01-16',
        duration: 1
      }, {
        id: 2,
        startDate: '2017-01-16',
        duration: 1
      }],
      dependencies: [],
      resources: [],
      assignments: []
    });
    const {
      project
    } = gantt,
          {
      taskStore
    } = project,
          task = taskStore.getById(2),
          stm = project.getStm();
    t.chain({
      waitForPropagate: project
    }, next => {
      t.diag('Initial state');
      t.notOk(taskStore.changes, 'No changes found');
      stm.disabled = false;
      stm.startTransaction();
      t.waitForPropagate(project, next);
      taskStore.insert(0, task);
    }, next => {
      stm.stopTransaction();
      t.diag('After remove state');
      t.ok(taskStore.changes, 'Changes found');
      t.is(taskStore.changes.added.length, 0, 'No added records found');
      t.is(taskStore.changes.modified.length, 2, '2 modified records found');
      t.is(taskStore.changes.removed.length, 0, 'No removed records found');
      t.is(taskStore.changes.modified[0], task, 'Task record is modified');
      t.is(taskStore.changes.modified[1], taskStore.getById(1), 'Another task is modified');
      next();
    }, async () => {
      stm.undo();
      await gantt.project.await('stateRestoringDone');
      t.diag('After undo state');
      t.notOk(taskStore.changes, 'No changes found');
      stm.redo();
      await gantt.project.await('stateRestoringDone');
      t.diag('After redo state');
      t.ok(taskStore.changes, 'Changes found');
      t.is(taskStore.changes.added.length, 0, 'No added records found');
      t.is(taskStore.changes.modified.length, 2, '2 modified records found');
      t.is(taskStore.changes.removed.length, 0, 'No removed records found');
      t.is(taskStore.changes.modified[0], task, 'Task record is modified');
      t.is(taskStore.changes.modified[1], taskStore.getById(1), 'Another task is modified');
    });
  });
  t.it('Should undo removing', async t => {
    gantt = await t.getGanttAsync({
      tasks: [{
        id: 1,
        startDate: '2017-01-16',
        duration: 1
      }, {
        id: 2,
        startDate: '2017-01-16',
        duration: 1,
        expanded: true,
        children: [{
          id: 3,
          startDate: '2017-01-16',
          duration: 1
        }]
      }],
      dependencies: [{
        id: 10,
        fromEvent: 1,
        toEvent: 3
      }],
      resources: [],
      assignments: []
    });
    const {
      project
    } = gantt,
          {
      taskStore
    } = project,
          task = taskStore.getById(3),
          stm = project.getStm();
    t.chain({
      waitForPropagate: project
    }, async () => {
      project.acceptChanges();
      stm.enable();
      stm.startTransaction();
      taskStore.remove(task);
    }, {
      waitForPropagate: project
    }, async () => {
      stm.stopTransaction();
      stm.undo();
    }, {
      waitForPropagate: project
    }, async () => {
      t.notOk(taskStore.changes, 'No changes found');
    });
  });
  t.it('Should keep recording changes if project is committing', async t => {
    gantt = await t.getGanttAsync();
    await gantt.await('dependenciesDrawn', false);
    const {
      stm
    } = gantt.project;
    stm.enable();
    stm.autoRecord = true; // set smallest possible timeout for autoRecording state to make sure it finished before project is recalculated

    stm.autoRecordTransactionStopTimeout = 1; // append task to start project recalculation

    gantt.taskStore.rootNode.appendChild({
      name: 'New task',
      duration: 30
    });
    await gantt.project.await('dataReady', false); // Check if after a timeout no new items triggered by the autoRecording state have appeared in the queue

    await t.waitFor(1000);
    t.is(stm.queue.length, 1, 'Record add and update is fit into one transaction');
  }); // https://github.com/bryntum/support/issues/2226

  t.it('Should not record changes to purely calculated fields like `earlyStart`, `critical` etc', async t => {
    gantt = await t.getGanttAsync();
    const {
      stm
    } = gantt.project;
    stm.enable();
    stm.autoRecord = true;
    stm.autoRecordTransactionStopTimeout = 1; // This does change any ´real´ data, just calculates a few fields so it should not trigger a recording

    gantt.features.criticalPaths.disabled = false; // Check if after a timeout no new items triggered by the autoRecording state have appeared in the queue

    await t.waitFor(1000);
    t.is(stm.queue.length, 0, 'Nothing recorded');
  });
  t.it('Should react to CTRL-Z when configured with enableUndoRedoKeys', async t => {
    gantt = await t.getGanttAsync({
      enableUndoRedoKeys: true
    });
    const {
      stm
    } = gantt.project;
    stm.enable();
    stm.autoRecord = true;
    await t.dragBy('[data-task-id="11"]', [100, 0]);
    await t.waitFor(() => stm.canUndo);
    t.ok(stm.canUndo, 'Undo possible'); // UNDO

    await t.type(null, 'Z', null, null, {
      ctrlKey: !BrowserHelper.isMac,
      metaKey: BrowserHelper.isMac
    });
    await t.waitFor(() => stm.canRedo);
    t.notOk(stm.canUndo, 'Undo queue empty');
    t.is(gantt.project.changes, null, 'Undid changes'); // REDO

    await t.type(null, 'Z', null, null, {
      shiftKey: true,
      ctrlKey: !BrowserHelper.isMac,
      metaKey: BrowserHelper.isMac
    });
    await t.waitFor(() => stm.canUndo);
    t.notOk(stm.canRedo, 'Redo queue empty');
    t.ok(stm.canUndo, 'Undo queue populated');
    t.ok(gantt.project.changes, 'Changes redone');
  });
});