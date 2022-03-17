"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => gantt && gantt.destroy());
  t.it('Should fire events upon show', async t => {
    const config = await ProjectGenerator.generateAsync(1, 30, () => {});
    const project = t.getProject(config);
    gantt = t.getGantt({
      startDate: config.startDate,
      endDate: config.endDate,
      project
    });
    await project.commitAsync();
    t.firesOnce(gantt, 'beforeTaskEdit');
    t.firesOnce(gantt, 'beforeTaskEditShow');
    await gantt.editTask(gantt.taskStore.rootNode.firstChild);
  });
  t.it('Should be possible to cancel show', async t => {
    const config = await ProjectGenerator.generateAsync(1, 30, () => {});
    const project = t.getProject(config);
    gantt = t.getGantt({
      startDate: config.startDate,
      endDate: config.endDate,
      project
    });
    await project.commitAsync();
    t.firesOnce(gantt, 'beforeTaskEdit');
    t.wontFire(gantt, 'beforeTaskEditShow');
    gantt.on('beforeTaskEdit', () => false);
    await gantt.editTask(gantt.taskStore.rootNode.firstChild);
    t.selectorNotExists('.b-gantt-taskeditor', 'No editor in DOM');
  });
  t.it('Should fire events upon save', async t => {
    const config = await ProjectGenerator.generateAsync(1, 30, () => {});
    const project = t.getProject(config);
    gantt = t.getGantt({
      startDate: config.startDate,
      endDate: config.endDate,
      project
    });
    await project.commitAsync();
    t.firesOnce(gantt, 'beforeTaskSave');
    await gantt.editTask(gantt.taskStore.rootNode.firstChild);
    await gantt.features.taskEdit.save();
  });
  t.it('Should be possible to cancel save', async t => {
    const config = await ProjectGenerator.generateAsync(1, 30, () => {});
    const project = t.getProject(config);
    gantt = t.getGantt({
      startDate: config.startDate,
      endDate: config.endDate,
      project
    });
    await project.commitAsync();
    t.firesOnce(gantt, 'beforeTaskSave');
    t.wontFire(gantt.taskEdit.getEditor(), 'hide');
    gantt.on('beforeTaskSave', () => false);
    await gantt.editTask(gantt.taskStore.rootNode.firstChild);
    await gantt.features.taskEdit.save();
    t.selectorExists('.b-gantt-taskeditor', 'Editor still visible');
  });
  t.it('Should fire events upon delete', async t => {
    const config = await ProjectGenerator.generateAsync(1, 30, () => {});
    const project = t.getProject(config);
    gantt = t.getGantt({
      startDate: config.startDate,
      endDate: config.endDate,
      project
    });
    await project.commitAsync();
    t.firesOnce(gantt, 'beforeTaskDelete');
    await gantt.editTask(gantt.taskStore.rootNode.firstChild);
    await gantt.features.taskEdit.delete();
  });
  t.it('Should be possible to cancel delete', async t => {
    const config = await ProjectGenerator.generateAsync(1, 30, () => {});
    const project = t.getProject(config);
    gantt = t.getGantt({
      startDate: config.startDate,
      endDate: config.endDate,
      project
    });
    await project.commitAsync();
    t.firesOnce(gantt, 'beforeTaskDelete');
    t.wontFire(gantt.taskEdit.getEditor(), 'hide');
    gantt.on('beforeTaskDelete', () => false);
    await gantt.editTask(gantt.taskStore.rootNode.firstChild);
    await gantt.features.taskEdit.delete();
    t.selectorExists('.b-gantt-taskeditor', 'Editor still visible');
  });
  t.it('Should fire events with correct params', async t => {
    const config = await ProjectGenerator.generateAsync(1, 1, () => {});
    const project = t.getProject(config);
    gantt = t.getGantt({
      startDate: config.startDate,
      endDate: config.endDate,
      project
    });
    await project.commitAsync();
    const task = gantt.taskStore.getById(3);
    t.firesOnce(gantt, 'beforeTaskEdit');
    gantt.on('beforeTaskEdit', event => {
      t.is(event.source, gantt, 'gantt');
      t.is(event.taskEdit, gantt.features.taskEdit, 'taskEdit');
      t.is(event.taskRecord, task, 'taskRecord');
      t.isInstanceOf(event.taskElement, HTMLElement, 'element');
    });
    t.firesOnce(gantt, 'beforeTaskEditShow');
    gantt.on('beforeTaskEditShow', event => {
      t.is(event.source, gantt, 'gantt');
      t.is(event.taskEdit, gantt.features.taskEdit, 'taskEdit');
      t.is(event.taskRecord, task, 'taskRecord');
      t.isInstanceOf(event.taskElement, HTMLElement, 'element');
      t.is(event.editor, gantt.features.taskEdit.getEditor(), 'editor');
    });
    t.firesOnce(gantt, 'beforeTaskSave');
    gantt.on('beforeTaskSave', event => {
      t.is(event.source, gantt, 'gantt');
      t.is(event.taskRecord, task, 'taskRecord');
      t.is(event.editor, gantt.features.taskEdit.getEditor(), 'editor');
    });
    t.firesOnce(gantt, 'beforeTaskDelete');
    gantt.on('beforeTaskDelete', event => {
      t.is(event.source, gantt, 'gantt');
      t.is(event.taskRecord, task, 'taskRecord');
      t.is(event.editor, gantt.features.taskEdit.getEditor(), 'editor');
    });
    gantt.on('beforeTaskSave', () => false);
    gantt.on('beforeTaskDelete', () => false);
    await gantt.editTask(task);
    await gantt.features.taskEdit.save();
    await gantt.features.taskEdit.delete();
  }); // https://github.com/bryntum/support/issues/649

  t.it('Should trigger sync upon task deletion if autoSync is true', async t => {
    t.mockUrl('sync', {
      responseText: '{}'
    });
    gantt = await t.getGanttAsync({
      project: {
        autoSync: true,
        transport: {
          sync: {
            url: 'sync'
          }
        }
      },
      features: {
        taskEdit: {
          confirmDelete: false
        }
      }
    });
    const spy = t.spyOn(gantt.project, 'sync');
    await gantt.editTask(gantt.project.firstChild.firstChild);
    await t.click('.b-button:contains(Delete)');
    await t.waitFor(() => spy.calls.count);
    t.pass('Triggered sync');
  });
});