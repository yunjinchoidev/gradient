StartTest(t => {
    const gantt = bryntum.query('gantt');

    t.it('Sanity', t => {
        t.chain(
            { waitForSelector : '.b-sch-foreground-canvas' },

            () => t.checkGridSanity(gantt)
        );
    });

    t.it('Toggling labels should work', async t => {
        gantt.enableEventAnimations = false;

        t.diag('TOP + BOTTOM');
        await t.waitForSelector('[data-task-id="11"] .b-sch-label-top');
        await t.waitForSelector('[data-task-id="11"] .b-sch-label-bottom');
        await t.waitForSelectorNotFound('[data-task-id="11"] .b-sch-label-left');
        await t.waitForSelectorNotFound('[data-task-id="11"] .b-sch-label-right');

        t.diag('LEFT + RIGHT');
        await t.click('[data-ref="leftAndRightLabels"]');
        await t.waitForSelectorNotFound('[data-task-id="11"] .b-sch-label-top');
        await t.waitForSelectorNotFound('[data-task-id="11"] .b-sch-label-bottom');
        await t.waitForSelector('[data-task-id="11"] .b-sch-label-left');
        await t.waitForSelector('[data-task-id="11"] .b-sch-label-right');

        t.diag('ALL');
        await t.click('[data-ref="allLabels"]');
        await t.waitForSelector('[data-task-id="11"] .b-sch-label-top');
        await t.waitForSelector('[data-task-id="11"] .b-sch-label-bottom');
        await t.waitForSelector('[data-task-id="11"] .b-sch-label-left');
        await t.waitForSelector('[data-task-id="11"] .b-sch-label-right');

        t.diag('TOP + BOTTOM');
        await t.click('[data-ref="topAndBottomLabels"]');
        await t.waitForSelector('[data-task-id="11"] .b-sch-label-top');
        await t.waitForSelector('[data-task-id="11"] .b-sch-label-bottom');
        await t.waitForSelectorNotFound('[data-task-id="11"] .b-sch-label-left');
        await t.waitForSelectorNotFound('[data-task-id="11"] .b-sch-label-right');
    });
});
