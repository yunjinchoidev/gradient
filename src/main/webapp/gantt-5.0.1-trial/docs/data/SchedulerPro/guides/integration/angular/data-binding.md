# Binding Bryntum Scheduler Pro data

Bryntum Scheduler Pro is a data intensive component that uses several datasets such as events, resources, dependencies,
calendars and other. These datasets usually come from the server and are held in SchedulerPro project during the lifetime
of the SchedulerPro view. There are several ways of populating the project data stores.

## Crud Manager

[Crud Manager](#Scheduler/data/CrudManager) is a built-in class that implements loading and saving of data in multiple
stores. Loading the stores and saving all changes is done in one request.

Crud Manager is the simplest way of binding data to the Bryntum Scheduler Pro project stores as seen from the client side, 
but it does require following a specific protocol on the backend. The configuration of Crud Manager can be as simple as:

```typescript
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

## Binding existing data to the Bryntum Scheduler Pro component

When the application already has a server transport layer then the data for SchedulerPro is available in application 
code and it needs to be passed (bound) to the component. One approach is to make the data available as an Angular 
component class variables and then use them in templates:

### `app.component.ts:`
```typescript
import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { SchedulerPro, ProjectModel } from '@bryntum/schedulerpro/schedulerpro.lite.umd.js';
import { schedulerproConfig } from './app.config';
import { DataService } from './data.service';

@Component({
    selector    : 'app-root',
    templateUrl : './app.component.html',
    styleUrls   : ['./app.component.scss'],
    providers   : [DataService]
})
export class AppComponent implements OnInit {

    events       = [];
    dependencies = [];
    resources    = [];
    assignments  = [];
    calendars    = [];
    timeRanges   = [];

    schedulerproConfig = schedulerproConfig;

    // Inject data service
    constructor(private dataService:DataService){};

    ngOnInit(): void {
        // Get initial data
        Object.assign(this, this.dataService.getData())
    }
}

```
### `app.component.html:`
```html
<bryntum-schedulerpro
    #schedulerpro
    [columnLines]       = "schedulerproConfig.columnLines"
    [columns]           = "schedulerproConfig.columns"
    [subGridConfigs]    = "schedulerproConfig.subGridConfigs"
    [viewPreset]        = "schedulerproConfig.viewPreset"
    [timeRangesFeature] = "schedulerproConfig.timeRangesFeature"
    [events]            = "events"
    [timeRanges]        = "timeRanges"
    [assignments]       = "assignments"
    [resources]         = "resources"
    [dependencies]      = "dependencies"
    [calendars]         = "calendars"
></bryntum-schedulerpro>
```

`DataService` is a placeholder name in this example and it would be replaced by the service that provides data in your
application.

The key is to supply existing data to the class variables and then use these variables in the template. This approach
is suitable for simpler applications that do not share a `project` between two or more Bryntum components.

## Binding existing data to the project

This approach bind data to a standalone `ProjectModel` and then uses this project in SchedulerPro. Project has its own
markup in the template and it must be assigned to the SchedulerPro during initialization.

This approach is suitable for more complex applications that use more than one Bryntum component that share a common
project:

### `app.component.ts:`
```typescript
import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { BryntumSchedulerProComponent, BryntumProjectModelComponent } from '@bryntum/schedulerpro-angular';
import { SchedulerPro, ProjectModel } from '@bryntum/schedulerpro/schedulerpro.lite.umd.js';
import { schedulerproConfig, projectConfig } from './app.config';
import { DataService } from './data.service';

@Component({
    selector    : 'app-root',
    templateUrl : './app.component.html',
    styleUrls   : ['./app.component.scss'],
    providers   : [DataService]
})
export class AppComponent implements AfterViewInit, OnInit {

    events       = [];
    dependencies = [];
    resources    = [];
    assignments  = [];
    calendars    = [];
    timeRanges   = [];

    schedulerproConfig = schedulerproConfig;
    projectConfig = projectConfig;

    private schedulerpro!: SchedulerPro;
    private project!: ProjectModel;
    private dataSet = 0;

    @ViewChild('schedulerpro') schedulerproComponent!: BryntumSchedulerProComponent;
    @ViewChild('project') projectComponent!: BryntumProjectModelComponent;

    // Inject data service
    constructor(private dataService:DataService){};

    ngOnInit(): void {
        // Get initial data
        Object.assign(this, this.dataService.getData())
    }

    ngAfterViewInit(): void {
        // Store SchedulerPro and project instances
        this.project = this.projectComponent.instance;
        this.schedulerpro = this.schedulerproComponent.instance;

        // Assign project to schedulerpro
        this.schedulerpro.project = this.project;
    }
}

```

### `app.component.html:`
```html
<bryntum-schedulerpro
    #schedulerpro
    [columnLines]       = "schedulerproConfig.columnLines"
    [columns]           = "schedulerproConfig.columns"
    [subGridConfigs]    = "schedulerproConfig.subGridConfigs"
    [viewPreset]        = "schedulerproConfig.viewPreset"
    [timeRangesFeature] = "schedulerproConfig.timeRangesFeature"
></bryntum-schedulerpro>
<bryntum-project-model
    #project
    [calendar]     = "projectConfig.calendar!"
    [startDate]    = "projectConfig.startDate!"
    [hoursPerDay]  = "projectConfig.hoursPerDay!"
    [daysPerMonth] = "projectConfig.daysPerMonth!"
    [events]       = "events"
    [timeRanges]   = "timeRanges"
    [assignments]  = "assignments"
    [resources]    = "resources"
    [dependencies] = "dependencies"
    [calendars]    = "calendars"
></bryntum-project-model>
```

`DataService` is a placeholder name in this example and it would be replaced by the service that provides data in your
application.



<p class="last-modified">Last modified on 2022-03-04 10:04:23</p>