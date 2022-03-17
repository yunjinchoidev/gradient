"use strict";

const STATE_KEY = 'GanttStateProviderTest';
StartTest(t => {
  let gantt;
  const getStateSpy = t.spyOn(Gantt.prototype, 'getState'),
        setValueSpy = t.spyOn(StateProvider.prototype, 'setValue');
  t.beforeEach(() => {
    var _gantt;

    (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
    getStateSpy.reset();
    setValueSpy.reset();
    localStorage.removeItem(`bryntum-state:${STATE_KEY}`);
  });
  t.it('Should store state in the background (inline data)', async t => {
    const stateProvider = new StateProvider(),
          writeStateSpy = t.spyOn(Gantt.prototype, 'saveState'),
          runStep = async (fn, name) => {
      writeStateSpy.reset();
      getStateSpy.reset();
      t.diag(name);
      await fn();
      await t.waitFor({
        method: () => getStateSpy.calls.count() >= 1,
        desc: 'State is read'
      });
      t.expect(writeStateSpy).toHaveBeenCalled('>=1');
    },
          ganttConfig = {
      stateProvider,
      stateId: STATE_KEY,
      features: {
        filter: true,
        regionResize: true
      },
      columns: [{
        id: 'name',
        type: 'name',
        width: 150
      }, {
        id: 'timeAxis',
        type: 'timeAxis'
      }]
    };

    gantt = await t.getGanttAsync(Object.assign({
      width: 600,
      height: 300,
      subGridConfigs: {
        locked: {
          width: 100
        }
      }
    }, ganttConfig)); // Sorting should trigger state

    await runStep(() => gantt.zoomIn(), 'Zoom in'); // Tick size should trigger state

    await runStep(() => gantt.tickSize += 10, 'Tick size'); // Bar margin

    await runStep(() => gantt.barMargin += 2, 'Bar margin'); // Event selection

    await runStep(() => t.click('.id11.b-gantt-task'), 'Select leaf task');
    const {
      state
    } = gantt;
    gantt.destroy(); // New gantt should apply state from start

    gantt = await t.getGanttAsync(Object.assign({}, ganttConfig));
    const newState = gantt.state;
    delete newState.scroll;
    delete state.scroll; // Assert center date when this issue is fixed
    // https://github.com/bryntum/support/issues/4094

    delete newState.zoomLevelOptions.centerDate;
    delete state.zoomLevelOptions.centerDate;
    t.isDeeply(newState, state, 'New gantt state is ok');
  });
  t.it('Should apply state on load', async t => {
    const stateProvider = new StateProvider();
    gantt = await t.getRemoteGanttAsync({
      stateProvider,
      stateId: STATE_KEY
    });
    await Promise.all([t.click('.id11.b-gantt-task'), gantt.await('selectionchange', false)]);
    await t.waitFor({
      method: () => {
        var _JSON$parse;

        return (_JSON$parse = JSON.parse(localStorage.getItem(`bryntum-state:${STATE_KEY}`))) === null || _JSON$parse === void 0 ? void 0 : _JSON$parse.selectedCell;
      },
      desc: 'State is saved'
    });
    gantt.destroy();
    gantt = await t.getRemoteGanttAsync({
      stateProvider,
      stateId: STATE_KEY
    }, 1000);
    t.is(gantt.selectedRecords[0].id, 11, 'Record selection is restored');
  });
  t.it('Should not write state until first commit is done', async t => {
    gantt = await t.getRemoteGanttAsync({
      stateProvider: new StateProvider(),
      stateId: STATE_KEY
    });
    t.notOk(gantt.stateProvider.writeStatefuls.isPending, 'No writes are pending');
    t.expect(setValueSpy).not.toHaveBeenCalled();
    t.notOk(gantt.readOnly, 'Gantt is not read only');
    gantt.destroy();
    setValueSpy.reset();
    gantt = await t.getRemoteGanttAsync({
      stateProvider: new StateProvider(),
      stateId: STATE_KEY,
      readOnly: true
    });
    t.notOk(gantt.stateProvider.writeStatefuls.isPending, 'No writes are pending');
    t.expect(setValueSpy).not.toHaveBeenCalled();
    t.ok(gantt.readOnly, 'Gantt is read only');
  });
  t.it('Should apply filter state on load with remove dataset', async t => {
    localStorage.setItem(`bryntum-state:${STATE_KEY}`, '{"store":{"filters":[{"columnOwned":true,"operator":">","value":"3 days","property":"fullDuration","type":"duration"}]}}');
    gantt = await t.getRemoteGanttAsync({
      stateProvider: new StateProvider(),
      stateId: STATE_KEY
    });
    t.notOk(gantt.taskStore.isAvailable(234), '2 day task is filtered out');
    setValueSpy.reset();
    gantt.taskStore.clearFilters();
    await t.waitFor({
      method: () => setValueSpy.calls.count() === 1,
      desc: 'Clearing filter triggered state'
    });
  });
  t.it('Should sync state after reconfiguring the project', async t => {
    gantt = await t.getRemoteGanttAsync({
      stateProvider: new StateProvider(),
      stateId: STATE_KEY
    });
    t.mockUrl('load', {
      responseText: JSON.stringify({
        success: true,
        tasks: {
          rows: [{
            id: 1,
            name: 'Task 1',
            startDate: '2017-01-15',
            duration: 1
          }, {
            id: 2,
            name: 'Task 2',
            duration: 1
          }]
        },
        dependencies: {
          rows: [{
            id: 1,
            fromEvent: 1,
            toEvent: 2
          }]
        }
      })
    });
    gantt.project = {
      autoLoad: false,
      transport: {
        load: {
          url: 'load'
        }
      }
    };
    await gantt.project.load();
    setValueSpy.reset();
    gantt.project.taskStore.sort({
      field: 'name',
      ascending: false
    });
    await t.waitFor({
      method: () => setValueSpy.calls.count() === 1,
      desc: 'Sorting triggered state'
    });
  });
});