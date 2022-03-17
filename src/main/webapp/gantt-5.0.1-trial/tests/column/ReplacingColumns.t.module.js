
StartTest((t) => {
    let gantt;

    t.beforeEach(() => gantt?.destroy());

    t.it('Should support replacing columns and automatically inject timeaxis column', async t => {
        gantt = await t.getGanttAsync({
            columns : [
                { type : 'name' },
                { type : 'startdate' }
            ]
        });

        gantt.columns.data = [
            { type : 'name', width : 250 },
            { type : 'wbs', width : 250 }
        ];

        await t.waitForSelectorNotFound('[data-column="startDate"]');
        await t.waitForSelector('[data-column="wbsValue"]');

        t.elementIsVisible('.b-sch-timeaxis-cell');
        t.elementIsVisible('.b-gantt-task');
    });
});
