"use strict";

StartTest(t => {
  let gantt, project;
  t.beforeEach(() => {
    var _project, _gantt;

    (_project = project) === null || _project === void 0 ? void 0 : _project.destroy();
    (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  });

  async function createGantt(config = {}) {
    project = new ProjectModel({
      tasksData: [{
        id: 1,
        name: 'Task 1',
        expanded: true,
        startDate: '2020-02-24',
        children: [{
          id: 11,
          name: 'Task 11',
          startDate: '2020-02-24',
          duration: 2,
          constraintDate: '2020-02-24',
          constraintType: 'muststarton'
        }, {
          id: 12,
          name: 'Task 12',
          startDate: '2020-02-24',
          duration: 2,
          deadlineDate: '2020-03-05'
        }, {
          id: 22,
          name: 'Task 22',
          startDate: '2020-02-24',
          duration: 2
        }, {
          id: 14,
          name: 'Task 14',
          startDate: '2020-02-24',
          duration: 3
        }]
      }],
      dependenciesData: [{
        fromEvent: 11,
        toEvent: 12
      }, {
        fromEvent: 12,
        toEvent: 13
      }, {
        fromEvent: 13,
        toEvent: 14
      }]
    });
    gantt = t.getGantt(Object.assign({
      features: {
        filter: true
      },
      startDate: '2020-02-24',
      project: config.project || project
    }, config));
    await gantt.project.commitAsync();
  }

  t.it('Should not display deleted data after re-apply filter', async t => {
    await createGantt();
    const sel = gantt.unreleasedEventSelector;
    t.chain({
      waitForSelector: `${sel}[data-task-id="22"]`
    }, next => {
      gantt.taskStore.filter('name', '1');
      next();
    }, {
      waitForSelectorNotFound: `${sel}[data-task-id="22"]`
    }, {
      waitForSelector: `${sel}[data-task-id="11"]`
    }, next => {
      gantt.taskStore.remove(gantt.taskStore.getById(11));
      next();
    }, {
      waitForSelectorNotFound: `${sel}[data-task-id="11"]`,
      desc: 'Task 11 has been deleted'
    }, next => {
      gantt.on('renderRows', () => {
        next();
      });
      gantt.taskStore.filter();
    }, {
      waitForSelectorNotFound: `${sel}[data-task-id="11"]`,
      desc: 'Task 11 has not been showed again after filter re-apply'
    });
  });
  t.it('Should not close filter popup when field trigger is clicked', async t => {
    await createGantt({
      columns: [{
        text: 'Duration',
        field: 'duration'
      }]
    });
    t.chain(next => {
      // simulate click on the filter icon
      gantt.features.filter.showFilterEditor(gantt.columns.get('duration').id);
      next();
    }, {
      waitForSelector: '.b-filter-popup'
    }, {
      click: '.b-icon.b-spin-up'
    }, next => {
      t.ok(gantt.features.filter.filterEditorPopup, 'Popup filter remains open after clicked on spin');
      next();
    }, {
      type: '2[ENTER]',
      clearExisting: true
    }, next => {
      t.is(gantt.store.filters.first.value, 2, 'Filter applied on press enter for number field filter');
      t.notOk(gantt.features.filter.filterEditorPopup, 'Popup closed after after press enter on field');
      next();
    }, next => {
      // simulate click on the filter icon
      gantt.features.filter.showFilterEditor(gantt.columns.get('duration').id);
      next();
    }, {
      waitForSelector: '.b-filter-popup'
    }, {
      click: '.b-icon.b-spin-up'
    }, {
      click: '.b-icon-remove'
    }, next => {
      t.notOk(gantt.store.filters.first, 'Filter removed clicking "x" icon on number field');
      t.ok(gantt.features.filter.filterEditorPopup, 'Popup filter remains open after clicked on "x"');
      next();
    }, {
      click: '.b-grid-subgrid'
    }, {
      waitForSelectorNotFound: '.b-filter-popup',
      desc: 'Popup closed after click out of the filter popup'
    });
  });
  t.it('Should apply filter to date column', async t => {
    await createGantt({
      columns: [{
        type: 'name'
      }, {
        type: 'startdate'
      }, {
        type: 'enddate'
      }]
    });
    await t.rightClick('[data-id="11"] [data-column="startDate"]');
    await Promise.all([gantt.taskStore.await('filter'), t.click('.b-menuitem:contains("On")')]);
    t.isDeeply(gantt.taskStore.getRange().map(r => r.id), [1, 11, 22, 14]);
    gantt.taskStore.clearFilters();
    await t.rightClick('[data-id="12"] [data-column="endDate"]');
    await Promise.all([gantt.taskStore.await('filter'), t.click('.b-menuitem:contains("On")')]);
    t.isDeeply(gantt.taskStore.getRange().map(r => r.id), [1, 12]);
  });
  t.it('Should apply filter to WBS column from context menu', async t => {
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
    await t.rightClick('[data-id="1"] .b-grid-cell');
    await Promise.all([gantt.taskStore.await('filter'), t.click('.b-menuitem:contains("Equals")')]);
    t.isDeeply(gantt.taskStore.getRange().map(r => r.id), [1000, 1, 11, 12, 13, 14]);
  });
  t.it('Should apply filter to WBS column from text field', async t => {
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
    await t.rightClick('.b-grid-header');
    await t.click('.b-menuitem:contains(Filter)');
    await Promise.all([gantt.taskStore.await('filter'), t.type('.b-textfield input', '1.1[ENTER]')]);
    t.isDeeply(gantt.taskStore.getRange().map(r => r.id), [1000, 1, 11, 12, 13, 14]);
  }); // https://github.com/bryntum/support/issues/2985

  t.it('Should not throw exception when load project after filter store when tasks are expanded', async t => {
    t.mockUrl('load', {
      responseText: JSON.stringify({
        success: true,
        tasks: {
          rows: [{
            id: 1,
            name: 'Event 1',
            startDate: '2020-01-14',
            expanded: true,
            children: [{
              id: 2,
              name: 'Setup web server',
              duration: 10,
              startDate: '2020-01-14'
            }]
          }]
        }
      })
    });
    await createGantt({
      startDate: new Date(2020, 0, 12),
      project: new ProjectModel({
        autoLoad: true,
        transport: {
          load: {
            url: 'load'
          }
        }
      })
    });
    t.chain({
      waitForEvent: [gantt.project, 'load']
    }, async () => {
      await gantt.taskStore.filter('name', 'Event 1');
      await gantt.project.load();
    });
  });
});