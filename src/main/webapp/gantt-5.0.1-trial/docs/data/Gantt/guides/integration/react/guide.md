<h1 class="title-with-image"><img src="Core/logo/react.svg"
alt="Bryntum Gantt supports React"/>Using Bryntum Gantt with React</h1>

## Bryntum NPM repository access

Please refer to this [guide for Bryntum NPM repository access](#Gantt/guides/npm-repository.md).

## Bryntum Gantt

Bryntum Gantt itself is framework agnostic, but ships with demos and wrappers to simplify using it with popular frameworks
such as React. The purpose of this guide is to give a basic introduction on how to use Bryntum Gantt with React.

Bryntum Gantt is integrated to React applications using the provided wrappers.

### The React wrappers

The wrappers encapsulate Bryntum Gantt and other Bryntum widgets in React components that expose configuration
options, properties, features and events. The wrapped Bryntum components are then used the usual React way.

## View online demos

Bryntum Gantt demos can be viewed in our
[online example browser](https://bryntum.com/examples/gantt/#Integration/React).

## Build and run local demos

React demos are located in **examples/frameworks/react** folder inside distribution zip.

Trial distribution zip can be requested from [https://bryntum.com](https://bryntum.com/products/gantt)
by clicking **Free Trial** button. Licensed distribution zip is located at
[Bryntum Customer Zone](https://customerzone.bryntum.com).

Each demo contains bundled `README.md` file in demo folder with build and run instructions.

You may run them either in development mode or built for production. They have been created using
[create-react-app](https://github.com/facebook/create-react-app) script so that they can be run locally by running:

```shell
$ npm install
$ npm run start
```

That starts a local server accessible at [http://localhost:3000](http://localhost:3000). If
you modify the example code while running it locally it is automatically rebuilt and updated in the browser allowing you
to see your changes immediately.

The production version of an example, or your application, is built by running:

```shell
$ npm install
$ npm run build
```

The built version is then located in `build` sub-folder which contains the compiled code that can be deployed to your
production server.

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

### Installing the wrappers package

The wrappers are implemented in a separate package `@bryntum/gantt-react` that is installed according to the used
package manager. Please refer to this [guide for Bryntum NPM repository access](#Gantt/guides/npm-repository.md).

To use native API package classes with wrappers import them from `@bryntum/gantt`.

```javascript
import { Gantt } from '@bryntum/gantt';
```

### Wrappers Overview

Wrappers are React components which provide full access to Bryntum API widget class configs, properties, events and
features. Each Wrapper has it's own tag which can be used in React JSX code. This is the list of available wrappers for
Bryntum Gantt React package.

| Wrapper name | API widget reference |
|--------------|----------------------|
| &lt;BryntumAssignmentField/&gt; | [AssignmentField](#Gantt/widget/AssignmentField) |
| &lt;BryntumAssignmentGrid/&gt; | [AssignmentGrid](#Gantt/widget/AssignmentGrid) |
| &lt;BryntumButton/&gt; | [Button](#Core/widget/Button) |
| &lt;BryntumButtonGroup/&gt; | [ButtonGroup](#Core/widget/ButtonGroup) |
| &lt;BryntumCalendarField/&gt; | [CalendarField](#SchedulerPro/widget/CalendarField) |
| &lt;BryntumCalendarPicker/&gt; | [CalendarPicker](#Gantt/widget/CalendarPicker) |
| &lt;BryntumCheckbox/&gt; | [Checkbox](#Core/widget/Checkbox) |
| &lt;BryntumChipView/&gt; | [ChipView](#Core/widget/ChipView) |
| &lt;BryntumCombo/&gt; | [Combo](#Core/widget/Combo) |
| &lt;BryntumConstraintTypePicker/&gt; | [ConstraintTypePicker](#SchedulerPro/widget/ConstraintTypePicker) |
| &lt;BryntumContainer/&gt; | [Container](#Core/widget/Container) |
| &lt;BryntumCycleResolutionPopup/&gt; | [CycleResolutionPopup](#SchedulerPro/widget/CycleResolutionPopup) |
| &lt;BryntumDateField/&gt; | [DateField](#Core/widget/DateField) |
| &lt;BryntumDatePicker/&gt; | [DatePicker](#Core/widget/DatePicker) |
| &lt;BryntumDateTimeField/&gt; | [DateTimeField](#Core/widget/DateTimeField) |
| &lt;BryntumDependencyField/&gt; | [DependencyField](#Gantt/widget/DependencyField) |
| &lt;BryntumDependencyTypePicker/&gt; | [DependencyTypePicker](#SchedulerPro/widget/DependencyTypePicker) |
| &lt;BryntumDisplayField/&gt; | [DisplayField](#Core/widget/DisplayField) |
| &lt;BryntumDurationField/&gt; | [DurationField](#Core/widget/DurationField) |
| &lt;BryntumEffortField/&gt; | [EffortField](#SchedulerPro/widget/EffortField) |
| &lt;BryntumEndDateField/&gt; | [EndDateField](#SchedulerPro/widget/EndDateField) |
| &lt;BryntumFileField/&gt; | [FileField](#Core/widget/FileField) |
| &lt;BryntumFilePicker/&gt; | [FilePicker](#Core/widget/FilePicker) |
| &lt;BryntumFilterField/&gt; | [FilterField](#Core/widget/FilterField) |
| &lt;BryntumGantt/&gt; | [Gantt](#Gantt/view/Gantt) |
| &lt;BryntumGanttBase/&gt; | [GanttBase](#Gantt/view/GanttBase) |
| &lt;BryntumGanttTaskEditor/&gt; | [GanttTaskEditor](#SchedulerPro/widget/GanttTaskEditor) |
| &lt;BryntumGrid/&gt; | [Grid](#Grid/view/Grid) |
| &lt;BryntumGridBase/&gt; | [GridBase](#Grid/view/GridBase) |
| &lt;BryntumList/&gt; | [List](#Core/widget/List) |
| &lt;BryntumMenu/&gt; | [Menu](#Core/widget/Menu) |
| &lt;BryntumModelCombo/&gt; | [ModelCombo](#SchedulerPro/widget/ModelCombo) |
| &lt;BryntumNumberField/&gt; | [NumberField](#Core/widget/NumberField) |
| &lt;BryntumPagingToolbar/&gt; | [PagingToolbar](#Core/widget/PagingToolbar) |
| &lt;BryntumPanel/&gt; | [Panel](#Core/widget/Panel) |
| &lt;BryntumPasswordField/&gt; | [PasswordField](#Core/widget/PasswordField) |
| &lt;BryntumProjectCombo/&gt; | [ProjectCombo](#Scheduler/widget/ProjectCombo) |
| &lt;BryntumRadio/&gt; | [Radio](#Core/widget/Radio) |
| &lt;BryntumRadioGroup/&gt; | [RadioGroup](#Core/widget/RadioGroup) |
| &lt;BryntumResourceCombo/&gt; | [ResourceCombo](#Scheduler/widget/ResourceCombo) |
| &lt;BryntumResourceFilter/&gt; | [ResourceFilter](#Scheduler/widget/ResourceFilter) |
| &lt;BryntumResourceHistogram/&gt; | [ResourceHistogram](#SchedulerPro/view/ResourceHistogram) |
| &lt;BryntumResourceUtilization/&gt; | [ResourceUtilization](#SchedulerPro/view/ResourceUtilization) |
| &lt;BryntumScheduler/&gt; | [Scheduler](#Scheduler/view/Scheduler) |
| &lt;BryntumSchedulerBase/&gt; | [SchedulerBase](#Scheduler/view/SchedulerBase) |
| &lt;BryntumSchedulerDatePicker/&gt; | [SchedulerDatePicker](#Scheduler/widget/SchedulerDatePicker) |
| &lt;BryntumSchedulerPro/&gt; | [SchedulerPro](#SchedulerPro/view/SchedulerPro) |
| &lt;BryntumSchedulerProBase/&gt; | [SchedulerProBase](#SchedulerPro/view/SchedulerProBase) |
| &lt;BryntumSchedulerTaskEditor/&gt; | [SchedulerTaskEditor](#SchedulerPro/widget/SchedulerTaskEditor) |
| &lt;BryntumSchedulingIssueResolutionPopup/&gt; | [SchedulingIssueResolutionPopup](#SchedulerPro/widget/SchedulingIssueResolutionPopup) |
| &lt;BryntumSchedulingModePicker/&gt; | [SchedulingModePicker](#SchedulerPro/widget/SchedulingModePicker) |
| &lt;BryntumSlider/&gt; | [Slider](#Core/widget/Slider) |
| &lt;BryntumSlideToggle/&gt; | [SlideToggle](#Core/widget/SlideToggle) |
| &lt;BryntumSplitter/&gt; | [Splitter](#Core/widget/Splitter) |
| &lt;BryntumStartDateField/&gt; | [StartDateField](#SchedulerPro/widget/StartDateField) |
| &lt;BryntumTabPanel/&gt; | [TabPanel](#Core/widget/TabPanel) |
| &lt;BryntumTaskEditor/&gt; | [TaskEditor](#Gantt/widget/TaskEditor) |
| &lt;BryntumTextAreaField/&gt; | [TextAreaField](#Core/widget/TextAreaField) |
| &lt;BryntumTextAreaPickerField/&gt; | [TextAreaPickerField](#Core/widget/TextAreaPickerField) |
| &lt;BryntumTextField/&gt; | [TextField](#Core/widget/TextField) |
| &lt;BryntumTimeField/&gt; | [TimeField](#Core/widget/TimeField) |
| &lt;BryntumTimeline/&gt; | [Timeline](#SchedulerPro/widget/Timeline) |
| &lt;BryntumTimePicker/&gt; | [TimePicker](#Core/widget/TimePicker) |
| &lt;BryntumToolbar/&gt; | [Toolbar](#Core/widget/Toolbar) |
| &lt;BryntumTrialButton/&gt; | [TrialButton](#Core/widget/trial/TrialButton) |
| &lt;BryntumUndoRedo/&gt; | [UndoRedo](#Scheduler/widget/UndoRedo) |
| &lt;BryntumWidget/&gt; | [Widget](#Core/widget/Widget) |

### Using the wrapper in your application

The wrapper defines a React component named `BryntumGantt`. You can use it the same way as you would use other React
components. For example:

Sample code for `App.js`:

```javascript
import React from 'react';
import { BryntumGantt } from '@bryntum/gantt-react';
import { ganttConfig } from './AppConfig'

export const App = () => {
    return (
        <BryntumGantt
            {...ganttConfig}
            // other props, event handlers, etc
        />
    );
}
```

Sample code for `AppConfig.js`:

```javascript
export const ganttConfig =  {
    tooltip : "My cool Bryntum Gantt component",
    // Bryntum Gantt config options
};
```

### Embedding widgets inside wrapper

Wrappers are designed to allow using Bryntum widgets as React components, but they themselves cannot contain other
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
used by the wrapper have it disabled by default). This allows two-way binding to work out of the box.
Without `syncDataOnLoad`, each change to state would apply the bound data as a completely new dataset.
With `syncDataOnLoad`, the new state is instead compared to the old, and the differences are applied.

## Rendering React components in column cells

Bryntum Gantt column already supports a [renderer](#Grid/column/Column#config-renderer) configuration option which is
a function that receives parameters used as inputs to compose the resulting html. Any kind of conditional complex logic
can be used to prepare visually rich cell contents.

If you have a React component that implements the desired cell visualization, it is possible to use it by using regular
JSX which references your React components from the cell renderer. The support is implemented in the `BryntumGantt`
wrapper therefore the wrapper must be used for the JSX renderers to work.

### Using simple inline JSX

Using inline JSX is as simple as the following:

```javascript
renderer: ({ value }) => <CustomComponent>{value}</CustomComponent>
```

If you also need to access other data fields or pass them into the React component, you can do it this way:

```javascript
renderer: (renderData) => {
  return(
    <CustomComponent dataProperty={renderData} ><b>{renderData.value}</b>/{renderData.record.city}</CustomComponent>
  );
}
```

<div class="note">
Mind please that the above functions return html-like markup without quotes. That makes the return value JSX and it is
understood and processed as such. If you enclose the markup in quotes it will not work
</div>

### Using a custom React component

It is similarly simple. Let's have the following simple component:

```javascript
import React from 'react';

const DemoButton = props => {
    return <button {...props}>{props.text}</button>;
};

```

The renderer then could be:

```javascript
import DemoButton from '../components/DemoButton';

handleCellButtonClick = (record) => {
    alert('Go ' + record.team + '!');
};

return (
  <BryntumGantt
    // Columns
    columns = {[
      {
        // Using custom React component
        renderer : ({ record }) =>
          <DemoButton
            text = {'Go ' + record.team + '!'}
            onClick = {() => handleCellButtonClick(record)}
          />,
        // other column props,
      },
      // ... other columns
    ]}
    // ... other BryntumGantt props
  />
);
```

The column `renderer` function above is expected to return JSX, exactly same as in the case of simple inline JSX, but
here it returns imported `DemoButton` component. The `renderer` also passes the mandatory props down to the component so
that it can render itself in the correct row context.

## Configs, properties and events

All Bryntum React Wrappers support the full set of the public configs, properties and events of a component.

### Listening to BryntumGantt events

The conventional React way is used to listen to Bryntum Gantt events. For example, if we want to listen
to `selectionChange` event we pass the listener function to `onSelectionChange` property. The property name must be
camel case and is case sensitive.

```javascript
const selectionChangeHandler = useCallback(({ selection }) => {
    console.log(selection); // actual logic comes here
});

// ...

return (
    <BryntumGantt
        onSelectionChange={selectionChangeHandler}
        // other properties
    />
)
```
### Using dataChange event to synchronize data

Bryntum Gantt keeps all data in its stores which are automatically synchronized with the UI and the user actions.
Nevertheless, it is sometimes necessary for the rest of the application to be informed about data changes. For that
it is easiest to use `dataChange` event.

```javascript
const App = props => {
    const syncData = ({ store, action, records }) => {
        console.log(`${store.id} changed. The action was: ${action}. Changed records: `, records);
        // Your sync data logic comes here
    }

    return (
        <Scheduler
            {...schedulerConfig}
            onDataChange={syncData}
            ref={schedulerRef}
        />
    )
}
```

You can find details of all events that are fired by `BryntumGantt` in
the [API documentation](https://bryntum.com/docs/gantt/api/Gantt/view/Gantt#events).

## Features

Features are suffixed with `Feature` and act as both configs and properties for `BryntumGanttComponent`. They are
mapped to the corresponding API features of the `instance`.

This is a list of all `BryntumGantt` features:

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

## The native Bryntum Gantt instance

It is important to know that the React component that we may even call "gantt" is _not_ the native Bryntum Gantt
instance, it is a wrapper or an interface between the React application and the Bryntum Gantt itself.

The properties and features are propagated from the wrapper down to the underlying Bryntum Gantt instance but there
might be the situations when you want to access the Bryntum Gantt directly. That is fully valid approach and you are
free to do it.

### Accessing the Bryntum Gantt instance

If you need to access Bryntum Gantt instance, you can do like this:

```javascript
const ganttRef = useRef();

useEffect(()=>{
  // the instance is available as
  console.log(ganttRef.current.instance);
},[])

return <BryntumGantt ref={ganttRef} {...ganttConfig} />
```

## Using Bryntum Gantt themes

For the scheduler styling you must also import a CSS file that contains a theme for Bryntum Gantt. There are
two main ways of importing the theme.

### Using single theme

The easiest way is to import the CSS file in your `App.js` or in `App.scss`.

In `App.js` you would import **one** of the following:

```javascript
import '@bryntum/gantt/gantt.classic-dark.css';
import '@bryntum/gantt/gantt.classic-light.css';
import '@bryntum/gantt/gantt.classic.css';
import '@bryntum/gantt/gantt.material.css';
import '@bryntum/gantt/gantt.stockholm.css';
```

The syntax is slightly different in `App.scss`; use **one** of the following:

```scss
@import '~@bryntum/gantt/gantt.classic-dark.css';
@import '~@bryntum/gantt/gantt.classic-light.css';
@import '~@bryntum/gantt/gantt.classic.css';
@import '~@bryntum/gantt/gantt.material.css';
@import '~@bryntum/gantt/gantt.stockholm.css';
```

<div class="note">
Importing theme in <b>App.scss</b> file is recommended because this way we keep all styling-related code together in one
file
</div>

### Selecting from multiple themes

Theme switching can be implemented with the help of the `<BryntumThemeCombo />` component. It has to be imported
as any other component before it is used, for example:

```javascript
import { BryntumThemeCombo, } from '@bryntum/scheduler-react';

// ... other code

return (
    // ... other components
    <BryntumThemeCombo />
    // ... other components
);

```

CSS and fonts files that contain themes must be accessible by the server in any subdirectory of the public server
root in `themes` and `themes/fonts`. The easiest way of putting them there is to copy the files automatically during
`postinstall` process in `package.json`:

```json
  "scripts": {
    "postinstall": "postinstall"
  },
  "postinstall": {
    "node_modules/@bryntum/gantt/*.css": "copy public/themes/",
    "node_modules/@bryntum/gantt/fonts": "copy public/themes/fonts"
  },
  "devDependencies": {
    "postinstall": "~0.7.0"
  }
},
```

<div class="note">
Use <b>npm install --save-dev postinstall</b> to install the required <b>postinstall</b> package or add it manually to
<b>package.json</b>
</div>

The last part is to add the default theme link to the head of `public/index.html`:

```html
<head>
  <link
    rel="stylesheet"
  	href="%PUBLIC_URL%/themes/gantt.stockholm.css"
  	id="bryntum-theme"
  />
</head>
```

<div class="note">
<b>id="bryntum-theme"</b> is mandatory because <b>BryntumThemeCombo</b> relies on it
</div>

<div class="note">
If you adjust location of themes and fonts, adjust it in both <b>package.json</b> and in <b>index.html</b>, for example
<b>my-resources/themes/</b> and <b>my-resources/themes/fonts</b>. No other configuration is needed
</div>

## Loading components dynamically with Next.js

Bryntum components are client-side only, they do not support server-side rendering. Therefore they must be loaded with
`ssr` turned off. Furthermore, the life cycle of dynamically loaded components is different from normal React
components hence the following steps are needed.

The `BryntumGantt` must be wrapped in another component so that React `refs` will continue to work. To implement it
create a folder outside of Next.js `pages`, for example `components`, and put this extra wrapper there.

Sample code for `components/Gantt.js`:

```javascript
/**
 * A simple wrap around BryntumGantt for ref to work
 */
import { BryntumGantt } from '@bryntum/gantt-react';

export default function Gantt({ganttRef, ...props }) {
    return <BryntumGantt {...props} ref={ganttRef} />
}
```

The above component then can be loaded dynamically with this code:

```javascript
import dynamic from "next/dynamic";
import { useRef } from 'react';

const Gantt = dynamic(
  () => import("../components/Gantt.js"), {ssr: false}
);

const MyComponent = () => {
  const ganttRef = useRef();

  const clickHandler = function(e) {
    // This will log the Bryntum Gantt native instance after it has been loaded
    console.log(ganttRef.current?.instance);
  }

  return (
    <>
      <button onClick={clickHandler}>ref test</button>
      <Gantt
        ganttRef={ganttRef}
        // other props
      />
    </>
```

## CRA performance

CRA scripts by default use `@babel/plugin-transform-runtime` plugin to transpile application's `*.js` library
dependencies. This affects React application performance, which is seriously degraded due to heavy usage of `async`
functions in the Bryntum API.

### Workaround

We offer an updated babel preset `@bryntum/babel-preset-react-app` npm package for CRA scripts to solve this issue.
Patch details can be found inside package `@bryntum/babel-preset-react-app/readme-bryntum.md`.

Add this package alias to your application's `package.json` in `devDependencies`:

```json
  "devDependencies": {
    "babel-preset-react-app": "npm:@bryntum/babel-preset-react-app"
  }
```

Or install with command line:

```shell
npm i --save-dev babel-preset-react-app@npm:@bryntum/babel-preset-react-app
```

Use `browserlist` option to enable most modern browsers babel configuration in app's `package.json`:

```json
     "browserslist": {
       "production": [
         "last 1 chrome version",
         "last 1 firefox version",
         "last 1 safari version"
       ]
     }
```

### CRA references

* [Original CRA scripts](https://github.com/facebook/create-react-app)
* [Alternatives to Ejecting](https://create-react-app.dev/docs/alternatives-to-ejecting)
* Customizing create-react-app: [How to Configure CRA](https://auth0.com/blog/how-to-configure-create-react-app)

## Best practices

There are many possible ways of creating and building React applications ranging from the recommended default way of
using [Create React App](https://create-react-app.dev/) scripts through applications initially created with Create React
App but ejected later, up to very custom setups using Webpack or another packager and manually created application.

We used Create React App to create all our React examples and it has proven to be the simples, most compatible and most
reliable way of using Bryntum Gantt in a React application.

The broad steps are as follows:

* Download the Bryntum Gantt, trial or full version depending on your license
* Use `npx create-react-app bryntum-demo` to create a basic empty React application
* Install `@bryntum/gantt-react` package according to section **Install Bryntum Gantt npm package** above
* Optional: Copy `BryntumGantt.js` wrapper
* Import and use the `BryntumGantt` in the application
* Import a Bryntum Gantt CSS file, for example `gantt.stockholm.css` to achieve the proper Bryntum Gantt look

Our examples also use resources from `@bryntum/demo-resources`, for example `example.scss`, fonts and images that are
used to style demo's header, logo, etc. These are generally not needed in your application because you have different
logo, colors, layout of header, etc.

We recommend to use the above procedure and create the application from scratch but if you take our demo as the basis,
do not forget to clean it up from imports, resources, css files and rules that are not needed.

Also we do not recommend to copy the downloaded and unzipped Bryntum Gantt to your project tree not only because it would
bloat the size but mainly because it can fool the IDE to propose auto-imports from the wrong places.

If you decide to copy the files from Bryntum download to your project, always copy selectively only the source files you
need, not the whole distribution.

Please consult Custom Configurations section below if your project has not been created with Create React App.

## Troubleshooting

### Installing, building or running

If you face any issues building or running examples or your application, such issues can be often resolved by the
Project Cleanup procedure which is described in this
[Troubleshooting guide](#Gantt/guides/npm-repository.md#troubleshooting)

### Bryntum bundle included twice

The error `Bundle included twice` usually means that somewhere you have imported both the normal and UMD versions of the
Bryntum Gantt package. Inspect the code and import either UMD or normal version of the Bryntum Gantt but not both.
Bryntum Gantt wrapper uses normal version: `@bryntum/gantt`.

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
* Visit [React Framework Homepage](https://reactjs.org)
* Post your questions to [Bryntum Support Forum](https://bryntum.com/forum/)
* [Contacts us](https://bryntum.com/contact/)


<p class="last-modified">Last modified on 2022-03-04 10:05:06</p>