# Using Bryntum Gantt in a Sharepoint SPFx Fabric Web Part

The SharePoint Framework (SPFx) is a page and web part model that provides support for OS independent client-side
SharePoint development. With a few simple steps we can create a React App and upload it as a web part. In this guide we
will show how the Bryntum Gantt chart can be easily embedded into SharePoint as a web part.

## Requirements

To get started, you need an IDE (e.g. WebStorm or VS Code), a SharePoint Online account and a Node version between: >=10.13.0 <11.0.0 || >=12.13.0 <13.0.0 || >=14.15.0 <15.0.0 (
required by SP Fabric).

## Getting started

To get started, a login to the npm registry is required. Please refer to [this guide](#Gantt/guides/npm-repository.md)
to set up an account.

## Initial setup

The demo can be found and launched in the examples folder.

```shell
cd examples/framework/react/typescript/sharepoint-fabric
npm i
gulp serve
```

The serve command will start the local workbench in a new browser window on localhost port 4321.

![workbench](Gantt/screen_sp_0.png)
To see if the setup is working correctly click the [+] sign and add the BryntumGantt chart to the page.

If all is set up correctly you should now see the Gantt chart rendered.

![workbench web part](Gantt/screen_sp_1.png)


### Tenant

The next step is to see it working on the SharePoint site. At this point we need our SharePoint Online account (tenant).
For this demo we used a developer site, but it should work on any site (except the admin site). The tenant workbench can
be opened at https://yourtenant.sharepoint.com/sites/your(developer)site/_layouts/workbench.aspx in the browser.

![tenant](Gantt/screen_sp_3.png)

Here add the BryntumGantt web part, in the same way as is done in the local workbench, to the remote workbench.

The button [Create Tasklist] creates the list and fills it with data selected in the Demo data choice box.

![Create tasklist](Gantt/screen_sp_4.png)

After a few seconds the task list is created on the remote tenant and shown in the Task Lists dropdown field. It will be
automatically loaded into the chart. We can save the PropertyPane to persist the changes for next time.

At this point we can modify the sources of the example to our liking. The local workbench will automatically detect code
changes and refresh the web part after any edits. On the remote tenant, the changes will be visible after manually
refreshing the page in the browser.

## Modify the code

When the local and remote workbench are running, we are ready to do some coding and customise the example to our liking.

### List creation and adding data model fields

We can for example add a few extra fields to the Task model:
```
// Fields which are not on a default SharePoint TaskList.
  static get additionalFields() {
    return [
      { name: 'constraintDate', dataSource: 'ConstraintDate', type : 'date' },
      { name: 'constraintType', dataSource: 'ConstraintType' },
      { name: 'effort', dataSource: 'Effort', type: 'number' },
      { name: 'duration', dataSource: 'Duration', type: 'number', allowNull: true },
      { name: 'manuallyScheduled', dataSource: 'ManuallyScheduled', type:'boolean' },
      { name: 'rollup', dataSource: 'Rollup', type:'boolean' },
      { name: 'schedulingMode', dataSource: 'SchedulingMode' },
      { name: 'effortDriven', dataSource: 'EffortDriven' }
    ];
  }
```

When creating a new list in the PropertyPane, the fields in the additional section are added to the newly created task
list (on creation).

### Data Model

The data model describes how TaskList data is processed and retrieved by the Gantt component.

The Gantt chart is configured with a ProjectModel which is the entity responsible for loading and saving data to
underlying data stores inside the Gantt chart. We override some methods used for communicating with the server and send
our data requests to SharePoint using the [pnpjs](https://pnp.github.io/pnpjs/) library.

```
class TaskListModel extends ProjectModel {

  private service: Service;

  // Override of the crudmanager to bypass Ajax response, no decoding needed
  public decode(response: any): any {
    return response;
  }

  // Override of the crudmanager to bypass Ajax response, no encoding needed
  public encode (requestConfig: any): string {
    return requestConfig;
  }

  /**
   * Override of the crudmanager. Use the List Proxy instead of the default AjaxRequest
   * @param request
   */
  public sendRequest(request: any): Promise<any> {
    return new Promise((resolve, reject) => {
      switch(request.type) {
          case 'load':
            return this.service.load(request);
          case 'sync':
            return this.service.sync(request);
        }
    });
  }
}
```

The Service class will process data requests and retrieve the data from SharePoint and return the response to the
Project. In case of a load request we do the following in the Service class:

```
public load(request: any): Promise<Response> {

    return new Promise((resolve, reject) => {
      this.proxy.getTaskListItems(this.listId).then(response => {
        this.finish(request, response);
        resolve(response);
      }).catch(handleFail);
    });
  }
```

The service is using a proxy to process the calls with the [pnpjs](https://pnp.github.io/pnpjs/) library.
TaskListItems are retrieved with the [sp package](https://pnp.github.io/pnpjs/sp/).

```
public getTaskListItems(listId: string): Promise<Response> {

    const response = new Response();

    return new Promise((resolve, reject) => {

      sp.web.lists.getById(listId).items.select('*,ParentIDId').getAll().then((tasks) => {

        /*...*/
        response.tasks.rows = ...

        // Get all site users. you might want to filter some out
        sp.web.siteUsers().then((users) => {
          response.resources.rows = users;
          resolve(response);
        });
      }).catch(reject);
    });
  }
```

The returned Response object is passed back to the ProjectModel in the [format](#Gantt/guides/data/crud_manager.md)
expected.

```
interface ITaskList {
  deleteTaskListItems(listId: string, actions: UpdateAction[]): Promise<UpdateAction[]>;
  addTaskListItems(listId: string, actions: UpdateAction[]): Promise<UpdateAction[]>;
  updateTaskListItems(listId: string, actions: UpdateAction[]): Promise<UpdateAction[]>;
  getTaskListItems(listId: string): Promise<Response>;
}
```

### PropertyPane

The example is built with React. The [React](#Gantt/guides/integration/react/guide.md) integration guide provides good
guidelines how to configure and style the gantt component. The PropertyPane for the web part is used to configure it
(e.g. its behavior and appearance). We recommend you to read
this [guide](https://docs.microsoft.com/nl-nl/sharepoint/dev/spfx/web-parts/get-started/build-a-hello-world-web-part)
which shows how to modify the basic structure of a web part.

## Deploy

When we are finished coding and the web part is ready for production use, the solution can be easily packaged by running
a few commands.

```
gulp bundle --ship
gulp package-solution --ship
```

We upload the created `bryntum-fabric-sp.sppkg package` to our app catalog.

![deploy](Gantt/screen_sp_5.png)

When pressing [Deploy], the web part is available for all the sites within the organisation.

![deployed](Gantt/screen_sp_6.png)


<p class="last-modified">Last modified on 2022-03-04 9:57:13</p>