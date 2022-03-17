StartTest(async t => {

    const gantt = bryntum.query('gantt');
    await t.waitForSelector('.b-gantt-task');

    t.it('Should not be vulnerable by XSS injection for custom drag tooltip', async t => {
        t.injectXSS(gantt);
        await t.dragBy({
            source : '[data-task-id="12"]',
            delta  : [0, 10]
        });
    });

});
