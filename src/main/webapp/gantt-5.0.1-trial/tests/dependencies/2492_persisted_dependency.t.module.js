StartTest(t => {
    let gantt;

    t.beforeEach(() => {
        gantt?.destroy();
    });

    t.it('Persisted dependency is removed from cache', async t => {
        gantt = await t.getGanttAsync({
            project : {
                transport : {
                    sync : {
                        url : 'sync'
                    }
                }
            }
        });

        const [dependency] = gantt.dependencyStore.add({
            from : 12,
            to   : 13
        });

        const phantomId = dependency.id;

        t.mockUrl('sync', {
            responseText : JSON.stringify({
                success      : true,
                dependencies : {
                    rows : [
                        { $PhantomId : phantomId, id : 100 }
                    ]
                }
            })
        });

        await gantt.project.commitAsync();

        await gantt.project.sync();

        gantt.dependencyStore.remove(dependency);

        await gantt.project.commitAsync();

        t.is(gantt.taskStore.getById(12).startDate, gantt.taskStore.getById(13).startDate, 'Dependency is removed');

        await t.waitForSelector('.b-sch-dependency');

        t.selectorCountIs('.b-sch-dependency[depId="100"]', 0, 'No dependency line matching new dep real id');
        t.selectorCountIs(`.b-sch-dependency[depId="${phantomId}"]`, 0, 'No dependency line matching new dep phantom id');
    });
});
