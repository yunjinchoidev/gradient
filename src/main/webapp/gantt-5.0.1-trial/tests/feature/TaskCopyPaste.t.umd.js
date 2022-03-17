"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => gantt && gantt.destroy());
  t.it('Should allow user cut and paste using context menu', async t => {
    gantt = await t.getGanttAsync();
    const {
      store
    } = gantt,
          rec11DepsCount = store.getById(11).dependencies.length;
    t.chain({
      contextmenu: '[data-id=11]'
    }, {
      click: '.b-menuitem[data-ref="cut"]'
    }, {
      waitForSelector: '.b-cut-row[data-id=11]',
      desc: 'Row id 11 style was changed to "cut" when using context menu'
    }, {
      waitForSelector: '[data-task-id=11] .b-cut-row',
      desc: 'Task bar id 11 style was changed to "cut" when using context menu'
    }, {
      contextmenu: '[data-id=13]'
    }, {
      click: '.b-menuitem[data-ref="paste"]'
    }, next => {
      const recPasted = store.getById(11);
      t.is(store.indexOf(recPasted), 3, 'Row id 11 was pasted to correct position');
      t.is(recPasted.dependencies.length, rec11DepsCount, 'Row id 11 still has same dependencies quantity');
    });
  });
  t.it('Should allow user copy and paste using context menu', async t => {
    gantt = await t.getGanttAsync();
    const {
      store
    } = gantt;
    t.chain({
      contextmenu: '[data-id=13]'
    }, {
      click: '.b-menuitem[data-ref="copy"]'
    }, {
      contextmenu: '[data-id=21]'
    }, {
      click: '.b-menuitem[data-ref="paste"]'
    }, next => {
      const [newRecCopy] = store.findByField('name', 'Gather documents - 2');
      t.is(newRecCopy.index, 8, 'Row copy of the id 13 was pasted to correct position and with correct name');
      t.is(newRecCopy.data.dependencies.length, 0, 'Row copy of the id 13 has no dependencies');
      next();
    }, {
      contextmenu: '[data-id=232]'
    }, {
      click: '.b-menuitem[data-ref="copy"]'
    }, {
      contextmenu: '[data-id=233]'
    }, {
      click: '.b-menuitem[data-ref="paste"]'
    }, () => {
      const [newRecCopy] = store.findByField('name', 'Step 2 - 2');
      t.is(newRecCopy.data.dependencies.length, 0, 'Row copy of the id 13 has no dependencies');
    });
  });
  t.it('Should allow user single cut and paste using CTRL+X and CTRL+V', async t => {
    gantt = await t.getGanttAsync();
    const {
      store
    } = gantt,
          rec11DepsCount = store.getById(11).dependencies.length;
    t.chain({
      click: '[data-id=11]'
    }, {
      type: '[X]',
      options: {
        ctrlKey: true
      }
    }, {
      waitForSelector: '.b-cut-row[data-id=11]',
      desc: 'Row id 11 style was changed to "cut" when using CTRL+X'
    }, {
      waitForSelector: '[data-task-id=11] .b-cut-row',
      desc: 'Task bar id 11 style was changed to "cut" when using CTRL+X'
    }, {
      click: '[data-id=13]'
    }, {
      type: '[V]',
      options: {
        ctrlKey: true
      }
    }, next => {
      const recPasted = store.getById(11);
      t.is(store.indexOf(recPasted), 3, 'Row id 11 was pasted to correct position');
      t.is(recPasted.dependencies.length, rec11DepsCount, 'Row id 11 still has same dependencies quantity');
    });
  });
  t.it('Should allow user multiple cut and paste using CTRL+X and CTRL+V', async t => {
    gantt = await t.getGanttAsync();
    const {
      store
    } = gantt,
          rec12DepsCount = store.getById(12).dependencies.length,
          rec13DepsCount = store.getById(13).dependencies.length;
    t.chain({
      click: '[data-id=12]'
    }, {
      click: '[data-id=13]',
      options: {
        ctrlKey: true
      }
    }, {
      type: '[X]',
      options: {
        ctrlKey: true
      }
    }, {
      waitForSelector: '.b-cut-row[data-id=12]',
      desc: 'Row id 12 style was changed to "cut" when using CTRL+X'
    }, {
      waitForSelector: '[data-task-id=12] .b-cut-row',
      desc: 'Task bar id 12 style was changed to "cut" when using CTRL+X'
    }, {
      click: '[data-id=22]'
    }, {
      type: '[V]',
      options: {
        ctrlKey: true
      }
    }, next => {
      const recPasted1 = store.getById(12),
            recPasted2 = store.getById(13);
      t.is(store.indexOf(recPasted1), 6, 'Row id 12 was pasted to correct position');
      t.is(recPasted1.dependencies.length, rec12DepsCount, 'Row id 12 still has same dependencies quantity');
      t.is(store.indexOf(recPasted2), 7, 'Row id 13 was pasted to correct position');
      t.is(recPasted2.dependencies.length, rec13DepsCount, 'Row id 13 still has same dependencies quantity');
    });
  });
  t.it('Should allow user single copy and paste using CTRL+C and CTRL+V', async t => {
    gantt = await t.getGanttAsync();
    const {
      store
    } = gantt;
    t.chain({
      click: '[data-id=14]'
    }, {
      type: '[C]',
      options: {
        ctrlKey: true
      }
    }, {
      click: '[data-id=231]'
    }, {
      type: '[V]',
      options: {
        ctrlKey: true
      }
    }, next => {
      const [newRecCopy] = store.findByField('name', 'Report to management - 2');
      t.is(newRecCopy.index, 11, 'Row copy of the id 14 was pasted to correct position and with correct name');
      t.is(newRecCopy.data.dependencies.length, 0, 'Row copy of the id 14 has no dependencies');
    });
  });
  t.it('Should allow user multiple copy and paste using CTRL+C and CTRL+V', async t => {
    gantt = await t.getGanttAsync();
    const {
      store
    } = gantt;
    t.chain({
      click: '[data-id=232]'
    }, {
      click: '[data-id=233]',
      options: {
        ctrlKey: true
      }
    }, {
      type: '[C]',
      options: {
        ctrlKey: true
      }
    }, {
      click: '[data-id=3]'
    }, {
      type: '[V]',
      options: {
        ctrlKey: true
      }
    }, () => {
      const [newRecCopy1] = store.findByField('name', 'Step 2 - 2'),
            [newRecCopy2] = store.findByField('name', 'Step 3 - 2');
      t.is(newRecCopy1.index, 15, 'Row copy of the id 232 was pasted to correct position and with correct name');
      t.is(newRecCopy2.index, 16, 'Row copy of the id 233 was pasted to correct position and with correct name');
      t.is(newRecCopy1.data.dependencies.length, 0, 'Row copy of the id 232 has no dependencies');
      t.is(newRecCopy2.data.dependencies.length, 0, 'Row copy of the id 233 has no dependencies');
    });
  });
  t.it('Should keep dependencies via copied tasks using CTRL+C and CTRL+V', async t => {
    gantt = await t.getGanttAsync();
    const {
      store
    } = gantt;
    t.chain({
      click: '[data-id=233]'
    }, {
      click: '[data-id=234]',
      options: {
        ctrlKey: true
      }
    }, {
      type: '[C]',
      options: {
        ctrlKey: true
      }
    }, {
      click: '[data-id=3]'
    }, {
      type: '[V]',
      options: {
        ctrlKey: true
      }
    }, () => {
      var _newRecCopy1$data$dep, _newRecCopy2$data$dep;

      const [newRecCopy1] = store.findByField('name', 'Step 3 - 2'),
            [newRecCopy2] = store.findByField('name', 'Follow up with customer - 2');
      t.is(newRecCopy1.index, 15, 'Row copy of the id 232 was pasted to correct position and with correct name');
      t.is(newRecCopy2.index, 16, 'Row copy of the id 233 was pasted to correct position and with correct name');
      t.is(newRecCopy1.data.dependencies.length, 1, 'Row copy of the id 233 has a dependency');
      t.is(newRecCopy2.data.dependencies.length, 1, 'Row copy of the id 234 has a dependency');
      t.is((_newRecCopy1$data$dep = newRecCopy1.data.dependencies[0]) === null || _newRecCopy1$data$dep === void 0 ? void 0 : _newRecCopy1$data$dep.toEvent.id, newRecCopy2.id, 'Row copy of the id 233 has a dependency to second copied record');
      t.is((_newRecCopy2$data$dep = newRecCopy2.data.dependencies[0]) === null || _newRecCopy2$data$dep === void 0 ? void 0 : _newRecCopy2$data$dep.fromEvent.id, newRecCopy1.id, 'Row copy of the id 234 has a dependency to first copied record');
    });
  });
  t.it('Should keep hierarchy via copied tasks using CTRL+C and CTRL+V', async t => {
    gantt = await t.getGanttAsync();
    const {
      store
    } = gantt;
    t.chain({
      click: '[data-id=23]'
    }, {
      click: '[data-id=231]',
      options: {
        ctrlKey: true
      }
    }, {
      type: '[C]',
      options: {
        ctrlKey: true
      }
    }, {
      click: '[data-id=3]'
    }, {
      type: '[V]',
      options: {
        ctrlKey: true
      }
    }, () => {
      var _newRecCopy1$data$chi;

      const [newRecCopy1] = store.findByField('name', 'Build prototype - 2');
      t.is((_newRecCopy1$data$chi = newRecCopy1.data.children[0]) === null || _newRecCopy1$data$chi === void 0 ? void 0 : _newRecCopy1$data$chi.data.name, 'Step 1 - 2', 'Pa copy of the id 23 has a child record with the name of the second record');
    });
  });
  t.it('Should paste cut data in same order as they appear in the store', async t => {
    gantt = await t.getGanttAsync();
    const {
      store
    } = gantt;
    gantt.selectRows([store.getById(13), store.getById(12)]);
    gantt.copyRows(true);
    gantt.pasteRows(store.getById(8));
    t.is(store.indexOf(store.getById(12)), 3, 'Row id 12 was pasted to correct position');
    t.is(store.indexOf(store.getById(13)), 4, 'Row id 13 was pasted to correct position');
  }); // https://github.com/bryntum/support/issues/3303

  t.it('Should trigger beforeCopy event', async t => {
    let count = 0;
    gantt = await t.getGanttAsync({
      listeners: {
        beforeCopy: ({
          records,
          isCut
        }) => {
          t.is(records.length, 1);
          t.is(isCut, false);
          count++;
          return false;
        }
      }
    });
    await t.click('.b-grid-cell:contains(Investigate)');
    await t.type(null, 'c', null, null, {
      ctrlKey: true
    });
    t.is(count, 1, '1 event fired');
    t.is(gantt.features.taskCopyPaste.clipboardRecords.length, 0, 'No record in clipboard');
  }); // https://github.com/bryntum/support/issues/3303

  t.it('Should trigger beforePaste event', async t => {
    let count = 0;
    gantt = await t.getGanttAsync({
      listeners: {
        beforePaste: ({
          referenceRecord,
          records,
          isCut
        }) => {
          t.is(referenceRecord, gantt.taskStore.getById(14));
          t.is(records.length, 1);
          t.is(isCut, true, 'Is cut operation');
          count++;
          return false;
        }
      }
    });
    t.wontFire(gantt.taskStore, 'change');
    t.wontFire(gantt.taskStore, 'add');
    t.wontFire(gantt.taskStore, 'remove');
    await t.click('.b-grid-cell:contains(Investigate)');
    await t.type(null, 'x', null, null, {
      ctrlKey: true
    });
    await t.click('.b-grid-cell:contains(Report to management)');
    t.is(gantt.features.taskCopyPaste.clipboardRecords.length, 1, 'One record in clipboard');
    await t.type(null, 'v', null, null, {
      ctrlKey: true
    });
    t.is(count, 1, '1 event fired');
  }); // https://github.com/bryntum/support/issues/4138

  t.it('Should not add b-cut-row CSS class after a task bar is cut then copied', async t => {
    gantt = t.getGantt({
      startDate: '2020-02-24',
      endDate: '2020-04-24',
      tasks: [{
        id: 11,
        name: 'Task 11',
        startDate: '2020-02-24',
        duration: 2,
        constraintDate: '2020-02-24',
        constraintType: 'muststarton'
      }]
    });
    await t.click('.b-gantt-task');
    await t.type(null, 'x', null, null, {
      ctrlKey: true
    });
    t.selectorExists('.b-cut-row');
    await t.type(null, 'c', null, null, {
      ctrlKey: true
    });
    t.selectorNotExists('.b-cut-row');
  });
});