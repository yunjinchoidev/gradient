"use strict";

StartTest(t => {
  t.it('Sanity', async t => {
    await t.waitForSelector('.b-grid-footers[data-region=normal] .b-timeaxis-tick:nth-child(2):textEquals(8)');
    t.selectorExists('.b-grid-footers[data-region=normal] .b-timeaxis-tick:nth-child(1):textEquals(0)');
    t.selectorExists('.b-grid-footers[data-region=normal] .b-timeaxis-tick:nth-child(2):textEquals(8)');
    t.selectorExists('.b-grid-footers[data-region=normal] .b-timeaxis-tick:nth-child(3):textEquals(8)');
    t.selectorExists('.b-grid-footers[data-region=normal] .b-timeaxis-tick:nth-child(4):textEquals(7)');
    t.selectorExists('.b-grid-footers[data-region=normal] .b-timeaxis-tick:nth-child(5):textEquals(4)');
  });
});