"use strict";

StartTest(t => {
  t.it('Should show task editor', async t => {
    await t.click('.edit');
    await t.waitForSelector('.b-taskeditor');
  });
  t.it('Should add new task', async t => {
    await t.click('.add');
    await t.waitForSelector('.b-tree-cell-inner:contains(New task)');
  });
  t.it('Should show context menu', async t => {
    await t.click('.menu');
    await t.waitForSelector('.b-menu:contains(Edit)');
  });
});