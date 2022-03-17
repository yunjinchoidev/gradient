"use strict";

StartTest(t => {
  const gantt = bryntum.query('gantt');
  t.it('Show highlight critical task rows w/ b-critical CSS class', async t => {
    await t.waitFor(() => gantt.project.crudLoaded);
    await t.waitForSelector('.b-grid-row.b-critical[data-id=331]');
    t.pass('Proper classes for record #331');
    await t.waitForSelector('.b-grid-row[data-id=332]');
    await t.waitForSelectorNotFound('.b-grid-row.b-critical[data-id=332]');
    t.pass('Proper classes for record #332');
    await t.waitForSelector('.b-grid-row[data-id=334]');
    await t.waitForSelectorNotFound('.b-grid-row.b-critical[data-id=334]');
    t.pass('Proper classes for record #334');
  });
});