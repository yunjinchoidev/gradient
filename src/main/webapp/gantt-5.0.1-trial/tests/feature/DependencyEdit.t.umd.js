"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(async () => {
    var _gantt;

    (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
    gantt = await t.getGanttAsync({
      appendTo: document.body,
      startDate: new Date(2018, 9, 14),
      endDate: new Date(2018, 9, 30),
      viewPreset: 'weekAndMonth',
      project: {
        startDate: new Date(2018, 9, 20),
        tasksData: [{
          id: 1,
          startDate: new Date(2018, 9, 20),
          duration: 2,
          name: 'task 1'
        }, {
          id: 2,
          startDate: new Date(2018, 9, 20),
          duration: 2,
          name: 'task 2'
        }],
        dependenciesData: [{
          id: 1,
          fromTask: 1,
          toTask: 2,
          type: 0
        }]
      },
      features: {
        dependencies: {
          showTooltip: false
        },
        taskTooltip: false,
        dependencyEdit: true
      }
    });
  });

  async function dblclickSVGElement(t, selector) {
    const el = await t.waitForSelector(selector);
    const element = el[0],
          ownerSVG = element.ownerSVGElement,
          ownerBox = ownerSVG.getBoundingClientRect(),
          elementBBox = element.getBBox();
    await t.doubleClick([ownerBox.left + elementBBox.x, ownerBox.top + elementBBox.y]);
  }

  t.it('Should show editor on dblclick on dependency', async t => {
    await dblclickSVGElement(t, '.b-sch-dependency');
    await t.waitForSelector('.b-popup .b-header-title:contains(Edit dependency)');
    t.pass('Popup shown with correct title');
    const depFeature = gantt.features.dependencyEdit;
    t.hasValue(depFeature.fromNameField, 'task 1');
    t.hasValue(depFeature.toNameField, 'task 2');
    t.hasValue(depFeature.typeField, 0);
    t.is(depFeature.typeField.inputValue, 'Start to Start');
    t.selectorExists('label:contains(Lag)', 'Lag field should exist by default');
  });
  t.it('Should delete dependency on Delete click', async t => {
    t.firesOnce(gantt.dependencyStore, 'remove');
    await dblclickSVGElement(t, '.b-sch-dependency');
    await t.click('.b-popup button:textEquals(Delete)');
    await t.waitForSelectorNotFound('.b-sch-dependency');
  });
  t.it('Should change nothing on Cancel and close popup', async t => {
    t.wontFire(gantt.dependencyStore, 'changePreCommit');
    await dblclickSVGElement(t, '.b-sch-dependency');
    await t.click('.b-popup button:textEquals(Cancel)');
  });
  t.it('Should change nothing on Save with no changes', async t => {
    t.wontFire(gantt.dependencyStore, 'changePreCommit');
    await dblclickSVGElement(t, '.b-sch-dependency');
    await t.click('.b-popup button:textEquals(Save)');
  });
  t.it('Should repaint and update model when changing type', async t => {
    t.firesOnce(gantt.dependencyStore, 'update');
    await dblclickSVGElement(t, '.b-sch-dependency');
    const depFeature = gantt.features.dependencyEdit;
    depFeature.typeField.value = 1;
    await t.click('.b-popup button:textEquals(Save)');
    t.is(gantt.dependencyStore.first.type, 1, 'Type updated');
  });
  t.it('Should repaint and update model when changing lag', async t => {
    t.firesOnce(gantt.dependencyStore, 'update');
    await dblclickSVGElement(t, '.b-sch-dependency');
    const depFeature = gantt.features.dependencyEdit;
    depFeature.lagField.value = 2;
    await t.click('.b-popup button:textEquals(Save)');
    await t.waitForPropagate(gantt.project);
    t.is(gantt.taskStore.last.startDate, new Date(2018, 9, 22), 'Lag change caused start date to be updated');
    t.is(gantt.dependencyStore.first.lag, 2, 'Lag updated');
  });
  t.it('Should deactivate dependency', async t => {
    t.willFireNTimes(gantt.dependencyStore, 'update', 3);
    const depFeature = gantt.features.dependencyEdit;
    gantt.dependencyStore.first.lag = 2;
    await gantt.project.commitAsync();
    depFeature.editDependency(gantt.dependencyStore.first);
    depFeature.activeField.value = false;
    await t.click('.b-popup button:textEquals(Save)');
    await t.waitForPropagate(gantt.project);
    t.is(gantt.project.endDate, new Date(2018, 9, 22), 'project end date is correct');
    t.is(gantt.taskStore.last.startDate, new Date(2018, 9, 20), 'last task start date is correct');
    t.is(gantt.taskStore.last.endDate, new Date(2018, 9, 22), 'last task end date is correct');
    t.notOk(gantt.dependencyStore.first.active, 'dependency active is updated');
    t.diag('Activating dependency back');
    depFeature.editDependency(gantt.dependencyStore.first);
    depFeature.activeField.value = true;
    await t.click('.b-popup button:textEquals(Save)');
    await t.waitForPropagate(gantt.project);
    t.is(gantt.project.endDate, new Date(2018, 9, 24), 'project end date is correct');
    t.is(gantt.taskStore.last.startDate, new Date(2018, 9, 22), 'last task start date is correct');
    t.is(gantt.taskStore.last.endDate, new Date(2018, 9, 24), 'last task end date is correct');
    t.ok(gantt.dependencyStore.first.active, 'dependency active is updated');
  });
});