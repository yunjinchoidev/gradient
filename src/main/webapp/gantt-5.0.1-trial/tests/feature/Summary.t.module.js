import { DateHelper } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt;

    async function createSingleSummary(config, wait = true) {
        gantt = await t.getGanttAsync(Object.assign({
            features : {
                summary : {
                    renderer : ({ taskStore, startDate, endDate }) => {
                        // Find all intersecting task and render the count in each cell
                        const intersectingTasks = taskStore.query(task => DateHelper.intersectSpans(task.startDate, task.endDate, startDate, endDate));

                        return intersectingTasks.length;
                    }
                }
            },

            startDate : new Date(2017, 0, 1),
            endDate   : new Date(2017, 0, 10),

            project : {
                startDate : new Date(2017, 0, 1),
                tasksData : [
                    {
                        id        : 1,
                        name      : 'Work',
                        startDate : new Date(2017, 0, 1, 1),
                        endDate   : new Date(2017, 0, 3)
                    },
                    {
                        id        : 2,
                        name      : 'Play',
                        startDate : new Date(2017, 0, 1, 1),
                        endDate   : new Date(2017, 0, 4)
                    },
                    {
                        id        : 3,
                        name      : 'Plan',
                        startDate : new Date(2017, 0, 1, 3),
                        endDate   : new Date(2017, 0, 5)
                    }
                ]
            },
            columns : [
                {
                    type            : 'name',
                    sum             : 'count',
                    summaryRenderer : ({ sum }) => 'Total: ' + sum
                }
            ]
        }, config));

        if (wait) {
            await t.waitForSelector(gantt.unreleasedEventSelector);
            await t.waitForSelector('.b-sch-summarybar .b-timeaxis-tick');
        }
    }

    t.beforeEach(t => gantt?.destroy());

    t.it('Rendering sanity checks', async t => {
        await createSingleSummary();

        t.contentLike('.b-sch-summarybar :nth-child(1) .b-timeaxis-summary-value', /^3$/);
        t.contentLike('.b-sch-summarybar :nth-child(2) .b-timeaxis-summary-value', /^3$/);
        t.contentLike('.b-sch-summarybar :nth-child(3) .b-timeaxis-summary-value', /^2$/);
        t.contentLike('.b-sch-summarybar :nth-child(4) .b-timeaxis-summary-value', /^1$/);
        t.contentLike('.b-sch-summarybar :nth-child(5) .b-timeaxis-summary-value', /^0$/);
        t.contentLike('.b-sch-summarybar :nth-child(6) .b-timeaxis-summary-value', /^0$/);

        t.hasSameWidth('.b-sch-summarybar', '.b-grid-header.b-sch-timeaxiscolumn', 'footer el sized as header el');
        t.hasSameWidth('.b-sch-summarybar :nth-child(1)', '.b-lowest .b-sch-header-timeaxis-cell:nth-child(1)');
        t.hasSameWidth('.b-sch-summarybar :nth-child(2)', '.b-lowest .b-sch-header-timeaxis-cell:nth-child(2)');
        t.hasSameWidth('.b-sch-summarybar :nth-child(3)', '.b-lowest .b-sch-header-timeaxis-cell:nth-child(3)');
        t.hasSameWidth('.b-sch-summarybar :nth-child(4)', '.b-lowest .b-sch-header-timeaxis-cell:nth-child(4)');
        t.hasSameWidth('.b-sch-summarybar :nth-child(5)', '.b-lowest .b-sch-header-timeaxis-cell:nth-child(5)');
        t.hasSameWidth('.b-sch-summarybar :nth-child(6)', '.b-lowest .b-sch-header-timeaxis-cell:nth-child(6)');
        t.hasSameWidth('.b-sch-summarybar :nth-child(7)', '.b-lowest .b-sch-header-timeaxis-cell:nth-child(7)');
    });

    t.it('Should refresh after task update', async t => {
        await createSingleSummary();

        gantt.taskStore.getById(1).startDate = new Date(2017, 0, 5);

        await gantt.project.commitAsync();

        t.contentLike('.b-sch-summarybar :nth-child(1) .b-timeaxis-summary-value', /^2$/);
        t.contentLike('.b-sch-summarybar :nth-child(2) .b-timeaxis-summary-value', /^2$/);
        t.contentLike('.b-sch-summarybar :nth-child(3) .b-timeaxis-summary-value', /^2$/);
        t.contentLike('.b-sch-summarybar :nth-child(4) .b-timeaxis-summary-value', /^1$/);
        t.contentLike('.b-sch-summarybar :nth-child(5) .b-timeaxis-summary-value', /^1$/);
        t.contentLike('.b-sch-summarybar :nth-child(6) .b-timeaxis-summary-value', /^1$/);
        t.contentLike('.b-sch-summarybar :nth-child(7) .b-timeaxis-summary-value', /^0$/);
    });
});
