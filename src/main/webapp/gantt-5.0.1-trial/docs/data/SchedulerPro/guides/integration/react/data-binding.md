# Binding Bryntum Scheduler Pro data

Bryntum Scheduler Pro is a data intensive component that uses several datasets such as tasks, dependencies, calendars and
other. These datasets usually come from the server and are held in SchedulerPro project during the lifetime of the SchedulerPro
view. There are several ways of populating the project with data.

## Crud Manager

[Crud Manager](#Scheduler/data/CrudManager) is a built-in class that implements loading and saving of data in multiple
stores. Loading the stores and saving all changes is done in one request.

Crud Manager is the simplest way of binding data to the Bryntum Scheduler Pro project stores as seen from the client side,
but it does require following a specific protocol on the backend. The configuration of Crud Manager can be as simple as:

```javascript
crudManager : { 
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

## Binding existing data to Bryntum Scheduler Pro component

When the application already has a server transport layer then the data for SchedulerPro is available in application
code and it needs to be passed (bound) to the component. One approach is to make the data available as state variables
and set these as properties of the React component:

### `App.js:`
```javascript
import { schedulerproConfig } from './AppConfig';

function App() {
    const [events, setEvents]             = useState([]);
    const [assignments, setAssignments]   = useState([]);
    const [dependencies, setDependencies] = useState([]);
    const [resources, setResources]       = useState([]);
    const [timeRanges, setTimeRanges]     = useState([]);
    const [calendars, setCalendars]       = useState([]);

    return (
        <BryntumSchedulerPro
            {...schedulerproConfig}
            calendars    = {calendars}
            event        = {events}
            assignments  = {assignments}
            dependencies = {dependencies}
            resources    = {resources}
            timeRanges   = {timeRanges}
        />
    );
}

export default App;

```

Here we have state variables, one per data set, together with their setters so whenever a change of data is needed the
setter needs to be called with new data as the argument and the change will be immediately reflected in the SchedulerPro.
For example:

```javascript
setEvents(newEvents); 
setResources(newResources);
```

This approach is suitable for simpler applications that do not share a `project` between two or more Bryntum components.

## Binding existing data to project

This approach bind data to a standalone `ProjectModel` and then uses this project in SchedulerPro. Project has its own
markup in the template and it must be assigned to the SchedulerPro during initialization.

This approach is suitable for more complex applications that use more than one Bryntum component that share a common
project:

### `App.js:`
```javascript
import { schedulerproConfig, projectConfig } from './AppConfig';

function App() {
    const schedulerpro = useRef();
    const project = useRef();

    const [calendars, setCalendars]       = useState([]);
    const [events, setEvents]             = useState([]);
    const [assignments, setAssignments]   = useState([]);
    const [dependencies, setDependencies] = useState([]);
    const [resources, setResources]       = useState([]);
    const [timeRanges, setTimeRanges]     = useState([]);

    return (
        <>
            <BryntumProjectModel
                {...projectConfig}
                ref          = {project}
                calendars    = {calendars}
                events       = {events}
                assignments  = {assignments}
                dependencies = {dependencies}
                resources    = {resources}
                timeRanges   = {timeRanges}
            />
            <BryntumSchedulerPro
                {...schedulerproConfig}
                project={project}
                ref={schedulerpro}
            />
        </>
    );
}

export default App;

```

Here we create a standalone ProjectModel (without any rendered output) with properties bound to individual data sets.
The project must be assigned to SchedulerPro in `useEffect` which is configured to run only once on component mount.

Note: `<BryntumProject>` must be returned first for other components to use it. Otherwise the SchedulerPro appears blank,
without any data.

<p class="last-modified">Last modified on 2022-03-04 10:04:23</p>