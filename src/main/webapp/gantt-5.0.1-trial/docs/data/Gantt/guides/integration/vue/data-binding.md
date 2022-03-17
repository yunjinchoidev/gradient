# Binding Bryntum Gantt data

Bryntum Gantt is a data intensive component that uses several datasets such as events, resources, dependencies,
calendars and other. These datasets usually come from the server and are held in Gantt project during the lifetime
of the Gantt view. There are several ways of populating the project data stores.

## Crud Manager

[Crud Manager](#Scheduler/data/CrudManager) is a built-in class that implements loading and saving of data in multiple
stores. Loading the stores and saving all changes is done in one request.

Crud Manager is the simplest way of binding data to the Bryntum Gantt project stores as seen from the client side,
but it does require following a specific protocol on the backend. The configuration of Crud Manager can be as simple as:

```typescript
project : { 
    transport : {
        load : {
            url : '/server/load/url'
        },
        sync : {
            url : '/server/save/url'
        }
    },
    autoLoad : true
}
```

With this configuration, the data is loaded and saved from and to the above URLs and the data transport is handled
automatically by Crud Manager.

## Binding existing data to Bryntum Gantt component

When the application already has a server transport layer then the data for Gantt is available in application
code and it needs to be passed (bound) to the component. One approach is to make the data available as component
variables and bind them in the Vue template:

### `App.vue:`
```javascript
<template>
        <bryntum-gantt
            ref           = "gantt"
            v-bind        = "ganttConfig"
            :tasks        = "tasks"
            :dependencies = "dependencies"
            :resources    = "resources"
            :assignments  = "assignments"
            :time-ranges  = "timeRanges"
            :calendars    = "calendars"
        ></bryntum-gantt>
    </div>
</template>
<script>
import { BryntumGantt, } from '@bryntum/gantt-vue';
import * as initialData from '@/initialData.js';

export default {
    name: 'app',

    // local components
    components: { BryntumGantt },

    data() {
        return {
            // initialData spreads as tasks, dependencies, etc.
            ...initialData,
            ganttConfig,
        };
    },
    mounted() {
        const gantt = this.$refs.gantt.instance;
        const { project } = gantt;
        Object.assign(project, {
            calendar     : 'general',
            startDate    : '2022-02-20,
            hoursPerDay  : 24,
            daysPerWeek  : 5,
            daysPerMonth : 20
        });
    },
```

### `initialData.js (abbreviated):`
```javascript
const calendars = [
    {
        id: 'general',
        name: 'General',
        intervals: [
            {
                recurrentStartDate: 'on Sat at 0:00',
                recurrentEndDate: 'on Mon at 0:00',
                isWorking: false
            }
        ],
        expanded: true,
        children: [ ... ]
    }
];
const tasks = [
    {
        id: 1000,
        name: 'Launch SaaS Product',
        percentDone: 50,
        startDate: '2019-01-14',
        expanded: true,
        children: [ ... ]
];
const dependencies = [
    {
        id: 1,
        fromTask: 11,
        toTask: 15,
        lag: 2
    },
    // ...
];
const resources = [
    { id: 1, name: 'Celia', city: 'Barcelona', calendar: null, image: 'celia.jpg' },
    // ...
];
const assignments = [
    { id: 1, event: 11, resource: 1 },
    // ...
];
const timeRanges = [
    {
        id: 1,
        name: 'Important date',
        startDate: '2022-02-28,
        duration: 0,
        durationUnit: 'd',
        cls: 'b-fa b-fa-diamond'
    }
];
export { calendars, assignments, dependencies, tasks, resources, timeRanges };

```

Here we have component variables, initialized by spreading `...initialData`. Whenever a change of the data is needed,
it is only necessary to assign the new values to these variables, for example:

```javascript
this.tasks = newTasks; 
this.dependencies = newDependencies;
```

This approach is suitable for simpler applications that do not share a `project` between two or more Bryntum components.

## Binding existing data to project

This approach bind data to a standalone `ProjectModel` and then uses this project in Gantt. Project has its own
markup in the template and it must be assigned to the Gantt during initialization.

This approach is suitable for more complex applications that use more than one Bryntum component that share a common
project:

### `App.vue:`
```javascript
<template>
    <bryntum-project-model
        ref           = "project"
        v-bind        = "projectConfig"
        :calendars    = "calendars"
        :tasks        = "tasks"
        :dependencies = "dependencies"
        :resources    = "resources"
        :assignments  = "assignments"
        :time-ranges  = "timeRanges"
    ></bryntum-project-model>

    <bryntum-gantt
        ref    = "gantt"
        v-bind = "ganttConfig"
    ></bryntum-gantt>
</template>
<script>
import { ganttConfig, projectConfig } from '@/AppConfig.js';
import * as initialData from '@/initialData.js';

export default {
    name: 'app',

    // local components
    components: { BryntumProjectModel, BryntumGantt },

    data() {
        return {
            // initialData spreads as tasks, dependencies, etc.
            ...initialData,
            projectConfig,
            ganttConfig
        };
    },
    mounted() {
        // assign project to gantt
        const gantt = this.$refs.gantt.instance;
        const project = this.$refs.project.instance;
        gantt.project = project;
    },

</script>
```

Here we create a standalone ProjectModel (without any rendered output) with properties bound to individual data sets.
The project must be assigned to Gantt in `mounted()` which runs only once on component mount.


<p class="last-modified">Last modified on 2022-03-04 10:05:06</p>