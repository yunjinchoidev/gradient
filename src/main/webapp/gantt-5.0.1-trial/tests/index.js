const
    Project                 = new Siesta.Project.Browser(),
    isRelease               = Project.getQueryParam('release'),
    { isPR, isTC, isTrial } = BryntumTestHelper;

Project.configure({
    title                   : 'Bryntum Gantt Test Suite',
    isReadyTimeout          : 30000, // longer for memory profiling which slows things down
    testClass               : BryntumGanttTest,
    runCore                 : 'sequential',
    disableCaching          : false,
    autoCheckGlobals        : false,
    keepResults             : false,
    enableCodeCoverage      : Boolean(window.IstanbulCollector),
    failOnResourceLoadError : true,
    turboMode               : true,
    // TODO: cleanup hoursPerDay/daysPerWeek/daysPerMonth silencing till Gantt 4.2.0
    allowedConsoleMessageRe : /"(hoursPerDay|daysPerWeek|daysPerMonth)" property was moved to the ProjectModel class|promise rejection/,
    recorderConfig          : {
        recordOffsets    : false,
        ignoreCssClasses : [
            'b-gantt-task-hover',
            'b-sch-event-hover',
            'b-active',
            'b-icon',
            'b-hover',
            'b-dirty',
            'b-focused',
            'b-contains-focus'
        ],
        shouldIgnoreDomElementId : id => /^b-/.test(id)
    }
});

const
    getItems                = mode => {
        const
            examples   = [
                {
                    pageUrl       : '../examples/advanced',
                    viewportWidth : 2000,
                    url           : 'examples/advanced.t.js'
                },
                {
                    pageUrl : '../examples/aggregation-column',
                    url     : 'examples/aggregation-column.t.js'
                },
                {
                    pageUrl : '../examples/baselines?test&reset',
                    url     : 'examples/baselines.t.js'
                },
                {
                    pageUrl : '../examples/basic?test',
                    url     : 'examples/basic.t.js'
                },
                {
                    defaultTimeout : 120000,
                    subtestTimeout : 60000,
                    waitForTimeout : 60000,
                    pageUrl        : '../examples/bigdataset?test',
                    url            : 'examples/bigdataset.t.js'
                },
                'criticalpaths',
                {
                    pageUrl : '../examples/criticalpaths?test&',
                    url     : 'examples/criticalpaths.t.js'
                },
                'custom-header',
                {
                    pageUrl : '../examples/custom-rendering?test',
                    url     : 'examples/custom-rendering.t.js'
                },
                'custom-taskbar',
                {
                    pageUrl : '../examples/drag-from-grid?test',
                    url     : 'examples/drag-from-grid.t.js'
                },
                {
                    pageUrl : '../examples/drag-resources-from-grid?test',
                    url     : 'examples/drag-resources-from-grid.t.js'
                },
                'drag-resources-from-grid',
                {
                    url        : 'esmodule',
                    includeFor : 'module'
                },
                'export',
                {
                    pageUrl    : '../examples/exporttoexcel',
                    url        : 'examples/exporttoexcel.t.js',
                    skipMonkey : true
                },
                {
                    pageUrl     : '../examples/extjsmodern',
                    url         : 'examples/extjsmodern.t.js',
                    keepPageUrl : true
                },
                {
                    pageUrl : '../examples/gantt-schedulerpro?test',
                    url     : 'examples/gantt-schedulerpro.t.js'
                },
                'grid-sections',
                {
                    pageUrl : '../examples/highlight-time-spans?test',
                    url     : 'examples/highlight-time-spans.t.js'
                },
                {
                    pageUrl     : '../examples/gantt-taskboard',
                    includeFor  : 'module',
                    keepPageUrl : true
                },
                'indicators',
                {
                    pageUrl : '../examples/labels?test',
                    url     : 'examples/labels.t.js'
                },
                {
                    pageUrl : '../examples/localization?test&reset',
                    url     : 'examples/localization.t.js'
                },
                {
                    pageUrl    : '../examples/msprojectexport',
                    url        : 'examples/msprojectexport.t.js',
                    skipMonkey : true
                },
                'msprojectimport',
                {
                    pageUrl       : 'php', // url gets changed on earlySetup stage
                    url           : 'examples/php.t.js?' + mode,
                    viewportWidth : 2000,
                    // will make a new database and config file for the test
                    earlySetup    : {
                        url      : '../examples/php/php/setup.php?createDatabase=random',
                        callback : (response, testDesc, test, callback) => {
                            response.text().then(text => {
                                // extract the config file name to be used in the test
                                const
                                    match      = text.match(/CONFIG FILE=(.+)$/),
                                    configFile = match && match[1] || 'FAILURE';

                                if (!match) {
                                    test.fail('Random database creation failed', `Response from "setup.php?createDatabase=random" is: ${text}`);
                                }

                                testDesc.configFile = configFile;
                                // update pageUrl used -> append config file name as param
                                test.scopeProvider.sourceURL = '../examples/php?config=' + configFile;
                                // pass generated database config file name to tear down url
                                testDesc.tearDown.url += '?config=' + configFile;

                                callback();
                            });
                        }
                    },
                    tearDown : {
                        url      : '../examples/php/php/drop.php',
                        callback : (response, testDesc, test, callback) => callback()
                    },
                    // only run backend test in chrome
                    skip : !bowser.chrome
                },
                {
                    pageUrl    : '../examples/msprojectimport',
                    url        : 'examples/msprojectimport.t.js',
                    skipMonkey : true
                },
                'parent-area',
                'progressline',
                {
                    pageUrl : '../examples/resourceassignment',
                    url     : 'examples/resourceassignment.t.js'
                },
                {
                    pageUrl : '../examples/resourceutilization',
                    url     : 'examples/resourceutilization.t.js'
                },
                {
                    pageUrl     : '../examples/state',
                    url         : 'examples/state.t.js',
                    alsoPreload : {
                        type         : 'js',
                        isEcmaModule : true,
                        content      : 'window.localStorage.clear()'
                    }
                },
                'resourcehistogram',
                'responsive',
                'rollups',
                {
                    pageUrl     : '../examples/scripttag',
                    keepPageUrl : true
                },
                {
                    pageUrl : '../examples/summary?test',
                    url     : 'examples/summary.t.js'
                },
                {
                    pageUrl : '../examples/taskeditor?test&reset',
                    url     : 'examples/taskeditor.t.js'
                },
                'taskmenu',
                'theme',
                {
                    pageUrl : '../examples/timeline?test&reset',
                    url     : 'examples/timeline.t.js'
                },
                'timeranges',
                {
                    pageUrl : '../examples/tooltips?test&reset',
                    url     : 'examples/tooltips.t.js'
                },
                {
                    pageUrl     : '../examples/webcomponents',
                    url         : 'examples/webcomponents.t.js',
                    keepPageUrl : true,
                    includeFor  : isTrial ? 'module' : 'es6'
                },
                'undoredo'
            ],

            frameworks = [
                {
                    pageUrl       : 'angular/advanced',
                    url           : 'angular/angular-advanced.t.js',
                    viewportWidth : 2000
                },
                'angular/gantt-schedulerpro',
                'angular/inline-data',
                {
                    pageUrl : 'angular/pdf-export',
                    url     : 'angular/angular-pdf-export.t.js'
                },
                {
                    pageUrl : 'angular/taskeditor',
                    url     : 'angular/angular-taskeditor.t.js'
                },
                {
                    pageUrl : 'angular/rollups',
                    url     : 'angular/angular-rollups.t.js'
                },
                {
                    pageUrl : 'angular/timeranges',
                    url     : 'angular/angular-timeranges.t.js'
                },
                'angular/pdf-export',
                {
                    pageUrl    : 'angular/test-app',
                    url        : 'angular/angular-test-app.t.js',
                    skipMonkey : true
                },
                'ionic/ionic-4',
                {
                    pageUrl : 'react/javascript/advanced',
                    url     : 'react/react-advanced.t.js'
                },
                {
                    pageUrl : 'react/javascript/basic',
                    url     : 'react/react-basic.t.js'
                },
                {
                    pageUrl : 'react/javascript/inline-data',
                    url     : 'react/react-inline-data.t.js'
                },
                'react/javascript/gantt-schedulerpro',
                'react/javascript/pdf-export',
                'react/javascript/resource-histogram',
                'react/javascript/timeline',
                {
                    pageUrl : 'react/javascript/rollups',
                    url     : 'react/react-rollups.t.js'
                },
                {
                    pageUrl : 'react/javascript/taskeditor',
                    url     : 'react/react-taskeditor.t.js'
                },
                {
                    pageUrl : 'react/javascript/timeranges',
                    url     : 'react/react-timeranges.t.js'
                },
                {
                    pageUrl : 'react/typescript/basic',
                    url     : 'react/react-basic-typescript.t.js'
                },
                {
                    pageUrl : 'vue/javascript/advanced',
                    url     : 'vue/vue-advanced.t.js'
                },
                'vue/javascript/gantt-schedulerpro',
                'vue/javascript/inline-data',
                'vue/javascript/pdf-export',
                'vue/javascript/vue-renderer',
                {
                    pageUrl : 'vue/javascript/rollups',
                    url     : 'vue/vue-rollups.t.js'
                },
                {
                    pageUrl : 'vue/javascript/taskeditor',
                    url     : 'vue/vue-taskeditor.t.js'
                },
                {
                    pageUrl : 'vue/javascript/timeranges',
                    url     : 'vue/vue-timeranges.t.js'
                },
                // This setting requires requests to be proxied. Usual setup would be like:
                // app running on http://localhost:8080
                // tests running on http://localhost/bryntum-suite/gantt/tests
                // CORS would block requests to different origin, so they has to be proxied.
                // Web server should be adjusted to map http://localhost/gantt-netcore to http://localhost:8080/
                {
                    pageUrl : '/gantt-netcore/index.html',
                    url     : 'aspnetcore/aspnet-example.t.js',
                    skip    : !BryntumTestHelper.isNetCore
                },
                'vue-3/javascript/gantt-schedulerpro',
                'vue-3/javascript/inline-data',
                'vue-3/javascript/simple',
                {
                    pageUrl : 'vue-3/javascript/test-app',
                    url     : 'vue-3/vue-3-test-app.t.js'
                },
                {
                    pageUrl : 'webpack',
                    url     : 'webpack.t.js'
                }
            ],

            items      = [
                {
                    group   : 'Combination',
                    // Dont pull in any classes from sources or bundles
                    preload : [
                        '../build/thin/core.stockholm.thin.css',
                        '../build/thin/grid.stockholm.thin.css',
                        '../build/thin/scheduler.stockholm.thin.css',
                        '../build/thin/schedulerpro.stockholm.thin.css',
                        '../build/thin/gantt.stockholm.thin.css'
                    ],
                    includeFor : 'module',
                    items      : [
                        {
                            url         : 'combination/thin-all.t.js',
                            keepUrl     : true,
                            alsoPreload : [
                                '../build/thin/calendar.stockholm.thin.css',
                                '../build/thin/taskboard.stockholm.thin.css'
                            ]
                        },
                        {
                            url         : 'combination/thin-gantt-calendar.t.js',
                            keepUrl     : true,
                            alsoPreload : [
                                '../build/thin/calendar.stockholm.thin.css'
                            ]
                        },
                        {
                            url     : 'combination/thin-gantt-grid.t.js',
                            keepUrl : true
                        },
                        {
                            url     : 'combination/thin-gantt-scheduler.t.js',
                            keepUrl : true

                        },
                        {
                            url     : 'combination/thin-gantt-schedulerpro.t.js',
                            keepUrl : true
                        },
                        {
                            url         : 'combination/thin-gantt-taskboard.t.js',
                            keepUrl     : true,
                            alsoPreload : [
                                '../build/thin/taskboard.stockholm.thin.css'
                            ]
                        }
                    ]
                },
                {
                    group                  : 'Docs',
                    pageUrl                : '../docs/?reset',
                    includeFor             : isTrial ? 'module' : 'es6',
                    keepPageUrl            : true,
                    subTestTimeout         : 120000,
                    defaultTimeout         : 240000,
                    waitForTimeout         : 10000,
                    disableNoTimeoutsCheck : true,
                    alsoPreload            : bowser.firefox && preloadNoResizeObserver,
                    viewportHeight         : 500,
                    viewportWidth          : 1500,
                    items                  : [
                        {
                            url            : 'docs/open-all-links.t.js',
                            subTestTimeout : 360000,
                            ignoreTopics   : [
                                'demos',
                                'engineDocs'
                            ],
                            ignoreLinks : [
                                'Grid/feature/CellMenu#Grid/guides/customization/contextmenu.md',
                                'Grid/view/Grid#Grid/guides/data/displayingdata.md',
                                'Scheduler/feature/TimeAxisHeaderMenu#Scheduler/guides/customization/contextmenu.md',
                                'Scheduler/preset/PresetManager#Scheduler/guides/customization/localization.md',
                                'SchedulerPro/data/CalendarManagerStore#SchedulerPro/guides/basics/calendars.md',
                                'SchedulerPro/model/CalendarIntervalModel#SchedulerPro/guides/basics/calendars.md',
                                'SchedulerPro/model/CalendarModel#SchedulerPro/guides/basics/calendars.md',
                                'SchedulerPro/model/ProjectModel#SchedulerPro/guides/basics/project_data.md',
                                'SchedulerPro/view/SchedulerPro#Scheduler/guides/customization/localization.md',
                                'SchedulerPro/view/SchedulerPro#Scheduler/guides/customization/styling.md',
                                'SchedulerPro/view/SchedulerPro#SchedulerPro/guides/basics/project_data.md',
                                'SchedulerPro/view/SchedulerPro#SchedulerPro/guides/getting_started.md'
                            ],
                            ignoreClasses : [],
                            docsTitle     : 'Bryntum Gantt'
                        },
                        {
                            url            : 'docs/verify-links-in-guides.t.js',
                            subTestTimeout : 240000,
                            ignoreLinks    : [
                                'Core/guides/data/treedata.md#Core/guides/data/storebasics.md',
                                'Core/guides/advanced/widgets.md#foo',
                                'SchedulerPro/guides/whats-new/4.2.5.md#SchedulerPro/guides/integration/nodejs.md'
                            ]
                        },
                        'docs/docs-sanity.t.js',
                        
                    ]
                },
                {
                    group : 'Gantt',
                    items : [
                        {
                            group : 'Columns',
                            items : [
                                'column/AddNewColumn.t.js',
                                'column/AddNewColumnCombo.t.js',
                                'column/CalendarColumn.t.js',
                                'column/ConstraintColumns.t.js',
                                'column/DependencyColumn.t.js',
                                'column/DurationColumn.t.js',
                                'column/EffortColumn.t.js',
                                'column/EventModeColumn.t.js',
                                'column/InactiveColumn.t.js',
                                'column/ManuallyScheduledColumn.t.js',
                                'column/MilestoneColumn.t.js',
                                'column/NameColumn.t.js',
                                'column/NoteColumn.t.js',
                                'column/PercentDoneColumn.t.js',
                                {
                                    url                     : 'column/ResourceAssignmentColumn.t.js',
                                    failOnResourceLoadError : false
                                },
                                'column/ReplacingColumns.t.js',
                                'column/ResourceAssignmentColumnConfig.t.js',
                                'column/RollupColumn.t.js',
                                'column/SchedulingModeColumn.t.js',
                                'column/SequenceColumn.t.js',
                                'column/TaskDateColumns.t.js'
                            ]
                        },
                        {
                            group : 'Data',
                            items : [
                                'data/AssignmentStore.t.js',
                                'data/TaskStore.t.js',
                                'data/cycle.t.js'
                            ]
                        },
                        {
                            group : 'Data components',
                            items : [
                                'data_components/project_creation.t.js',
                                'data_components/Tasks.t.js',
                                'data_components/task_store.t.js',
                                // these 2 are postponed, since we first implement the new dependency validation code
                                // and then see whats next
                                // 'data_components/042_dependency_store.t.js',
                                // 'data_components/042_dependency_store2.t.js',
                                'data_components/AssignmentManipulationStore.t.js',
                                'data_components/CalendarIntervalModel.t.js',
                                'data_components/persisting.t.js',
                                'data_components/UndoRedo.t.js'
                            ]
                        },
                        {
                            group : 'Dependencies',
                            items : [
                                'dependencies/1348_missing_dependencies.t.js',
                                'dependencies/2492_persisted_dependency.t.js',
                                'dependencies/dependency_rendering.t.js',
                                'dependencies/dependency_rendering_2.t.js',
                                'dependencies/dependency_rendering_3.t.js',
                                'dependencies/DependencyStore.t.js'
                            ]
                        },
                        {
                            group : 'CRUD manager',
                            items : [
                                'crud_manager/01_add_stores.t.js',
                                'crud_manager/02_phantom_parent.t.js',
                                'crud_manager/20_empty_dataset.t.js',
                                // run the test in chrome only ..no need to test backend in all browsers
                                { // eslint-disable-line no-undef
                                    url        : 'crud_manager/11_backend.t.js',
                                    loadUrl    : '../examples/php/php/load.php',
                                    syncUrl    : '../examples/php/php/sync.php',
                                    resetUrl   : '../examples/php/php/reset.php',
                                    // will make a new database and config file for the test
                                    earlySetup : {
                                        url      : '../examples/php/php/setup.php?createDatabase=random',
                                        callback : (response, testDesc, test, callback) => {
                                            response.text().then(text => {
                                                // extract the config file name to be used in the test
                                                const
                                                    match      = text.match(/CONFIG FILE=(.+)$/),
                                                    configFile = match && match[1] || 'FAILURE';

                                                if (!match) {
                                                    test.fail('Random database creation failed', `Response from "setup.php?createDatabase=random" is: ${text}`);
                                                }

                                                testDesc.configFile = configFile;

                                                callback();
                                            });
                                        }
                                    },
                                    defaultTimeout : 180000,
                                    skip           : !bowser.chrome || isRelease
                                },
                                'crud_manager/12_mask.t.js',
                                'crud_manager/13_reload_data.t.js',
                                'crud_manager/14_sync.t.js',
                                'crud_manager/21_mapping.t.js',
                                {
                                    url         : 'crud_manager/beforeSync.t.js',
                                    usesConsole : true
                                }
                            ]
                        },
                        {
                            group       : 'Localization',
                            alsoPreload : preloadLocalization,
                            items       : [
                                {
                                    alsoPreload : {
                                        default : [{
                                            type         : 'js',
                                            isEcmaModule : true,
                                            content      : [
                                                'import "../examples/_shared/locales/examples.locale.En.js";',
                                                'import "../examples/_shared/locales/examples.locale.Nl.js";',
                                                'import "../examples/_shared/locales/examples.locale.Ru.js";',
                                                'import "../examples/_shared/locales/examples.locale.SvSE.js";'
                                            ].join('')
                                        }
                                        ]
                                    },
                                    ignoreList : {
                                        Common : [
                                            'PresetManager.dayAndWeek',
                                            'PresetManager.hourAndDay',
                                            'PresetManager.minuteAndHour',
                                            'PresetManager.secondAndMinute',
                                            'ConstraintIntervalDescription.dateFormat',
                                            'ResourceUtilization.groupBarTipAssignment'
                                        ]
                                    },
                                    universalList : {
                                        Common : [
                                            'Object.Ok',
                                            'TrialPanel.email',
                                            'TimePicker.minute'
                                        ],
                                        Nl : [
                                            'CodeEditor.Code editor',
                                            'CodeEditor.Download code',
                                            'DateColumn.Deadline',
                                            'DependencyEdit.Type',
                                            'DependencyTab.ID',
                                            'DependencyTab.Type',
                                            'EventEdit.Resource',
                                            'EventEdit.Start',
                                            'EventModeColumn.Auto',
                                            'ExportDialog.columns',
                                            'Filter.filter',
                                            'Indicators.Start',
                                            'SchedulerGeneralTab.Resources',
                                            'SchedulerGeneralTab.Preamble',
                                            'SchedulerGeneralTab.Postamble',
                                            'WBSColumn.WBS'
                                        ],
                                        SvSE : [
                                            'DateColumn.Deadline',
                                            'DeadlineDateColumn.Deadline',
                                            'DependencyTab.ID',
                                            'DependencyType.short.0',
                                            'DependencyType.SS',
                                            'EventEdit.Start',
                                            'Filter.filter',
                                            'GeneralTab.Start',
                                            'Indicators.deadlineDate',
                                            'Indicators.Start',
                                            'SchedulerGeneralTab.Start',
                                            'SchedulingModePicker.Normal',
                                            'StartDateColumn.Start',
                                            'StatusColumn.Status',
                                            'TaskEditorBase.Information',
                                            'ResourceHistogram.plusMore',
                                            'ResourceUtilization.plusMore'
                                        ],
                                        De : [
                                            'ExportDialog.export',
                                            'Filter.filter'
                                        ]
                                    },
                                    url        : 'localization/MissingLocalization.t.js?examples-all',
                                    includeFor : 'es6',
                                    skip       : !bowser.chrome
                                },
                                {
                                    alsoPreload : {
                                        default : [{
                                            type         : 'js',
                                            isEcmaModule : true,
                                            content      : [
                                                'import "../examples/localization/locales/custom.locale.En.js";',
                                                'import "../examples/localization/locales/custom.locale.Nl.js";',
                                                'import "../examples/localization/locales/custom.locale.Ru.js";',
                                                'import "../examples/localization/locales/custom.locale.SvSE.js";',
                                                'import "../examples/localization/locales/custom.locale.De.js";'
                                            ].join('')
                                        }
                                        ]
                                    },
                                    ignoreList : {
                                        Common : [
                                            'PresetManager.secondAndMinute',
                                            'PresetManager.minuteAndHour',
                                            'PresetManager.hourAndDay',
                                            'PresetManager.dayAndWeek',
                                            'ConstraintIntervalDescription.dateFormat'
                                        ],
                                        De : [
                                            'Column',
                                            'Shared'
                                        ]
                                    },
                                    universalList : {
                                        Common : [
                                            'Object.Ok',
                                            'TrialPanel.email',
                                            'Column.WBS',
                                            'WBSColumn.WBS',
                                            'ResourceUtilization.groupBarTipAssignment',
                                            'TimePicker.minute'
                                        ],
                                        Nl : [
                                            'CodeEditor.Code editor',
                                            'CodeEditor.Download code',
                                            'DependencyEdit.Type',
                                            'DependencyTab.ID',
                                            'DependencyTab.Type',
                                            'EventEdit.Resource',
                                            'EventEdit.Start',
                                            'EventModeColumn.Auto',
                                            'ExportDialog.columns',
                                            'Filter.filter',
                                            'Indicators.Start',
                                            'SchedulerGeneralTab.Resources',
                                            'SchedulerGeneralTab.Preamble',
                                            'SchedulerGeneralTab.Postamble'
                                        ],
                                        SvSE : [
                                            'Column.Start',
                                            'DeadlineDateColumn.Deadline',
                                            'DependencyTab.ID',
                                            'DependencyType.short.0',
                                            'DependencyType.SS',
                                            'EventEdit.Start',
                                            'Filter.filter',
                                            'GeneralTab.Start',
                                            'Indicators.deadlineDate',
                                            'Indicators.Start',
                                            'SchedulerGeneralTab.Start',
                                            'SchedulingModePicker.Normal',
                                            'StartDateColumn.Start',
                                            'TaskEditorBase.Information',
                                            'ResourceHistogram.plusMore',
                                            'ResourceUtilization.plusMore'
                                        ],
                                        De : [
                                            'AdvancedTab.Rollup',
                                            'DependencyTab.ID',
                                            'DependencyTab.Name',
                                            'EventEdit.Name',
                                            'EventEdit.Start',
                                            'EventModeColumn.Auto',
                                            'ExportDialog.export',
                                            'Filter.filter',
                                            'GeneralTab.Name',
                                            'GeneralTab.Start',
                                            'Indicators.Start',
                                            'RollupColumn.Rollup',
                                            'SchedulerGeneralTab.Name',
                                            'SchedulerGeneralTab.Start',
                                            'SchedulerGeneralTab.Preamble',
                                            'SchedulerGeneralTab.Postamble',
                                            'SchedulingModePicker.Normal',
                                            'TrialPanel.name',
                                            'TimePicker.Minute'
                                        ]
                                    },
                                    url        : 'localization/MissingLocalization.t.js?examples-localization',
                                    includeFor : 'es6',
                                    skip       : !bowser.chrome
                                },
                                {
                                    url         : 'localization/DependencyTypeLocalization.t.js',
                                    usesConsole : true
                                },
                                'localization/TaskEditorLocalization.t.js',
                                'localization/AddNewColumnLocalization.t.js',
                                'localization/ProjectLinesLocalization.t.js'
                            ]
                        },

                        
                        {
                            group : 'Features',
                            items : [
                                'feature/Baselines.t.js',
                                {
                                    group       : 'Export',
                                    alsoPreload : [
                                        {
                                            type    : 'css',
                                            // Without this we cannot get 50px high header container. And we need it
                                            content : 'body, button { font-family: Arial, Helvetica, sans-serif;  font-size: 14px; }'
                                        }
                                    ],
                                    items : [
                                        'feature/export/Export.t.js',
                                        'feature/export/MspExport.t.js',
                                        'feature/export/MultiPage.t.js',
                                        {
                                            url            : 'feature/export/MultiPageVertical.t.js',
                                            usesConsole    : true,
                                            defaultTimeout : 180000 // Edge cannot export fast enough
                                        },
                                        {
                                            url  : 'feature/export/MultiPageZoomed.t.js',
                                            skip : !bowser.chrome
                                        },
                                        {
                                            url         : 'feature/export/RowsOptions.t.js',
                                            usesConsole : true
                                        },
                                        {
                                            url         : 'feature/export/ScheduleRange.t.js',
                                            usesConsole : true
                                        },
                                        'feature/export/SinglePage.t.js'
                                    ]
                                },
                                {
                                    url         : 'feature/CellEdit.t.js',
                                    usesConsole : true
                                },
                                'feature/ColumnLines.t.js',
                                'feature/CriticalPaths.t.js',
                                'feature/Dependencies.t.js',
                                'feature/DependencyEdit.t.js',
                                'feature/Filter.t.js',
                                'feature/FilterBar.t.js',
                                'feature/Indicators.t.js',
                                'feature/Labels.t.js',
                                'feature/NonWorkingTime.t.js',
                                'feature/Pan.t.js',
                                'feature/ParentArea.t.js',
                                'feature/PercentBar.t.js',
                                'feature/ProjectLines.t.js',
                                'feature/ProgressLine.t.js',
                                'feature/QuickFind.t.js',
                                'feature/Rollups.t.js',
                                'feature/RowReorder.t.js',
                                'feature/Summary.t.js',
                                'feature/TaskCopyPaste.t.js',
                                'feature/TaskMenu.t.js',
                                'feature/TaskDrag.t.js',
                                'feature/TaskDragCreate.t.js',
                                'feature/TaskEdit.t.js',
                                'feature/TaskEditAdvanced.t.js',
                                'feature/TaskEditAssignments.t.js',
                                'feature/TaskEditDependency.t.js',
                                'feature/TaskEditConfiguration.t.js',
                                'feature/TaskEditEvents.t.js',
                                'feature/TaskEditSTM.t.js',
                                'feature/TaskEditStartEndDates.t.js',
                                'feature/TaskReorderSTM.t.js',
                                {
                                    url         : 'feature/TaskResize.t.js',
                                    alsoPreload : [preloadTouchMock]
                                },
                                'feature/TaskTooltip.t.js',
                                'feature/TimeRanges.t.js',
                                {
                                    viewportHeight : 1200,
                                    url            : 'feature/TreeGroup.t.js'
                                }
                            ]
                        },
                        {
                            group : 'DST',
                            items : [
                                'feature/dst/CellEdit.t.js',
                                'feature/dst/TaskEdit.t.js'
                            ]
                        },
                        {
                            group : 'Gantt + Scheduler Pro',
                            items : [
                                'gantt_schedulerpro/DragCreate.t.js',
                                'gantt_schedulerpro/TaskOperations.t.js'
                            ]
                        },
                        {
                            group       : 'Grid + Scheduler',
                            preload     : [],
                            alsoPreload : {
                                umd : [
                                    {
                                        type         : 'js',
                                        isEcmaModule : true,
                                        content      : [
                                            'window.Grid      = bryntum.grid.Grid;',
                                            'window.Scheduler = bryntum.scheduler.Scheduler;',
                                            'window.Gantt     = bryntum.gantt.Gantt;',
                                            'window.VersionHelper = bryntum.scheduler.VersionHelper;'
                                        ].join('')
                                    }
                                ],
                                module : [
                                    {
                                        type         : 'js',
                                        isEcmaModule : true,
                                        content      : [
                                            'import { Grid } from "../../Grid/build/grid.module.js";',
                                            'import { Scheduler } from "../../Scheduler/build/scheduler.module.js";',
                                            'import { Gantt } from "../build/gantt.module.js";',
                                            'Object.assign(window, { Grid, Scheduler, Gantt });'
                                        ].join('')
                                    }
                                ]
                            },
                            items : [
                                // Below tests use the same grid-and-scheduler.t.js scenario
                                // yet use:
                                // 1) either umd or native modules
                                // 2) loaded either locally or from bryntum.com
                                {
                                    url                     : 'grid+scheduler/grid-and-scheduler.t.js?umd-online-bundles',
                                    pageUrl                 : 'grid+scheduler/grid-and-scheduler-umd-online.html',
                                    includeFor              : 'umd',
                                    keepPageUrl             : true,
                                    allowedConsoleMessageRe : /Bryntum .* Trial Version/
                                },
                                {
                                    url         : 'grid+scheduler/grid-and-scheduler.t.js?online-bundles',
                                    alsoPreload : [
                                        '../build/gantt.classic.css',
                                        {
                                            type         : 'js',
                                            isEcmaModule : true,
                                            content      : [
                                                'import { Grid } from "https://bryntum.com/examples/build/grid.module.js";',
                                                'import { Scheduler, VersionHelper } from "https://bryntum.com/examples/build/scheduler.module.js";',
                                                'import { Gantt } from "../build/gantt.module.js";',
                                                'Object.assign(window, { Grid, Scheduler, Gantt, VersionHelper });'
                                            ].join('')
                                        }
                                    ],
                                    includeFor              : 'module',
                                    skip                    : isPR,
                                    allowedConsoleMessageRe : /Bryntum .* Trial Version/
                                },
                                {
                                    url         : 'grid+scheduler/grid-and-scheduler.t.js?umd-local-bundles',
                                    pageUrl     : 'grid+scheduler/grid-and-scheduler-umd.html',
                                    keepPageUrl : true,
                                    includeFor  : 'umd',
                                    skip        : isTC
                                },
                                {
                                    alsoPreload : [
                                        '../build/gantt.classic.css',
                                        {
                                            type         : 'js',
                                            isEcmaModule : true,
                                            content      : [
                                                'import { Grid } from "../../Grid/build/grid.module.js";',
                                                'import { Scheduler } from "../../Scheduler/build/scheduler.module.js";',
                                                'import { Gantt } from "../build/gantt.module.js";',
                                                'Object.assign(window, { Grid, Scheduler, Gantt });'
                                            ].join('')
                                        }
                                    ],
                                    url        : 'grid+scheduler/grid-and-scheduler.t.js?local-bundles',
                                    includeFor : 'module',
                                    skip       : isTC
                                }
                            ]
                        },
                        {
                            group : 'Model',
                            items : [
                                'model/AssignmentModel.t.js',
                                'model/DependencyModel.t.js',
                                'model/ProjectModel.t.js',
                                {
                                    url         : 'model/TaskModel.t.js',
                                    consoleFail : ['error']
                                }
                            ]
                        },
                        {
                            group : 'Widgets',
                            items : [
                                'widget/AssignmentGrid.t.js',
                                'widget/AssignmentField.t.js',
                                'widget/TaskEditor.t.js',
                                'widget/Timeline.t.js'
                            ]
                        },
                        {
                            group : 'view',
                            items : [
                                {
                                    group : 'Export',
                                    items : [
                                        'view/export/ExportDialog.t.js'
                                    ]
                                },
                                {
                                    group : 'Mixin',
                                    items : [
                                        'view/mixin/GanttScroll.t.js',
                                        'view/mixin/GanttState.t.js',
                                        'view/mixin/GanttStateProvider.t.js',
                                        'view/mixin/GanttStores.t.js',
                                        'view/mixin/TaskNavigation.t.js',
                                        'view/mixin/Responsive.t.js'
                                    ]
                                },
                                {
                                    url        : 'view/GanttBase.t.js',
                                    includeFor : 'es6',
                                    // To prevent default preloads, which will include Gantt.js
                                    preload    : [
                                        '../build/gantt.classic.css'
                                    ]
                                },
                                'view/GanttCurrentConfig.t.js',
                                'view/GanttSubGridRegions.t.js',
                                {
                                    url         : 'view/gantt.t.js',
                                    alsoPreload : [
                                        'view/data.js'
                                    ]
                                },
                                'view/SchedulerProWithGanttProject.t.js',
                                'view/TaskHover.t.js',
                                'view/TaskSelection.t.js',
                                {
                                    url  : 'view/TimeViewRangePageZoom.t.js',
                                    skip : !bowser.chrome
                                },
                                'view/TaskRendering.t.js',
                                'view/TaskRendering2.t.js',
                                'view/Zooming.t.js',
                                'view/TaskIndent.t.js',
                                'view/TaskIndent2.t.js',
                                'view/TaskIndentDirty.t.js',
                                'view/TaskWbs.t.js',
                                {
                                    url        : 'view/WebComponent.t.js',
                                    includeFor : isTrial ? 'module' : 'es6'
                                },
                                {
                                    url        : 'view/WebComponentCriticalPaths.t.js',
                                    includeFor : isTrial ? 'module' : 'es6'
                                },
                                'view/SchedulingIssuePopup.t.js',
                                'view/ResourceUtilization.t.js',
                                'view/ResourceUtilizationWithPartner.t.js',
                                'view/ResourceUtilizationAssignmentColumn.t.js'
                            ]
                        },
                        {
                            group : 'Util',
                            items : [
                                'util/TableExporter.t.js',
                                'util/ResourceAssignmentParser.t.js'
                            ]
                        }
                    ]
                },
                {
                    group              : 'Trial examples',
                    skip               : !isTrial,
                    enablePageRedirect : true,
                    includeFor         : 'module',
                    consoleFail        : ['error', 'warn'],
                    items              : [
                        {
                            pageUrl    : '../examples/basic?test',
                            url        : 'examples/trial-expired-example.t.js?basic',
                            includeFor : 'umd,module'
                        },
                        {
                            pageUrl    : '../examples/advanced?test',
                            url        : 'examples/trial-expired-example.t.js?advanced',
                            includeFor : 'umd,module'
                        },
                        {
                            pageUrl : '../examples/esmodule?test',
                            url     : 'examples/trial-expired-example.t.js?esmodule'
                        },
                        {
                            pageUrl     : '../examples/webcomponents?test',
                            url         : 'examples/trial-expired-example.t.js?webcomponents',
                            keepPageUrl : true,
                            includeFor  : isTrial ? 'module' : 'es6'
                        }
                    ]
                },
                {
                    group : 'Engine',
                    items : [
                        {
                            includeFor : 'module,umd',
                            url        : 'engine/engine-export.t.js'
                        }
                    ]
                },
                {
                    group : 'Examples',
                    // Filter out examples used for monkey tests only
                    items : examples.filter(example => example?.pageUrl != null && example?.url != null)
                },
                {
                    group          : 'Examples browser',
                    subTestTimeout : 120000,
                    defaultTimeout : 120000,
                    waitForTimeout : 60000,
                    items          : [
                        {
                            pageUrl            : '../examples/?theme=material&test',
                            url                : 'examples/browser/examplebrowser.t.js',
                            enablePageRedirect : true,
                            exampleName        : 'localization',
                            exampleTitle       : 'Localization demo',
                            offlineExampleName : 'frameworks-react-javascript-basic',
                            jumpSectionName    : 'Additional widgets',
                            jumpExampleName    : 'resourcehistogram',
                            filterText         : 'line',
                            filterCount        : 5
                        },
                        {
                            pageUrl : '../examples/?online&test',
                            url     : 'examples/browser/examplebrowseronline.t.js'
                        },
                        {
                            pageUrl         : '../examples/?online&test',
                            url             : 'examples/browser/examplebrowser-links.t.js',
                            isPR,
                            isTrial,
                            config          : { skipSanityChecks : true },
                            productName     : 'Gantt',
                            skipHeaderCheck : [
                                'esmodule',
                                'scripttag'
                            ],
                            skipTrialCheck : [
                                'extjsmodern'
                            ],
                            enablePageRedirect : true,
                            defaultTimeout     : 480000,
                            skip               : {
                                // Demo browser opens module demos even if opened as umd when not run on an ancient
                                // browser (which we do not support), so no point in running this test for umd
                                umd : true
                            }
                        }
                    ]
                },
                {
                    group : 'Monkey Tests for Examples',
                    items : BryntumTestHelper.prepareMonkeyTests({
                        items  : examples,
                        mode,
                        config : {
                            webComponent   : 'bryntum-gantt',
                            waitSelector   : '.b-gantt-task',
                            targetSelector : '.b-ganttbase'
                        }
                    })
                },
                {
                    group : 'Smart Monkey Tests for Examples',
                    items : BryntumTestHelper.prepareMonkeyTests({
                        items        : examples.concat([{ pageUrl : '../examples' }]),
                        mode,
                        smartMonkeys : true,
                        config       : {
                            webComponent   : 'bryntum-gantt',
                            waitSelector   : '.b-gantt-task',
                            targetSelector : '.b-ganttbase',
                            consoleFail    : ['error']
                        }
                    })
                },
                {
                    group      : 'Frameworks examples (npm build)',
                    includeFor : 'umd',
                    skip       : !(isTrial && bowser.chrome),
                    items      : [
                        'examples/frameworks-build.t.js'
                    ]
                },
                {
                    group          : 'Frameworks',
                    consoleFail    : ['error', 'warn'],
                    includeFor     : isTrial ? 'umd' : 'es6',
                    config         : { skipSanityChecks : true },
                    subTestTimeout : 120000,
                    defaultTimeout : 120000,
                    skip           : isTC && !isTrial,
                    items          : [
                        {
                            group : 'Frameworks examples',
                            items : BryntumTestHelper.prepareFrameworkTests(frameworks)
                        },
                        {
                            group : 'Monkey tests for Frameworks examples',
                            items : BryntumTestHelper.prepareFrameworkMonkeyTests({
                                items  : frameworks,
                                config : {
                                    waitSelector   : '.b-gantt-task',
                                    targetSelector : '.b-ganttbase'
                                }
                            })
                        },
                        {
                            group : 'Smart Monkey tests for Frameworks examples',
                            items : BryntumTestHelper.prepareFrameworkMonkeyTests({
                                items        : frameworks,
                                smartMonkeys : true,
                                config       : {
                                    waitSelector   : '.b-gantt-task',
                                    targetSelector : '.b-ganttbase'
                                }
                            })
                        }
                    ]
                }
            ];

        return BryntumTestHelper.prepareItems(items, mode);
    },
    // Preloads for tests. Usage example: alsoPreload : [preloadName]
    preloadFont             = {
        // want size to be as equal as possible on different platforms
        type    : 'css',
        content : 'body, button { font-family: Arial, Helvetica, sans-serif;  font-size: 14px; }'
    },
    preloadLocalization     = {
        umd : [
            '../build/locales/gantt.locale.En.js',
            '../build/locales/gantt.locale.Nl.js',
            '../build/locales/gantt.locale.Ru.js',
            '../build/locales/gantt.locale.SvSE.js',
            '../examples/localization/locales/custom.locale.De.umd.js'
        ],
        default : [{
            type         : 'js',
            isEcmaModule : true,
            content      : [
                'import En from "../lib/Gantt/localization/En.js";',
                'import Nl from "../lib/Gantt/localization/Nl.js";',
                'import Ru from "../lib/Gantt/localization/Ru.js";',
                'import SvSE from "../lib/Gantt/localization/SvSE.js";',
                'import "../examples/localization/locales/custom.locale.De.js";',
                'window.bryntum.locales = { En, Nl, Ru, SvSE, De: window.bryntum.locales.De };'
            ].join('')
        }]
    },
    preloadTouchMock        = {
        // Force our core code to detect touch device
        type    : 'js',
        content : 'if (window.Touch) { window.ontouchstart = function(){}; }'
    },
    preloadNoResizeObserver = {
        type    : 'js',
        content : 'window.ResizeObserver = false; window.onerror = function(err) { return /ResizeObserver/.test(err);};'
    },
    preloadTurbo            = {
        // To allow classes to have different config values in test execution
        type    : 'js',
        content : 'window.__applyTestConfigs = ' + String(Project.turboMode) + ';'
    },
    preloadCss              = '../build/gantt.classic.css',
    preloads                = [
        preloadCss,
        preloadFont,
        preloadTurbo
    ],
    groups                  = [];



groups.push({
    group   : 'Using module bundle',
    preload : preloads.concat({
        type         : 'js',
        isEcmaModule : true,
        content      : `
            import * as Module from "../build/gantt.module.js";
            Object.assign(window, Module);
        `
    }),
    isEcmaModule : true,
    collapsed    : true,
    mode         : 'module',
    items        : getItems('module')
});

groups.push({
    group        : 'Using umd bundle',
    preload      : preloads.concat(isTrial ? '../build/gantt.umd.js' : '../build/gantt.umd.min.js'),
    isEcmaModule : false,
    collapsed    : false,
    mode         : 'umd',
    items        : getItems('umd')
});

Project.start(groups);
