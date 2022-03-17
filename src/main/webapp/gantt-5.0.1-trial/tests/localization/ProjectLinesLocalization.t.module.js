
StartTest(t => {

    let gantt;

    t.beforeEach((t, next) => {
        gantt && gantt.destroy();
        // Wait for locales to load
        t.waitFor(() => window.bryntum.locales, next);
    });

    t.it('Should update project labels after localization change', async t => {
        gantt = t.getGantt({
            appendTo : document.body,
            tasks    : [
                {
                    id        : 1,
                    name      : 'task 1',
                    startDate : '2017-01-16',
                    duration  : 10
                }
            ],
            features : {
                projectLines : true
            }
        });

        await gantt.project.commitAsync();

        // TODO: Fails because project does not get an endDate

        Object.keys(window.bryntum.locales).forEach(name => {
            t.describe(`${name} locale is ok`, t => {
                const
                    locale = t.applyLocale(name),
                    lines = document.querySelectorAll('.b-sch-timerange label');

                t.contentLike(lines[0], locale.ProjectLines['Project Start'], 'Project Start localization is ok');
                t.contentLike(lines[1], locale.ProjectLines['Project End'], 'Project End localization is ok');
            });
        });
    });
});
