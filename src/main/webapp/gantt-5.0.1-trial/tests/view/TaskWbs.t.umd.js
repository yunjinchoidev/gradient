"use strict";

StartTest(t => {
  let gantt, items, project;
  t.beforeEach(() => {
    var _gantt;

    gantt = (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
    items = project = null;
  });

  function sortByWbs(ascending = true) {
    gantt.taskStore.addSorter({
      field: 'wbsValue',
      ascending
    });
  }

  async function getGantt(ganttConfig, eventsData) {
    var _ganttConfig$project$, _ganttConfig$project;

    gantt = await t.getGanttAsync(ObjectHelper.merge({
      height: 700,
      startDate: (_ganttConfig$project$ = ganttConfig === null || ganttConfig === void 0 ? void 0 : (_ganttConfig$project = ganttConfig.project) === null || _ganttConfig$project === void 0 ? void 0 : _ganttConfig$project.startDate) !== null && _ganttConfig$project$ !== void 0 ? _ganttConfig$project$ : '2017-06-19',
      columns: [{
        type: 'wbs'
      }],
      project: {
        startDate: '2017-06-19',
        eventsData: [{
          id: 11,
          name: 'Node 11',
          startDate: '2017-06-19',
          endDate: '2017-06-24',
          expanded: true,
          children: [{
            id: 1,
            name: 'Node 1',
            startDate: '2017-06-19',
            endDate: '2017-06-24'
          }, {
            id: 2,
            name: 'Node 2',
            startDate: '2017-06-19',
            endDate: '2017-06-24',
            expanded: true,
            children: [{
              id: 3,
              name: 'Node 3',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 4,
              name: 'Node 4',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 5,
              name: 'Node 5',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }]
          }]
        }, {
          id: 21,
          name: 'Node 21',
          startDate: '2017-06-19',
          endDate: '2017-06-24',
          expanded: true,
          children: [{
            id: 6,
            name: 'Node 6',
            startDate: '2017-06-19',
            endDate: '2017-06-24'
          }, {
            id: 7,
            name: 'Node 7',
            startDate: '2017-06-19',
            endDate: '2017-06-24',
            expanded: true,
            children: [{
              id: 8,
              name: 'Node 8',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 9,
              name: 'Node 9',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }]
          }]
        }].concat(eventsData || [])
      }
    }, ganttConfig));
    project = gantt.project;
    return gantt;
  }

  function getItems(taskStore = gantt.taskStore) {
    items = [];
    taskStore.rootNode.traverse(node => {
      if (!node.isRoot) {
        items.push(`${'>'.repeat(node.childLevel + 1)} ${node.name} (${node.wbsCode})`);
      }
    });
    return items;
  }

  t.describe('Wbs', t => {
    t.it('should handle comparisons', t => {
      /* eslint-disable camelcase */
      const wbs1_1 = Wbs.from('1.1');
      const wbs1_10 = Wbs.from('1.10');
      const wbs1_100 = Wbs.from('1.100');
      const wbs1_1_1_100_1 = Wbs.from('1.1.1.100.1');
      const wbs1_1_1_2_100_1 = Wbs.from('1.1.1.2.100.1');
      const wbs1_2 = Wbs.from('1.2');
      const wbs1_2b = Wbs.from('1.2');
      const wbs1_3 = Wbs.from('1.3');
      t.ok(Wbs.compare(wbs1_2, wbs1_2b) === 0, 'Compares 1.2 equal to 1.2');
      t.ok(!(wbs1_2 < wbs1_2b), 'Compares 1.2 not less than 1.2');
      t.ok(wbs1_2 > wbs1_1, 'Compares 1.2 greater than 1.1');
      t.ok(wbs1_2 < wbs1_3, 'Compares 1.2 less than 1.3');
      t.ok(wbs1_2 < wbs1_10, 'Compares 1.2 less than 1.10');
      t.ok(wbs1_2 < wbs1_100, 'Compares 1.2 less than 1.100');
      t.ok(wbs1_1_1_2_100_1 < wbs1_1_1_100_1, 'Compares 1.1.1.2.100.1 less than 1.1.1.100.1');
      t.notOk(wbs1_1_1_2_100_1.value < wbs1_1_1_100_1.value, 'Compares text of 1.1.1.2.100.1 not less than 1.1.1.100.1');
      /* eslint-enable camelcase */
    });
    t.it('should handle null value', t => {
      const wbs = new Wbs(null);
      t.isStrict(wbs.toString(), '', 'Handles null on toString');
      t.isStrict(wbs.valueOf(), '', 'Handles null on valueOf');
      t.isStrict(wbs.append('1').toString(), '1', 'Handles null with append');
      t.expect(Wbs.split(null)).toEqual([]);
    });
    t.it('should handle append', t => {
      const wbs = Wbs.from('1.2');
      t.isStrict(wbs.append('3').toString(), '1.2.3', 'Correctly append');
    });
    t.it('should properly match', t => {
      const wbs = Wbs.from('1.2.1.3');
      t.ok(wbs.match('1.2'));
      t.ok(wbs.match('1.2*'));
      t.ok(wbs.match('2.1'));
      t.ok(wbs.match('*2.1*'));
      t.ok(wbs.match('1.3'));
      t.ok(wbs.match('*1.3'));
      t.notOk(wbs.match('*1.2'));
      t.notOk(wbs.match('4'));
    });
    t.it('should properly split', t => {
      t.expect(Wbs.split(1)).toEqual([1]);
      t.expect(Wbs.split('1')).toEqual([1]);
      t.expect(Wbs.split('1.2')).toEqual([1, 2]);
    });
  });
  t.it('should maintain WBS values when filtered', async t => {
    await getGantt();
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 3 (1.2.1)', '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct unfiltered nodes');
    gantt.taskStore.addFilter(rec => !/Node [38]/.test(rec.name));
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', //'>>> Node 3 (1.2.1)',
    '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', //'>>> Node 8 (2.2.1)',
    '>>> Node 9 (2.2.2)'], 'Correct filtered nodes');
  });
  t.it('should maintain WBS values when appending items', async t => {
    await getGantt();
    const node3 = gantt.taskStore.getById(3);
    t.expect(node3.wbsCode).toEqual('1.2.1');
    t.expect(node3.wbsValue.value).toEqual('1.2.1');
    node3.parent.appendChild({
      id: 300,
      name: 'Node 300',
      startDate: '2017-06-19',
      endDate: '2017-06-24'
    });
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 3 (1.2.1)', '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '>>> Node 300 (1.2.4)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct after append');
  });
  t.it('should reassign WBS values when setting inlineData', async t => {
    await getGantt();
    const node3 = gantt.taskStore.getById(3);
    t.expect(node3.wbsCode).toEqual('1.2.1');
    t.expect(node3.wbsValue.value).toEqual('1.2.1');
    gantt.taskStore.project.inlineData = {
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
    t.isDeeply(getItems(), ['> Herp (1)', '>> Derp (1.1)'], 'Correct after assigning inlineData');
  });
  t.it('should maintain WBS values when appending items to reverse sorted store', async t => {
    await getGantt();
    const node3 = gantt.taskStore.getById(3);
    sortByWbs(false);
    node3.parent.appendChild({
      id: 300,
      name: 'Node 300',
      startDate: '2017-06-19',
      endDate: '2017-06-24'
    });
    t.expect(node3.wbsCode).toEqual('1.2.2');
    t.expect(node3.wbsValue.value).toEqual('1.2.2');
    t.isDeeply(getItems(), ['> Node 21 (2)', '>> Node 7 (2.2)', '>>> Node 9 (2.2.2)', '>>> Node 8 (2.2.1)', '>> Node 6 (2.1)', '> Node 11 (1)', '>> Node 2 (1.2)', '>>> Node 5 (1.2.4)', '>>> Node 4 (1.2.3)', '>>> Node 3 (1.2.2)', '>>> Node 300 (1.2.1)', '>> Node 1 (1.1)'], 'Correct after append');
  });
  t.it('should maintain WBS values when inserting items', async t => {
    await getGantt();
    const node2 = gantt.taskStore.getById(2);
    node2.parent.insertChild({
      id: 200,
      name: 'Node 200',
      startDate: '2017-06-19',
      endDate: '2017-06-24'
    }, node2);
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 200 (1.2)', '>> Node 2 (1.3)', '>>> Node 3 (1.3.1)', '>>> Node 4 (1.3.2)', '>>> Node 5 (1.3.3)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct after insert');
  });
  t.it('should maintain WBS values when inserting items in reverse sorted store', async t => {
    await getGantt();
    const node2 = gantt.taskStore.getById(2);
    sortByWbs(false);
    node2.parent.insertChild({
      id: 200,
      name: 'Node 200',
      startDate: '2017-06-19',
      endDate: '2017-06-24'
    }, node2);
    const order = ['> Node 21 (2)', '>> Node 7 (2.2)', '>>> Node 9 (2.2.2)', '>>> Node 8 (2.2.1)', '>> Node 6 (2.1)', '> Node 11 (1)', '>> Node 200 (1.3)', '>> Node 2 (1.2)', '>>> Node 5 (1.2.3)', '>>> Node 4 (1.2.2)', '>>> Node 3 (1.2.1)', '>> Node 1 (1.1)'];
    t.isDeeply(getItems(), order, 'Correct initial order');
    gantt.taskStore.rootNode.refreshWbs();
    t.isDeeply(getItems(), order, 'Correct after refresh');
    gantt.taskStore.clearSorters();
    t.isDeeply(getItems(), order, 'Correct after clearing sorters');
    gantt.taskStore.rootNode.refreshWbs();
    t.isDeeply(getItems(), ['> Node 21 (1)', '>> Node 7 (1.1)', '>>> Node 9 (1.1.1)', '>>> Node 8 (1.1.2)', '>> Node 6 (1.2)', '> Node 11 (2)', '>> Node 200 (2.1)', '>> Node 2 (2.2)', '>>> Node 5 (2.2.1)', '>>> Node 4 (2.2.2)', '>>> Node 3 (2.2.3)', '>> Node 1 (2.3)'], 'Correct after refresh');
  });
  t.it('should maintain WBS values when removing items', async t => {
    await getGantt();
    gantt.taskStore.getById(3).remove();
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', //'>>> Node 3 (1.2.1)',
    '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct after remove');
  });
  t.it('should properly sort WBS values numerically', async t => {
    await getGantt({
      project: {
        eventsData: [{
          id: 100,
          name: 'Node 100',
          startDate: '2017-06-19',
          endDate: '2017-06-24',
          expanded: true,
          children: [{
            id: 1,
            name: 'Node 1',
            startDate: '2017-06-19',
            endDate: '2017-06-24'
          }, {
            id: 2,
            name: 'Node 2',
            startDate: '2017-06-19',
            endDate: '2017-06-24',
            expanded: true,
            children: [{
              id: 3,
              name: 'Node 3',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 4,
              name: 'Node 4',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 5,
              name: 'Node 5',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 6,
              name: 'Node 6',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 7,
              name: 'Node 7',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 8,
              name: 'Node 8',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 9,
              name: 'Node 9',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 10,
              name: 'Node 10',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 11,
              name: 'Node 11',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 12,
              name: 'Node 12',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 13,
              name: 'Node 13',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }, {
              id: 14,
              name: 'Node 14',
              startDate: '2017-06-19',
              endDate: '2017-06-24'
            }]
          }]
        }]
      }
    });
    sortByWbs(false);
    t.isDeeply(getItems(), ['> Node 100 (1)', '>> Node 2 (1.2)', '>>> Node 14 (1.2.12)', '>>> Node 13 (1.2.11)', '>>> Node 12 (1.2.10)', '>>> Node 11 (1.2.9)', '>>> Node 10 (1.2.8)', '>>> Node 9 (1.2.7)', '>>> Node 8 (1.2.6)', '>>> Node 7 (1.2.5)', '>>> Node 6 (1.2.4)', '>>> Node 5 (1.2.3)', '>>> Node 4 (1.2.2)', '>>> Node 3 (1.2.1)', '>> Node 1 (1.1)'], 'Correct after sort');
  });
  t.it('should maintain WBS values when reverse sorted', async t => {
    await getGantt();
    sortByWbs(false);
    t.isDeeply(getItems(), ['> Node 21 (2)', '>> Node 7 (2.2)', '>>> Node 9 (2.2.2)', '>>> Node 8 (2.2.1)', '>> Node 6 (2.1)', '> Node 11 (1)', '>> Node 2 (1.2)', '>>> Node 5 (1.2.3)', '>>> Node 4 (1.2.2)', '>>> Node 3 (1.2.1)', '>> Node 1 (1.1)'], 'Correct initial order');
    gantt.taskStore.rootNode.refreshWbs();
    t.isDeeply(getItems(), ['> Node 21 (2)', '>> Node 7 (2.2)', '>>> Node 9 (2.2.2)', '>>> Node 8 (2.2.1)', '>> Node 6 (2.1)', '> Node 11 (1)', '>> Node 2 (1.2)', '>>> Node 5 (1.2.3)', '>>> Node 4 (1.2.2)', '>>> Node 3 (1.2.1)', '>> Node 1 (1.1)'], 'Correct after refresh');
    gantt.taskStore.clearSorters();
    gantt.taskStore.rootNode.refreshWbs();
    t.isDeeply(getItems(), ['> Node 21 (1)', '>> Node 7 (1.1)', '>>> Node 9 (1.1.1)', '>>> Node 8 (1.1.2)', '>> Node 6 (1.2)', '> Node 11 (2)', '>> Node 2 (2.1)', '>>> Node 5 (2.1.1)', '>>> Node 4 (2.1.2)', '>>> Node 3 (2.1.3)', '>> Node 1 (2.2)'], 'Correct after clear sorters and refresh');
  });
  t.it('should maintain WBS values when sorted and filtered', async t => {
    await getGantt(); // await t.click('[data-column="wbsCode"]');

    sortByWbs(false);
    gantt.taskStore.addFilter(rec => !/Node [38]/.test(rec.name));
    t.isDeeply(getItems(), ['> Node 21 (2)', '>> Node 7 (2.2)', '>>> Node 9 (2.2.2)', //'>>> Node 8 (2.2.1)',
    '>> Node 6 (2.1)', '> Node 11 (1)', '>> Node 2 (1.2)', '>>> Node 5 (1.2.3)', '>>> Node 4 (1.2.2)', //'>>> Node 3 (1.2.1)',
    '>> Node 1 (1.1)'], 'Correct after filter');
  });
  t.it('should maintain WBS values when inserting into a reverse sorted then filtered store', async t => {
    await getGantt();
    const node3 = gantt.taskStore.getById(3);
    sortByWbs(false);
    gantt.taskStore.addFilter(rec => !/Node [38]/.test(rec.name));
    t.isDeeply(getItems(), ['> Node 21 (2)', '>> Node 7 (2.2)', '>>> Node 9 (2.2.2)', //'>>> Node 8 (2.2.1)',
    '>> Node 6 (2.1)', '> Node 11 (1)', '>> Node 2 (1.2)', '>>> Node 5 (1.2.3)', '>>> Node 4 (1.2.2)', //'>>> Node 3 (1.2.1)',
    '>> Node 1 (1.1)'], 'Correct filtered nodes');
    node3.parent.insertChild({
      id: 300,
      name: 'Node 300',
      startDate: '2017-06-19',
      endDate: '2017-06-24'
    }, node3);
    t.isDeeply(getItems(), ['> Node 21 (2)', '>> Node 7 (2.2)', '>>> Node 9 (2.2.2)', //'>>> Node 8 (2.2.1)',
    '>> Node 6 (2.1)', '> Node 11 (1)', '>> Node 2 (1.2)', '>>> Node 5 (1.2.4)', '>>> Node 4 (1.2.3)', '>>> Node 300 (1.2.2)', //'>>> Node 3 (1.2.1)',
    '>> Node 1 (1.1)'], 'Correct after insert');
  });
  t.it('should maintain WBS values when indenting', async t => {
    await getGantt();
    const node4 = gantt.taskStore.getById(4);
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 3 (1.2.1)', '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct unfiltered nodes');
    await gantt.taskStore.indent(node4);
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 3 (1.2.1)', '>>>> Node 4 (1.2.1.1)', '>>> Node 5 (1.2.2)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct unfiltered nodes');
  });
  t.it('should maintain WBS values when outdenting', async t => {
    await getGantt();
    const node3 = gantt.taskStore.getById(3);
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 3 (1.2.1)', '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct unfiltered nodes');
    await gantt.taskStore.outdent(node3);
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>> Node 3 (1.3)', '>>> Node 4 (1.3.1)', '>>> Node 5 (1.3.2)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct unfiltered nodes');
  });
  t.it('should maintain WBS values when reordering rows', async t => {
    await getGantt();
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 3 (1.2.1)', '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct unfiltered nodes');
    await t.mouseDown('.b-grid-cell:contains("Node 3")');
    await t.moveCursorTo('.b-grid-cell:contains("Node 6")');
    await t.waitForSelector('.b-grid-row.b-row-reordering-target-parent:contains("Node 21")');
    await t.mouseUp();
    await t.waitForSelectorNotFound('.b-row-reordering');
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '> Node 21 (2)', '>> Node 3 (1.2.1)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct unfiltered nodes');
  });
  t.it('should auto update WBS values when sorting and adding using wbsMode:auto', async t => {
    await getGantt();
    gantt.taskStore.wbsMode = 'auto';
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 3 (1.2.1)', '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct unfiltered nodes');
    gantt.taskStore.sort('name', false);
    await t.waitForSelectorNotFound('.b-row-reordering');
    t.isDeeply(getItems(), ['> Node 21 (1)', '>> Node 7 (1.1)', '>>> Node 9 (1.1.1)', '>>> Node 8 (1.1.2)', '>> Node 6 (1.2)', '> Node 11 (2)', '>> Node 2 (2.1)', '>>> Node 5 (2.1.1)', '>>> Node 4 (2.1.2)', '>>> Node 3 (2.1.3)', '>> Node 1 (2.2)'], 'Correct reverse sorted nodes');
    gantt.taskStore.getById(11).insertChild({
      id: 123,
      name: 'Xyz',
      startDate: '2017-06-21',
      endDate: '2017-06-26'
    }, gantt.taskStore.getById(2));
    t.isDeeply(getItems(), ['> Node 21 (1)', '>> Node 7 (1.1)', '>>> Node 9 (1.1.1)', '>>> Node 8 (1.1.2)', '>> Node 6 (1.2)', '> Node 11 (2)', '>> Xyz (2.1)', '>> Node 2 (2.2)', '>>> Node 5 (2.2.1)', '>>> Node 4 (2.2.2)', '>>> Node 3 (2.2.3)', '>> Node 1 (2.3)'], 'Correct reverse sorted nodes after insert');
  });
  t.it('should auto update WBS values when sorted and inserting child using wbsMode:auto', async t => {
    project = new ProjectModel({
      taskStore: {
        wbsMode: 'auto'
      }
    });
    await project.loadInlineData({
      tasksData: [{
        id: 28,
        name: 'a'
      }, {
        id: 29,
        name: 'b'
      }]
    });
    const taskStore = project.taskStore;
    await getGantt({
      project
    }); // apply descending sort by name

    taskStore.sort('name', false);
    t.expect(project.children.map(task => task.name)).toEqual(['b', 'a']);
    t.expect(getItems(project.taskStore)).toEqual(['> b (1)', '> a (2)']); // add a child to task 'b' (which is at the top of the list bc of the sort but currently has a wbs value of 2)

    taskStore.getById(29).insertChild({
      id: 30,
      name: 'c'
    });
    t.expect(getItems(project.taskStore)).toEqual(['> b (1)', '>> c (1.1)', '> a (2)']);
    t.expect(taskStore.getById(28).wbsValue.value).toEqual('2');
    t.expect(taskStore.getById(29).wbsValue.value).toEqual('1');
  });
  t.it('should auto update WBS values when reordering rows using wbsMode:auto', async t => {
    await getGantt();
    gantt.taskStore.wbsMode = 'auto';
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 3 (1.2.1)', '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct unfiltered nodes');
    await t.mouseDown('.b-grid-cell:contains("Node 3")');
    await t.moveCursorTo('.b-grid-cell:contains("Node 7")');
    await t.waitForSelector('.b-grid-row.b-row-reordering-target-parent:contains("Node 21")');
    await t.mouseUp();
    await t.waitForSelectorNotFound('.b-row-reordering');
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 4 (1.2.1)', '>>> Node 5 (1.2.2)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 3 (2.2)', '>> Node 7 (2.3)', '>>> Node 8 (2.3.1)', '>>> Node 9 (2.3.2)'], 'Correct reordered nodes');
    await t.click('[data-column=name]');
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 4 (1.2.1)', '>>> Node 5 (1.2.2)', '> Node 21 (2)', '>> Node 3 (2.1)', '>> Node 6 (2.2)', '>> Node 7 (2.3)', '>>> Node 8 (2.3.1)', '>>> Node 9 (2.3.2)'], 'Correct sorted nodes');
    await t.click('[data-column=name]');
    t.isDeeply(getItems(), ['> Node 21 (1)', '>> Node 7 (1.1)', '>>> Node 9 (1.1.1)', '>>> Node 8 (1.1.2)', '>> Node 6 (1.2)', '>> Node 3 (1.3)', '> Node 11 (2)', '>> Node 2 (2.1)', '>>> Node 5 (2.1.1)', '>>> Node 4 (2.1.2)', '>> Node 1 (2.2)'], 'Correct reverse sorted nodes');
    gantt.taskStore.addFilter(rec => !/Node [69]/.test(rec.name));
    t.isDeeply(getItems(), ['> Node 21 (1)', '>> Node 7 (1.1)', //'>>> Node 9 (1.1.1)',
    '>>> Node 8 (1.1.2)', //'>> Node 6 (1.2)',
    '>> Node 3 (1.3)', '> Node 11 (2)', '>> Node 2 (2.1)', '>>> Node 5 (2.1.1)', '>>> Node 4 (2.1.2)', '>> Node 1 (2.2)'], 'Correct filtered nodes');
  });
  t.it('should auto update WBS values when reordering rows using wbsMode:{add/remove} but not on sort', async t => {
    await getGantt();
    gantt.taskStore.wbsMode = {
      sort: false
    };
    t.isDeeply(gantt.taskStore.wbsMode, {
      sort: false,
      // if we add more operations, they should appear in this object as true...
      add: true,
      remove: true
    }, 'Correctly used opt-out form');
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 3 (1.2.1)', '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct unfiltered nodes');
    await t.mouseDown('.b-grid-cell:contains("Node 3")');
    await t.moveCursorTo('.b-grid-cell:contains("Node 7")');
    await t.waitForSelector('.b-grid-row.b-row-reordering-target-parent:contains("Node 21")');
    await t.mouseUp();
    await t.waitForSelectorNotFound('.b-row-reordering');
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 4 (1.2.1)', '>>> Node 5 (1.2.2)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 3 (2.2)', '>> Node 7 (2.3)', '>>> Node 8 (2.3.1)', '>>> Node 9 (2.3.2)'], 'Correct reordered nodes');
    await t.click('[data-column=name]');
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 4 (1.2.1)', '>>> Node 5 (1.2.2)', '> Node 21 (2)', '>> Node 3 (2.2)', '>> Node 6 (2.1)', '>> Node 7 (2.3)', '>>> Node 8 (2.3.1)', '>>> Node 9 (2.3.2)'], 'Correct sorted nodes');
  });
  t.it('should auto update WBS values on sort using wbsMode:{sort} but not when reordering rows', async t => {
    await getGantt();
    gantt.taskStore.wbsMode = {
      sort: true
    };
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 3 (1.2.1)', '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct unfiltered nodes');
    await t.mouseDown('.b-grid-cell:contains("Node 3")');
    await t.moveCursorTo('.b-grid-cell:contains("Node 7")');
    await t.waitForSelector('.b-grid-row.b-row-reordering-target-parent:contains("Node 21")');
    await t.mouseUp();
    await t.waitForSelectorNotFound('.b-row-reordering');
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 4 (1.2.2)', '>>> Node 5 (1.2.3)', '> Node 21 (2)', '>> Node 6 (2.1)', '>> Node 3 (1.2.1)', '>> Node 7 (2.2)', '>>> Node 8 (2.2.1)', '>>> Node 9 (2.2.2)'], 'Correct reordered nodes');
    await t.click('[data-column=name]');
    t.isDeeply(getItems(), ['> Node 11 (1)', '>> Node 1 (1.1)', '>> Node 2 (1.2)', '>>> Node 4 (1.2.1)', '>>> Node 5 (1.2.2)', '> Node 21 (2)', '>> Node 3 (2.1)', '>> Node 6 (2.2)', '>> Node 7 (2.3)', '>>> Node 8 (2.3.1)', '>>> Node 9 (2.3.2)'], 'Correct sorted nodes');
  }); // TODO ? the unfilteredChildren is not sorted, so the order does not match up... not sure best path here

  t.xit('should maintain WBS values when inserting into a filtered then reverse sorted store', async t => {
    await getGantt();
    const node3 = gantt.taskStore.getById(3);
    gantt.taskStore.addFilter(rec => !/Node [38]/.test(rec.name));
    sortByWbs(false);
    t.isDeeply(getItems(), ['> Node 21 (2)', '>> Node 7 (2.2)', '>>> Node 9 (2.2.2)', //'>>> Node 8 (2.2.1)',
    '>> Node 6 (2.1)', '> Node 11 (1)', '>> Node 2 (1.2)', '>>> Node 5 (1.2.3)', '>>> Node 4 (1.2.2)', //'>>> Node 3 (1.2.1)',
    '>> Node 1 (1.1)'], 'Correct after sort');
    node3.parent.insertChild({
      id: 300,
      name: 'Node 300',
      startDate: '2017-06-19',
      endDate: '2017-06-24'
    }, node3);
    t.isDeeply(getItems(), ['> Node 21 (2)', '>> Node 7 (2.2)', '>>> Node 9 (2.2.2)', //'>>> Node 8 (2.2.1)',
    '>> Node 6 (2.1)', '> Node 11 (1)', '>> Node 2 (1.2)', '>>> Node 5 (1.2.4)', '>>> Node 4 (1.2.3)', '>>> Node 300 (1.2.2)', //'>>> Node 3 (1.2.1)',
    '>> Node 1 (1.1)'], 'Correct after insert');
  }); // https://github.com/bryntum/support/issues/3572

  t.it('should track persistable WBS values when inserting items', async t => {
    class MyTask extends TaskModel {
      static get fields() {
        return [{
          name: 'wbsValue',
          persist: true
        }];
      }

    }

    await getGantt({
      project: {
        taskModelClass: MyTask
      }
    });
    const node2 = gantt.taskStore.getById(2);
    node2.parent.insertChild({
      id: 200,
      name: 'Node 200',
      startDate: '2017-06-19',
      endDate: '2017-06-24'
    }, node2);
    t.isDeeply(gantt.taskStore.added.map(({
      persistableData
    }) => [persistableData.id, persistableData.wbsValue]), [[200, '1.2']], 'the added record wbsValue is included into the data for persisting');
    t.isDeeply(gantt.taskStore.modified.map(({
      modificationDataToWrite
    }) => modificationDataToWrite), [{
      id: 2,
      wbsValue: '1.3',
      parentIndex: 2
    }, {
      id: 3,
      wbsValue: '1.3.1'
    }, {
      id: 4,
      wbsValue: '1.3.2'
    }, {
      id: 5,
      wbsValue: '1.3.3'
    }], 'updated records have wbsValue for persisting');
  });
});