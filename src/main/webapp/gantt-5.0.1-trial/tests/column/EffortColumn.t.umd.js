"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    return (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  }); // Here we check that effort column shows the same value which is showed in its editor #950

  t.it('Should use the same value for column rendering and editor', t => {
    gantt = t.getGantt({
      id: 'gantt',
      columns: [{
        type: DurationColumn.type,
        width: 150
      }, {
        type: EffortColumn.type,
        width: 150
      }]
    });
    let clickedTextContent;
    t.chain({
      waitForEvent: [gantt.project, 'load']
    }, {
      waitForRowsVisible: gantt
    }, next => {
      const task = gantt.taskStore.getAt(2),
            [durationCellEl] = t.query('[data-index=2] [data-column=fullDuration]'),
            fullDurationRendered = durationCellEl.innerHTML,
            fullDurationTask = task.fullDuration,
            [effortCellEl] = t.query('[data-index=2] [data-column=fullEffort]'),
            fullEffortRendered = effortCellEl.innerHTML,
            fullEffortTask = task.fullEffort;
      fullDurationTask.unit = DateHelper.parseTimeUnit(fullDurationTask.unit);
      fullEffortTask.unit = DateHelper.parseTimeUnit(fullEffortTask.unit);
      t.ok(durationCellEl, 'Duration cell rendered');
      t.isDeeply(DateHelper.parseDuration(fullDurationRendered), fullDurationTask, 'Duration is rendered properly');
      t.ok(effortCellEl, 'Effort cell rendered');
      t.isDeeply(DateHelper.parseDuration(fullEffortRendered), fullEffortTask, 'Effort is rendered properly');
      next(fullEffortRendered);
    }, {
      mousedown: '[data-index=2] [data-column=fullEffort]'
    }, (next, el) => {
      clickedTextContent = el.textContent;
      next();
    }, {
      dblClick: '[data-index=2] [data-column=fullEffort]'
    }, () => {
      const [editorInputEl] = t.query('.b-cell-editor input');
      t.is(editorInputEl.value, clickedTextContent, 'Editor value is correct');
    });
  });
  t.it('Should changed effort value using editor', t => {
    gantt = t.getGantt({
      columns: [{
        type: EffortColumn.type,
        width: 150
      }]
    });
    t.chain({
      waitForEvent: [gantt.project, 'load']
    }, {
      dblClick: '[data-index=2] [data-column=fullEffort]'
    }, {
      type: '100 m'
    }, next => {
      const task = gantt.taskStore.getAt(2);
      t.is(task.effort, 100, 'Effort has been changed correctly');
      t.is(task.effortUnit, 'minute', 'Effort unit has been changed correctly');
      next();
    }, // Cannot edit parent
    {
      dblClick: '.b-tree-parent-row [data-column=fullEffort]'
    }, () => {
      t.selectorNotExists('.b-editor', 'Editor not shown for parent task');
    });
  });
});