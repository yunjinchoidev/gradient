"use strict";

StartTest(t => {
  let gantt, treeGroup;
  t.beforeEach(t => {
    var _gantt;

    return (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  });

  async function setup(config = {}, levels) {
    gantt = await t.getGantt({
      features: {
        treeGroup: {
          levels
        }
      }
    });
    treeGroup = gantt.features.treeGroup;
  }

  function rect(selector) {
    return Rectangle.from(t.query(selector)[0], gantt.timeAxisSubGridElement);
  }

  t.it('Should group initially', async t => {
    await setup({}, [task => DateHelper.format(task.startDate, '{Week} W')]);
    await t.waitFor(() => !treeGroup.isApplying); // Correct rows/cells

    const strings = t.query('.b-tree-cell-value').map(el => el.innerText);
    t.is(strings[0], 'Week 3', 'Row 0 correct');
    t.is(strings[1], 'Investigate', 'Row 1 correct');
    t.is(strings[2], 'Assign resources', 'Row 2 correct');
    t.is(strings[3], 'Gather documents', 'Row 3 correct');
    t.is(strings[4], 'Week 4', 'Row 4 correct');
    t.is(strings[5], 'Report to management', 'Row 5 correct');
    t.is(strings[6], 'Preparation work', 'Row 6 correct');
    t.is(strings[7], 'Choose technology suite', 'Row 7 correct');
    t.is(strings[8], 'Week 5', 'Row 8 correct');
    t.is(strings[9], 'Step 1', 'Row 9 correct');
    t.is(strings[10], 'Step 2', 'Row 10 correct'); // Correct task bar count etc

    t.selectorCountIs('.b-gantt-task-parent', 3, '3 parents');
    t.selectorCountIs('.b-gantt-task-wrap:not(.b-gantt-task-parent)', 11, '11 tasks');
    await t.waitForDependencies();
    t.selectorCountIs('.b-sch-dependency', 10, 'Dependencies drawn'); // Assert position for one bar from each parent

    t.isApproxRect(rect('[data-task-id="11"]'), {
      top: 56,
      left: 23,
      width: 234,
      height: 25
    }, 'Investigate');
    t.isApproxRect(rect('[data-task-id="21"]'), {
      top: 286,
      left: 257,
      width: 117,
      height: 25
    }, 'Preparation work');
    t.isApproxRect(rect('[data-task-id="234"]'), {
      top: 562,
      left: 445,
      width: 23,
      height: 25
    }, 'Follow up with customer');
    t.notOk(gantt.taskStore.changes, 'Store has no changes');
  });
  t.it('Should group at runtime', async t => {
    await setup();
    const spy = t.spyOn(gantt.currentOrientation, 'onRenderDone');
    treeGroup.levels = [task => DateHelper.format(task.startDate, '{Week} W')];
    await t.waitFor(() => !treeGroup.isApplying);
    t.expect(spy).toHaveBeenCalled('<=2'); // Assert position for one bar from each parent

    t.isApproxRect(rect('[data-task-id="11"]'), {
      top: 56,
      left: 23,
      width: 234,
      height: 25
    }, 'Investigate');
    t.isApproxRect(rect('[data-task-id="21"]'), {
      top: 286,
      left: 257,
      width: 117,
      height: 25
    }, 'Preparation work');
    t.isApproxRect(rect('[data-task-id="234"]'), {
      top: 562,
      left: 445,
      width: 23,
      height: 25
    }, 'Follow up with customer');
    t.notOk(gantt.taskStore.changes, 'Store has no changes');
  });
  t.it('Should regroup at runtime', async t => {
    await setup({}, [task => DateHelper.format(task.startDate, '{Week} W')]);
    await t.waitFor(() => !treeGroup.isApplying);
    const spy = t.spyOn(gantt.currentOrientation, 'onRenderDone');
    await treeGroup.group([task => task.percentDone > 50 ? 'Finishing' : 'Starting', 'duration']);
    t.expect(spy).toHaveBeenCalled('<=2');
    t.selectorCountIs('.b-gantt-task-parent', 9, '9 parents'); // Assert position for one bar from each parent

    t.isApproxRect(rect('[data-task-id="11"]'), {
      top: 194,
      left: 23,
      width: 234,
      height: 25
    }, 'Investigate');
    t.isApproxRect(rect('[data-task-id="21"]'), {
      top: 792,
      left: 257,
      width: 117,
      height: 25
    }, 'Preparation work');
    t.isApproxRect(rect('[data-task-id="234"]'), {
      top: 470,
      left: 445,
      width: 23,
      height: 25
    }, 'Follow up with customer');
  });
  t.it('Should restore original data when clearing groups', async t => {
    await setup({}, [task => task.percentDone > 50 ? 'Finishing' : 'Starting']);
    await t.waitFor(() => !treeGroup.isApplying);
    await gantt.clearGroups();
    const strings = t.query('.b-tree-cell-value').map(el => el.innerText);
    t.is(strings[0], 'Project A', 'Row 0 correct');
    t.is(strings[1], 'Planning', 'Row 1 correct');
    t.is(strings[2], 'Investigate', 'Row 2 correct');
    t.is(strings[3], 'Assign resources', 'Row 3 correct');
    t.is(strings[4], 'Gather documents', 'Row 4 correct');
    t.is(strings[5], 'Report to management', 'Row 5 correct');
    t.is(strings[6], 'Implementation Phase', 'Row 6 correct');
    t.is(strings[7], 'Preparation work', 'Row 7 correct');
    t.is(strings[8], 'Choose technology suite', 'Row 8 correct');
    t.is(strings[9], 'Build prototype', 'Row 9 correct');
    t.is(strings[10], 'Step 1', 'Row 10 correct'); // Assert position for one bar from each parent

    t.isApproxRect(rect('[data-task-id="11"]'), {
      top: 102,
      left: 23,
      width: 234,
      height: 25
    }, 'Investigate');
    t.isApproxRect(rect('[data-task-id="21"]'), {
      top: 332,
      left: 257,
      width: 117,
      height: 25
    }, 'Preparation work');
    t.isApproxRect(rect('[data-task-id="234"]'), {
      top: 608,
      left: 445,
      width: 23,
      height: 25
    }, 'Follow up with customer');
  }); // https://github.com/bryntum/support/issues/4286

  t.it('Should disable indent/outdent in task menu when tree grouped', async t => {
    await setup({}, [task => task.percentDone > 50 ? 'Finishing' : 'Starting']);
    await t.waitFor(() => !treeGroup.isApplying);
    t.wontFire(gantt.taskStore, 'indent');
    t.wontFire(gantt.taskStore, 'outdent');
    await t.rightClick('.b-grid-cell:contains(Assign resources)');
    t.selectorExists('.b-menuitem.b-disabled:contains(Indent)');
    t.selectorExists('.b-menuitem.b-disabled:contains(Outdent)');
    t.selectorExists('.b-menuitem.b-disabled:contains(Add)');
    t.selectorNotExists('.b-menuitem:contains(Cut)');
    gantt.indent(gantt.taskStore.getById(12));
    gantt.outdent(gantt.taskStore.getById(12));
    await gantt.clearGroups();
    await t.rightClick('.b-grid-cell:contains(Assign resources)');
    t.selectorExists('.b-menuitem:not(.b-disabled):contains(Indent)');
    t.selectorExists('.b-menuitem:not(.b-disabled):contains(Outdent)');
    t.selectorExists('.b-menuitem:not(.b-disabled):contains(Add)');
  });
});