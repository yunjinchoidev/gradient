import { ObjectHelper } from '../../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt;

    t.beforeEach(() => {
        gantt && gantt.destroy && gantt.destroy();
    });

    const exportProperties = [
        'scheduleRange',
        'exporterType',
        'orientation',
        'paperFormat',
        'fileFormat',
        'rowsRange',
        'alignRows'
    ];

    t.it('Export dialog should be configured with default PdfExport feature configs', async t => {
        const exportCfg = {
            scheduleRange : 'completeview',
            exporterType  : 'singlepage',
            orientation   : 'portrait',
            paperFormat   : 'A4',
            fileFormat    : 'pdf',
            rowsRange     : 'all',
            alignRows     : false
        };

        gantt = await t.getGanttAsync({
            features : {
                pdfExport : true
            }
        });

        await gantt.features.pdfExport.showExportDialog();

        const
            { exportDialog } = gantt.features.pdfExport,
            values = ObjectHelper.copyProperties({}, exportDialog.values, exportProperties);

        t.isDeeply(values, exportCfg, 'Fields are configured right');
        t.ok(exportDialog.widgetMap.alignRowsField.hidden, 'alignRows hidden');
    });

    t.it('Export dialog should be configured with PdfExport feature configs', async t => {
        const exportCfg = {
            scheduleRange : 'currentview',
            exporterType  : 'multipage',
            orientation   : 'landscape',
            paperFormat   : 'A3',
            fileFormat    : 'png',
            rowsRange     : 'visible',
            alignRows     : true
        };

        gantt = await t.getGanttAsync({
            features : {
                pdfExport : { ...exportCfg }
            }
        });

        await gantt.features.pdfExport.showExportDialog();

        const
            { exportDialog } = gantt.features.pdfExport,
            values = ObjectHelper.copyProperties({}, exportDialog.values, exportProperties);

        t.isDeeply(values, exportCfg, 'Fields are configured right');
        t.notOk(exportDialog.widgetMap.alignRowsField.hidden, 'alignRows visible');
    });

    t.it('Hidden columns should not be selected', async t => {
        gantt = await t.getGanttAsync({
            sanityCheck : false,
            startDate   : new Date(2020, 6, 19),
            endDate     : new Date(2020, 6, 26),
            features    : {
                pdfExport : {
                    exportServer : '/export'
                }
            },
            columns : [
                { text : 'Vis', flex : 1, id : 1 },
                { text : 'Hidden', flex : 1, id : 2, hidden : true },
                { text : 'Non exportable', flex : 1, id : 3, exportable : false },
                { text : 'Vis', flex : 1, id : 4 }
            ]
        });

        await gantt.features.pdfExport.showExportDialog();

        const { exportDialog } = gantt.features.pdfExport;

        // Gantt always adds name column
        t.isDeeply(exportDialog.widgetMap.columnsField.value, [gantt.columns.first.id, 1, 4], 'Visible & exportable columns preselected');

        await t.click('button:contains(Cancel)');

        gantt.columns.getAt(1).hidden = true;
        gantt.columns.getAt(2).hidden = false;

        await gantt.features.pdfExport.showExportDialog();

        t.isDeeply(exportDialog.widgetMap.columnsField.value.sort(), [gantt.columns.first.id, 2, 4].sort(), 'Visible & exportable columns preselected');
    });

    t.it('Should trigger `export` event when clicking Export button', async t => {
        gantt = await t.getGanttAsync({
            columns : [
                { field : 'name', text : 'name', id : 'name' },
                { field : 'color', text : 'color', id : 'color' },
                { field : 'age', text : 'age', id : 'age', hidden : true }
            ],
            features : {
                pdfExport : {
                    exportServer : '/export',
                    exportDialog : {
                        autoSelectVisibleColumns : false,
                        items                    : {
                            columnsField : {
                                value : ['name']
                            },
                            scheduleRangeField : {
                                value : 'daterange'
                            },
                            rangesContainer : {
                                items : {
                                    rangeStartField : {
                                        value : new Date(2021, 6, 26)
                                    },
                                    rangeEndField : {
                                        value : new Date(2021, 6, 28)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        });

        await gantt.features.pdfExport.showExportDialog();

        const
            { exportDialog } = gantt.features.pdfExport,
            { columnsField } = exportDialog.widgetMap;

        t.isDeeply(columnsField.value, ['name'], 'Only name column is exported');

        t.firesOnce(exportDialog, 'export');
        exportDialog.on('export', ({ values }) => {
            t.isDeeply(values, {
                alignRows     : false,
                columns       : ['name'],
                exporterType  : 'singlepage',
                fileFormat    : 'pdf',
                orientation   : 'portrait',
                paperFormat   : 'A4',
                repeatHeader  : false,
                rowsRange     : 'all',
                scheduleRange : 'daterange',
                rangeStart    : new Date(2021, 6, 26),
                rangeEnd      : new Date(2021, 6, 28)
            });
        });

        await t.click('button:contains(Export)');
    });
});
