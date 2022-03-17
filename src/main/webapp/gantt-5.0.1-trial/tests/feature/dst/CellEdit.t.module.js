
StartTest(t => {
    let gantt;

    if (t.getDSTDates(2020).length === 0) {
        t.diag('Current timezone does not use DST, skipping tests');
        return;
    }

    t.beforeEach(() => {
        gantt?.destroy();
    });

    t.it('Should set task end date past autumn DST switch date (working weekend)', async t => {
        gantt = await t.getGanttAsync({
            project : {
                startDate  : '2020-10-20',
                eventsData : [
                    {
                        id        : 1,
                        startDate : '2020-10-20',
                        endDate   : '2020-10-27'
                    }
                ]
            },
            startDate : '2020-10-20',

            columns : [
                { type : 'startdate' },
                { type : 'enddate' }
            ]
        });

        await t.doubleClick('.b-grid-cell[data-column="endDate"]');

        await t.click('.b-icon-calendar');

        await t.click('.b-calendar-cell[data-date="2020-10-28"]');

        await gantt.project.commitAsync();

        const task = gantt.taskStore.getById(1);

        t.is(task.endDate, new Date(2020, 9, 28), 'Task end date is set');
    });

    t.it('Should set task end date past spring DST switch date (working weekend)', async t => {
        gantt = await t.getGanttAsync({
            project : {
                startDate  : '2020-03-24',
                eventsData : [
                    {
                        id        : 1,
                        startDate : '2020-03-24',
                        endDate   : '2020-03-31'
                    }
                ]
            },
            startDate : '2020-03-24',

            columns : [
                { type : 'startdate' },
                { type : 'enddate' }
            ]
        });

        await t.doubleClick('.b-grid-cell[data-column="endDate"]');

        await t.click('.b-icon-calendar');

        await t.click('.b-calendar-cell[data-date="2020-04-01"]');

        await gantt.project.commitAsync();

        const task = gantt.taskStore.getById(1);

        t.is(task.endDate, new Date(2020, 3, 1), 'Task end date is set');
    });

    t.it('Should set task end date past autumn DST switch date (non-working weekend)', async t => {
        gantt = await t.getGanttAsync({
            project : {
                startDate     : '2020-10-20',
                calendar      : 1,
                calendarsData : [
                    {
                        id        : 1,
                        intervals : [
                            {
                                recurrentStartDate : 'on Sat at 0:00',
                                recurrentEndDate   : 'on Mon at 0:00',
                                isWorking          : false
                            }
                        ]
                    }
                ],
                eventsData : [
                    {
                        id        : 1,
                        startDate : '2020-10-20',
                        endDate   : '2020-10-27'
                    }
                ]
            },
            startDate : '2020-10-20',

            columns : [
                { type : 'startdate' },
                { type : 'enddate' }
            ]
        });

        await t.doubleClick('.b-grid-cell[data-column="endDate"]');

        await t.click('.b-icon-calendar');

        await t.click('.b-calendar-cell[data-date="2020-10-28"]');

        await gantt.project.commitAsync();

        const task = gantt.taskStore.getById(1);

        t.is(task.endDate, new Date(2020, 9, 28), 'Task end date is set');
    });

    t.it('Should set task end date past spring DST switch date (non-working weekend)', async t => {
        gantt = await t.getGanttAsync({
            project : {
                startDate     : '2020-03-24',
                calendar      : 1,
                calendarsData : [
                    {
                        id        : 1,
                        intervals : [
                            {
                                recurrentStartDate : 'on Sat at 0:00',
                                recurrentEndDate   : 'on Mon at 0:00',
                                isWorking          : false
                            }
                        ]
                    }
                ],
                eventsData : [
                    {
                        id        : 1,
                        startDate : '2020-03-24',
                        endDate   : '2020-03-31'
                    }
                ]
            },
            startDate : '2020-03-24',

            columns : [
                { type : 'startdate' },
                { type : 'enddate' }
            ]
        });

        await t.doubleClick('.b-grid-cell[data-column="endDate"]');

        await t.click('.b-icon-calendar');

        await t.click('.b-calendar-cell[data-date="2020-04-01"]');

        await gantt.project.commitAsync();

        const task = gantt.taskStore.getById(1);

        t.is(task.endDate, new Date(2020, 3, 1), 'Task end date is set');
    });
});
