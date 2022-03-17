<h1 class="title-with-image"><img src="Core/logo/vue.svg" 
alt="Bryntum Gantt supports Vue"/>Using Bryntum Gantt with Vue</h1>

## Bryntum NPM repository access

Please refer to this [guide for Bryntum NPM repository access](#Gantt/guides/npm-repository.md).

## Bryntum Gantt

Bryntum Gantt itself is framework agnostic, but it ships with demos and wrappers to simplify using it with popular
frameworks such as Vue. The purpose of this guide is to give a basic introduction on how to use Bryntum Gantt with Vue.

## View online demos

Bryntum Gantt Vue demos can be viewed in our
[online example browser](https://bryntum.com/examples/gantt/#Integration/Vue).

## Build and run local demos

Vue demos are located in **examples/frameworks/vue** and **examples/frameworks/vue-3** folders inside distribution zip.

Trial distribution zip can be requested from [https://bryntum.com](https://bryntum.com/products/gantt)
by clicking **Free Trial** button. Licensed distribution zip is located at
[Bryntum Customer Zone](https://customerzone.bryntum.com).

Each demo contains bundled `README.md` file in demo folder with build and run instructions.

To view and run an example locally in development mode, you can use the following commands:

```shell
$ npm install
$ npm run start
```

That starts a local server accessible at [http://127.0.0.1:8080](http://127.0.0.1:8080). If you modify the example code
while running it locally it is automatically rebuilt and updated in the browser allowing you to see your changes
immediately.

The production version of an example, or your application, is built by running:

```shell
$ npm install
$ npm run build
```

## TypeScript and Typings

Bryntum bundles ship with typings for the classes for usage in TypeScript applications. You can find `gantt*.d.ts`
files in the `build` folder inside the distribution zip package. The definitions also contain a special config type
which can be passed to the class constructor.

The config specific types are also accepted by multiple other properties and functions, for example
the [Store.data](#Core/data/Store#config-data) config of the `Store` which accepts type `Partial<ModelConfig>[]`.

Sample code for tree store creation with `ModelConfig` and `StoreConfig` classes:

```typescript
import { Store, StoreConfig, ModelConfig } from '@bryntum/gantt';

const storeConfig: Partial<StoreConfig> = {
    tree : true,
    data : [
        {
            id       : 1,
            children : [
                {
                    id : 2
                }
            ] as Partial<ModelConfig>[]
        }
    ] as Partial<ModelConfig>[]
};

new Store(storeConfig);
```

## Wrappers

The Vue wrappers encapsulate Bryntum Gantt and other Bryntum widgets in Vue components that expose
configuration options, properties, features and events. The wrapped all Bryntum UI components so they can be used the
usual Vue way.

To use native API package classes with wrappers import them from `@bryntum/gantt`.

```javascript
import { Gantt } from '@bryntum/gantt';
```

### Installing the wrappers package

The wrappers are distributed as a separate package `@bryntum/gantt-vue` that is installed according to the used
package manager. Please refer to this [guide for Bryntum NPM repository access](#Gantt/guides/npm-repository.md).

### Wrappers Overview

Wrappers are Vue components which provide full access to Bryntum API widget class configs, properties, events and
features. Each Wrapper has it's own HTML tag which can be used in vue templates. This is the list of available
wrappers for Bryntum Gantt Vue package:

| Wrapper tag name | API widget reference |
|------------------|----------------------|
| &lt;bryntum-assignment-field/&gt; | [AssignmentField](#Gantt/widget/AssignmentField) |
| &lt;bryntum-assignment-grid/&gt; | [AssignmentGrid](#Gantt/widget/AssignmentGrid) |
| &lt;bryntum-button/&gt; | [Button](#Core/widget/Button) |
| &lt;bryntum-button-group/&gt; | [ButtonGroup](#Core/widget/ButtonGroup) |
| &lt;bryntum-calendar-field/&gt; | [CalendarField](#SchedulerPro/widget/CalendarField) |
| &lt;bryntum-calendar-picker/&gt; | [CalendarPicker](#Gantt/widget/CalendarPicker) |
| &lt;bryntum-checkbox/&gt; | [Checkbox](#Core/widget/Checkbox) |
| &lt;bryntum-chip-view/&gt; | [ChipView](#Core/widget/ChipView) |
| &lt;bryntum-combo/&gt; | [Combo](#Core/widget/Combo) |
| &lt;bryntum-constraint-type-picker/&gt; | [ConstraintTypePicker](#SchedulerPro/widget/ConstraintTypePicker) |
| &lt;bryntum-container/&gt; | [Container](#Core/widget/Container) |
| &lt;bryntum-cycle-resolution-popup/&gt; | [CycleResolutionPopup](#SchedulerPro/widget/CycleResolutionPopup) |
| &lt;bryntum-date-field/&gt; | [DateField](#Core/widget/DateField) |
| &lt;bryntum-date-picker/&gt; | [DatePicker](#Core/widget/DatePicker) |
| &lt;bryntum-date-time-field/&gt; | [DateTimeField](#Core/widget/DateTimeField) |
| &lt;bryntum-dependency-field/&gt; | [DependencyField](#Gantt/widget/DependencyField) |
| &lt;bryntum-dependency-type-picker/&gt; | [DependencyTypePicker](#SchedulerPro/widget/DependencyTypePicker) |
| &lt;bryntum-display-field/&gt; | [DisplayField](#Core/widget/DisplayField) |
| &lt;bryntum-duration-field/&gt; | [DurationField](#Core/widget/DurationField) |
| &lt;bryntum-effort-field/&gt; | [EffortField](#SchedulerPro/widget/EffortField) |
| &lt;bryntum-end-date-field/&gt; | [EndDateField](#SchedulerPro/widget/EndDateField) |
| &lt;bryntum-file-field/&gt; | [FileField](#Core/widget/FileField) |
| &lt;bryntum-file-picker/&gt; | [FilePicker](#Core/widget/FilePicker) |
| &lt;bryntum-filter-field/&gt; | [FilterField](#Core/widget/FilterField) |
| &lt;bryntum-gantt/&gt; | [Gantt](#Gantt/view/Gantt) |
| &lt;bryntum-gantt-base/&gt; | [GanttBase](#Gantt/view/GanttBase) |
| &lt;bryntum-gantt-task-editor/&gt; | [GanttTaskEditor](#SchedulerPro/widget/GanttTaskEditor) |
| &lt;bryntum-grid/&gt; | [Grid](#Grid/view/Grid) |
| &lt;bryntum-grid-base/&gt; | [GridBase](#Grid/view/GridBase) |
| &lt;bryntum-list/&gt; | [List](#Core/widget/List) |
| &lt;bryntum-menu/&gt; | [Menu](#Core/widget/Menu) |
| &lt;bryntum-model-combo/&gt; | [ModelCombo](#SchedulerPro/widget/ModelCombo) |
| &lt;bryntum-number-field/&gt; | [NumberField](#Core/widget/NumberField) |
| &lt;bryntum-paging-toolbar/&gt; | [PagingToolbar](#Core/widget/PagingToolbar) |
| &lt;bryntum-panel/&gt; | [Panel](#Core/widget/Panel) |
| &lt;bryntum-password-field/&gt; | [PasswordField](#Core/widget/PasswordField) |
| &lt;bryntum-project-combo/&gt; | [ProjectCombo](#Scheduler/widget/ProjectCombo) |
| &lt;bryntum-radio/&gt; | [Radio](#Core/widget/Radio) |
| &lt;bryntum-radio-group/&gt; | [RadioGroup](#Core/widget/RadioGroup) |
| &lt;bryntum-resource-combo/&gt; | [ResourceCombo](#Scheduler/widget/ResourceCombo) |
| &lt;bryntum-resource-filter/&gt; | [ResourceFilter](#Scheduler/widget/ResourceFilter) |
| &lt;bryntum-resource-histogram/&gt; | [ResourceHistogram](#SchedulerPro/view/ResourceHistogram) |
| &lt;bryntum-resource-utilization/&gt; | [ResourceUtilization](#SchedulerPro/view/ResourceUtilization) |
| &lt;bryntum-scheduler/&gt; | [Scheduler](#Scheduler/view/Scheduler) |
| &lt;bryntum-scheduler-base/&gt; | [SchedulerBase](#Scheduler/view/SchedulerBase) |
| &lt;bryntum-scheduler-date-picker/&gt; | [SchedulerDatePicker](#Scheduler/widget/SchedulerDatePicker) |
| &lt;bryntum-scheduler-pro/&gt; | [SchedulerPro](#SchedulerPro/view/SchedulerPro) |
| &lt;bryntum-scheduler-pro-base/&gt; | [SchedulerProBase](#SchedulerPro/view/SchedulerProBase) |
| &lt;bryntum-scheduler-task-editor/&gt; | [SchedulerTaskEditor](#SchedulerPro/widget/SchedulerTaskEditor) |
| &lt;bryntum-scheduling-issue-resolution-popup/&gt; | [SchedulingIssueResolutionPopup](#SchedulerPro/widget/SchedulingIssueResolutionPopup) |
| &lt;bryntum-scheduling-mode-picker/&gt; | [SchedulingModePicker](#SchedulerPro/widget/SchedulingModePicker) |
| &lt;bryntum-slider/&gt; | [Slider](#Core/widget/Slider) |
| &lt;bryntum-slide-toggle/&gt; | [SlideToggle](#Core/widget/SlideToggle) |
| &lt;bryntum-splitter/&gt; | [Splitter](#Core/widget/Splitter) |
| &lt;bryntum-start-date-field/&gt; | [StartDateField](#SchedulerPro/widget/StartDateField) |
| &lt;bryntum-tab-panel/&gt; | [TabPanel](#Core/widget/TabPanel) |
| &lt;bryntum-task-editor/&gt; | [TaskEditor](#Gantt/widget/TaskEditor) |
| &lt;bryntum-text-area-field/&gt; | [TextAreaField](#Core/widget/TextAreaField) |
| &lt;bryntum-text-area-picker-field/&gt; | [TextAreaPickerField](#Core/widget/TextAreaPickerField) |
| &lt;bryntum-text-field/&gt; | [TextField](#Core/widget/TextField) |
| &lt;bryntum-time-field/&gt; | [TimeField](#Core/widget/TimeField) |
| &lt;bryntum-timeline/&gt; | [Timeline](#SchedulerPro/widget/Timeline) |
| &lt;bryntum-time-picker/&gt; | [TimePicker](#Core/widget/TimePicker) |
| &lt;bryntum-toolbar/&gt; | [Toolbar](#Core/widget/Toolbar) |
| &lt;bryntum-trial-button/&gt; | [TrialButton](#Core/widget/trial/TrialButton) |
| &lt;bryntum-undo-redo/&gt; | [UndoRedo](#Scheduler/widget/UndoRedo) |
| &lt;bryntum-widget/&gt; | [Widget](#Core/widget/Widget) |

### Using the wrapper in your application

Now you can use the the component defined in the wrapper in your application:

Sample code for `App.vue`:

```html
<template>
    <bryntum-gantt
        ref="gantt"
        tooltip="ganttConfig.tooltip"
        v-bind="ganttConfig"
        @click="onClick"
    />
</template>

<script>

import { BryntumGantt } from '@bryntum/gantt-vue';
import { ganttConfig } from './AppConfig';
import './components/ColorColumn.js';

export default {
    name: 'app',

    // local components
    components: {
        BryntumGantt
    },
    data() {
        return { ganttConfig };
    }
};
</script>

<style lang="scss">
@import './App.scss';
</style>
```

As shown above you can assign values and bind to Vue data with `tooltip="ganttConfig.tooltip"` or `v-bind` option.
Listen to events with `@click="onClick"`, or use `v-on`.

`AppConfig.js` should contain a simple Bryntum Gantt configuration.
We recommend to keep it in a separate file because it can become lengthy especially for more advanced configurations.

Sample code for `AppConfig.js`:

```javascript
export const ganttConfig =  {
    tooltip : "My cool Bryntum Gantt component"
    // Bryntum Gantt config options
};
```

Add `sass-loader` to your `package.json` if you used SCSS.

You will also need to import CSS file for Bryntum Gantt.
The ideal place for doing it is the beginning of `App.scss/App.css` that would be imported in `App.vue`:

```javascript
@import "~@bryntum/gantt/gantt.stockholm.css";
```

### Embedding widgets inside wrapper

Wrappers are designed to allow using Bryntum widgets as Vue components, but they themselves cannot contain other
Bryntum wrappers inside their tag. To embed Bryntum widgets inside a wrapper you should instead use the available
configuration options for the wrapper's widget. Please note that not all widgets may contain inner widgets, please refer
to the API docs to check for valid configuration options.

This example shows how to use a `Toolbar` widget inside the wrapper for Bryntum Gantt:

Sample code for `AppConfig.js`:

```javascript
export const ganttConfig =  {
    // Toolbar (tbar) config
    tbar: {
        items : [
            {
                type : 'button',
                text : 'My button'
            }
        ]
    }
    // Bryntum Gantt config options
};
```

### Syncing bound data changes

The stores used by the wrapper enable [syncDataOnLoad](#Core/data/Store#config-syncDataOnLoad) by default (Stores not
used by the wrapper have it disabled by default). It is done to make Vue column renderer update the value.
Without `syncDataOnLoad`, each time a new array of data is set to the store would apply the data as a completely new
dataset. With `syncDataOnLoad`, the new state is instead compared to the old, and the differences are applied.

## Configs, properties and events

All Bryntum Vue Wrappers support the full set of the public configs, properties and events of a component.

### Using dataChange event to synchronize data

Bryntum Gantt keeps all data in its stores which are automatically synchronized with the UI and the user actions.
Nevertheless, it is sometimes necessary for the rest of the application to be informed about data changes. For that
it is easiest to use `dataChange` event.

```javascript
<template>
        <bryntum-scheduler
            ref="scheduler"
            v-bind="schedulerConfig"
            @datachange="syncData"
        />
    </div>
</template>

<script>
import { BryntumScheduler } from "@bryntum/scheduler-vue";
import { schedulerConfig } from "./AppConfig.js";

export default {
    name: "App",

    components: { BryntumScheduler },

    methods: {
        syncData({ store, action, records }) {
            console.log(`${store.id} changed. The action was: ${action}. Changed records: `, records);
            // Your sync data logic comes here
        }
    },

    data() {
        return { schedulerConfig };
    }
};
</script>

```

## Features

Features are suffixed with `Feature` and act as both configs and properties for `BryntumGanttComponent`.
They are mapped to the corresponding API features of the Bryntum Gantt `instance`.

This is a list of all `BryntumGanttComponent` features:

|Wrapper feature name|API feature reference |
|--------------------|----------------------|
| baselinesFeature | [Baselines](#Gantt/feature/Baselines) |
| cellEditFeature | [CellEdit](#Gantt/feature/CellEdit) |
| cellMenuFeature | [CellMenu](#Grid/feature/CellMenu) |
| cellTooltipFeature | [CellTooltip](#Grid/feature/CellTooltip) |
| columnAutoWidthFeature | [ColumnAutoWidth](#Grid/feature/ColumnAutoWidth) |
| columnDragToolbarFeature | [ColumnDragToolbar](#Grid/feature/ColumnDragToolbar) |
| columnLinesFeature | [ColumnLines](#Scheduler/feature/ColumnLines) |
| columnPickerFeature | [ColumnPicker](#Grid/feature/ColumnPicker) |
| columnReorderFeature | [ColumnReorder](#Grid/feature/ColumnReorder) |
| columnResizeFeature | [ColumnResize](#Grid/feature/ColumnResize) |
| criticalPathsFeature | [CriticalPaths](#Gantt/feature/CriticalPaths) |
| dependenciesFeature | [Dependencies](#Gantt/feature/Dependencies) |
| dependencyEditFeature | [DependencyEdit](#SchedulerPro/feature/DependencyEdit) |
| eventFilterFeature | [EventFilter](#Scheduler/feature/EventFilter) |
| excelExporterFeature | [ExcelExporter](#Grid/feature/experimental/ExcelExporter) |
| filterFeature | [Filter](#Grid/feature/Filter) |
| filterBarFeature | [FilterBar](#Grid/feature/FilterBar) |
| groupFeature | [Group](#Grid/feature/Group) |
| groupSummaryFeature | [GroupSummary](#Grid/feature/GroupSummary) |
| headerMenuFeature | [HeaderMenu](#Grid/feature/HeaderMenu) |
| headerZoomFeature | [HeaderZoom](#Scheduler/feature/HeaderZoom) |
| indicatorsFeature | [Indicators](#Gantt/feature/Indicators) |
| labelsFeature | [Labels](#Gantt/feature/Labels) |
| mergeCellsFeature | [MergeCells](#Grid/feature/MergeCells) |
| mspExportFeature | [MspExport](#Gantt/feature/export/MspExport) |
| multipageFeature | [MultiPageExporter](#Gantt/feature/export/exporter/MultiPageExporter) |
| multipageverticalFeature | [MultiPageVerticalExporter](#Gantt/feature/export/exporter/MultiPageVerticalExporter) |
| nonWorkingTimeFeature | [NonWorkingTime](#Scheduler/feature/NonWorkingTime) |
| panFeature | [Pan](#Scheduler/feature/Pan) |
| parentAreaFeature | [ParentArea](#Gantt/feature/ParentArea) |
| pdfExportFeature | [PdfExport](#Gantt/feature/export/PdfExport) |
| percentBarFeature | [PercentBar](#SchedulerPro/feature/PercentBar) |
| progressLineFeature | [ProgressLine](#Gantt/feature/ProgressLine) |
| projectLinesFeature | [ProjectLines](#Gantt/feature/ProjectLines) |
| quickFindFeature | [QuickFind](#Grid/feature/QuickFind) |
| regionResizeFeature | [RegionResize](#Grid/feature/RegionResize) |
| rollupsFeature | [Rollups](#Gantt/feature/Rollups) |
| rowCopyPasteFeature | [RowCopyPaste](#Grid/feature/RowCopyPaste) |
| rowReorderFeature | [RowReorder](#Grid/feature/RowReorder) |
| scheduleMenuFeature | [ScheduleMenu](#Scheduler/feature/ScheduleMenu) |
| scheduleTooltipFeature | [ScheduleTooltip](#Scheduler/feature/ScheduleTooltip) |
| searchFeature | [Search](#Grid/feature/Search) |
| singlepageFeature | [SinglePageExporter](#Gantt/feature/export/exporter/SinglePageExporter) |
| sortFeature | [Sort](#Grid/feature/Sort) |
| stickyCellsFeature | [StickyCells](#Grid/feature/StickyCells) |
| stripeFeature | [Stripe](#Grid/feature/Stripe) |
| summaryFeature | [Summary](#Gantt/feature/Summary) |
| taskCopyPasteFeature | [TaskCopyPaste](#Gantt/feature/TaskCopyPaste) |
| taskDragFeature | [TaskDrag](#Gantt/feature/TaskDrag) |
| taskDragCreateFeature | [TaskDragCreate](#Gantt/feature/TaskDragCreate) |
| taskEditFeature | [TaskEdit](#Gantt/feature/TaskEdit) |
| taskMenuFeature | [TaskMenu](#Gantt/feature/TaskMenu) |
| taskResizeFeature | [TaskResize](#Gantt/feature/TaskResize) |
| taskTooltipFeature | [TaskTooltip](#Gantt/feature/TaskTooltip) |
| timeAxisHeaderMenuFeature | [TimeAxisHeaderMenu](#Scheduler/feature/TimeAxisHeaderMenu) |
| timeRangesFeature | [TimeRanges](#Scheduler/feature/TimeRanges) |
| treeFeature | [Tree](#Grid/feature/Tree) |
| treeGroupFeature | [TreeGroup](#Gantt/feature/TreeGroup) |

## Bryntum Gantt API instance

It is important to know that the Vue `BryntumGanttComponent` is **not** the native Bryntum Gantt instance, it
is a wrapper or an interface between the Vue application and the Bryntum Gantt itself.

All available configs, properties and features are propagated from the wrapper down to the underlying Bryntum Gantt
instance, but there might be the situations when you want to access the Bryntum Gantt directly. That is fully valid
approach and you are free to do it.

### Accessing the Bryntum Gantt instance (Vue 2)

If you need to access Bryntum Gantt functionality not exposed by the wrapper, you can access the Bryntum Gantt instance
directly. Within the **Vue 2** wrapper it is available under the `instance` property.

This simple example shows how you could use it:

App.vue
```html
<template>
    <bryntum-gantt ref="gantt" v-bind="ganttConfig" />
</template>

<script>
// Bryntum Gantt and its config
import { BryntumGantt } from '@bryntum/gantt-vue';
import { ganttConfig } from './GanttConfig';
import './components/ColorColumn.js';

// App
export default {
    name: 'App',

    // local components
    components: {
        BryntumGantt
    },

    data() {
        return { ganttConfig };
    },

    methods: {
        doSomething() {
            // Reference to Bryntum Gantt instance
            const ganttInstance = this.$refs.gantt.instance;
        }
    }
};
</script>

<style lang="scss">
@import './App.scss';
</style>
```

When accessing `instance` directly, use wrapper's API widget reference docs from the list above to get available
configs and properties.

### Accessing the Bryntum Gantt instance (Vue 3)

If you need to access Bryntum Gantt functionality not exposed by the wrapper, you can access the Bryntum Gantt instance
directly. Within the **Vue 3** wrapper it is available under the `instance.value` property.

This simple example shows how you could use it:

App.vue
```html
<template>
    <bryntum-gantt ref="gantt" v-bind="ganttConfig" />
</template>

<script>
// vue imports
import { ref, reactive } from 'vue';

// Bryntum Gantt and its config
import { BryntumGantt } from '@bryntum/gantt-vue-3';
import { useGanttConfig } from './GanttConfig';
import './components/ColorColumn.js';

// App
export default {
    name: 'App',

    // local components
    components: {
        BryntumGantt
    },

    setup() {
        const gantt = ref(null);
        const ganttConfig = reactive(useGanttConfig());

        doSomething() {
            // Reference to Bryntum Gantt instance
            const ganttInstance = gantt.value.instance.value;
        }

        return {
            gantt,
            ganttConfig,
            doSomething
        };
    },
};
</script>

<style lang="scss">
@import './App.scss';
</style>
```

When accessing `instance` directly, use wrapper's API widget reference docs from the list above to get available
configs and properties.

## Troubleshooting

### Installing, building or running

If you face any issues building or running examples or your application, such issues can be often resolved by the
Project Cleanup procedure which is described in this
[Troubleshooting guide](#Gantt/guides/npm-repository.md#troubleshooting)

### Transpiling dependencies
If you use Vue CLI, you can also try adding the following to your `vue.config.js`:

```javascript
module.exports = {
...
    transpileDependencies: [
        '@bryntum/gantt'
    ],
};
```

### Custom Configurations

[Vue CLI](https://cli.vuejs.org/) is the default tooling for creating, developing and managing Vue applications so it
has been chosen for our examples. It also provides an abstraction level between the application and Webpack and easy
configurability of the project through `vue.config.js` file.

While this approach would be best in majority of cases, you can still have a custom Webpack configuration that is not
managed by Vue CLI. Although it is not feasible for us to support all possible custom configurations we have some
guidelines to make the Bryntum Calendar integration easier and smoother.

If you face any issues, executing one or more of the following steps should resolve the problem.

### Add or edit `.eslintignore` file

It may also be necessary to ignore linter for some files. If you do not have `.eslintignore` in your project root create
it (edit it otherwise) so that it has at least the following content:

```javascript
gantt.module.js
```

## JavaScript heap out of memory

"JavaScript heap out of memory" error occurs on large projects where the default amount of memory allocated by node 
is not sufficient to complete the command successfully.

You can increase this amount by running the following command:

**For Linux/macOS:**

```shell
export NODE_OPTIONS=--max-old-space-size=8192
```

**For Windows powershell:**

```shell
$env:NODE_OPTIONS="--max-old-space-size=8192"
```

Alternatively you can increase the amount of memory by adding the following
`NODE_OPTIONS='--max-old-space-size=8192'` config to `scripts` section in **package.json** file:

**For example change used build script:**

```json
{
  "scripts": {
    "build": "your-build-script"
  }
}
```

**to:**

```json
{
  "scripts": {
    "build": "cross-env NODE_OPTIONS='--max-old-space-size=8192' your-build-script"
  }
}
```

To apply this environment config you need `cross-env` npm library which can be installed to devDependencies with:

```shell
nmp install cross-env --save-dev
```

## References

* Config options, features, events and methods [Bryntum Gantt API docs](#api)
* Visit [Vue Framework Homepage](https://vuejs.org)
* Post your questions to [Bryntum Support Forum](https://bryntum.com/forum/)
* [Contacts us](https://bryntum.com/contact/)


<p class="last-modified">Last modified on 2022-03-04 10:05:06</p>