"use strict";

StartTest(t => {
  let gantt, addNewColumn;
  t.beforeEach(() => {
    gantt && gantt.destroy();
    gantt = t.getGantt({
      appendTo: document.body,
      subGridConfigs: {
        locked: {
          width: 200
        }
      },
      columns: [{
        type: 'name'
      }, {
        text: 'foo'
      }, {
        text: 'bar'
      }, {
        text: 'baz'
      }, {
        type: 'addnew',
        width: 80
      }]
    });
    addNewColumn = gantt.columns.getAt(4);
  });
  t.it('Check all extra available columns', async t => {
    t.ok(addNewColumn.combo.isWidget, 'combo property works');
    await t.waitForRowsVisible(gantt);
    await t.click(addNewColumn.combo.input);
    t.isDeeply(addNewColumn.combo.picker.store.records.map(r => ({
      id: r.id,
      text: r.text
    })), [{
      id: 'percentdone',
      text: '% Done'
    }, {
      id: 'resourceassignment',
      text: 'Assigned Resources'
    }, {
      id: 'calendar',
      text: 'Calendar'
    }, {
      id: 'constraintdate',
      text: 'Constraint Date'
    }, {
      id: 'constrainttype',
      text: 'Constraint Type'
    }, {
      id: 'deadlinedate',
      text: 'Deadline'
    }, {
      id: 'duration',
      text: 'Duration'
    }, {
      id: 'earlyenddate',
      text: 'Early End'
    }, {
      id: 'earlystartdate',
      text: 'Early Start'
    }, {
      id: 'effort',
      text: 'Effort'
    }, {
      id: 'eventmode',
      text: 'Event mode'
    }, {
      id: 'enddate',
      text: 'Finish'
    }, {
      id: 'inactive',
      text: 'Inactive'
    }, {
      id: 'lateenddate',
      text: 'Late End'
    }, {
      id: 'latestartdate',
      text: 'Late Start'
    }, {
      id: 'manuallyscheduled',
      text: 'Manually scheduled'
    }, {
      id: 'milestone',
      text: 'Milestone'
    }, {
      id: 'note',
      text: 'Note'
    }, {
      id: 'predecessor',
      text: 'Predecessors'
    }, {
      id: 'rollup',
      text: 'Rollup'
    }, {
      id: 'schedulingmodecolumn',
      text: 'Scheduling Mode'
    }, {
      id: 'sequence',
      text: 'Sequence'
    }, {
      id: 'showintimeline',
      text: 'Show in timeline'
    }, {
      id: 'startdate',
      text: 'Start'
    }, {
      id: 'successor',
      text: 'Successors'
    }, {
      id: 'totalslack',
      text: 'Total Slack'
    }, {
      id: 'wbs',
      text: 'WBS'
    }], 'Correct available columns');
  });
  t.it('Create new column', async t => {
    const newColumnsStore = addNewColumn.combo.store,
          firstColumnClass = newColumnsStore.getAt(0).value,
          secondColumnClass = newColumnsStore.getAt(1).value;
    await t.waitForRowsVisible(gantt);
    t.click(addNewColumn.combo.input);
    await t.waitFor(() => {
      var _addNewColumn$combo$_;

      return (_addNewColumn$combo$_ = addNewColumn.combo._picker) === null || _addNewColumn$combo$_ === void 0 ? void 0 : _addNewColumn$combo$_.isVisible;
    });
    t.click(addNewColumn.combo.picker.getItem(0));
    await t.waitFor(() => {
      var _addNewColumn$combo$_2;

      return !((_addNewColumn$combo$_2 = addNewColumn.combo._picker) !== null && _addNewColumn$combo$_2 !== void 0 && _addNewColumn$combo$_2.isVisible);
    }); // The first column class must now be present

    t.ok(gantt.columns.some(c => c.constructor === firstColumnClass));
    await t.click(addNewColumn.combo.input);
    await t.waitFor(() => addNewColumn.combo.picker.isVisible);
    await t.click(addNewColumn.combo.picker.getItem(0));
    await t.waitFor(() => !addNewColumn.combo.picker.isVisible); // The second column class must now be present

    t.ok(gantt.columns.some(c => c.constructor === secondColumnClass));
  }); // https://app.assembla.com/spaces/bryntum/tickets/8133/details

  t.it('should not cause scroll to be reset when hiding a column', async t => {
    await t.waitForRowsVisible(gantt);
    gantt.subGrids.locked.scrollable.x = 100;
    await t.rightClick('.b-grid-header-text:contains(foo)');
    await t.click('.b-menu-text:contains(Hide)');
    gantt.columns.getAt(2).hidden = true;
    t.is(gantt.subGrids.locked.scrollable.x, 100, 'Scroll intact');
  });
});