[//]: # (Links in this document only works when viewed in the documentation browser, surf to ./docs)

# Bryntum Scheduler Pro

Welcome to the Bryntum Scheduler Pro, a combination of the [Scheduler](#Scheduler/view/Scheduler) with the powerful
Gantt scheduling engine. Bryntum Scheduler Pro integrates easily with popular frameworks. Click logo to open framework
integration guide:

<div class="framework-logos">
<a href="#SchedulerPro/guides/integration/react/guide.md"><img src="Core/logo/react.svg" alt="React"><span>React</span></a>
<a href="#SchedulerPro/guides/integration/angular/guide.md"><img src="Core/logo/angular.svg" alt="Angular"><span>Angular</span></a>
<a href="#SchedulerPro/guides/integration/vue/guide.md"><img src="Core/logo/vue.svg" alt="Vue"><span>Vue</span></a>
<a href="#SchedulerPro/guides/integration/ionic.md"><img src="Core/logo/ionic.svg" alt="Ionic"><span>Ionic</span></a>
<a href="#Scheduler/guides/integration/salesforce/readme.md"><img src="Core/logo/salesforce.svg" alt="Salesforce"><span>Salesforce</span></a>
<a href="#SchedulerPro/guides/integration/nodejs.md"><img src="Core/logo/nodejs.svg" alt="Node.js"><span>Node.
js</span></a>
</div>

This document contains very brief info on the SchedulerPro's structure and how to get started. For more information, please
view the guides and API Docs ([open SchedulerPro in API docs](#SchedulerPro/view/SchedulerPro)).

## Live demo

Here you can try out the Scheduler Pro and some of its main features. For more demos please refer to the example
browser.

<div class="external-example" data-file="SchedulerPro/guides/readme/replaceimage.js"></div>

## Framework agnostic

The Bryntum Scheduler Pro does not require any framework but works perfectly with popular frameworks such as React,
Angular, Vue, Ionic and Ext JS. It also ships with frameworks demos which can be found in the `examples/frameworks` and
`examples-scheduler/frameworks` folders.

## Including Scheduler Pro in your app

Include the distributed bundles using a script tag or as an ES module. Source maps are included so debugging should be a
breeze :)
For info on other use cases please view the guides found under /docs.

## Folder structure

The project has the following folders:

| Folder                | Contents                                                                                     |
|-----------------------|----------------------------------------------------------------------------------------------|
| `/build`              | Distribution folder, contains js bundles, css themes, locales and fonts. More info below.    |
| `/docs`               | Documentation, open it in a browser (needs to be on a web server) to view guides & API docs. |
| `/examples`           | Demos, open it in a browser (needs to be on a web server)                                    |
| `/examples-scheduler` | Demos from Scheduler, open it in a browser (needs to be on a web server)                     |
| `/lib`                | Source code, can be included in your ES6+ project using `import`.                            |
| `/resources`          | SCSS files to build our themes or your own custom theme.                                     |
| `/tests`              | Our complete test suite, including Siesta Lite to allow you to run them in a browser.        |

### Using bundles

The bundles are located in `/build`. Bundle files are:

| File                         | Contents                                                            |
|------------------------------|---------------------------------------------------------------------|
| `package.json`               | Importable npm package                                              |
| `schedulerpro.lite.umd.js`   | UMD-format bundle without transpilation and WebComponents included  |
| `schedulerpro.module.js`     | ES module bundle for usage with modern browsers or in build process |
| `schedulerpro.lwc.module.js` | ES module bundle for usage with Lightning Web Components            |
| `schedulerpro.umd.js`        | Transpiled (babel -> ES5) bundle in UMD-format                      |

All bundles are also available in minified versions, denoted with a `.min.js` file extension.
Typings for TypeScripts can be found in files with a `.d.ts` file extension.

Example inclusion of UMD bundle with material theme:

```html
<link rel="stylesheet" type="text/css" href="build/schedulerpro.material.css" id="bryntum-theme">

<script type="text/javascript" src="build/schedulerpro.umd.js"></script>
```

### Basic Scheduler Pro example

Below is a simple demo creating a simple scheduler with a few resources and linked events:

```javascript
const scheduler = new SchedulerPro({
    project : {
        resourcesData: [
            { id: 1, name: 'Dan Stevenson' },
            { id: 2, name: 'Talisha Babin' }
        ],

        eventsData: [
            // the date format used is configurable, defaults to the simplified ISO format (e.g. 2017-10-05T14:48:00.000Z)
            // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toISOString
            { id: 1, startDate: '2017-01-01', duration : 3, durationUnit : 'd', name : 'Event 1' },
            { id: 2, duration : 4, durationUnit : 'd', name : 'Event 2' }
        ],

        assignmentsData : [
            { event : 1, resource : 1 },
            { event : 2, resource : 2 }
        ],

        dependenciesData : [
            { fromEvent : 1, toEvent : 2 }
        ]
    },

    appendTo: targetElement,
    autoHeight : true,
    rowHeight : 50,

    columns: [
        { text: 'Name', field: 'name', width: 160 }
    ],

    startDate  : new Date(2017, 0, 1),
    endDate    : new Date(2017, 0, 10)
});
```

<div class="external-example" data-file="SchedulerPro/guides/readme/basic.js"></div>

In the above sample:

* Scheduler Pro uses a Project entity to consume inline data
* Due to the absence of a start date for `Event 2`, the Scheduling Engine calculates it using `Event 1` start date and
  duration
* Assignment store holds information about which events are assigned to which resources.

## A few good-to-know details

### Code and technologies

* The Scheduler Pro is written in ECMAScript 2020 using modules. The modules are built into a bundle using WebPack +
  Babel. These bundles work in all supported browsers (Chrome, Firefox, Safari and Edge).
* The Scheduling Engine is written in TypeScript and transpiled into ECMAScript 2020 modules, which are included into
  resulting Scheduler Pro bundle as well.
* The Scheduler Pro is internally styled using SASS. During the build it generates CSS themes from the SASS files. In
  most cases you include one of the themes in your app. For more details on styling, see the guides under
  guides/styling.

### Scheduler Pro class structure

* The Scheduler Pro is a subclass of [Bryntum Scheduler](#Scheduler/view/Scheduler) which in its turn is based on the
  [Bryntum Grid](#Grid/view/Grid). The Grid provides a lot of the necessary data table infrastructure. Most of the
  features and options for the Grid can be used in the Scheduler too.
* For performance reasons scheduled event elements are reused when scrolling, meaning you should never manipulate DOM
  elements directly (do it from eventRenderers etc. instead).

### External dependencies

Bryntum Scheduler has very few third party dependencies, you can always find our up-to-date dependencies in the
licenses.md file

## Copyright and license

Copyright © 2009 - {{YEAR}}, Bryntum

All rights reserved.

[License](https://www.bryntum.com/products/scheduler-pro/license/)


<p class="last-modified">Last modified on 2022-03-04 9:57:56</p>