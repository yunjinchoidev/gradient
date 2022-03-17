"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    return (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  });
  t.it('Should update dependency columns on dependency store changes', t => {
    gantt = t.getGantt({
      id: 'gantt',
      columns: [{
        type: PredecessorColumn.type
      }, {
        type: SuccessorColumn.type
      }],
      tasks: [{
        id: 1,
        cls: 'id1',
        startDate: '2017-01-16',
        endDate: '2017-01-18',
        name: 'Task 1',
        leaf: true
      }, {
        id: 2,
        cls: 'id2',
        startDate: '2017-01-16',
        endDate: '2017-01-18',
        name: 'Task 2',
        leaf: true
      }, {
        id: 3,
        cls: 'id3',
        startDate: '2017-01-16',
        endDate: '2017-01-18',
        name: 'Task 3',
        leaf: true
      }],
      dependencies: []
    });
    const project = gantt.project,
          dependencyStore = project.dependencyStore,
          eventStore = project.eventStore;
    let dep1;
    t.chain({
      waitForPropagate: project
    }, () => {
      [dep1] = dependencyStore.add({
        id: 1,
        fromEvent: 1,
        toEvent: 2
      });
      return project.propagateAsync();
    }, () => {
      t.isDeeply(eventStore.getById(1).outgoingDeps, new Set([dependencyStore.getById(1)]), 'Correct outgoing deps for event 1');
      t.isDeeply(eventStore.getById(2).incomingDeps, new Set([dependencyStore.getById(1)]), 'Correct incoming deps for event 2');
      t.contentLike('.id1 [data-column=successors]', '2', 'Successor rendered');
      t.contentLike('.id2 [data-column=predecessors]', '1', 'Predecessor rendered');
      dependencyStore.add({
        fromEvent: 3,
        toEvent: 2
      });
      return project.propagateAsync();
    }, next => {
      t.contentLike('.id1 [data-column=successors]', '2', 'Successor rendered');
      t.contentLike('.id2 [data-column=predecessors]', '1;3', 'Predecessor rendered');
      t.contentLike('.id3 [data-column=successors]', '2', 'Successor rendered');
      next();
    }, next => {
      dep1.setLag(1, TimeUnit.Day);
      next();
    }, {
      waitForPropagate: gantt
    }, () => {
      t.contentLike('.id2 [data-column=predecessors]', '1+1d;3', 'Predecessor rendered');
    });
  });
  t.it('Should use delimiter config for rendering and editing', async t => {
    gantt = await t.getGanttAsync({
      id: 'gantt',
      columns: [{
        type: PredecessorColumn.type,
        delimiter: ','
      }, {
        type: SuccessorColumn.type,
        delimiter: '/'
      }]
    });
    t.selectorExists('.id14 [data-column=predecessors]:contains(11,12,13)', 'Correct separator rendered #1');
    t.selectorExists('.id14 [data-column=successors]:contains(21/22)', 'Correct separator rendered #2');
    gantt.startEditing({
      id: 14,
      field: 'predecessors'
    });
    t.is(document.querySelector('input[name=predecessors]').value, '11,12,13', 'Correct separator while editing #1');
    gantt.features.cellEdit.cancelEditing();
    gantt.startEditing({
      id: 14,
      field: 'successors'
    });
    t.is(document.querySelector('input[name=successors]').value, '21/22', 'Correct separator while editing #2');
  });
  t.it('Should use dependencyIdField config for rendering and editing', async t => {
    gantt = await t.getGanttAsync({
      id: 'gantt',
      columns: [{
        type: PredecessorColumn.type,
        dependencyIdField: 'wbsCode'
      }, {
        type: SuccessorColumn.type,
        dependencyIdField: 'wbsCode'
      }]
    });
    t.selectorExists('.id14 [data-column=predecessors]:contains(1.1.3;1.1.2;1.1.1)', 'Correct separator rendered #1');
    t.selectorExists('.id14 [data-column=successors]:contains(1.2.2;1.2.1)', 'Correct separator rendered #2');
    gantt.startEditing({
      id: 14,
      field: 'predecessors'
    });
    t.is(document.querySelector('input[name=predecessors]').value, '1.1.3;1.1.2;1.1.1', 'Correct separator while editing #1');
    gantt.features.cellEdit.cancelEditing();
    gantt.startEditing({
      id: 14,
      field: 'successors'
    });
    t.is(document.querySelector('input[name=successors]').value, '1.2.2;1.2.1', 'Correct separator while editing #2');
  });
  t.it('Should update successors and predecessors properly on manual editing', t => {
    gantt = t.getGantt({
      appendTo: document.body,
      id: 'gantt',
      columns: [{
        type: PredecessorColumn.type
      }, {
        type: SuccessorColumn.type
      }]
    });
    t.chain({
      dblClick: '.id14 [data-column=predecessors]:contains(11;12;13)'
    }, {
      type: '12;13[ENTER]',
      clearExisting: true
    }, {
      waitForSelector: '.id14 [data-column=predecessors]:contains(12;13)',
      desc: 'Data for predecessor has been changed properly'
    }, {
      dblClick: '.id14 [data-column=successors]:contains(21;22)'
    }, {
      type: '21[ENTER]',
      clearExisting: true
    }, {
      waitForSelector: '.id14 [data-column=successors]:contains(21)',
      desc: 'Data for successor has been changed properly'
    });
  }); // https://app.assembla.com/spaces/bryntum/tickets/8763

  t.it('Should not crash when picking two predecessors', t => {
    gantt = t.getGantt({
      features: {
        taskTooltip: false
      },
      appendTo: document.body,
      columns: [{
        type: PredecessorColumn.type
      }]
    });
    t.chain({
      dblclick: '[data-index="9"] .b-grid-cell[data-column=predecessors]'
    }, {
      click: '.b-icon-picker'
    }, async () => {
      const list = gantt.features.cellEdit.editor.inputField.picker;
      list.scrollable.scrollIntoView(list.getItem(list.store.getById(1)));
    }, {
      click: '.b-list-item:textEquals(Planning (1))'
    }, async () => {
      const list = gantt.features.cellEdit.editor.inputField.picker;
      list.scrollable.scrollIntoView(list.getItem(list.store.getById(11)));
    }, {
      click: '.b-list-item:textEquals(Investigate (11))'
    }, {
      click: '[data-task-id="11"]'
    }, () => {
      t.pass('No crash');
    });
  }); // https://github.com/bryntum/support/issues/2136

  t.it('Should update existing successors when cell editing', async t => {
    gantt = await t.getGanttAsync({
      columns: [{
        type: PredecessorColumn.type
      }, {
        type: SuccessorColumn.type
      }]
    });
    t.wontFire(gantt.dependencyStore, 'add', '0 add events');
    t.wontFire(gantt.dependencyStore, 'remove', '0 remove events');
    await t.doubleClick('.id11 [data-column=successors]:textEquals(14)');
    await t.type(null, '14+2[ENTER]', null, null, null, true);
    const task = gantt.taskStore.getById(11); // wait till changes get applied

    await t.waitFor(() => task.successors[0].lag === 2);
    const dep = task.successors[0],
          changes = gantt.dependencyStore.changes;
    t.is(dep.lag, 2, 'Lag updated');
    t.is(changes.added.length, 0, 'Added');
    t.is(changes.removed.length, 0, 'Removed');
    t.is(changes.modified.length, 1, 'Modified');
  });
  t.it('Should update existing predecessors when cell editing', async t => {
    gantt = t.getGantt({
      columns: [{
        type: PredecessorColumn.type
      }]
    });
    t.firesOnce(gantt.dependencyStore, 'update', '1 update event');
    t.wontFire(gantt.dependencyStore, 'add', '0 add events');
    t.wontFire(gantt.dependencyStore, 'remove', '0 remove events');
    await t.doubleClick('.id21 [data-column=predecessors]:textEquals(14)');
    await t.waitForEventOnTrigger(gantt.dependencyStore, 'update', () => {
      t.type(null, '14+2[ENTER]', null, null, null, true);
    });
    const dep = gantt.taskStore.getById(21).predecessors[0],
          changes = gantt.dependencyStore.changes;
    t.is(dep.lag, 2, 'Lag updated');
    t.is(changes.added.length, 0, 'Added');
    t.is(changes.removed.length, 0, 'Removed');
    t.is(changes.modified.length, 1, 'Modified');
  }); // https://github.com/bryntum/support/issues/2025

  t.it('Should pass validation after switch locale when cell editing', async t => {
    LocaleManager.extendLocale('En', {
      DependencyType: {
        SS: 'AA',
        SF: 'EA',
        FS: 'AE',
        FF: 'EE',
        short: ['AA', 'EA', 'AE', 'EE']
      }
    });
    gantt = t.getGantt({
      columns: [{
        type: PredecessorColumn.type
      }]
    });
    await t.doubleClick('.id21 [data-column=predecessors]:textEquals(14)');
    await t.type(null, '14EE[ENTER]', null, null, null, true); // wait till changes get applied

    await t.waitFor(() => gantt.taskStore.getById(21).dependencies[0].type === 3);
  });
  t.it('Should not show error message while typing, only when pressing ENTER', async t => {
    gantt = await t.getGanttAsync({
      columns: [{
        type: PredecessorColumn.type
      }]
    });
    gantt.taskStore.add({
      id: 5000,
      name: 'New task'
    });
    await gantt.taskStore.getById(1000).setManuallyScheduled(true);
    await t.doubleClick('.id1 [data-column=predecessors]');
    await t.type(null, '1.', null, null, null, true);
    t.selectorNotExists('.b-invalid');
    await t.type(null, '[ENTER]');
    t.selectorExists('.b-invalid');
    t.waitForSelector('.b-field-error-tip:textEquals(Invalid dependency format)');
    await t.type(null, '5000', null, null, null, true);
    t.waitForSelectorNotFound('.b-field-error-tip:contains(Invalid dependency format)');
  });
  t.it('Should show error when adding invalid parent-to-child dependency after pressing ENTER', async t => {
    gantt = await t.getGanttAsync({
      columns: [{
        type: PredecessorColumn.type
      }]
    });
    await gantt.taskStore.getById(1000).setManuallyScheduled(true);
    await t.doubleClick('.id1 [data-column=predecessors]');
    await t.type(null, '1[ENTER]', null, null, null, true);
    await t.waitForSelector('.b-field-error-tip:contains("Invalid dependency")');
  }); // https://github.com/bryntum/support/issues/2728

  t.it('Should set lagUnit based on task durationUnit', async t => {
    gantt = t.getGantt({
      project: {
        taskStore: {
          fields: [{
            name: 'durationUnit',
            defaultValue: 'min'
          }]
        }
      },
      viewPreset: 'monthAndYear',
      columns: [{
        type: SuccessorColumn.type
      }]
    });
    await t.doubleClick('.id11 [data-column=successors]:textEquals(14)');
    await t.type(null, '14+2[ENTER]', null, null, null, true); // wait till changes get applied

    await t.waitFor(() => gantt.taskStore.getById(11).successors[0].lag === 2);
    const dep = gantt.taskStore.getById(11).successors[0];
    t.is(dep.lag, 2, 'Lag amount ok');
    t.is(dep.lagUnit, 'minute', 'If unit omitted, lagUnit === task durationUnit');
  }); // https://github.com/bryntum/support/issues/3014

  t.it('Should show children of collapsed tasks in the list', t => {
    gantt = t.getGantt({
      appendTo: document.body,
      columns: [{
        type: PredecessorColumn.type
      }]
    });
    gantt.collapseAll();
    gantt.taskStore.add({
      name: 'new task',
      leaf: true
    });
    gantt.taskStore.add({
      name: 'other task',
      leaf: true
    });
    t.is(gantt.taskStore.allCount, 17, '17 records in the master store');
    t.chain({
      dblclick: '.b-grid-row:contains(new task) [data-column=predecessors]'
    }, {
      click: '.b-icon-picker'
    }, async () => {
      t.selectorExists('.b-list-item[data-index="0"]:contains(Assign)', 'Store should be sorted by name');
      t.selectorCountIs('.b-list-item', 16, '16 records in the chained store, all but the source record itself');
      t.selectorNotExists('.b-list-item:contains(new task)', 'Task list should not include original row task');
      t.selectorNotExists('.b-list-item:contains(generated)', 'Generated task ids should not be shown');
    }, {
      type: '[ESCAPE]'
    }, {
      dblclick: '.b-grid-row:contains(other task) [data-column=predecessors]'
    }, {
      click: '.b-icon-picker'
    }, () => {
      t.selectorCountIs('.b-list-item', 16, '16 records in the chained store, all but the source record itself');
      t.selectorExists('.b-list-item:contains(new task)', 'Task list should include all rows except original row task');
      t.selectorNotExists('.b-list-item:contains(other task)', 'Task list should not include original row task');
    });
  }); // https://github.com/bryntum/support/issues/3441

  t.it('Should add dependency if picker task list is filtered', async t => {
    const async = t.beginAsync();
    gantt = await t.getGanttAsync({
      columns: [{
        type: PredecessorColumn.type
      }]
    });
    t.firesOnce(gantt.dependencyStore, 'add');
    gantt.dependencyStore.on('add', ({
      records
    }) => {
      const addedDependency = records[0];
      t.is(addedDependency.fromEvent.id, 12, 'From ok');
      t.is(addedDependency.toEvent.id, 13, 'To ok');
      t.endAsync(async);
    });
    await t.doubleClick('.id13 [data-column=predecessors]');
    await t.click('.b-icon-picker');
    await t.click('.b-dependency-list-filter');
    await t.type(null, 'blargh');
    await t.click('.b-dependencyfield');
    await t.type(null, '12[ENTER]');
  }); // https://github.com/bryntum/support/issues/3676

  t.it('Should add dependency if picker task list is filtered', async t => {
    gantt = t.getGantt({
      features: {
        filter: true
      },
      columns: [{
        type: PredecessorColumn.type
      }]
    });
    gantt.features.filter.showFilterEditor(gantt.columns.getAt(1));
    await t.type('input:focus', '11[ENTER]');
    t.selectorCountIs('.b-grid-subgrid-locked .b-grid-row', 3, 'Result: 1 leaf and its 2 ancestors');
  }); // https://github.com/bryntum/support/issues/3854

  t.it('Filtering using context menu\'s "Equals"', async t => {
    gantt = t.getGantt({
      features: {
        filter: true
      },
      columns: [{
        type: PredecessorColumn.type
      }]
    });
    await t.rightClick('.b-grid-cell[data-column="predecessors"]:contains(22)');
    await t.click('.b-menuitem[data-ref="filterStringEquals"]');
    t.selectorCountIs('.b-grid-subgrid-locked .b-grid-row', 6, 'Result: 3 leaves and 3 ancestors'); // Correct tasks visible

    t.is(gantt.taskStore.map(t => t.id).toString(), '1000,2,23,231,232,233');
  });
  t.it('Should change dependency type', async t => {
    gantt = await t.getGanttAsync({
      columns: [{
        type: 'predecessor'
      }]
    });
    await t.doubleClick('.id21 [data-column="predecessors"]');
    await t.click('.b-fieldtrigger');
    await t.click('.id14 .b-to');
    await t.click('.id21 .b-sch-timeaxis-cell');
    await gantt.await('dependenciesDrawn');
    const task = gantt.taskStore.getById(21),
          [dependency] = Array.from(task.incomingDeps);
    t.is(dependency.type, 3, 'Dependency type is ok');
  }); // https://github.com/bryntum/bryntum-suite/pull/4470

  t.it('Should take task id by default if dependencyIdField is not defined', async t => {
    const project = new ProjectModel({
      startDate: new Date(2020, 0, 1),
      eventsData: [{
        id: 2,
        name: 'Proof-read docs',
        startDate: '2020-01-02',
        endDate: '2020-01-05',
        effort: 0
      }, {
        id: 3,
        name: 'Release alpha',
        startDate: '2020-01-09',
        endDate: '2020-01-10',
        effort: 0
      }, {
        id: 4,
        name: 'Release beta',
        startDate: '2020-01-10',
        endDate: '2020-01-11',
        effort: 0
      }, {
        id: 5,
        name: 'Release RC',
        startDate: '2020-01-11',
        endDate: '2020-01-12',
        effort: 0
      }, {
        id: 6,
        name: 'Release GA',
        startDate: '2020-01-12',
        endDate: '2020-01-13',
        effort: 0
      }],
      resourcesData: [{
        id: 1,
        name: 'John Johnson'
      }, {
        id: 2,
        name: 'Janet Janetson'
      }, {
        id: 3,
        name: 'Kermit the Frog'
      }, {
        id: 4,
        name: 'Kermit the Frog Jr.'
      }],
      assignmentsData: [{
        resource: 1,
        event: 2,
        units: 50
      }, {
        resource: 3,
        event: 2
      }],
      dependenciesData: [{
        fromEvent: 2,
        toEvent: 3
      }, {
        fromEvent: 3,
        toEvent: 4
      }, {
        fromEvent: 4,
        toEvent: 6
      }]
    });
    new DependencyField({
      appendTo: document.body,
      store: project.taskStore,
      dependencyStore: project.dependencyStore,
      otherSide: 'from',
      ourSide: 'to',
      value: project.firstChild.dependencies
    });
    await t.click('.b-fieldtrigger');
    await t.waitForSelector('.b-dependency-list-filter');
    await t.waitForSelector('.b-predecessor-item-text:contains(2)');
  }); // https://github.com/bryntum/support/issues/3981

  t.it('Should show correct filter value after filtering using `equals` menu option', async t => {
    gantt = await t.getGanttAsync({
      dependencyIdField: 'wbsCode',
      features: {
        filter: true
      },
      columns: [{
        type: 'predecessor',
        width: 300,
        sortable: false
      }]
    });
    await t.rightClick('[data-column="predecessors"]:textEquals(1.1.3;1.1.2;1.1.1)');
    await t.click('.b-menuitem:contains(Equals)');
    await t.moveCursorTo('.b-grid-header-text:contains(Predecessors)');
    await t.click('.b-grid-header-text:contains(Predecessors) .b-filter-icon');
    await t.waitForSelector('input:focus');
    const field = t.query('input:focus')[0];
    t.is(field.value, '1.1.3;1.1.2;1.1.1', 'Correct field value');
    t.selectorCountIs('.b-grid-row [data-column="predecessors"]', 3, '3 rows shown');
    t.selectorExists('[data-column="predecessors"]:textEquals(1.1.3;1.1.2;1.1.1)');
  });
});