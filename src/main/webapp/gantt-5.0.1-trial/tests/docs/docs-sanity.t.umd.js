"use strict";

StartTest(t => {
  const {
    location
  } = t.global;
  t.global.DocsBrowserInstance.animateScroll = false; // https://github.com/bryntum/support/issues/3891

  t.it('Should not have external examples images with 404', async t => {
    location.hash = '#Scheduler/guides/customization/styling.md#using-different-themes';
    await t.waitForSelector('[data-id="Scheduler/guides/customization/styling.md"]');
    await t.waitForSelector('img[src="data/Scheduler/images/themes/thumb.classic.png"]');
    await t.waitForSelector('a[href="#Scheduler/guides/customization/styling.md#using-different-themes"]');
  });
});