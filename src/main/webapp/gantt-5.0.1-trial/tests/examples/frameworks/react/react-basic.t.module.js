/**
 * React basic demo test
 */
StartTest(t => {
    const gantt = bryntum.query('gantt');

    t.it('Rendering', t => {
        t.chain(
            { waitForSelector : '.b-gantt' },
            { waitForSelector : '.b-gantt-task' },
            { waitForSelector : '.b-react-portal-container' },
            { waitForSelector : '.b-react-portals-cache' }
        );
    });

    t.it('Context Menu', t => {
        t.chain(
            { contextmenu : '.b-sch-header-timeaxis-cell:textEquals(Sun 20 Jan 2019)' },
            { waitForSelector : '.b-menu-text:textEquals(Filter tasks)' },
            { waitForSelector : '.b-menu-text:textEquals(Zoom)' },
            { waitForSelector : '.b-menu-text:textEquals(Date range)' }
        );
    });

    t.it('Task Editor', t => {
        t.chain(
            { dblclick : '[data-task-id="15"]' },
            { waitForSelector : '.b-gantt-taskeditor' },
            { click : '[name="name"]' },
            { type : '[BACKSPACE][BACKSPACE][BACKSPACE][BACKSPACE][BACKSPACE]all tests[ENTER]' },
            { waitForSelector : '.b-grid-cell :textEquals(Run all tests)' }
        );
    });

    t.it('Tooltips', t => {
        t.chain(
            { moveMouseTo : '[data-task-id="1"]' },
            { waitForSelector : '.b-gantt-task-title:textEquals(Setup web server)' }
        );
    });

    t.it('Loading inlineData must work', async t => {
        const { project } = gantt;
        const inlineData = {
            eventsData : [{
                id          : 1000,
                name        : 'Launch SaaS Product',
                percentDone : 50,
                startDate   : null,
                endDate     : null,
                children    : [{
                    id          : 1001,
                    name        : 'Launch SaaS Product 2',
                    percentDone : 50,
                    startDate   : '2021-01-02',
                    endDate     : '2021-01-05'
                }, {
                    id          : 1002,
                    name        : 'Launch SaaS Product 2',
                    percentDone : 50,
                    startDate   : '2021-01-10',
                    endDate     : '2021-01-15'
                }]
            }],

            resourcesData    : [],
            assignmentsData  : [],
            dependenciesData : [{ id : 5, to : 1002, from : 1001, type : 0 }]
        };
        project.loadInlineData(inlineData);
        await project.commitAsync();

        await t.waitForSelector('span:contains(Launch SaaS Product 2)');
    });
});
