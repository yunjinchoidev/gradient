StartTest(t => {
    t.it('Sanity checks', async t => {
        await t.waitForSelector('.b-gantt-task');
        await t.waitForSelector('.b-sch-event');

        const
            gantt        = bryntum.query('gantt'),
            scheduler = bryntum.query('schedulerpro');

        t.is(gantt.subGrids.locked.width, scheduler.subGrids.locked.width, 'Locked grid width synced');
        t.is(gantt.subGrids.normal.width, scheduler.subGrids.normal.width, 'Normal grid width synced');
    });
});
