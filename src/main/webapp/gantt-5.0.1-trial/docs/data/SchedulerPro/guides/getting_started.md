# Getting started with Bryntum Scheduler Pro

## Overview

Bryntum Scheduler Pro is a powerful extension of the Scheduler component. It combines the powerful visualisation
capabilities of the Scheduler with the scheduling engine from the Gantt. This means it can understand Gantt project
data, consisting of tasks, dependencies, resources, assignments and calendars (for non-working time). You can have
inter-task dependencies and if a task is moved, any successors will also be shifted according to the engine scheduling
logic. The Scheduler Pro is a great choice for applications needing more than just a good visualisation, a few examples:

* Complex scheduling scenarios where tasks dependent on other tasks (such as a Gantt project)
* Planning systems based on resource availability
* Manufacturing Execution System (MES) apps for production facilities

Scheduler Pro schedules project tasks taking dependencies, constraints and calendars into account. For an in-depth
introduction to the Project, please refer to the [Project model guide](#SchedulerPro/guides/basics/project_data.md)

## Live demo

Here you can try out the Scheduler Pro and some of its main features. For more demos please refer to the example
browser.

<div class="external-example" data-file="SchedulerPro/guides/readme/replaceimage.js"></div>

### Differences between Scheduler and Scheduler Pro

Scheduler Pro extends Scheduler and schedules tasks based on the Project, Resource and Event calendars, while also
taking into account dependencies and constraints. Scheduler Pro also comes with more demos showing off advanced use
cases. Below is a list of technical differences between the two versions:

- Scheduler uses an EventStore, ResourceStore (optionally an AssignmentStore and a DependencyStore), whereas Scheduler
  Pro always uses an AssignmentStore to manage event assignments.
- Scheduler Pro uses the same data model as the Gantt and can visualise a Project side by side with the Gantt.
- Scheduler supports showing dependencies but they are just visual elements, they do not impact scheduling. In Scheduler
  Pro, adding a dependency between two tasks will affect the scheduling of the successor task.
- Scheduler Pro supports visualising a task completion progress bar.
- Scheduler Pro includes a Timeline widget and a Resource Histogram widget.

### Project data

The project data is managed by the scheduling engine, which is based on our
open-source [Chronograph](https://github.com/bryntum/chronograph) project.

The scheduling engine is self-contained, designed to be compatible with a server-side Node.js environment and is
implemented as a separate project using TypeScript. The documentation for this part of the codebase is available
in [Bryntum Scheduling Engine API Docs](engine).

You do not need to use the scheduling engine directly, unless you want to customize the scheduling rules with your
business logic.

### Visualization and UI

The visualization and user interface part of the Scheduler Pro is written in plain JavaScript. You can create a
different visualization for any part of the project data if needed.

### Folder structure

The project has the following folders:

| Folder          | Contents                                                                                                                          |
|-----------------|-----------------------------------------------------------------------------------------------------------------------------------|
| `/build`        | Distribution folder, contains JS bundles, CSS themes, locales and fonts. More info below.                                         |
| `/docs`         | Documentation, open it in a browser (needs to be on a web server) to view guides & API docs.                                      |
| `/examples`     | Demos, open it in a browser (needs to be on a web server)                                                                         |
| `/lib`          | Source code, can be included in your ES6+ project using `import`.                                                                 |
| `/resources`    | SCSS files to build our themes or your own custom theme.                                                                          |
| `/tests`        | Our complete test suite, including [Siesta Lite](https://bryntum.com/products/siesta/) to allow you to run them in a browser. |

## Including in your app

The first step to start with the Scheduler Pro is to include it in your web app. You need to include the CSS theme from
one of the available bundle files and JavaScript classes. The latter can be done in different ways, choose the most
appropriate for your development environment.

### Using bundles

The bundles are located in `/build`. Bundle files are:

| File                         | Contents                                                                           |
|------------------------------|------------------------------------------------------------------------------------|
| `package.json`               | Importable npm package                                                             |
| `schedulerpro.lite.umd.js`   | UMD-format bundle without transpilation and WebComponents included                 |
| `schedulerpro.module.js`     | ES module bundle for usage with modern browsers or in build process                |
| `schedulerpro.lwc.module.js` | ES module bundle for usage with Lightning Web Components                           |
| `schedulerpro.umd.js`        | Transpiled (babel -> ES5) bundle in UMD-format                                     |
| `schedulerpro.node.cjs`      | Transpiled (babel -> node) Non-UI bundle in CommonJS format for usage with Node.JS |
| `schedulerpro.node.mjs`      | Transpiled (babel -> node) Non-UI bundle in Modules format for usage with Node.JS  |

All bundles are also available in minified versions, denoted with a `.min.js` file extension.
Typings for TypeScripts can be found in files with a `.d.ts` file extension.

Example inclusion of UMD bundle:

```html
<script type="text/javascript" src="build/schedulerpro.umd.js"></script>
```

### Using themes

The themes are located in `/build`. Theme files are:

| File                             | Contents            |
|----------------------------------|---------------------|
| `schedulerpro.classic-dark.css`  | Classic-Dark theme  |
| `schedulerpro.classic.css`       | Classic theme       |
| `schedulerpro.classic-light.css` | Classic-Light theme |
| `schedulerpro.material.css`      | Material theme      |
| `schedulerpro.stockholm.css`     | Stockholm theme     |

All themes are also available in minified versions, denoted with a `.min.css` file extension.

Example inclusion of Classic-Light theme:

```html
<link rel="stylesheet" href="build/schedulerpro.classic-light.css" id="bryntum-theme">
```

**Note**: It is recommended to provide `id="bryntum-theme` attribute to the stylesheet.

### Importing EcmaScript modules from sources

This is the most efficient way from a code size perspective, as your bundle will only include the JS modules actually
used by the Scheduler Pro codebase. Please note that this is not possible with the trial version, sources are only
included in the fully licensed version.

In your application code, just import the classes you need from their source file. All source files are located under
`lib/` and they all offer a default export. Please note that if you want to support older browsers you may need to
transpile and bundle your code since ES modules are only supported in modern browsers.

```javascript
import SchedulerPro from '../../../lib/SchedulerPro/view/SchedulerPro.js';

const scheduler = new SchedulerPro({
    project : {
        autoLoad  : true,
        transport : {
            load : {
                url : './data/data.json'
            }
        }
    },
    /*...*/
})
```

Almost all included demos use this technique, see for example the
<a href="../examples/constraints" target="_blank">Constraints example</a>.

### Importing EcmaScript module bundle

In your application code, import the classes you need from the EcmaScript module bundle located
at `build/schedulerpro.module.js`

```javascript
import {SchedulerPro} from '../../../build/schedulerpro.module.js';

const scheduler = new SchedulerPro({
    project : {
        autoLoad  : true,
        transport : {
            load : {
                url : './data/data.json'
            }
        }
    },
    /*...*/
})
```

For a complete example using this technique, please see the
<a href="../examples-scheduler/esmodule" target="_blank">ES module example</a>.

### Loading using `<script>` tag

To include Bryntum Scheduler Pro on your page using a plain old script tag, just include a `<script>` tag pointing to
the UMD bundle file located in `build/schedulerpro.umd.js`:

```html
<script type="text/javascript" src="../../../build/schedulerpro.umd.js"></script>
```

From your scripts you can access Scheduler Pro classes in the global `bryntum` namespace:

```javascript
const scheduler = new bryntum.schedulerpro.SchedulerPro({
    project : {
        autoLoad  : true,
        transport : {
            load : {
                url : './data/data.json'
            }
        }
    },
    /*...*/
});
```

For a complete example, please check out the 
<a href="../examples-scheduler/scripttag" target="_blank">script tag example</a>.

## Creating a project

Once you have the classes imported in one of the ways listed above, you can proceed to the next step - creating a
project instance for your Scheduler Pro. The project is a central place for all data, such as tasks and dependencies.

Under the hood, the project is an instance of the [ProjectModel](#SchedulerPro/model/ProjectModel) class and it is
subclass of the [Model](#Core/data/Model).

Please familiarize yourself with the API of the [Model](#Core/data/Model) class, as it is the base class for all
Scheduler Pro entities.

When creating a project instance, you can also specify configuration options for the project itself. For example, the
project's start date (all tasks will be scheduled to start no earlier than that date).

Lets create a simple project with a few events and dependencies between them (assuming the UMD bundle):

```javascript
const project = new bryntum.schedulerpro.ProjectModel({
    eventsData : [
        { id : 1, name : 'Proof-read docs', startDate : '2020-03-23', duration : 3 },
        // start date will be recalculated according to incoming dependency
        { id : 2, name : 'Release docs', startDate : '2020-03-24', duration : 1 }
    ],

    resourcesData : [
        { id : 1, name : 'Albert' },
        { id : 2, name : 'Ben' }
    ],

    assignmentsData : [
        { resource : 1, event : 1 },
        { resource : 1, event : 2 },
        { resource : 2, event : 2 }
    ],

    dependenciesData : [
        { fromEvent : 1, toEvent : 2, lag : 1 }
    ]
});
```

## Visualisation

Now that the data is in place, simply pass it to the [Scheduler Pro](#SchedulerPro/view/SchedulerPro) instance, to
visualise it:

```javascript
const scheduler = new bryntum.schedulerpro.SchedulerPro({
    project     : project,

    startDate   : '2020-03-22',
    endDate     : '2020-03-29',

    columns     : [
        { field : 'name', text : 'Name' },
    ],

    appendTo    : document.body
});
```

When you open your app in the browser you should see:

<div class="external-example" data-file="SchedulerPro/guides/gettingstarted/basic.js"></div>

Now you should be familiar with the general concepts of the Bryntum Scheduler Pro. Please continue reading one of the
following sections for more detailed information on the specific topic.

<!-- Not ported yet
## Updating the project data

Please refer to the [Project data](#guides/basicsject_data.md) guide for additional information about how changes
to the project data (like updating the start date of a task) should be performed.
-->

## Specifying columns

Bryntum Scheduler Pro is based on the Bryntum Grid and inherits all functionality related to columns from it. Please
refer to [this guide](#Scheduler/guides/basics/columns.md) for general purpose information about how to define columns 
for your scheduler.

Scheduler Pro includes one specific column:

* [ResourceCalendarColumn](#SchedulerPro/column/ResourceCalendarColumn) - Shows resource calendar, is editable

## Enabling features

Please refer to the [Enabling extra features](#Scheduler/guides/basics/features.md) guide to learn how to enhance 
your Scheduler
Pro with additional functionality (time ranges, resource time ranges, etc.).

## Rendering and styling

In the [Rendering and styling](#Scheduler/guides/customization/styling.md) guide you will learn how to customize 
rendering of your
Scheduler Pro.

## Calendars system

The [Calendars](#SchedulerPro/guides/basics/calendars.md) guide contains information about how the working time of your
events/resources can be specified.


<p class="last-modified">Last modified on 2022-03-04 9:57:14</p>