StartTest(t => {
    let gantt;

    t.beforeEach(() => {
        gantt?.destroy();
    });

    // https://github.com/bryntum/support/issues/3568
    t.it('Should have correct visibleDateRange in horizontalScroll listeners', async t => {
        gantt = await t.getGanttAsync({
            visibleDate    : new Date(2021, 9, 15),
            startDate      : new Date(2000, 0, 1),
            endDate        : new Date(2030, 11, 31),
            viewPreset     : 'weekAndMonth',
            tasks          : [],
            subGridConfigs : {
                locked : { width : 100 }
            }
        });

        await gantt.timeAxisSubGrid.scrollable.await('scrollEnd');

        t.firesOk(gantt, {
            // Should ideally be two, (one per subgrid) but for time axis subgrid one is from scroll and one from
            // scrollEnd. Dont want to upset that.
            horizontalscroll : 3
        });

        gantt.on('horizontalScroll', ({ subGrid }) => {
            if (subGrid === gantt.timeAxisSubGrid) {
                const visibleDateRange = gantt.visibleDateRange;
                t.is(visibleDateRange.startDate.getFullYear(), 2021, 'Year consistent');
                t.is(visibleDateRange.startDate.getMonth(), 8, 'Month consistent');
                t.is(visibleDateRange.startDate.getDate(), 15, 'Date consistent');
            }
        });

        gantt.viewPreset = 'dayAndWeek';

        await gantt.timeAxisSubGrid.scrollable.await('scrollEnd', false);
    });
});
