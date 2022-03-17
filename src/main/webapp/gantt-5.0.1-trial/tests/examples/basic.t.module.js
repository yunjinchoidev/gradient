StartTest(async t => {
    // Should expose [gantt/grid/etc] on window
    await t.waitFor(() => window.gantt);

    t.it('Check all locales', async t => {
        await t.click('[data-ref=infoButton]');

        for (const locale of ['English', 'Nederlands', 'Svenska', 'Русский']) {
            t.diag(`Checking locale ${locale}`);

            const value = document.querySelector('[data-ref=localeCombo] input').value;

            // Change to the locale if necessary
            if (value !== locale) {
                await t.click('[data-ref=localeCombo] input');

                await t.click(`.b-list-item:contains(${locale})`);

                // Change triggers hide of the info popup
                await t.waitForSelectorNotFound('[data-ref=localeCombo] input');

                // Show the info popup again
                await t.click('[data-ref=infoButton]');

                // This must exist
                await t.waitForSelector('.info-popup .b-checkbox');
            }

            await t.moveMouseTo('.info-popup .b-checkbox');

            await t.waitForSelector('.b-tooltip-shared');

            t.contentNotLike('.b-tooltip-shared', /L{/, 'Tooltip is localized');
        }
    });

    t.it('Should not throw on double task drag', async t => {
        await t.dragTo({
            source     : '.b-grid-cell:contains(Contact designers)',
            fromOffset : [10, '50%'],
            toOffset   : [10, 10],
            target     : '.b-grid-cell:contains(Launch SaaS Product)'
        });

        await t.waitForSelectorNotFound('.b-dragging');
        await t.waitForSelector('.b-gantt [data-index="0"] .b-grid-cell[data-column="name"]:contains(Contact designers)');

        await t.dragTo({
            source     : '.b-grid-cell:contains(Run tests)',
            fromOffset : [10, '50%'],
            toOffset   : [10, 10],
            target     : '.b-grid-cell:contains(Launch SaaS Product)'
        });

        await t.waitForSelectorNotFound('.b-dragging');
        await t.waitForSelector('.b-gantt [data-index="1"] .b-grid-cell[data-column="name"]:contains(Run tests)');
    });

});
