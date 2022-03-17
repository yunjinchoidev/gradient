StartTest('Test buttons tooltips', t => {

    t.setWindowSize(1280, 1024);

    t.it('Check toolbar buttons tooltips', async t => {
        await t.waitForSelector('.b-fiddlepanel .b-top-toolbar');
        document.querySelector('.b-icon-code').scrollIntoView();

        // For whatever reason Siesta does not display the tooltips if hovered too early,
        // although they show up with the actual mouse
        await t.waitForSelector('.b-gantt-task');

        const buttons = t.query('.b-fiddlepanel .b-top-toolbar .b-button');
        await t.moveMouseTo('.b-fiddlepanel .b-toolbar-content');
        await t.moveMouseTo(buttons[0]);
        await t.waitForSelector(`.b-tooltip:contains('Create new task')`);

        await t.moveMouseTo(buttons[1]);
        await t.waitForSelector(`.b-tooltip:contains('Edit selected task')`);
    });

});
