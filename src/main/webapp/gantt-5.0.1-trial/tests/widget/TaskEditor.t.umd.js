"use strict";

StartTest(t => {
  let editor, editor2, project;
  t.beforeEach(() => TaskEditor.destroy(editor, editor2, project));
  t.it('Should be possible to create 2 editors with the same tab disabled', async t => {
    editor = new TaskEditor({
      autoShow: true,
      cls: 'editor1',
      // Private, but it's what TaskEdit feature sets at the end
      tabPanelItems: {
        notesTab: false
      },
      rootElement: document.body,
      // Will hide due to focusLeave when the second shows and is focused without this
      autoClose: false
    });
    editor2 = new TaskEditor({
      autoShow: true,
      cls: 'editor2',
      rootElement: document.body,
      // Private, but it's what TaskEdit feature sets at the end
      tabPanelItems: {
        notesTab: false
      }
    });
    await t.waitForSelector('.editor1');
    await t.waitForSelector('.editor2');
    t.selectorNotExists('.editor1 .b-notes-tab');
    t.selectorNotExists('.editor2 .b-notes-tab');
  });
  t.it('Should not crash when clicking units cell during edit of new assignment', async t => {
    editor = new TaskEditor({
      autoShow: true,
      rootElement: document.body,
      height: '30em'
    });
    project = t.getProject();
    await project.commitAsync();
    editor.loadEvent(project.firstChild);
    await t.click('.b-tabpanel-tab:textEquals(Resources)');
    await t.click('[data-ref=resourcesTab] [data-ref=toolbar] [data-ref=add]');
    await t.click('.b-grid-cell[data-column=units]');
  });
  t.it('Should round percentDone value in task editor', async t => {
    editor = new TaskEditor({
      rootElement: document.body,
      autoShow: true
    });
    project = t.getProject();
    await project.commitAsync();
    const parentRecord = project.firstChild;
    editor.loadEvent(parentRecord);
    t.is(editor.widgetMap.generalTab.widgetMap.percentDone.value, parentRecord.renderedPercentDone);
  });
  t.it('Should be possible to sort lag column in predecessor grid', async t => {
    editor = new TaskEditor({
      rootElement: document.body,
      autoShow: true
    });
    project = t.getProject();
    await project.commitAsync();
    const parentRecord = project.firstChild.firstChild.lastChild,
          grid = bryntum.query('predecessorstab').grid;
    editor.loadEvent(parentRecord);
    await t.click('.b-tabpanel-tab:contains(Predecessors)');
    grid.store.getAt(0).lag = 2;
    grid.store.getAt(1).lag = 1;
    grid.store.getAt(2).lag = 3;
    await t.click('.b-grid-header-text:contains(Lag)');
    t.isDeeply(grid.store.map(r => r.lag), [1, 2, 3], 'Store sorted ASC');
    await t.click('.b-grid-header-text:contains(Lag)');
    t.isDeeply(grid.store.map(r => r.lag), [3, 2, 1], 'Store sorted DESC');
  });
  t.it('Should fire Popup events on Cancel', async t => {
    editor = new TaskEditor({
      rootElement: document.body,
      autoShow: true
    });
    t.firesOnce(editor, 'beforeClose');
    await t.click('.b-button:contains(Cancel)');
  });
});