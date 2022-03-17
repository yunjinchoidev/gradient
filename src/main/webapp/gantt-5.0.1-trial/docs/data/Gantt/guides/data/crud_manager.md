# Crud Manager in the Gantt

## Introduction

This guide describes how to use the _Crud Manager_ in _Bryntum Gantt_.
It contains only Gantt specific details. For general information on _Crud Manager_ implementation and architecture
see [this guide](#Gantt/guides/data/crud_manager.md).

In the Gantt Crud Manager mixins are applied to [ProjectModel](#Gantt/model/ProjectModel) class.
So each project is capable of loading and saving its data using _Crud Manager_ protocol.
It uses AJAX as transport system and JSON as encoding format.

## Gantt stores

There are a lot of stores in the Gantt. They are used for keeping calendars, resources, assignments, dependencies and
tasks. The stores reference each other records and are joined together by a project.

Providing _Crud Manager_ functionality to [ProjectModel](#Gantt/model/ProjectModel) allows to handle the stores loading
and persisting.

Project creates related stores by default and in case you need to provide your own store instances there are
corresponding configs:

- [calendarManagerStore](#Gantt/model/ProjectModel#config-calendarManagerStore),
- [resourceStore](#Gantt/model/ProjectModel#config-resourceStore),
- [assignmentStore](#Gantt/model/ProjectModel#config-assignmentStore),
- [dependencyStore](#Gantt/model/ProjectModel#config-dependencyStore),
- [taskStore](#Gantt/model/ProjectModel#config-taskStore).

Here's how a basic configuration could look:

```javascript
const project = new ProjectModel({
    autoLoad : true,
    // we want to provide a custom store for tasks
    taskStore,
    transport : {
        load : {
            url : 'php/read.php'
        },
        sync : {
            url : 'php/save.php'
        }
    }
});
```

## Response format validation

Gantt project can validate responses and log found issues to the browser console.
This should help implementing backend integration on development stage.

Example of the validation report:

```text
Project sync response error(s):
- "tasks" store "rows" section should mention added record(s) #XXX sent in the request. It should contain the added records identifiers (both phantom and "real" ones assigned by the backend).
- "tasks" store "rows" section should mention updated record(s) #XXX sent in the request. It should contain the updated record identifiers.
- "tasks" store "removed" section should mention removed record(s) #XXX sent in the request. It should contain the removed record identifiers.
Please adjust your response to look like this:
{
    "tasks": {
        "removed": [
            {
                "id": XXX
            },
            ...
        ],
        "rows": [
            {
                "$PhantomId": XXX,
                "id": ...
            },
            {
                "id": XXX
            },
            ...
        ]
    }
}
Note: Please consider enabling "supportShortSyncResponse" option to allow less detailed sync responses (https://bryntum.com/docs/scheduler/api/Scheduler/crud/AbstractCrudManagerMixin#config-supportShortSyncResponse)
Note: To disable this validation please set the "validateResponse" config to false
```

The validation can be enabled with [validateResponse](#Gantt/model/ProjectModel#config-validateResponse) config.
**Please note** that the config is meant to be used on development stage and disabled for production systems.

## Load response structure

The backend (in this above case it's "php/read.php" script) should return a JSON similar to the one seen below:

```json
{
    "success" : true,

    "project" : {
        "calendar"     : 10,
        "startDate"    : "2019-01-14",
        "hoursPerDay"  : 24,
        "daysPerWeek"  : 5,
        "daysPerMonth" : 20
    },

    "calendars" : {
        "rows" : [
            {
                "id"        : 10,
                "name"      : "General",
                "intervals" : [
                    {
                        "recurrentStartDate" : "on Sat at 0:00",
                        "recurrentEndDate"   : "on Mon at 0:00",
                        "isWorking"          : false
                    }
                ]
            }
        ]
    },

    "tasks" : {
        "rows" : [
            {
                "id"          : 11,
                "name"        : "Investigate",
                "percentDone" : 50,
                "startDate"   : "2021-02-08",
                "endDate"     : "2021-02-13",
                "duration"    : 5
            },
            {
                "id"          : 12,
                "name"        : "Assign resources",
                "percentDone" : 50,
                "startDate"   : "2021-02-08",
                "endDate"     : "2021-02-20",
                "duration"    : 10
            },
            {
                "id"          : 17,
                "name"        : "Report to management",
                "percentDone" : 0,
                "startDate"   : "2021-02-20",
                "endDate"     : "2021-02-20",
                "duration"    : 0
            }
        ]
    },

    "dependencies" : {
        "rows" : [
            {
                "id"      : 1,
                "from"    : 11,
                "to"      : 17,
                "type"    : 2,
                "lag"     : 0,
                "lagUnit" : "d"
            }
        ]
    },

    "resources" : {
        "rows" : [
            {
                "id"   : 1,
                "name" : "Mats"
            },
            {
                "id" : 2,
                "name" : "Nickolay"
            }
        ]
    },

    "assignments" : {
        "rows" : [
            {
                "id"       : 1,
                "event"    : 11,
                "resource" : 1,
                "units"    : 80
            }
        ]
    }
}
```

The above response sections contain corresponding stores data which are discovered in the following chapters.

### Project data

The project reads values of its own fields from `project` section of the responses. In the above example it looks this:

```
{
    ...

    "project" : {
        "startDate"    : "2010-01-18",
        "calendar"     : 12,
        "hoursPerDay"  : 8,
        "daysPerWeek"  : 5,
        "daysPerMonth" : 20
    }
}
```

Please check [ProjectModel docs](#Gantt/model/ProjectModel#fields) for the full list of the project fields.

### Calendars data

Calendars in the Gantt define working periods of time when resources or tasks could perform.
The project reads their data from load response `calendars` section.
The records are responded as an array of objects under `rows` property.
In the provided response example it looks this:

```
{
    ...

    "calendars" : {
        "rows" : [
            {
                "id"        : 10,
                "name"      : "General",
                "intervals" : [
                    {
                        "recurrentStartDate" : "on Sat at 0:00",
                        "recurrentEndDate"   : "on Mon at 0:00",
                        "isWorking"          : false
                    }
                ]
            }
        ]
    }
}
```

Please check [CalendarModel docs](#Gantt/model/CalendarModel#fields) for the full list of calendar fields.

### Tasks data

The project reads tasks from `tasks` section of load response.
The records are responded as an array of objects under `rows` property.
In the provided response example it looks this:

```
{
    ...

    "tasks": {
        "rows": [
            {
                "id"          : 11,
                "name"        : "Investigate",
                "percentDone" : 50,
                "startDate"   : "2021-02-08",
                "endDate"     : "2021-02-13",
                "duration"    : 5
            },
            {
                "id"          : 12,
                "name"        : "Assign resources",
                "percentDone" : 50,
                "startDate"   : "2021-02-08",
                "endDate"     : "2021-02-20",
                "duration"    : 10
            },
            {
                "id"          : 17,
                "name"        : "Report to management",
                "percentDone" : 0,
                "startDate"   : "2021-02-20",
                "endDate"     : "2021-02-20",
                "duration"    : 0
            }
        ]
    }
}
```

Please check [TaskModel docs](#Gantt/model/TaskModel#fields) for the full list of task fields.

### Dependencies data

Task dependencies represent links between tasks that describe how tasks should be scheduled
based on each other.
The project reads them from `dependencies` section of load response.
The records are responded as an array of objects under `rows` property.
In the provided response example it looks this:

```
{
    ...

    "dependencies": {
        "rows" : [
            {
                "id"      : 1,
                "from"    : 11,
                "to"      : 17,
                "type"    : 2,
                "lag"     : 0,
                "lagUnit" : "d"
            }
        ]
    }
}
```

Please check [DependencyModel docs](#Gantt/model/DependencyModel#fields) for the full list of dependency fields.

### Resources data

The project reads resources from `resources` section of load response.
The records are responded as an array of objects under `rows` property.
In the provided response example it looks this:

```
{
    ...

    "resources" : {
        "rows" : [
            {
                "id"   : 1,
                "name" : "Mats"
            },
            {
                "id"   : 2,
                "name" : "Nickolay"
            }
        ]
    }
}
```

Please check [ResourceModel docs](#Gantt/model/ResourceModel#fields) for the full list of resource fields.

### Assignments data

Assignments specify resources usage for certain tasks.
The project reads them from `assignments` section of load response.
The records are responded as an array of objects under `rows` property.
In the provided response example it looks this:

```
{
    ...

    "assignments" : {
        "rows" : [
            {
                "id"       : 1,
                "event"    : 11,
                "resource" : 1,
                "units"    : 80
            }
        ]
    }
}
```

Please check [AssignmentModel docs](#Gantt/model/AssignmentModel#fields) for the full list of assignment fields.

## Sending extra HTTP request parameters

Extra params may be added using [transport](#Scheduler/crud/transport/AjaxTransport#config-transport) configuration:

```javascript
const project = new ProjectModel({
    transport : {
        load : {
            url    : 'php/read.php',
            method : 'POST',
            params : {
                userAccess : 'granted',
                viewId     : 'full'
            }
        },
        sync : {
            url : 'php/save.php'
        }
    }
});
```

Or dynamically by passing into [load](#Gantt/model/ProjectModel#function-load) method:

```javascript
project.load({
    request : {
        params : {
            startDate : '2021-01-01'
        }
    }
})
```

## Dealing with extra stores

Since [ProjectModel](#Gantt/model/ProjectModel) implements a _Crud Manager_ you can provide any number of additional stores using [crudStores](#Scheduler/crud/AbstractCrudManagerMixin#function-addCrudStore) config:

```javascript
const project = new ProjectModel({
    // let's additionally register the following stores
    // to also handle them by batch when loading the project data
    crudStores : [ store1, store2, store3 ],
    transport : {
        load : {
            url : 'php/read.php'
        },
        sync : {
            url : 'php/save.php'
        }
    }
});
```

Or add them programmatically using the [addCrudStore](#Scheduler/crud/AbstractCrudManagerMixin#function-addCrudStore) method:

```javascript
project.addCrudStore([ store2, store3 ]);
```

## Triggering loading and saving

In the following example the project will start data loading automatically due to the provided
[autoLoad](#Gantt/model/ProjectModel#config-autoLoad) config.
In this case the project schedules asynchronous loading on construction stage:

```javascript
const project = new ProjectModel({
    autoLoad : true,
    transport : {
        load : {
            url : 'php/read.php'
        },
        sync : {
            url : 'php/save.php'
        }
    }
});
```

And in order to start data loading manually the project has [load](#Gantt/model/ProjectModel#function-load) method.
The method returns a `Promise` that gets resolved once data is loaded and processed by the _Scheduling Engine_:

```javascript
// load data
project.load().catch(() => {
    console.log('Data loading error');
}).then(() => {
    // here data is loaded and processed by the engine
    console.log('Data loaded and processed...');
});
```

To persist changes automatically, there is [autoSync](#Gantt/model/ProjectModel#config-autoSync) option.
When set to `true` it causes project to react on data changes made in the registered stores
and schedule data syncing.
For example in the following snippet the project will trigger data
saving (handled by `php/save.php` script) as soon as any registered store record gets changed:

```javascript
const project = new ProjectModel({
    autoSync : true,
    transport : {
        load : {
            url : 'php/read.php'
        },
        sync : {
            url : 'php/save.php'
        }
    }
});
```

And of course manual saving is also possible with [sync](#Gantt/model/ProjectModel#function-sync) method:

```javascript
await project.sync().catch(() => {
    console.log('Data saving error');
}).then(() => {
    console.log('Changes saved...');
});

```

## Calendars persisting

**Please note that** persisting of calendars is not implemented yet. The project at the moment supports only loading of them.
Please subscribe to the [related GitHub issue](https://github.com/bryntum/support/issues/2332) to stay informed
of the problem status.


<p class="last-modified">Last modified on 2022-03-04 9:57:13</p>