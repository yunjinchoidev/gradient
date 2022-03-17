StartTest(async t => {

    const gantt = bryntum.query('gantt');

    await t.waitForSelector('.b-gantt-task');

    t.it('Should show progress', async t => {
        await t.waitForSelectorNotFound('.b-calculation-progress');

        await t.waitForSelectorOnTrigger('.b-calculation-progress', () => {
            t.click('[data-ref=5kButton]');
        });
        await t.waitForSelectorNotFound('.b-calculation-progress');
    });

    // https://github.com/bryntum/support/issues/4003
    t.it('Should have very few selfDependent atoms after commit', t => {
        t.isLess(gantt.project.replica.baseRevision.selfDependent.size, 4, 'Not that many');
    });

    // https://github.com/bryntum/support/issues/4003
    t.it('Should not transition the initial refresh', async t => {
        await t.waitForSelectorNotFound('.b-calculation-progress');

        const spy = t.spyOn(gantt, 'refreshWithTransition');

        await t.waitForSelectorOnTrigger('.b-calculation-progress', () => {
            console.time('calculation');
            t.click('[data-ref=10kButton]');
        });

        await t.waitForSelectorNotFound('.b-calculation-progress');

        console.timeEnd('calculation');
        t.expect(spy).toHaveBeenCalled(0);
    });

});
