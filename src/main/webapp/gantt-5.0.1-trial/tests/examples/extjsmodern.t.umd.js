"use strict";

StartTest(t => {
  t.it('Sanity check', async t => {
    await t.waitForSelector('.b-gantt-task');

    if (document.querySelector('.x-messagebox')) {
      await t.click('.x-messagebox .x-button');
    }

    await t.click('[data-task-id=11]');
    t.pass('Should not throw this.fireEvent on task click');
    await t.click('.b-add-task');
    await t.waitForSelector('.b-gantt-taskeditor');
    t.pass('Should show task editor');
  });
});