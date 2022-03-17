<h1 class="title-with-image">
<img src="Core/logo/salesforce.svg" alt="Bryntum Gantt supports Lightning Web Components"/>
Using Bryntum Gantt as a Lightning Web Component
</h1>

<img src="Gantt/salesforce_gantt_demo.png" style="width: 800px; height: 478px" alt="Bryntum Gantt Lightning Web Component demo"/>

## Installation

### Prerequisites

* Salesforce CLI

    We will be using it to create Lightning Web Component and upload it to an organization.
    See [this article](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
    for installation guidance.
    
* Visual Studio Code with
[Salesforce Extension Pack](https://marketplace.visualstudio.com/items?itemName=salesforce.salesforcedx-vscode)

### Setup

1. [Enable Dev Hub in Org](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_enable_devhub.htm)

2. Enable [My Domain](https://help.salesforce.com/articleView?id=domain_name_overview.htm&type=5) to use Lightning features

2. Create a base directory for Salesforce DX project:
    ```shell
    $ mkdir ~/salesforce
    ```
    
3. Create a Salesforce DX project via CLI:
    ```shell
    $ cd ~/salesforce
    $ sfdx force:project:create -n BryntumGantt --manifest
      target dir = /home/user/salesforce
         create BryntumGantt/config/project-scratch-def.json
         create BryntumGantt/README.md
         create BryntumGantt/sfdx-project.json
         create BryntumGantt/manifest/package.xml
         create BryntumGantt/.vscode/extensions.json
         create BryntumGantt/.vscode/launch.json
         create BryntumGantt/.vscode/settings.json
         create BryntumGantt/force-app/main/default/lwc/.eslintrc.json
         create BryntumGantt/force-app/main/default/aura/.eslintrc.json
         create BryntumGantt/scripts/soql/account.soql
         create BryntumGantt/scripts/apex/hello.apex
         create BryntumGantt/.eslintignore
         create BryntumGantt/.forceignore
         create BryntumGantt/.gitignore
         create BryntumGantt/.prettierignore
         create BryntumGantt/.prettierrc
         create BryntumGantt/package.json
    $ cd BryntumGantt
    ```
    Or from VS Code by typing this to the command palette: `SFDX: Create Project` -> `Standard` -> ...

4. [Authorize an Org](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_auth_web_flow.htm)
    ```shell
    $ sfdx force:auth:web:login --setdefaultdevhubusername
    Successfully authorized ...@...com with org ID ...
    You may now close the browser
    ```
    Or from VS Code by typing to command palette: `SFDX: Authorize a Dev Hub`

5. Create a Scratch Org
    ```shell
    $ sfdx force:org:create -f config/project-scratch-def.json --setalias BryntumGantt --durationdays 30 --setdefaultusername
    Successfully created scratch org: ..., username: test-...@example.com
    ```
    Or from VS Code by typing to command palette: `SFDX: Create a Default Scratch Org`

6. Create a static resource

    Copy the static resource definition from examples directory to Salesforce DX project directory 
    ```shell
    $ cp path-to-bryntum-gantt/examples/salesforce/src/staticresources/bryntum_gantt.resource-meta.xml \
    ~/salesforce/BryntumGantt/force-app/main/default/staticresources/bryntum_gantt.resource-meta.xml
    ```
   
    Create a directory for static resources:
    ```shell
    $ mkdir ~/salesforce/BryntumGantt/force-app/main/default/staticresources/bryntum_gantt
    ```
   
    Copy required sources to the static resource folder, required sources are:
    - JS bundle specific for LWC
    - CSS bundle
    - Locales
    - Fonts
    ```shell
    $ cd path-to-bryntum-gantt/build
    $ cp -r gantt.lwc.module.js gantt.stockholm.css gantt.stockholm.css.map gantt.d.ts locales/ fonts/ \
    ~/salesforce/BryntumGantt/force-app/main/default/staticresources/bryntum_gantt
    $ cd ~/salesforce/BryntumGantt/
    ```
   
   You should get this folder structure
    ```shell
    $ ll force-app/main/default/staticresources/bryntum_gantt
    total 8704
    drwxr-xr-x 1 user user    4096 Oct 20 19:43 ./
    drwxr-xr-x 1 user user    4096 Oct 20 19:45 ../
    drwxr-xr-x 1 user user    4096 Oct 20 19:43 fonts/
    -rw-r--r-- 1 user user  586228 Oct 20 19:43 gantt.d.ts
    -rw-r--r-- 1 user user 5994801 Oct 20 19:43 gantt.lwc.module.js
    -rw-r--r-- 1 user user  548262 Oct 20 19:43 gantt.stockholm.css
    -rw-r--r-- 1 user user  667445 Oct 20 19:43 gantt.stockholm.css.map
    drwxr-xr-x 1 user user    4096 Oct 20 19:43 locales/
    ```

    Push the static resource to the default Scratch Org
    ```shell
    $ sfdx force:source:push
    Job ID | ...
    SOURCE PROGRESS | ████████████████████████████████████████ | 1/1 Components
    === Pushed Source
    STATE  FULL NAME     TYPE            PROJECT PATH
    ─────  ────────────  ──────────────  ───────────────────────────────────────────────────────────────────────────────
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/Roboto-Bold.woff
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/Roboto-Bold.woff2
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/Roboto-Light.woff
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/Roboto-Light.woff2
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/Roboto-Medium.woff
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/Roboto-Medium.woff2
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/Roboto-Regular.woff
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/Roboto-Regular.woff2
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/fa-solid-900.eot
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/fa-solid-900.svg
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/fa-solid-900.ttf
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/fa-solid-900.woff
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/fonts/fa-solid-900.woff2
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/gantt.d.ts
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/gantt.lwc.module.js
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/gantt.stockholm.css
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/gantt.stockholm.css.map
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/locales/gantt.locale.En.js
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/locales/gantt.locale.Nl.js
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/locales/gantt.locale.Ru.js
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt/locales/gantt.locale.SvSE.js
    Add    bryntum_gantt  StaticResource  force-app/main/default/staticresources/bryntum_gantt.resource-meta.xml
    ```
    Or from VS Code by typing to the command palette: `SFDX: Push Source To Default Scratch Org`
   
7. Create a Lightning Web Component

    ```shell
    $ sfdx force:lightning:component:create --type lwc -n Gantt_component -d force-app/main/default/lwc
    target dir = /home/user/salesforce/BryntumGantt/force-app/main/default/lwc
       create force-app/main/default/lwc/gantt_component/gantt_component.js
       create force-app/main/default/lwc/gantt_component/gantt_component.html
       create force-app/main/default/lwc/gantt_component/gantt_component.js-meta.xml
    ```
   Or from VS Code by typing to command palette: `SFDX: Create Lightning Web Component`

8. Copy the Lightning Web Component code

    ```shell
    $ cd path-to-bryntum-gantt/examples/salesforce/src/lwc/gantt_component
    $ cp *.js *.html *.css *.map ~/salesforce/BryntumGantt/force-app/main/default/lwc/gantt_component
    $ cd ~/salesforce/BryntumGantt/
    ```
   
   Change the component definition in `gantt_component.js-meta.xml` to expose it in the Lightning App Builder:
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <LightningComponentBundle xmlns="http://soap.sforce.com/2006/04/metadata">
        <apiVersion>49.0</apiVersion>
        <isExposed>true</isExposed>
        <masterLabel>Bryntum Gantt</masterLabel>
        <description>Bryntum Gantt sample</description>
        <targets>
          <target>lightning__AppPage</target>
        </targets>
    </LightningComponentBundle>
    ```
   
   As a result you should get a project which looks like this:
   
   <img src="Gantt/salesforce_gantt_project.png" style="width: 800px; height: 560px" alt="Build Gantt Lightning Component project"/>

9. Push the sources to the Scratch Org
    
    ```shell
    $ sfdx force:source:push
    Job ID | ...
    SOURCE PROGRESS | ████████████████████████████████████████ | 1/1 Components
    === Pushed Source
    STATE  FULL NAME                           TYPE                      PROJECT PATH
    ─────  ──────────────────────────────────  ────────────────────────  ────────────────────────────────────────────────────────────────────
    Add    gantt_component/data/launch-saas.js   LightningComponentBundle  force-app/main/default/lwc/gantt_component/data/launch-saas.js
    Add    gantt_component/lib/GanttToolbar.js   LightningComponentBundle  force-app/main/default/lwc/gantt_component/lib/GanttToolbar.js
    Add    gantt_component/gantt_component.css   LightningComponentBundle  force-app/main/default/lwc/gantt_component/gantt_component.css
    Add    gantt_component/gantt_component.html  LightningComponentBundle  force-app/main/default/lwc/gantt_component/gantt_component.html
    Add    gantt_component/gantt_component.js    LightningComponentBundle  force-app/main/default/lwc/gantt_component/gantt_component.js
    Add    gantt_component/gantt_component.js    LightningComponentBundle  force-app/main/default/lwc/gantt_component/gantt_component.js-meta.xml
    ```
    Or from VS Code by typing this to the command palette: `SFDX: Push Source To Default Scratch Org`
    
## Usage

To use the web component we need a Lightning Application 

1. Open default org
    ```shell
    $ sfdx force:org:open
    ```
    Or from VS Code by typing this to the command palette: `SFDX: Open Default Org`
    
2. Open the Lightning App Builder, create a new Lightning Page. Pick `App Page` then page name and layout.

3. You should see a `Bryntum Gantt` custom component available for the new page. Append it to any region and save.

4. Activate the page. Click `Activation`, navigate to `Lightning Experience` tab and pick Lightning Application to append
this page to. Save the changes.

<img src="Gantt/salesforce_gantt_build_ltng_app.gif" style="width: 800px; height: 473px" alt="Build Gantt Lightning Component"/>

5. Open the application page. It should be accessible in the app launcher if you click it and type `Bryntum`.

If everything went well, you should see a simple gantt demo running in the Lightning Page.

<img src="Gantt/salesforce_gantt_use_ltng_app.gif" style="width: 800px; height: 473px" alt="Use Gantt Lightning Component"/>

## Lightning Locker

As of version 4.1.0, Bryntum Gantt offers full support for Locker Service and can be embedded into a Lightning
Web Component (LWC), as simple as:

```
Promise.all([
    loadScript(this, GANTT + '/gantt.lwc.module.js'),
    loadStyle(this, GANTT + '/gantt.stockholm.css')
]).then(() => {
    new bryntum.gantt.Gantt({
        appendTo : this.template,
        ...
    });
})
```

### CSS collisions

You may encounter a CSS collision on components when loading static resources for different Bryntum products. Normally
this should not be a problem because each product bundle exports the components it is based on. Scheduler exports Grid, Gantt
exports both Scheduler and Grid. Which means you can use Grid from Gantt's static resource (please note you still need 
a license for every Bryntum product you use).

In case you have a static resource for the Grid (having grid.theme.css) and another for Scheduler (having scheduler.theme.css)
you may see some wrong styles, like the timeline header misplaced by a few pixels.

If you experience this or any other integration issue please let us know in our [forums](https://bryntum.com/forum).

### Changed and missing APIs

Lightning Locker modifies the behavior of some native APIs (and other native APIs are not supported). 
We have refactored our code base to allow overriding certain behavior specifically to work with Lightning Locker. As a result
**gantt.lwc.module.js only works when Lightning Locker is enabled**, it is not supposed to work in a regular page.

Overrides are organized in a single entry **lib/Gantt/override/salesforce/AllOverrides.js** which you will only need 
if you want to generate a special bundle (e.g. to achieve minimum size). This entry should be imported first.

## Supported Browsers

The LWC bundle we provide only supports modern browsers since Salesforce dropped support for legacy browsers at the 
end of 2020. IE11 and old (non-Chromium based) Edge are not supported. 


<p class="last-modified">Last modified on 2022-03-04 9:57:13</p>