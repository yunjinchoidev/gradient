import { DurationColumn, NameColumn, LocaleManager, CSSHelper, DateHelper } from '../../build/gantt.module.js?457330';
/* global ProjectModel */

StartTest((t) => {
    let gantt;

    t.beforeEach(() => gantt && gantt.destroy());

    t.it('Should render duration', (t) => {
        const project = new ProjectModel({
            startDate  : '2017-01-16',
            eventsData : [
                {
                    id          : 1,
                    cls         : 'id1',
                    name        : 'Planning',
                    percentDone : 60,
                    startDate   : '2017-01-16',
                    duration    : 10,
                    expanded    : true,
                    rollup      : true,
                    children    : [
                        {
                            id           : 11,
                            cls          : 'id11',
                            name         : 'Investigate',
                            percentDone  : 70,
                            startDate    : '2017-01-16',
                            duration     : 10,
                            durationUnit : 'day'
                        },
                        {
                            id           : 12,
                            cls          : 'id12',
                            name         : 'Assign resources',
                            percentDone  : 60,
                            startDate    : '2017-01-16',
                            duration     : 8,
                            durationUnit : 'minute'
                        },
                        {
                            id          : 13,
                            cls         : 'id13',
                            name        : 'Assign resources',
                            percentDone : 60,
                            startDate   : '2017-01-16'
                        }
                    ]
                }
            ]
        });

        gantt = t.getGantt({
            appendTo : document.body,
            height   : 300,
            project  : project,
            columns  : [
                { type : NameColumn.type, width : 150 },
                { type : DurationColumn.type, width : 150 }
            ]
        });

        t.chain(
            { waitForEvent : [project, 'load'] },

            { waitForSelector : '.b-number-cell:textEquals(10 days)' },
            { waitForSelector : '.b-number-cell:textEquals(8 minutes)' },
            { waitForSelector : '.b-grid-row:last-child .b-number-cell:empty' }
        );
    });

    t.it('Should not be allowed to edit duration on parents', t => {
        const project = new ProjectModel({
            startDate  : '2017-01-16',
            eventsData : [
                {
                    id          : 1,
                    name        : 'Planning',
                    percentDone : 60,
                    startDate   : '2017-01-16',
                    duration    : 10,
                    expanded    : true,
                    children    : [
                        {
                            id           : 11,
                            name         : 'Investigate',
                            percentDone  : 70,
                            startDate    : '2017-01-16',
                            duration     : 10,
                            durationUnit : 'day'
                        }
                    ]
                }
            ]
        });

        gantt = t.getGantt({
            appendTo : document.body,
            height   : 300,
            project  : project,
            columns  : [
                { type : NameColumn.type, width : 150 },
                { type : DurationColumn.type, width : 150 }
            ]
        });

        t.chain(
            { waitForEvent : [project, 'load'] },

            { dblClick : '.b-tree-parent-row [data-column=fullDuration]' },

            next => {
                t.selectorNotExists('.b-editor', 'No editor shown parent');
                next();
            },

            { dblClick : '.b-grid-row:not(.b-tree-parent-row) [data-column=fullDuration]' },

            { waitForSelector : '.b-editor', desc : 'Editor shown for child' }
        );
    });

    t.it('Should apply value instantly after spin', async t => {
        gantt = await t.getGanttAsync({
            project : {
                eventsData : [
                    {
                        id       : 11,
                        duration : 10
                    }
                ]
            },
            columns : [
                { type : DurationColumn.type, width : 150 }
            ]
        });

        const task = gantt.taskStore.getById(11);

        // Update fires twice for the task and twice for the project
        t.willFireNTimes(gantt.taskStore, 'update', 4);

        await t.doubleClick('.b-grid-cell[data-column=fullDuration]');
        await t.type(null, '[UP]');

        await gantt.project.commitAsync();

        t.is(task.duration, 11, 'Up spin: Task duration updated');
        t.is(task.endDate, new Date(2017, 0, 27), 'Task end date updated');

        await t.type(null, '[DOWN]');

        await gantt.project.commitAsync();

        t.is(task.duration, 10, 'Down spin: Task duration updated');
        t.is(task.endDate, new Date(2017, 0, 26), 'Task end date updated');

    });

    t.it('Should not try to instantly update invalid values', async t => {
        gantt = await t.getGanttAsync({
            project : {
                eventsData : [
                    {
                        id       : 11,
                        duration : 10
                    }
                ]
            },
            columns : [
                { type : DurationColumn.type, width : 150 }
            ]
        });

        t.wontFire(gantt.taskStore, 'update');

        t.chain(
            { dblClick : '.b-grid-cell[data-column=fullDuration]' },
            { type : '-1', clearExisting : true }
        );
    });

    // https://github.com/bryntum/support/issues/1135
    t.it('Should sort duration values correctly', t => {
        gantt       = t.getGantt({
            project : {
                eventsData : [
                    {
                        id          : 11,
                        name        : 'Planning',
                        percentDone : 60,
                        startDate   : '2017-01-16',
                        duration    : 10,
                        expanded    : true,
                        children    : [
                            {
                                id           : 1,
                                name         : 'One',
                                percentDone  : 70,
                                startDate    : '2017-01-16',
                                duration     : 1,
                                durationUnit : 'day'
                            },
                            {
                                id           : 2,
                                name         : 'Ten',
                                percentDone  : 70,
                                startDate    : '2017-01-16',
                                duration     : 10,
                                durationUnit : 'day'
                            },
                            {
                                id           : 3,
                                name         : 'Five',
                                percentDone  : 70,
                                startDate    : '2017-01-16',
                                duration     : 5,
                                durationUnit : 'day'
                            },
                            {
                                id           : 5,
                                name         : 'Thousand',
                                percentDone  : 70,
                                startDate    : '2017-01-16',
                                duration     : 1000,
                                durationUnit : 'second'
                            }
                        ]
                    }
                ]
            },
            columns : [
                { type : DurationColumn.type }
            ]
        });
        const tasks = gantt.taskStore.rootNode.firstChild.children;

        t.chain(
            { click : '.b-grid-header[data-column=fullDuration]' },

            async() => t.isDeeply(tasks.map(task => task.duration), [1000, 1, 5, 10]),

            { click : '.b-grid-header[data-column=fullDuration]' },

            async() => t.isDeeply(tasks.map(task => task.duration), [10, 5, 1, 1000])
        );
    });

    t.it('Should show error tooltip when finalizeCellEditor returns false', t => {
        // Uses custom error which isn't translated
        LocaleManager.throwOnMissingLocale = false;

        gantt = t.getGantt({
            project : {
                eventsData : [
                    {
                        id           : 1,
                        name         : 'Task',
                        startDate    : '2017-01-16',
                        duration     : 1,
                        durationUnit : 'day'
                    }
                ]
            },
            columns : [
                {
                    type             : DurationColumn.type,
                    finalizeCellEdit : async({ value }) => {

                        if (value.magnitude > 10) {
                            return 'foo';
                        }
                    }
                }
            ]
        });

        t.wontFire(gantt.taskStore, 'add', 'Tabbing out of invalid cell did not create a new row');

        t.chain(
            { dblclick : '.b-grid-cell[data-column=fullDuration]' },

            { type : '11d', clearExisting : true },

            { type : '[TAB]' },

            { waitForSelector : '.b-field-error-tip:contains(foo)' },

            async() => {
                t.selectorExists('.b-durationfield.b-invalid');
                // destroy to avoid throw missing locale for 'fool' when move the focus mouse after finish the test (Safari problem)
                gantt.destroy();
                LocaleManager.throwOnMissingLocale = true;
            }
        );
    });

    t.it('Should hide error tooltip when finalizeCellEditor returns true after first returning false', t => {
        // Uses custom error which isn't translated
        LocaleManager.throwOnMissingLocale = false;

        gantt = t.getGantt({
            project : {
                eventsData : [
                    {
                        id           : 1,
                        name         : 'Task',
                        startDate    : '2017-01-16',
                        duration     : 1,
                        durationUnit : 'day'
                    }
                ]
            },
            columns : [
                {
                    type             : DurationColumn.type,
                    finalizeCellEdit : async({ value }) => {
                        if (value.magnitude > 10) {
                            return 'foo';
                        }

                        return true;
                    }
                }
            ]
        });

        t.willFireNTimes(gantt.taskStore, 'add', 2, 'Tabbing out of valid cell did create a new row, as did Enter key on last row');

        t.chain(
            { dblclick : '.b-grid-cell[data-column=fullDuration]' },

            { type : '11d', clearExisting : true },

            { type : '[TAB]' },

            { waitForSelector : '.b-field-error-tip:contains(foo)' },

            { type : '9d', clearExisting : true },
            { type : '[TAB]' },

            { waitForSelectorNotfound : '.b-durationfield.b-invalid' },

            { waitForSelector : '.b-textfield [name=name]:focus' },

            { type : 'Hello[ENTER]', clearExisting : true },

            { waitForEvent : [gantt.taskStore, 'add'] },

            () => {
                t.is(gantt.taskStore.rootNode.children[1].name, 'Hello');
                LocaleManager.throwOnMissingLocale = true;
            }
        );
    });

    t.it('Should filter duration column', async t => {
        function setup(t, next) {
            const project = new ProjectModel({
                startDate  : '2020-10-26',
                eventsData : [
                    {
                        id        : 1,
                        name      : 'Planning',
                        startDate : '2020-10-26',
                        expanded  : true,
                        children  : [
                            {
                                id        : 11,
                                name      : 'Investigate',
                                startDate : '2020-10-26',
                                duration  : 5
                            },
                            {
                                id        : 12,
                                name      : 'Investigate',
                                startDate : '2020-10-26',
                                duration  : 6
                            },
                            {
                                id        : 13,
                                name      : 'Investigate',
                                startDate : '2020-10-26',
                                duration  : 7
                            },
                            {
                                id           : 14,
                                name         : 'Investigate',
                                startDate    : '2020-10-26',
                                duration     : 5,
                                durationUnit : 'hour'
                            },
                            {
                                id           : 15,
                                name         : 'Investigate',
                                startDate    : '2020-10-26',
                                duration     : 6,
                                durationUnit : 'hour'
                            },
                            {
                                id           : 16,
                                name         : 'Investigate',
                                startDate    : '2020-10-26',
                                duration     : 7,
                                durationUnit : 'hour'
                            },
                            {
                                id        : 17,
                                name      : 'Investigate',
                                startDate : '2020-10-26',
                                duration  : 0
                            }
                        ]
                    }
                ]
            });

            t.getGanttAsync({
                appendTo  : document.body,
                height    : 500,
                project   : project,
                startDate : '2020-10-26',
                features  : {
                    filter : true,
                    sort   : false
                },
                columns : [
                    { type : NameColumn.type, width : 150 },
                    { type : DurationColumn.type, width : 150 }
                ]
            }).then(result => {
                gantt = result;
                next();
            });
        }

        CSSHelper.insertRule('[data-column="fullDuration"] .b-filter-icon { display : block !important; position : absolute; left : 6em; top : 1em; }');

        t.it('From header filter popup', async t => {
            t.beforeEach(setup);

            t.it('Equals 6 days', async t => {
                await t.click('[data-column="fullDuration"] .b-filter-icon');
                await t.type('.b-filter-popup .b-durationfield:nth-child(1) input', '6[ENTER]');
                await t.waitForSelector('.b-filter-icon[data-filter-text*="= 6 days"]');

                t.is(gantt.taskStore.count, 2, 'Tasks are filtered');
                t.is(gantt.taskStore.last.id, 12, 'Target task remains is view');
            });

            t.it('Less than 6 days', async t => {
                await t.click('[data-column="fullDuration"] .b-filter-icon');
                await t.type('.b-filter-popup .b-durationfield:nth-child(2) input', '6[ENTER]');
                await t.waitForSelector('.b-filter-icon[data-filter-text*="< 6 days"]');

                gantt.taskStore.forEach(task => {
                    if (task.isLeaf) {
                        t.isLess(task.fullDuration.milliseconds, DateHelper.asMilliseconds(6, 'd'), `Task ${task.name} duration is ok`);
                    }
                });
                // parent, 1 5-day-task + 3 few-hours-tasks, 1 milestone
                t.is(gantt.taskStore.count, 6, 'Tasks are filtered');
            });

            t.it('Greater than 6 days', async t => {
                await t.click('[data-column="fullDuration"] .b-filter-icon');
                await t.type('.b-filter-popup .b-durationfield:nth-child(3) input', '6[ENTER]');
                await t.waitForSelector('.b-filter-icon[data-filter-text*="> 6 days"]');

                gantt.taskStore.forEach(task => {
                    if (task.isLeaf) {
                        t.isGreater(task.fullDuration.milliseconds, DateHelper.asMilliseconds(6, 'd'), `Task ${task.name} duration is ok`);
                    }
                });
                // parent, 1 7-day-task
                t.is(gantt.taskStore.count, 2, 'Tasks are filtered');
            });

            t.it('Less than 6 hours', async t => {
                await t.click('[data-column="fullDuration"] .b-filter-icon');
                await t.type('.b-filter-popup .b-durationfield:nth-child(2) input', '6h[ENTER]');
                await t.waitForSelector('.b-filter-icon[data-filter-text*="< 6 hours"]');

                gantt.taskStore.forEach(task => {
                    if (task.isLeaf) {
                        t.isLess(task.fullDuration.milliseconds, DateHelper.asMilliseconds(6, 'd'), `Task ${task.name} duration is ok`);
                    }
                });
                // parent, 1 5-hour-task, 1 milestone
                t.is(gantt.taskStore.count, 3, 'Tasks are filtered');
            });

            t.it('Equals to 0', async t => {
                await t.click('[data-column="fullDuration"] .b-filter-icon');
                await t.type('.b-filter-popup .b-durationfield:nth-child(1) input', '0[ENTER]');
                await t.waitForSelector('.b-filter-icon[data-filter-text*="0 days"]');

                gantt.taskStore.forEach(task => {
                    if (task.isLeaf) {
                        t.is(task.fullDuration.milliseconds, 0, `Task ${task.name} duration is ok`);
                    }
                });
                // parent, 1 milestone
                t.is(gantt.taskStore.count, 2, 'Tasks are filtered');
            });
        });

        t.it('From cell context menu', async t => {
            t.beforeEach(setup);

            t.it('Equals 6 days', async t => {
                await t.rightClick('[data-id="12"] [data-column="fullDuration"]');

                t.selectorCountIs('.b-menuitem:contains(Equals)', 1, 'No extra Equals items');

                await t.click('.b-menuitem:contains(Equals)');

                t.is(gantt.taskStore.last.id, 12, 'Target task remains is view');
            });

            t.it('Less than 6 days', async t => {
                await t.rightClick('[data-id="12"] [data-column="fullDuration"]');

                await t.click('.b-menuitem:contains(Less)');

                gantt.taskStore.forEach(task => {
                    if (task.isLeaf) {
                        t.isLess(task.fullDuration.milliseconds, DateHelper.asMilliseconds(6, 'd'), `Task ${task.name} duration is ok`);
                    }
                });
            });

            t.it('More than 6 days', async t => {
                await t.rightClick('[data-id="12"] [data-column="fullDuration"]');

                await t.click('.b-menuitem:contains(More)');

                gantt.taskStore.forEach(task => {
                    if (task.isLeaf) {
                        t.isGreater(task.fullDuration.milliseconds, DateHelper.asMilliseconds(6, 'd'), `Task ${task.name} duration is ok`);
                    }
                });
            });

            t.it('Less than 6 hours', async t => {
                await t.rightClick('[data-id="15"] [data-column="fullDuration"]');

                await t.click('.b-menuitem:contains(Less)');

                gantt.taskStore.forEach(task => {
                    if (task.isLeaf) {
                        t.isLess(task.fullDuration.milliseconds, DateHelper.asMilliseconds(6, 'h'), `Task ${task.name} duration is ok`);
                    }
                });
            });

            t.it('Equals 0 days', async t => {
                await t.rightClick('[data-id="17"] [data-column="fullDuration"]');

                await t.click('.b-menuitem:contains(Equals)');

                gantt.taskStore.forEach(task => {
                    if (task.isLeaf) {
                        t.is(task.fullDuration.milliseconds, 0, `Task ${task.name} duration is ok`);
                    }
                });

                gantt.taskStore.clearFilters();
            });
        });
    });

    t.it('Should pass min/max values to editor', async t => {
        gantt = await t.getGanttAsync({
            project : {
                eventsData : [
                    {
                        id       : 11,
                        duration : 10
                    }
                ]
            },
            columns : [
                { type : DurationColumn.type, width : 150, min : '1d', max : '4d' }
            ]
        });

        t.wontFire(gantt.taskStore, 'update');

        gantt.features.cellEdit.startEditing({ column : 1, row : 0 });

        const durationField = gantt.features.cellEdit.editorContext.editor.inputField;

        t.is(durationField.min.toString(), '1 day', 'Min configured');
        t.is(durationField.max.toString(), '4 days', 'Max configured');
    });
});
