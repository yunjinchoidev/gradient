StartTest(t => {
    t.it('Should be possible to abort dragging task to gantt', async t => {
        await t.dragBy({
            source   : '.unplannedTasks .b-grid-cell:contains(Acceptance test)',
            delta    : [-50, 0],
            dragOnly : true
        });

        // Check the task presence in Gantt
        await t.type(null, '[ESCAPE]');
        await t.waitForSelectorNotFound('.b-dragging,.b-aborting,.b-drag-proxy');
    });

    t.it('Should size drag proxy correctly', async t => {
        await t.dragBy({
            source   : '.unplannedTasks .b-grid-cell:contains(Acceptance test)',
            delta    : [-150, 0],
            dragOnly : true
        });

        t.isApprox(t.rect('.b-drag-proxy').width, t.rect('.unplannedTasks .b-grid-row').width);

        await t.type(null, '[ESCAPE]');
    });

    t.it('Should be possible to edit duration then drag task to gantt', async t => {
        await t.doubleClick('.unplannedTasks .b-grid-cell[data-column="fullDuration"]'); await t.type({
            text          : '5d[ENTER]',
            clearExisting : true
        });

        await t.dragTo({
            source     : '.unplannedTasks .b-grid-cell:contains(Acceptance test)',
            fromOffset : [10, '50%'],
            toOffset   : [10, 1],
            target     : '.b-grid-cell:contains(Install Apache)'
        });

        // Check the task presence in Gantt
        await t.waitForSelectorNotFound('.b-dragging');
        await t.waitForSelector('.b-gantt [data-index="2"] .b-grid-cell[data-column="name"]:contains(Acceptance test)');
        await t.waitForSelector('.b-gantt [data-index="2"] [data-column="fullDuration"]:contains(5 days)');
    });

    t.it('Should not throw on planned task drag after unplanned dragged before (monkey caught)', async t => {

        await t.dragTo({
            source     : '.unplannedTasks .b-grid-cell:contains(Code security analysis)',
            fromOffset : [10, '50%'],
            toOffset   : [10, 1],
            target     : '.b-grid-cell:contains(Install Apache)'
        });

        await t.waitForSelectorNotFound('.b-dragging');

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
