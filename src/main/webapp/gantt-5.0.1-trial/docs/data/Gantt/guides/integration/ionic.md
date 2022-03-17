<h1 class="title-with-image"><img src="Core/logo/ionic.svg" alt="Bryntum Gantt supports Ionic"/>
Using Bryntum Gantt with Ionic</h1>

## Bryntum NPM repository access

Please refer to this [guide for Bryntum NPM repository access](#Gantt/guides/npm-repository.md).

## Ionic with Angular

The guide below references to using Ionic Framework for building application based on Angular.

## Bryntum Gantt

The Bryntum Gantt itself is framework agnostic, but it ships with demos and wrappers to simplify its use with popular
frameworks such as Ionic. The purpose of this guide is to give you a basic introduction on how to use Bryntum Gantt
with Ionic.

## View online demos

Bryntum Gantt Ionic demos can be viewed in our
[online example browser](https://bryntum.com/examples/gantt/#Integration/Ionic).

## Build and run local demos

Ionic demos are located in **examples/frameworks/ionic** folder
inside distribution zip.

Trial distribution zip can be requested from [https://bryntum.com](https://bryntum.com/products/gantt)
by clicking **Free Trial** button. Licensed distribution zip is located at
[Bryntum Customer Zone](https://customerzone.bryntum.com).

Each demo contains bundled `README.md` file in demo folder with build and run instructions.

To view and run an example locally in development mode, you can use the following commands:

```shell
$ npm install
$ npm run start
```

That starts a local server accessible at [http://localhost:4200"](http://localhost:4200). If
you modify the example code while running it locally it is automatically rebuilt and updated in the browser allowing you
to see your changes immediately.

The production version of an example, or your application, is built by running:

```shell
$ npm install
$ npm run build
```

The built version is then located in `dist` sub-folder which contains the compiled code that can be deployed to your
production server.

## Install Ionic framework

Installation and API documentation can be found at the Ionic project's page https://ionicframework.com/.

Install the Ionic CLI globally with npm:

```shell
$ npm install -g ionic
```

The -g means it is a global install. For Windows it is recommended to open an Admin command prompt. For Mac/Linux, run
the command with sudo.

## Create Ionic app

Create an App:

```shell
$ ionic start IonicApp blank
```

`blank` is a common starter template for the app.

Run the App:

```shell
$ cd IonicApp
$ ionic serve
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

The Ionic wrappers encapsulate Bryntum Gantt and other Bryntum widgets in Ionic components that expose configuration
options, properties, features and events. The wrapped all Bryntum UI components so they can be used the usual Ionic way.

To use native API package classes with wrappers import them from `@bryntum/gantt/gantt.lite.umd.js`.

```typescript
import { Gantt } from '@bryntum/gantt/gantt.lite.umd.js';
```

### Installing the wrappers package

The wrappers are distributed as a separate package `@bryntum/gantt-angular` that is installed according to the used
package manager. Please refer to this [guide for Bryntum NPM repository access](#Gantt/guides/npm-repository.md).

### Wrappers Overview

Wrappers are Ionic components which provide full access to Bryntum API widget class configs, properties, events and
features. Each Wrapper has it's own HTML tag which can be used in ionic templates. This is the list of available
wrappers for Bryntum Gantt Ionic package:

| Wrapper tag name | Wrapper component name | API widget reference |
|------------------|------------------------|----------------------|
| &lt;bryntum-assignment-field/&gt; | BryntumAssignmentFieldComponent | [AssignmentField](#Gantt/widget/AssignmentField) |
| &lt;bryntum-assignment-grid/&gt; | BryntumAssignmentGridComponent | [AssignmentGrid](#Gantt/widget/AssignmentGrid) |
| &lt;bryntum-button/&gt; | BryntumButtonComponent | [Button](#Core/widget/Button) |
| &lt;bryntum-button-group/&gt; | BryntumButtonGroupComponent | [ButtonGroup](#Core/widget/ButtonGroup) |
| &lt;bryntum-calendar-field/&gt; | BryntumCalendarFieldComponent | [CalendarField](#SchedulerPro/widget/CalendarField) |
| &lt;bryntum-calendar-picker/&gt; | BryntumCalendarPickerComponent | [CalendarPicker](#Gantt/widget/CalendarPicker) |
| &lt;bryntum-checkbox/&gt; | BryntumCheckboxComponent | [Checkbox](#Core/widget/Checkbox) |
| &lt;bryntum-chip-view/&gt; | BryntumChipViewComponent | [ChipView](#Core/widget/ChipView) |
| &lt;bryntum-combo/&gt; | BryntumComboComponent | [Combo](#Core/widget/Combo) |
| &lt;bryntum-constraint-type-picker/&gt; | BryntumConstraintTypePickerComponent | [ConstraintTypePicker](#SchedulerPro/widget/ConstraintTypePicker) |
| &lt;bryntum-container/&gt; | BryntumContainerComponent | [Container](#Core/widget/Container) |
| &lt;bryntum-cycle-resolution-popup/&gt; | BryntumCycleResolutionPopupComponent | [CycleResolutionPopup](#SchedulerPro/widget/CycleResolutionPopup) |
| &lt;bryntum-date-field/&gt; | BryntumDateFieldComponent | [DateField](#Core/widget/DateField) |
| &lt;bryntum-date-picker/&gt; | BryntumDatePickerComponent | [DatePicker](#Core/widget/DatePicker) |
| &lt;bryntum-date-time-field/&gt; | BryntumDateTimeFieldComponent | [DateTimeField](#Core/widget/DateTimeField) |
| &lt;bryntum-dependency-field/&gt; | BryntumDependencyFieldComponent | [DependencyField](#Gantt/widget/DependencyField) |
| &lt;bryntum-dependency-type-picker/&gt; | BryntumDependencyTypePickerComponent | [DependencyTypePicker](#SchedulerPro/widget/DependencyTypePicker) |
| &lt;bryntum-display-field/&gt; | BryntumDisplayFieldComponent | [DisplayField](#Core/widget/DisplayField) |
| &lt;bryntum-duration-field/&gt; | BryntumDurationFieldComponent | [DurationField](#Core/widget/DurationField) |
| &lt;bryntum-effort-field/&gt; | BryntumEffortFieldComponent | [EffortField](#SchedulerPro/widget/EffortField) |
| &lt;bryntum-end-date-field/&gt; | BryntumEndDateFieldComponent | [EndDateField](#SchedulerPro/widget/EndDateField) |
| &lt;bryntum-file-field/&gt; | BryntumFileFieldComponent | [FileField](#Core/widget/FileField) |
| &lt;bryntum-file-picker/&gt; | BryntumFilePickerComponent | [FilePicker](#Core/widget/FilePicker) |
| &lt;bryntum-filter-field/&gt; | BryntumFilterFieldComponent | [FilterField](#Core/widget/FilterField) |
| &lt;bryntum-gantt/&gt; | BryntumGanttComponent | [Gantt](#Gantt/view/Gantt) |
| &lt;bryntum-gantt-base/&gt; | BryntumGanttBaseComponent | [GanttBase](#Gantt/view/GanttBase) |
| &lt;bryntum-gantt-task-editor/&gt; | BryntumGanttTaskEditorComponent | [GanttTaskEditor](#SchedulerPro/widget/GanttTaskEditor) |
| &lt;bryntum-grid/&gt; | BryntumGridComponent | [Grid](#Grid/view/Grid) |
| &lt;bryntum-grid-base/&gt; | BryntumGridBaseComponent | [GridBase](#Grid/view/GridBase) |
| &lt;bryntum-list/&gt; | BryntumListComponent | [List](#Core/widget/List) |
| &lt;bryntum-menu/&gt; | BryntumMenuComponent | [Menu](#Core/widget/Menu) |
| &lt;bryntum-model-combo/&gt; | BryntumModelComboComponent | [ModelCombo](#SchedulerPro/widget/ModelCombo) |
| &lt;bryntum-number-field/&gt; | BryntumNumberFieldComponent | [NumberField](#Core/widget/NumberField) |
| &lt;bryntum-paging-toolbar/&gt; | BryntumPagingToolbarComponent | [PagingToolbar](#Core/widget/PagingToolbar) |
| &lt;bryntum-panel/&gt; | BryntumPanelComponent | [Panel](#Core/widget/Panel) |
| &lt;bryntum-password-field/&gt; | BryntumPasswordFieldComponent | [PasswordField](#Core/widget/PasswordField) |
| &lt;bryntum-project-combo/&gt; | BryntumProjectComboComponent | [ProjectCombo](#Scheduler/widget/ProjectCombo) |
| &lt;bryntum-radio/&gt; | BryntumRadioComponent | [Radio](#Core/widget/Radio) |
| &lt;bryntum-radio-group/&gt; | BryntumRadioGroupComponent | [RadioGroup](#Core/widget/RadioGroup) |
| &lt;bryntum-resource-combo/&gt; | BryntumResourceComboComponent | [ResourceCombo](#Scheduler/widget/ResourceCombo) |
| &lt;bryntum-resource-filter/&gt; | BryntumResourceFilterComponent | [ResourceFilter](#Scheduler/widget/ResourceFilter) |
| &lt;bryntum-resource-histogram/&gt; | BryntumResourceHistogramComponent | [ResourceHistogram](#SchedulerPro/view/ResourceHistogram) |
| &lt;bryntum-resource-utilization/&gt; | BryntumResourceUtilizationComponent | [ResourceUtilization](#SchedulerPro/view/ResourceUtilization) |
| &lt;bryntum-scheduler/&gt; | BryntumSchedulerComponent | [Scheduler](#Scheduler/view/Scheduler) |
| &lt;bryntum-scheduler-base/&gt; | BryntumSchedulerBaseComponent | [SchedulerBase](#Scheduler/view/SchedulerBase) |
| &lt;bryntum-scheduler-date-picker/&gt; | BryntumSchedulerDatePickerComponent | [SchedulerDatePicker](#Scheduler/widget/SchedulerDatePicker) |
| &lt;bryntum-scheduler-pro/&gt; | BryntumSchedulerProComponent | [SchedulerPro](#SchedulerPro/view/SchedulerPro) |
| &lt;bryntum-scheduler-pro-base/&gt; | BryntumSchedulerProBaseComponent | [SchedulerProBase](#SchedulerPro/view/SchedulerProBase) |
| &lt;bryntum-scheduler-task-editor/&gt; | BryntumSchedulerTaskEditorComponent | [SchedulerTaskEditor](#SchedulerPro/widget/SchedulerTaskEditor) |
| &lt;bryntum-scheduling-issue-resolution-popup/&gt; | BryntumSchedulingIssueResolutionPopupComponent | [SchedulingIssueResolutionPopup](#SchedulerPro/widget/SchedulingIssueResolutionPopup) |
| &lt;bryntum-scheduling-mode-picker/&gt; | BryntumSchedulingModePickerComponent | [SchedulingModePicker](#SchedulerPro/widget/SchedulingModePicker) |
| &lt;bryntum-slider/&gt; | BryntumSliderComponent | [Slider](#Core/widget/Slider) |
| &lt;bryntum-slide-toggle/&gt; | BryntumSlideToggleComponent | [SlideToggle](#Core/widget/SlideToggle) |
| &lt;bryntum-splitter/&gt; | BryntumSplitterComponent | [Splitter](#Core/widget/Splitter) |
| &lt;bryntum-start-date-field/&gt; | BryntumStartDateFieldComponent | [StartDateField](#SchedulerPro/widget/StartDateField) |
| &lt;bryntum-tab-panel/&gt; | BryntumTabPanelComponent | [TabPanel](#Core/widget/TabPanel) |
| &lt;bryntum-task-editor/&gt; | BryntumTaskEditorComponent | [TaskEditor](#Gantt/widget/TaskEditor) |
| &lt;bryntum-text-area-field/&gt; | BryntumTextAreaFieldComponent | [TextAreaField](#Core/widget/TextAreaField) |
| &lt;bryntum-text-area-picker-field/&gt; | BryntumTextAreaPickerFieldComponent | [TextAreaPickerField](#Core/widget/TextAreaPickerField) |
| &lt;bryntum-text-field/&gt; | BryntumTextFieldComponent | [TextField](#Core/widget/TextField) |
| &lt;bryntum-time-field/&gt; | BryntumTimeFieldComponent | [TimeField](#Core/widget/TimeField) |
| &lt;bryntum-timeline/&gt; | BryntumTimelineComponent | [Timeline](#SchedulerPro/widget/Timeline) |
| &lt;bryntum-time-picker/&gt; | BryntumTimePickerComponent | [TimePicker](#Core/widget/TimePicker) |
| &lt;bryntum-toolbar/&gt; | BryntumToolbarComponent | [Toolbar](#Core/widget/Toolbar) |
| &lt;bryntum-trial-button/&gt; | BryntumTrialButtonComponent | [TrialButton](#Core/widget/trial/TrialButton) |
| &lt;bryntum-undo-redo/&gt; | BryntumUndoRedoComponent | [UndoRedo](#Scheduler/widget/UndoRedo) |
| &lt;bryntum-widget/&gt; | BryntumWidgetComponent | [Widget](#Core/widget/Widget) |

### Import BryntumGanttModule

Add the following code to your `app.module.ts`:

```typescript
import { BryntumGanttModule } from '@bryntum/gantt-angular'

@NgModule({
    imports : [
        BryntumGanttModule
    ]
})
```

Then you will be able to use the custom tag like `<bryntum-gantt>` and others listed above the same way as you use
your application components. Our examples are built this way so you can refer to them to see how to use the tag and how
to pass parameters.

### Using the wrapper in your application

Now you can use the the component defined in the wrapper in your application:

```html
<bryntum-gantt
    #gantt
    tooltip="My cool Bryntum Gantt component" ,
    (onCatchAll)="onGanttEvents($event)"
// other configs, properties, events or features
></bryntum-gantt>
```

You will also need to import CSS file for Bryntum Gantt. We recommend to do it in `src/styles.scss`:

```typescript
@import "@bryntum/gantt/gantt.material.css";

// other application-global styling
```

### Embedding widgets inside wrapper

Wrappers are designed to allow using Bryntum widgets as Angular components, but they themselves cannot contain other
Bryntum wrappers inside their tag. To embed Bryntum widgets inside a wrapper you should instead use the available
configuration options for the wrapper's widget. Please note that not all widgets may contain inner widgets, please refer
to the API docs to check for valid configuration options.

This example shows how to use a `Toolbar` widget inside the wrapper for Bryntum Gantt:

Sample code for `app.component.ts`:

```ts
export class AppComponent {

    // Toolbar (tbar) config
    tbarConfig = {
        items : [
            {
                type : 'button',
                text : 'My button'
            }
        ]
    }

}
```

Sample code for `app.component.html`:

```html
<bryntum-gantt
    #gantt
    tbar="tbarConfig",
></bryntum-gantt>
```

## Configs, properties and events

All Bryntum Ionic Wrappers support the full set of the public configs, properties and events of a component.

## Listening to Bryntum Gantt events

The Bryntum Gantt events are passed up to the Angular wrapper which makes it possible to listen to them the standard Angular
way. 

The following code demonstrates listening to the `taskClick` event:

Sample code for `app.component.ts`:

```typescript
export class AppComponent implements AfterViewInit {

    onGanttTaskClick(e : {[key:string] : any}) : void {
        console.log('onTaskClick', e);
    }
    // etc.
```

Sample code for `app.component.html`:

```html
<bryntum-gantt
    #gantt
    (onTaskClick) = "onGanttTaskClick($event)"

```

Please note that we prefix the capitalized event name with the `on` keyword and that we pass `$event` as
the argument to the listener.

Another valid method is to pass a [`listeners`](https://bryntum.com/docs/gantt/api/Core/mixin/Events#config-listeners)
config object to the Angular wrapper. For example:

Sample code for `app.config.ts`:

```typescript
export const ganttConfig = {
    listeners : {
        taskClick(e) {
            console.log('taskClick', e);
        }
    },
    // etc
```

and `app.component.html`:

```html
<bryntum-gantt
    #gantt
    [listeners] = "ganttConfig.listeners"

```

Please note that we use unprefixed event names in this case.

### Using dataChange event to synchronize data

Bryntum Gantt keeps all data in its stores which are automatically synchronized with the UI and the user actions.
Nevertheless, it is sometimes necessary for the rest of the application to be informed about data changes. For that
it is easiest to use `dataChange` event.

`app.component.html`:

```html
<bryntum-gantt
    #gantt
    (onDataChange) = "syncData($event)"

```

`app.component.ts`:

```typescript
export class AppComponent {

    syncData({ store, action, records } : { store : Store; action : String; records : Model[]}) : void {
        console.log(`${store.id} changed. The action was: ${action}. Changed records: `, records);
        // Your sync data logic comes here
    }

    // ...
}
```

## Features

Features are suffixed with `Feature` and act as both configs and properties for `BryntumGanttComponent`. They are
mapped to the corresponding API features of the Bryntum Gantt `instance`.

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

It is important to know that the Ionic `BryntumGanttComponent` is **not** the native Bryntum Gantt instance, it
is a wrapper or an interface between the Ionic application and the Bryntum Gantt itself.

All available configs, properties and features are propagated from the wrapper down to the underlying Bryntum Gantt
instance, but there might be the situations when you want to access the Bryntum Gantt directly. That is fully valid
approach and you are free to do it.

### Accessing the Bryntum Gantt instance

If you need to access Bryntum Gantt functionality not exposed by the wrapper, you can access the Bryntum Gantt instance
directly. Within the wrapper it is available under the `instance` property.

This simple example shows how you could use it:

app.component.html

```html
<ion-header>
...
</ion-header>

<ion-content>
    <gantt
        #gantt
        tooltip = "My cool Bryntum Gantt component"
    ></gantt>
</ion-content>
```

Sample code for `app.component.ts`:

```typescript
import { BryntumGanttComponent } from '@bryntum/gantt-angular';
import { Gantt } from '@bryntum/gantt/gantt.lite.umd.js';

export class AppComponent implements AfterViewInit {

    @ViewChild(BryntumGanttComponent, { static : false }) ganttComponent: BryntumGanttComponent;

    private gantt : Gantt;

    @ViewChild(BryntumGanttComponent, { static : false }) ganttComponent: BryntumGanttComponent;

    ngAfterViewInit(): void {
        // store Bryntum Gantt isntance
        this.gantt = this.ganttComponent.instance;
    }
}
```

When accessing `instance` directly, use wrapper's API widget reference docs from the list above to get available configs
and properties.

## Troubleshooting

### Installing, building or running

If you face any issues building or running examples or your application, such issues can be often resolved by the
Project Cleanup procedure which is described in this
[Troubleshooting guide](#Gantt/guides/npm-repository.md#troubleshooting)

### Bryntum bundle included twice

The error

```text
Bryntum bundle included twice, check cache-busters and file types (.js)
Simultaneous imports from "*.module.js" and "*.umd.js" bundles are not allowed.
```

usually means that somewhere you have imported both the normal and Lite UMD versions of the Bryntum Gantt package. Check
the code and import `gantt.lite.umd.js` version of the Bryntum Gantt.

Wrong import:

```typescript
import { Gantt } from '@bryntum/gantt';
```

Correct import:

```typescript
import { Gantt } from '@bryntum/gantt/gantt.lite.umd.js';
```

### A property added to ganttConfig has no effect

If you have added a new property, for example `listeners` to the configuration object, make sure that you also have
added it to the component template, for example:

```html
<bryntum-gantt>
    [listeners] = "ganttConfig.listeners"
</bryntum-gantt>
```

Angular does not process `ganttConfig` file as a whole but we need to use individual properties in the template.

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
* Visit [Ionic Framework Homepage](https://ionicframework.com)
* Visit [Angular Framework Homepage](https://angular.io)
* Post your questions to [Bryntum Support Forum](https://bryntum.com/forum/)
* [Contacts us](https://bryntum.com/contact/)


<p class="last-modified">Last modified on 2022-03-04 10:05:06</p>