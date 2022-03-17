import { DateHelper, Override, ProjectGenerator, RandomGenerator, Gantt, PresetManager, Orientation, PaperFormat, Rectangle } from '../../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt, paperHeight;

    Object.assign(window, {
        DateHelper,
        Override,
        ProjectGenerator,
        RandomGenerator,
        Gantt,
        PresetManager,
        PaperFormat,
        Rectangle
    });

    t.overrideAjaxHelper();

    t.beforeEach(() => {
        gantt && gantt.destroy();
    });

    t.it('Should export to multiple pages', async(t) => {
        const
            verticalPages   = 3,
            horizontalPages = 2,
            totalPages      = horizontalPages * verticalPages,
            rowsPerPage     = 11;

        ({ gantt, paperHeight } = await t.createGanttForExport({
            horizontalPages,
            verticalPages,
            rowsPerPage
        }));

        let result, html;

        t.chain(
            { waitForPropagate : gantt },
            { waitForSelector : '.b-sch-dependency' },
            { waitFor : 500 },
            async() => {
                result = await gantt.features.pdfExport.export({
                    columns      : gantt.columns.visibleColumns.map(c => c.id),
                    exporterType : 'multipage',
                    range        : 'completeview'
                });

                ({ html } = result.response.request.body);

                t.is(html.length, totalPages, `${totalPages} pages exported`);

                for (let i = 0; i < html.length; i++) {
                    const { document : doc, iframe } = await t.setIframeAsync({
                        height : paperHeight,
                        html   : html[i].html
                    });

                    t.ok(t.assertHeaderPosition(doc), `Header exported ok on page ${i}`);
                    t.ok(t.assertFooterPosition(doc), `Footer exported ok on page ${i}`);

                    t.assertRowsExportedWithoutGaps(doc, false, (i + 1) % verticalPages !== 0);

                    if (i % verticalPages === 0) {
                        t.ok(t.assertTicksExportedWithoutGaps(doc), `Ticks exported without gaps on page ${i}`);
                    }

                    const
                        { taskStore } = gantt,
                        tasks = taskStore.query(record => {
                            return taskStore.indexOf(record) > rowsPerPage * (i % verticalPages) - 1 &&
                                taskStore.indexOf(record) < rowsPerPage * (i % verticalPages + 1) - 1;
                        }),
                        dependencies = gantt.dependencyStore.query(record => {
                            return tasks.includes(record.fromEvent) && tasks.includes(record.toEvent);
                        });

                    t.ok(tasks.length, 'Some tasks found');
                    t.ok(dependencies.length, 'Some dependencies found');

                    t.ok(t.assertExportedTasksList(doc, tasks), `Tasks are exported ok on page ${i}`);
                    t.ok(t.assertExportedGanttDependenciesList(doc, dependencies), `Dependncies are exported ok on page ${i}`);

                    iframe.remove();
                }
            }
        );
    });

    t.it('Should export large gantt to multiple pages', async t => {
        const
            verticalPages = 5,
            rowsPerPage   = 24,
            startDate     = new Date(2020, 6, 13),
            endDate       = new Date(2020, 6, 20),
            {
                tasksData,
                dependenciesData
            } = await ProjectGenerator.generateAsync(100, 10, null, startDate);

        gantt = t.getGantt({
            height     : 900,
            width      : 600,
            viewPreset : 'weekAndDayLetter',
            project    : {
                eventsData : tasksData,
                dependenciesData,
                startDate
            },
            features : {
                pdfExport : {
                    exportServer : '/export',
                    headerTpl    : ({ currentPage }) => `<div style="height:9px;background-color: grey">
                    ${currentPage != null ? `Page ${currentPage}` : 'HEAD'}</div>`,
                    footerTpl : () => `<div style="height:9px;background-color: grey">FOOT</div>`
                }
            },
            startDate,
            endDate,
            columns : [
                { type : 'wbs', width : 50, minWidth : 50 },
                { type : 'name', width : 200 }
            ]
        });

        await Promise.all([
            gantt.project.commitAsync(),
            t.waitForSelector('.b-sch-dependency')
        ]);

        const html = await t.getExportHtml(gantt, {
            exporterType : 'multipage'
        });

        t.is(html.length, verticalPages, 'Correct amount of exported pages');

        for (let i = 0; i < html.length; i++) {
            const { document : doc, iframe } = await t.setIframeAsync({
                height : paperHeight,
                html   : html[i].html
            });

            t.subTest(`Checking exported page ${i}`, async t => {
                t.ok(t.assertHeaderPosition(doc), `Header exported ok on page ${i}`);
                t.ok(t.assertFooterPosition(doc), `Footer exported ok on page ${i}`);

                t.assertRowsExportedWithoutGaps(doc, false, (i + 1) % verticalPages !== 0);

                if (i % verticalPages === 0) {
                    t.ok(t.assertTicksExportedWithoutGaps(doc), `Ticks exported without gaps on page ${i}`);
                }

                const
                    { taskStore } = gantt,
                    tasks = taskStore.query(record => {
                        return taskStore.indexOf(record) > rowsPerPage * (i % html.length) - 1 &&
                            taskStore.indexOf(record) < rowsPerPage * (i % html.length + 1) - 1 &&
                            gantt.timeAxis.isTimeSpanInAxis(record);
                    }),
                    dependencies = gantt.dependencyStore.query(record => {
                        return tasks.includes(record.fromEvent) && tasks.includes(record.toEvent);
                    });

                if (i === html.length) {
                    t.ok(tasks.length, 'Some tasks found');
                    t.ok(dependencies.length, 'Some dependencies found');
                }

                t.ok(t.assertExportedTasksList(doc, tasks), `Tasks are exported ok on page ${i}`);
                t.ok(t.assertExportedGanttDependenciesList(doc, dependencies), `Dependencies are exported ok on page ${i}`);

                iframe.remove();
            });
        }
    });

    t.it('Should export large gantt to multiple letter pages', async t => {
        const
            verticalPages   = 3,
            horizontalPages = 3,
            headerHeight    = 50,
            rowsPerPage     = 15;

        gantt = new Gantt({
            appendTo : document.body,
            project  : {
                transport : {
                    load : {
                        url : '../examples/_datasets/launch-saas.json'
                    }
                }
            },
            enableEventAnimations : false,
            startDate             : '2019-01-13',
            endDate               : '2019-04-07',
            columns               : [
                { type : 'name', field : 'name', text : 'Name', width : 201 }, // 198 - 201
                { type : 'startdate', text : 'Start date' },
                { type : 'duration', text : 'Duration' }
            ],
            features : {
                pdfExport : {
                    exportServer : '/export',
                    headerTpl    : ({ currentPage }) => `<div style="height:${headerHeight}px;background-color: grey">
                    ${currentPage != null ? `Page ${currentPage}` : 'HEAD'}</div>`,
                    footerTpl : () => `<div style="height:${headerHeight}px;background-color: grey">FOOT</div>`
                }
            }
        });

        await gantt.project.load();

        const html = await t.getExportHtml(gantt, {
            paperFormat  : 'Letter',
            orientation  : Orientation.landscape,
            exporterType : 'multipage',
            alignRows    : true
        });

        t.is(html.length, verticalPages * horizontalPages, 'Correct amount of exported pages');

        for (let i = 0; i < html.length; i++) {
            const { document : doc, iframe } = await t.setIframeAsync({
                width  : 11 * 96,
                height : 8.5 * 96,
                html   : html[i].html
            });

            t.subTest(`Checking exported page ${i}`, async t => {
                t.ok(t.assertHeaderPosition(doc), `Header exported ok on page ${i}`);
                t.ok(t.assertFooterPosition(doc), `Footer exported ok on page ${i}`);

                t.assertRowsExportedWithoutGaps(doc, false, false);

                if (i % verticalPages === 0) {
                    t.ok(t.assertTicksExportedWithoutGaps(doc), `Ticks exported without gaps on page ${i}`);
                }

                const
                    { taskStore } = gantt,
                    tasks = taskStore.query(record => {
                        return taskStore.indexOf(record) > rowsPerPage * (i % 3) - 1 &&
                            taskStore.indexOf(record) < rowsPerPage * (i % 3 + 1) - 1 &&
                            gantt.timeAxis.isTimeSpanInAxis(record);
                    }),
                    dependencies = gantt.dependencyStore.query(record => {
                        return tasks.includes(record.fromEvent) && tasks.includes(record.toEvent);
                    });

                if (i === html.length) {
                    t.ok(tasks.length, 'Some tasks found');
                    t.ok(dependencies.length, 'Some dependencies found');
                }

                t.ok(t.assertExportedTasksList(doc, tasks), `Tasks are exported ok on page ${i}`);
                t.ok(t.assertExportedGanttDependenciesList(doc, dependencies), `Dependencies are exported ok on page ${i}`);

                iframe.remove();
            });
        }
    });
});
