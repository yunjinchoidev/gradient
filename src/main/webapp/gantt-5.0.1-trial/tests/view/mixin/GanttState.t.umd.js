"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    gantt && gantt.destroy();
  });

  function getState(stateful) {
    return JSON.stringify(stateful.state);
  }

  function applyState(stateful, state) {
    state = JSON.parse(state);
    stateful.state = state;
    return state;
  }

  t.it('Should restore state', t => {
    gantt = t.getGantt({
      startDate: null,
      endDate: null
    });
    const {
      startDate,
      endDate
    } = gantt;
    applyState(gantt, getState(gantt));
    t.is(gantt.startDate, startDate, 'Gantt start is ok');
    t.is(gantt.endDate, endDate, 'Gantt end is ok');
  });
  t.it('Should restore zoom level', async t => {
    gantt = t.getGantt(); // change tick size

    gantt.tickSize *= 2;
    const {
      tickSize,
      startDate,
      endDate,
      viewportCenterDate
    } = gantt;
    const state = getState(gantt);
    gantt.tickSize += 50;
    applyState(gantt, state);
    t.is(gantt.tickSize, tickSize, 'Tick size is ok');
    t.is(gantt.startDate, startDate, 'Start is ok');
    t.is(gantt.endDate, endDate, 'End is ok');
    t.is(gantt.viewportCenterDate, viewportCenterDate, 'Center date is ok');
  });
  t.it('Should restore duration column filter', async t => {
    gantt = await t.getGanttAsync({
      features: {
        filter: true
      },
      columns: [{
        type: 'name'
      }, {
        type: 'duration'
      }]
    });
    t.chain({
      rightClick: '.b-grid-row[data-id="11"] .b-grid-cell[data-column="fullDuration"]'
    }, {
      click: '.b-menuitem:contains(Equals)'
    }, async () => {
      t.is(gantt.taskStore.count, 3, '3 tasks left');
      const state = getState(gantt);
      gantt.taskStore.clearFilters();
      t.isGreater(gantt.taskStore.count, 3, 'Filter removed');
      applyState(gantt, state);
    }, {
      waitFor() {
        return gantt.taskStore.count === 3;
      },

      desc: 'Task store count is ok'
    });
  });
  t.it('Should restore duration column customized filter', async t => {
    gantt = await t.getGanttAsync({
      features: {
        filter: true
      },
      columns: [{
        type: 'name'
      }, {
        type: 'duration',
        filterable: {
          filterField: {
            type: 'durationfield'
          },
          filterFn: ({
            record,
            value,
            operator
          }) => {
            switch (operator) {
              case '<':
                return record.fullDuration < value;

              case '>':
                return record.fullDuration > value;

              case '=':
                return record.fullDuration.valueOf() === value.valueOf();
            }
          }
        }
      }]
    });
    t.chain({
      rightClick: '.b-grid-row[data-id="11"] .b-grid-cell[data-column="fullDuration"]'
    }, {
      click: '.b-menuitem:contains(Equals)'
    }, async () => {
      t.is(gantt.taskStore.count, 3, '3 tasks left');
      const state = getState(gantt);
      gantt.taskStore.clearFilters();
      t.isGreater(gantt.taskStore.count, 3, 'Filter removed');
      applyState(gantt, state);
    }, {
      waitFor() {
        return gantt.taskStore.count === 3;
      },

      desc: 'Task store count is ok'
    }, async () => {
      t.selectorCountIs('.b-grid-header [data-filter-text*="= 10 days"]', 1, 'Tooltip is ok');
    });
  }); // https://github.com/bryntum/support/issues/2080

  t.it('Should restore WBS column filter', async t => {
    gantt = await t.getGanttAsync({
      features: {
        filter: true
      },
      columns: [{
        type: 'wbs'
      }, {
        type: 'name'
      }]
    });
    t.chain({
      rightClick: '.b-grid-row[data-id="1"] .b-grid-cell'
    }, {
      click: '.b-menuitem:contains(Equals)'
    }, async () => {
      t.is(gantt.taskStore.count, 6, '6 tasks left');
      const state = getState(gantt);
      gantt.taskStore.clearFilters();
      t.isGreater(gantt.taskStore.count, 6, 'Filter removed');
      applyState(gantt, state);
    }, {
      waitFor() {
        return gantt.taskStore.count === 6;
      },

      desc: 'Task store count is ok'
    });
  });
  t.it('Sorting should first be applied after initial commit (restoring state)', async t => {
    var _gantt$taskStore$sort;

    const eventsData = [{
      id: 1,
      name: 'Task 1',
      startDate: '2020-11-30',
      duration: 2
    }, {
      id: 2,
      name: 'Task 2',
      startDate: '2020-12-01',
      duration: 2
    }, {
      id: 3,
      name: 'Task 3',
      startDate: '2020-12-02',
      duration: 2
    }];
    gantt = await t.getGanttAsync({
      project: {
        startDate: '2020-11-30',
        eventsData
      }
    }); // Sort tasks in reverse order by start date. They won't change order

    gantt.taskStore.sort({
      field: 'startDate',
      ascending: false
    });
    t.isDeeply(gantt.taskStore.getRange().map(r => r.id), [1, 2, 3], 'Task order is correct');
    const state = getState(gantt);
    gantt.destroy(); // do not wait for project to be ready on purpose

    gantt = t.getGantt({
      project: {
        startDate: '2020-11-30',
        eventsData
      }
    }); // This would restore gantt state

    applyState(gantt, state); // Wait for project to calculate

    await gantt.project.await('dataReady'); // Store state will be restored in the next animation frame after dataReady, so we need to wait for one

    await t.waitForAnimationFrame();
    t.isDeeply((_gantt$taskStore$sort = gantt.taskStore.sorters) === null || _gantt$taskStore$sort === void 0 ? void 0 : _gantt$taskStore$sort[0], {
      field: 'startDate',
      ascending: false
    }, 'Sorter is applied');
    t.isDeeply(gantt.taskStore.getRange().map(r => r.id), [1, 2, 3], 'Task order is correct');
  });
  t.it('Filters should first be applied after initial commit (restoring state)', async t => {
    // End dates are invalid here, so if filter is going to be applied _before_ project is calculated, filter result
    // will be incorrect
    const eventsData = [{
      id: 1,
      name: 'Task 1',
      startDate: '2020-12-01',
      endDate: '2020-12-10',
      duration: 2
    }, {
      id: 2,
      name: 'Task 2',
      startDate: '2020-12-01',
      endDate: '2020-12-09',
      duration: 4
    }, {
      id: 3,
      name: 'Task 3',
      startDate: '2020-12-01',
      endDate: '2020-12-03',
      duration: 10
    }];
    gantt = await t.getGanttAsync({
      project: {
        startDate: '2020-12-01',
        eventsData
      }
    }); // Sort tasks in reverse order by start date. They won't change order

    gantt.taskStore.filter({
      property: 'endDate',
      operator: '<',
      value: new Date('2020-12-04')
    });
    t.isDeeply(gantt.taskStore.getRange().map(r => r.id), [1], 'Filter is correct');
    const state = getState(gantt);
    gantt.destroy(); // do not wait for project to be ready on purpose

    gantt = t.getGantt({
      project: {
        startDate: '2020-12-01',
        eventsData
      }
    }); // This would restore gantt state

    applyState(gantt, state); // Wait for project to calculate

    await gantt.project.await('dataReady'); // Store state will be restored in the next animation frame after dataReady, so we need to wait for one

    await t.waitForAnimationFrame();
    const filter = gantt.taskStore.filters.first;
    t.is(filter.property, 'endDate', 'Property is ok');
    t.is(filter.operator, '<', 'Operator is ok');
    t.is(filter.value, new Date('2020-12-04'), 'Value is ok');
    t.isDeeply(gantt.taskStore.getRange().map(r => r.id), [1], 'Filter is applied correctly');
  }); // https://github.com/bryntum/support/issues/2478

  t.it('Expand trigger should be visible after apply collapsed state for normal grid', async t => {
    gantt = await t.getGanttAsync();
    let {
      normal
    } = gantt.subGrids;
    const normalGridWidth = normal.width;
    await gantt.subGrids.normal.collapse(); // save state

    const state = getState(gantt);
    gantt.destroy();
    gantt = await t.getGanttAsync(); // apply state to new gantt

    applyState(gantt, state);
    await t.waitForSelector('.b-icon-collapse-gridregion');
    t.pass('Expand normal grid icon is visible');
    await gantt.subGrids.normal.expand();
    ({
      normal
    } = gantt.subGrids); // If both locked and normal grid width is defined it wouldn't allow proper resizing using splitter.
    // There HAS TO BE at least one region that could fill remaining space with `flex: 1`

    t.is(typeof gantt.state.subGrids.locked.width, 'number', 'State should define width of the locked grid');
    t.is(gantt.state.subGrids.normal.width, undefined, 'State should not define width of the normal grid'); // Wait for any animation to finish

    await t.waitFor(() => normal.width === normalGridWidth);
    t.is(normal.width, normalGridWidth, 'Width restored correctly');
    t.notOk(normal.collapsed, 'Normal grid is expanded');
    t.notOk(normal.element.classList.contains('b-grid-subgrid-collapsed'), 'Normal grid element doesnt have collapsed cls');
  });
});