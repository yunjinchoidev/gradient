# 5.0.1 - 2022-03-04

## API CHANGES

* [WRAPPERS] New `ResourceUtilization` widget wrapper available for Angular, React and Vue frameworks (Fixed #4276)

## BUG FIXES

* Fixed #3861 - Bug in Baseline Demo after setting baseline `3`
* Fixed #4162 - Left arrow key does not navigate from selected task
* Fixed #4252 - No dependencies in `CycleResolutionPopup` combo
* Fixed #4286 - When `TreeGroup` feature is active, `Indent`, `Outdent`, add `SubTask` should be disabled
* Fixed #4295 - Edit / View task modal will not open when gantt view is collapsed

# 5.0.0 - 2022-02-21

* We are thrilled to announce version 5.0 of our Gantt product. This release marks a big milestone for us, after more
  than a year of development. This update includes performance improvements, a new ResourceUtilization widget, a
  TreeGroup feature as well as bug fixes and other enhancements requested by our community. A big thanks to our
  customers who helped us with testing our alpha & beta versions

* You are most welcome to join us on March 16th, at 9am PST (6pm CET) for a 5.0 walkthrough webinar, demonstrating all
  the shiny new features
  [Click here to register](https://us06web.zoom.us/webinar/register/5116438317103/WN_4MkExpZPQsGYNpzh1mR_Ag)

* We hope you will enjoy this release and we are looking forward to hearing your feedback of what you would like us to
  develop next

* / Mats Bryntse, CEO @Bryntum

## FEATURES / ENHANCEMENTS

* Added a new Resource Utilization view displaying resource allocation. Please check its demo for details
  (Fixed #2348)
* With this release Gantt starts displaying a popup informing users of scheduling conflicts, cycles and calendar
  misconfigurations. The popup allows the user to pick an appropriate resolution for the case at hand. On the data
  level the cases are indicated by new events triggered on the project (Fixed #1264, #1265)
* Gantt now performs the initial rendering of tasks quicker than before, by rendering them using raw data prior to
  performing calculations. Especially on large datasets this makes it feel much snappier. Requires loading normalized
  data to work optimally. Depending on how much non-UI manipulating your app does on the tasks the delayed calculations
  might affect your code, be sure to check out the upgrade guide (Fixed #2251)
* Gantt has a new `TreeGroup` feature that can transform the task tree on the fly. It generates a new tree structure
  based on an array of field names (or functions), each entry yields a new level in the resulting tree. Check it out in
  the new `grouping` demo (Fixed #3543)
* Each product has a new "thin" JavaScript bundle. The thin bundle only contains product specific code, letting you
  combine multiple Bryntum products without downloading the shared code multiple times (previously only possible with
  custom-built bundles from sources). Find out more in the What's new guide (Fixed #2805)
* Each theme is now available in a version that only has product specific CSS in it, called a `thin` version. These
  files are name `[product].[theme].thin.css` - `gantt.stockholm.thin.css` for example. They are intended for using
  when you have multiple different bryntum products on the same page, to avoid including shared CSS multiple times
  Read more about it in the `What's new` section in docs (Fixed #3276)
* `Model` has a new `readOnly` field that is respected by UI level editing features to disallow editing records having
  `readOnly : true`. It does not directly affect the datalayer, meaning that you can still programmatically edit the
  records (Fixed #665)
* Manually scheduled tasks are changed to not skip non-working time for proposed start/end date values. Check the
  upgrade guide if you want to revert to the previous behaviour (Fixed #2326)
* Added a `pinSuccessors` config that allows successors to stay in place by adjusting lag when dragging a task
  (Fixed #3998)
* Gantt's task rendering now uses absolute positioning instead of translation to position the task bars. This was
  changed to match changes in Scheduler and Scheduler Pro (Fixed #4055)
* New `ParentArea` feature highlighting the area encapsulating all child tasks (Fixed #1290)
* New `ProjectModel` setters/getters for `assignments`, `calendars`, `dependencies`, `resources`, `tasks`, `timeRanges`
  (Fixed #4043)
* New `highlight-time-spans` demo showing how to visualize time spans
* New `grid-regions` demo showing how to place columns on the right side of the timeline
* `window` references are replaced with `globalThis` which is supported in all modern browsers and across different JS
  environments (Fixed #4071)
* Gantt now triggers `beforeMspExport` and `mspExport` events when `MspExport` feature is used (Fixed #3565)
* A new function called `downloadTestCase()` was added to Bryntum widgets, it is intended to simplify creating test
  cases for reporting issues on Bryntum's support forum. Running it collects the current value for the configs your app
  is using, inlines the current dataset and compiles that into a JavaScript app that is then downloaded. The app will
  most likely require a fair amount of manual tweaking to reproduce the issue, but we are hoping it will simplify the
  process for you. Run `gantt.downloadTestCase()` on the console in a demo to try it
* Updated FontAwesome Free to version 6, which includes some new icons sponsored by Bryntum in the charts category:
  https://fontawesome.com/search?m=free&c=charts-diagrams&s=solid
* When configured with a StateProvider and `stateId`, Gantt state is stored automatically as stateful properties
  change (Fixed #1859)
* You can now style `CalendarIntervals` by providing a `cls` field in their data. This makes it very easy to style non
  working time elements (Fixed #3255)
* [WRAPPERS] Gantt has a new `ProjectModel` framework wrapper available for React, Vue and Angular. It simplifies
  sharing data between multiple Bryntum components  (Fixed #4877)
* [ANGULAR] New demo showing use of inline data. Demo located in `examples/frameworks/angular/inline-data` folder
* [REACT] New demo showing use of inline data. Demo located in `examples/frameworks/react/javascript/inline-data`
  folder
* [VUE] New demo showing use of inline data. Demo located in `examples/frameworks/vue/javascript/inline-data` folder
* [VUE-3] New demo showing use of inline data. Demo located in `examples/frameworks/vue-3/javascript/inline-data` folder

For more details, see [What's new](https://bryntum.com/docs/gantt/#Gantt/guides/whats-new/5.0.0.md)
and [Upgrade guide](https://bryntum.com/docs/gantt/#Gantt/guides/upgrades/5.0.0.md) in docs

## API CHANGES

* [BREAKING] The Engine `ResourceAllocationInfo` class `allocation` property has been changed from an `Array` to
  an `Object` with two properties `total` and `byAssignments`. The `total` property contains an array of the resource
  allocation intervals. And the `byAssignments` is a `Map` keeping individual assignment allocation intervals with
  assignments as keys and arrays of allocation intervals as values
  Please check [Upgrade guide](https://bryntum.com/docs/scheduler-pro/#Gantt/guides/upgrades/5.0.0.md) if
  your code uses that class
* [BREAKING] React wrappers now use the more modern module bundle by default, instead of the legacy umd bundle. Hence
  application imports must be changed to match. This will slightly improve application size and performance
  (Fixed #2787)
* [DEPRECATED] ResourceHistogram `getBarTip` config has been deprecated in favour of new `barTooltipTemplate` config
  Please check the upgrade guide and update your code accordingly
* Store's `toJSON()` method now ignores all local filters and returns all records (Fixed #4101)
* `DependencyModel.active` field has been changed to be persistable by default. To revert to the old behavior
  please override the field and set its `persist` config to `false`
* The following previously deprecated Gantt configs, functions etc. where removed:
    * `TaskContextMenu` feature - previously replaced by `TaskMenu` feature
    * Arguments `startText`, `endText`, `startClockHtml`, `endClockHtml` & `dragData` of `TaskDrag#tooltipTemplate()`
    * Config `TaskEdit#tabsConfig` - previously replaced by `items`
    * Config `ProjectModel#eventModelClass` - previously replaced by `taskModelClass`
    * Config `ProjectModel#eventStoreClass` - previously replaced by `taskStoreClass`
    * Field `TaskModel#wbsIndex` - previously replaced by `wbsValue`
    * Argument `tplData` of `Gantt#taskRenderer()` - previously replaced by `renderData`
    * Config `AssignmentPicker#grid` - previously replaced by configuring `AssignmentPicker` directly
    * Config `TaskEditor#durationDecimalPrecision` - previously replaced by `durationDisplayPrecision`
  * Event `Gantt#beforeExport` - in favor of `beforePdfExport` event
  * Event `Gantt#export` - in favor of `pdfExport` event

## BUG FIXES

* Fixed #209 - TaskArea layer plugin for Gantt
* Fixed #1771 - Parent task not rerendered on expand or collapse
* Fixed #1965 - Exception is thrown when adding a dependency results in constraint violation
* Fixed #3786 - Erratic dragging when using `getDateConstraints`
* Fixed #3898 - MS Project import fails for MPX files using wk duration unit
* Fixed #3957 - Gantt label editing only works once
* Fixed #3966 - Dependency error message should be shown on the field
* Fixed #3993 - MS Project import demo fails to import MPX file
* Fixed #4003 - Bigdataset initial rendering artefacts
* Fixed #4113 - Calendar is not applies when switching via projects
* Fixed #4142 - Timeline demo issue
* Fixed #4165 - Exception in custom task bar demo
* Fixed #4179 - Events disappear when clicking size buttons
* Fixed #4232 - Rollups + loading nodes on demand causes a crash

# 4.3.9 - 2022-02-17

## BUG FIXES

Fixed #4121 - Reasonable minimum task bar in both `Gantt` and `Scheduler`
Fixed #4170 - `Column` interface is missing `static get type()`
Fixed #4172 - `HasPercentDoneMixin` is not exported in `Gantt` bundle
Fixed #4209 - `transformFlatData` not working if `children : true` is present

# 4.3.8 - 2022-02-07

## BUG FIXES

* Fixed #4072 - `Container.setValues` should use each widget's `defaultBindProperty`, not hardcode value
* Fixed #4104 - MS Project export feature does not extract assignments
* Fixed #4107 - MS Project export feature retrieves wrong duration for manually scheduled tasks
* Fixed #4118 - Assigning resource via `ResourceAssignmentColumn` doesn't trigger events in `assignmentStore`

# 4.3.7 - 2022-02-02

## FEATURES / ENHANCEMENTS

* The new `newTaskDefaults` allows you to customize values applied to newly created tasks through UI (Fixed #4004)
* CellEdit can now be configured to stop editing after clicking another cell via its new `continueEditingOnCellClick`
  config (Fixed #4046)

## API CHANGES

* [DEPRECATED] Gantt `beforeExport` and `export` events (triggered by `PdfExport` feature) were deprecated in favor of
  the `beforePdfExport` and `pdfExport` events respectively. The old events names will be dropped in v5.0.0

## BUG FIXES

* Fixed #3997 - Store id property documentation is not clear
* Fixed #4007 - End to end dependency is not drawn in some cases
* Fixed #4012 - Unexpected scheduling conflict
* Fixed #4029 - `autoEdit` should not react when CTRL / CMD key is used to copy & paste
* Fixed #4033 - `taskKeyDown`, `taskKeyUp` event parameter missing
* Fixed #4037 - Resource name in Assignment Picker is too escaped
* Fixed #4041 - `TextArea` ignores arrowDown key press
* Fixed #4064 - Unexpected constraint when setting a dependency lag
* Fixed #4082 - Relayed listeners do not trigger onFunctions

# 4.3.6 - 2022-01-13

## BUG FIXES

* Fixed #3788 - Minimum value for duration field in Task Editor works incorrect
* Fixed #3981 - Predecessor/successor column filter shows incorrect value when clicked Equals
* Fixed #3990 - Chrome & Content Security Policy causes failure because of debug code section
* Fixed #4008 - Filter icon disappears when a column is hidden

# 4.3.5 - 2021-12-24

## BUG FIXES

* Fixed #3746 - Minimum value violated error for end date field in the task editor
* Fixed #3750 - Resizing task end date puts start date constraint
* Fixed #3887 - Calendar applies wrong if it's startDate is far in the past
* Fixed #3896 - [TypeScript] Wrong typings of model class configs
* Fixed #3900 - MS Project export feature uses wrong UID type
* Fixed #3907 - [TypeScript] Cannot pass Scheduler instance to `Store.relayAll`
* Fixed #3923 - Dependency line has extra points with certain system scaling
* Fixed #3928 - DateHelper `k` format behaves incorrectly

# 4.3.4 - 2021-12-13

## FEATURES / ENHANCEMENTS

* Updated `advanced`, `gantt-schedulerpro` and `taskeditor` Angular demos to use Angular 13 (Fixed #3742)
* Enhanced `wbsMode` to allow an object indicating what triggers renumbering WBS values (Fixed #3858)

## BUG FIXES

* Fixed #3621 - [TypeScript] Improve typings of mixins
* Fixed #3777 - Online angular pdf export demo has wrong export server configured
* Fixed #3803 - Can't change dependency type using column editor
* Fixed #3850 - [TypeScript] Missing static properties in typings
* Fixed #3854 - `DependencyColumn` does not produce valid value for the Filter Feature
* Fixed #3878 - `DependencyField` renders (undefined) if used out of scope of the project

# 4.3.3 - 2021-11-30

## FEATURES / ENHANCEMENTS

* `ResourceAssignmentColumn` has a new `avatarTooltipTemplate` config that lets you supply custom content for the avatar
  tooltip (Fixed #2954)

## BUG FIXES

* Fixed #3626 - Tasks overlap each other on vertical drag
* Fixed #3628 - Task Editor combo `listItemTpl` has no effect
* Fixed #3639 - `wbsValue` is now correctly updated when sorting the `TaskStore` and `wbsMode: 'auto'` is enabled
* Fixed #3645 - Dependency links are not shown up at browser zoom level 75%
* Fixed #3648 - [DOCS] Content navigation is broken
* Fixed #3676 - Error when using predecessor/successor filters
* Fixed #3677 - Crash in `cellEdit` when starting edit record in collapsed parent
* Fixed #3689 - Implement support of PDF export feature on Salesforce
* Fixed #3720 - `dataSource` property not working on dependency from and to fields
* Fixed #3726 - Remove outline when using mouse
* Fixed #3734 - Resource Assignment Picker needs a `minHeight`
* Fixed #3743 - [DOCS] `web.config` file for Windows IIS server
* Fixed #3751 - Gantt localization bundle contains unwanted `Core` code
* Fixed #3794 - `ProjectLines` feature doesn't react to project change
* Fixed #3807 - `beforeTaskDrag` event is fired on mouse down
* Fixed #3821 - `MspExport` feature exports only expanded node tasks

# 4.3.2 - 2021-10-29

## FEATURES / ENHANCEMENTS

* New `summary` demo showing how to add a summary bar to the Gantt (Fixed #3601)
* The `WBS` field can now be automatically refreshed by setting `wbsMode: 'auto'` on the `TaskStore` class (Fixed #2721)
* `TaskCopyPaste` feature now fires `beforeCopy` and `beforePaste` events to let you prevent the actions (Fixed #3303)

## BUG FIXES

* Fixed #3464 - Infinite loop when `earlystart` is displayed with a `null` startDate/endDate
* Fixed #3572 - `wbsValue` updates are not included into sync pack after it set to be persistent
* Fixed #3584 - Project start date is not updated after task addition, when initially no tasks have start/end/duration
  data
* Fixed #3597 - Removing the `startDate`/`endDate` of a task with dependencies prevent you from scheduling it again
* Fixed #3599 - `readOnly` flag allows task drag drop
* Fixed #3605 - Pressing ESC during task drag schedule leaves an element
* Fixed #3610 - `readOnly` not disabling actions in Task Context Menu
* Fixed #3612 - `TaskModelClass` cannot be defined in project settings
* Fixed #3618 - LockerService exception: The addEventListener method on ShadowRoot does not support any options

# 4.3.1 - 2021-10-21

## FEATURES / ENHANCEMENTS

* Bumped builtin Font Awesome Free to version 5.15.4
* Added new demo `drag-from-grid` showing how to drag unplanned tasks onto the Gantt
* Added new config `scrollTaskIntoViewOnCellClick` which scrolls the task bar into when clicking a cell in the table
* `ProjectModel` now has a `resetUndoRedoQueuesAfterLoad` flag to optionally clear undo / redo queues after each load
  (Fixed #3549)
* A group column can now be `sealed` meaning you are not allowed to drop columns into it (Fixed #3536)

## BUG FIXES

* Fixed #802  - Rollup elements should be rendered same way as task itself
* Fixed #3389 - Tasks copy/paste doesn't copy dependencies nor maintain tree indent level properly
* Fixed #3425 - Infinite cycle in the Engine
* Fixed #3429 - Reload dependencies as `inlineData` causes error when visible in React
* Fixed #3558 - Id column in TaskEditor´s `DependencyTab` is not sortable
* Fixed #3561 - Crash after right clicking columns on Gantt Predecessor / Successor, only works on the first one
* Fixed #3563 - Gantt - Feature toggle event for baselines feature does not fire
* Fixed #3567 - Minified css bundle contains unicode chars
* Fixed #3576 - Gantt `TaskDragCreate` must not delete task on ESC
* Fixed #3578 - Crash when setting calendar column editor to false

# 4.3.0 - 2021-10-12

## FEATURES / ENHANCEMENTS

* Inactive tasks support has been added. Such tasks don't take part in the scheduling yet stay in the project plan. For
  more details please check
  ["Inactive tasks"](https://bryntum.com/docs/gantt/guide/Gantt/basics/inactive_tasks) guide and see
  [this new demo](https://bryntum.com/examples/gantt/inactive-tasks) (Fixed #2981, #807)
* `ResourceHistogram` now supports resource grouping. It displays the aggregated resources allocation on the group
  level (Fixed #2608)
* [IONIC] Added Ionic framework integration demo. Demo located in `examples/frameworks/ionic/ionic-4` folder
  (Fixed #2622)

## API CHANGES

* [DEPRECATED] Buttons `menuIconCls` config was deprecated in favor of the new `menuIcon` config, which better matches
  the naming of other configs

## BUG FIXES

* Fixed #3457 - Filter field inside toolbar overflow hides after every keypress
* Fixed #3484 - Gantt does not handle if resource store is grouped

# 4.2.7 - 2021-10-01

## FEATURES / ENHANCEMENTS

* Added new `setCalculations` method to the `ProjectModel` class. The method toggles the project
  owned model fields calculation functions, which allows changing the behavior of standard fields dynamically
  Please check the new `static` demo for details (Fixed #2284, Fixed #2327)

## BUG FIXES

* Fixed #2909 - MS Project importer doesn't support project calendar recurring exceptions
* Fixed #3243 - Dependency links are misplaced when browser zoom level is 75%
* Fixed #3272 - Expanding last node sometimes doesn't increase scroll size
* Fixed #3382 - visibleDate works incorrect if `startDate` is not provided (re-fix)
* Fixed #3396 - MSProjectReader does not import calendar intervals properly
* Fixed #3424 - Crash when showing id column of predecessor grid in task editor
* Fixed #3426 - Button with menu should show extra menu arrow icon
* Fixed #3441 - Invalid dependency format errors when filtered
* Fixed #3450 - Unable to set columns store data on Gantt instance
* Fixed #3453 - QuickFind feature doesn't work in Gantt
* Fixed #3454 - Timeline tasks should use 'cls' field
* Fixed #3458 - Document nested fields
* Fixed #3459 - Add an event when expanding/collapsing subgrids
* Fixed #3460 - Dependency terminals not hidden after task resize
* Fixed #3462 - Exception in the Gantt when Project endDate is not calculated
* Fixed #3465 - Gantt ResourceAssignmentColumn too many decimal places
* Fixed #3466 - An error if totalslack column used and Saturday work scheduled

# 4.2.6 - 2021-09-15

## BUG FIXES

* Fixed #3382 - `visibleDate` works incorrect if `startDate` is not provided
* Fixed #3400 - Export to MS Project throws error when `startDate` or `endDate` is `null`
* Fixed #3408 - Updated typings to support spread operator for method parameters

# 4.2.5 - 2021-09-08

## FEATURES / ENHANCEMENTS

* New `gantt.node.mjs` and `gantt.node.cjs` bundles are available. Both are compatible with the
  Node.js environment (Fixed #3224)
* Added `keyMap` config to reconfigure or disable cut / copy / paste keyboard shortcuts for TaskCopyPaste (Fixed #3351)
* ProjectModel now fires a `dataReady` event when the engine has finished its calculations and the result has been
  written back to the records (Fixed #2019)
* The API documentation now better communicates when a field or property accepts multiple input types but uses a single
  type for output. For example date fields on models, which usually accepts a `String` or `Date` but always outputs a
  `Date` (Fixed #2933)
* New `custom-headers` demo showing how to customize the rows shown in the time axis header

## BUG FIXES

* Fixed #1847 - Gantt bundle does not export Engine classes
* Fixed #3120 - Cannot read property 'map' of undefined in task store toJSON
* Fixed #3283 - Resources grouping works incorrect with some data set
* Fixed #3322 - Add `dataChange` event to framework guides
* Fixed #3337 - Gantt `ProjectModel#sync` Promise does not return response data
* Fixed #3345 - AspNet demos use wrong `@bryntum` npm package version
* Fixed #3346 - Gantt web component does not show critical paths
* Fixed #3347 - Inconsistent Language - Start to Finish/Start to End
* Fixed #3350 - Disabling task copy paste feature leaves keyboard shortcuts still active
* Fixed #3359 - Dependency id column in predecessors tab render the `dependencyIdField` rather than `task.id`
* Fixed #3365 - Indicators config is mutated preventing reuse
* Fixed #3371 - Label editor misaligned
* Fixed #3379 - Crash when dates missing when using critical path

# 4.2.4 - 2021-08-27

## FEATURES / ENHANCEMENTS

* MS Project export feature now exports task baselines (Fixed #3278)
* Project now triggers a `change` event when data in any of its stores changes. Useful to listen for to keep an external
  data model up to date for example (Fixed #3281)
* Project got a new config `adjustDurationToDST` which is `false` by default, meaning project will no longer try to keep
  task duration in hours an integer multiple of 24. This change fixes the problem with task end date shifting 1 hour
  from midnight in certain cases. To return to the old behavior set this config to `true` (Fixed #3329)

## BUG FIXES

* Fixed #794 - Dependency creation tooltip is initially misaligned
* Fixed #1432 - Gantt doesn't take DST into account for task duration
* Fixed #3116 - Gantt throws on task terminal drag
* Fixed #3127 - appendChild function of task model is not working
* Fixed #3132 - Add support of "mo" units to MS Project import
* Fixed #3170 - Tasks are not rescheduled after adding intervals to calendar
* Fixed #3250 - Menus do not work in fullscreen mode
* Fixed #3264 - Progress line ignores milestones
* Fixed #3265 - Docs are not scrolled to the referenced member
* Fixed #3270 - Cutting and Pasting tasks does not preserve the order
* Fixed #3283 - Resources grouping works incorrect with some data set
* Fixed #3284 - PercentDoneColumn cannot use other model field
* Fixed #3291 - Gantt dependency tooltip should render the dependencyIdField rather than `task.id`
* Fixed #3296 - Task editor does not show if triggered when schedule region is collapsed
* Fixed #3301 - Copy/Paste should not react if cell or editor text is selected
* Fixed #3305 - Guides look bad in the docs search results
* Fixed #3306 - Doc browser does not scroll to member
* Fixed #3311 - alwaysWrite field causing stack overflow for task 'calendar'
* Fixed #3321 - Baseline bars misrendered if task has no start / end dates
* Fixed #3324 - Not possible to select end date after editing

# 4.2.3 - 2021-08-05

## FEATURES / ENHANCEMENTS

* Project can now log warnings to the browser console when it detects an unexpected response format. To enable these
  checks please use the `validateResponse` config (Fixed #2668)
* [NPM] Bryntum Npm server now supports remote private repository access for Artifactory with username and password
  authentication (Fixed #2864)
* The PdfExport feature now supports configuring its ExportDialog to pre-select columns to export or to customize any of
  the child widgets (Fixed #2052)
* [TYPINGS] Type definitions now contain typed `features` configs and properties (Fixed #2740)

## API CHANGES

* [DEPRECATED] PdfExport feature `export` event is deprecated and will be removed in 4.3.0. Use `export` event on the
  Gantt instead
* [DEPRECATED] Gantt `beforeExport` event signature is deprecated and will be removed in 4.3.0. New signature wraps
  config object to the corresponding key

## BUG FIXES

* Fixed #431 - Baseline index is NaN in tooltip
* Fixed #3116 - Gantt throws on task terminal drag
* Fixed #3184 - Visual artifact with full % Done column in circle mode
* Fixed #3202 - Bug with scrolling the column visibility pop-up
* Fixed #3204 - TimeRanges data provided inline is not rendered
* Fixed #3206 - Selection is not updated when triggering contextmenu on expander icon
* Fixed #3214 - Resizing or dragging column in a grid inside a Popup starts drag & drop of outer popup
* Fixed #3229 - Filter by typing in Predecessor and Successor field doesn't filter by wbsCode
* Fixed #3235 - Export to MSProject does not support cyrillic symbols
* Fixed #3247 - Scroller position reset to 0 when filtering using FilterBar with no results
* Fixed #3248 - Crash when dragging task if no 'locked' region exists

# 4.2.2 - 2021-07-21

## FEATURES / ENHANCEMENTS

* Added a new `hideRangesOnZooming` config to `NonWorkingTime` feature (Fixed #2788). The config allows to disable the
  feature default behavior when it hides ranges shorter than the base timeaxis unit on zooming out
* [NPM] Bryntum Npm server now supports `npm token` command for managing access tokens for CI/CD (Fixed #2703)

## API CHANGES

* [DEPRECATED] Class `GanttMspExport` exported from the bundle is deprecated, use `MspExport` instead
  `GanttMspExport` will be removed from the bundle in 5.0

## BUG FIXES

* Fixed #416 - TreeNode children field cannot be mapped
* Fixed #435 - Cannot map baselines field and baseline start/end fields
* Fixed #2071 - Support configuring eventeditor / taskeditor child items with 'true' value
* Fixed #3114 - TaskEdit crashes when tab panel items configured with true
* Fixed #3153 - Critical Paths feature does not include all paths
* Fixed #3159 - Gantt Task Editor Resources tab user combo should be editable for filtering
* Fixed #3160 - ResourceAssignmentColumn throws an error after closed with filtered data
* Fixed #3167 - LWC bundle is missing from trial packages
* Fixed #3169 - Unhovered task dependency terminals not properly hidden
* Fixed #3176 - Dependency arrow not pointing task for end-to-start relationship if target task is short
* Fixed #3178 - Syntax highlighter messes up code snippets in docs
* Fixed #3185 - Add CSS class to indicate that an event is being created
* Fixed #3196 - MspExport feature is missing from the angular wrapper

# 4.2.1 - 2021-07-07

## FEATURES / ENHANCEMENTS

* [FRAMEWORKS] Added `taskCopyPasteFeature` to frameworks wrappers (Fixed #3135)

## BUG FIXES

* Fixed #3136 - [NPM] Running `npm install` twice creates modified `package-lock.json` file

# 4.2.0 - 2021-06-30

## FEATURES / ENHANCEMENTS

* Gantt has a new config option `infiniteScroll` meaning that as the user scrolls the timeline back or forward in time,
  the "window" of time encapsulated by the time axis is moved. Added `infinite-scroll` demo. (Fixed #3048)
* The `TaskResize` feature now uses the task's data to change the appearance by updating `endDate` live but in batched
  mode so that the changes are not propagated until the operation is finished. (Fixed #2541)
* Dependencies can now be created by dropping on the target task without hitting the terminal circle element. The
  defaultValue of the DependencyModel `type` field will be used in this case. (Fixed #3003)
* Dependency creation can now be finalized asynchronously, for example after showing the user a confirmation dialog
* Name column in predecessors / successors grid is now editable by default for easy filtering of tasks (Fixed #3045)
* Added "Upgrade Font Awesome icons to Pro version" guide
* Added "Replacing Font Awesome with Material Icons" guide
* [FRAMEWORKS] Added SchedulerPro component wrappers and `gantt-schedulerpro` demos for frameworks (Fixed #2970)

## LOCALE UPDATES

* `removeRows` label of CellMenu & GridBase was removed
* Value of `removeRow` label of CellMenu & GridBase was updated to say just 'Remove'
* RowCopyPaste locales were updated to just say 'Copy', 'Cut' & 'Paste'. `copyRows`, `cutRows` & `pasteRows` keys were
  removed
* EventCopyPaste locales were updated to just say 'Copy', 'Cut' & 'Paste'. `copyRows`, `cutRows` & `pasteRows` keys were
  removed
* TaskCopyPaste locales were updated to just say 'Copy', 'Cut' & 'Paste'. `copyRows`, `cutRows` & `pasteRows` keys were
  removed
* Gantt `Edit` text was updated to be just 'Edit'
* Gantt `Delete task` text was updated to be just 'Delete'

## BUG FIXES

* Fixed #164 - No drag proxy visible while setting start/end dates by dragging
* Fixed #516 - Cannot create dependencies if showCreationTooltip is false
* Fixed #3074 - Throwing exception when create dependency on drag
* Fixed #3091 - Wrong label for Delete task when several tasks are selected

* For more details, see [What's new](https://bryntum.com/docs/gantt/guide/Gantt/whats-new/4.2.0) and
  [Upgrade guide](https://bryntum.com/docs/gantt/guide/Gantt/upgrades/4.2.0) in docs

# 4.1.6 - 2021-06-23

## FEATURES / ENHANCEMENTS

* TaskEdit has a new `scrollIntoView` boolean config allowing to opt-out of scrolling the task being edited into view
  (Fixed #997)
* Indicators feature now support a `tooltipTemplate` defining the tooltip markup (Fixed #3032)

## BUG FIXES

* Fixed #2267 - Parent row is expanded on task drop, even if task is added as a sibling
* Fixed #2738 - Not possible to set initial value for combo if ajaxstore used
* Fixed #3005 - [VUE-3] Problem with Critical Paths due to Vue Proxy and double native events firing bug
* Fixed #3012 - Labels demo functionality is broken
* Fixed #3014 - Collapsed tasks do not appear as options in dependency column editors
* Fixed #3024 - Task context menu should hide when drag drop starts on touch device
* Fixed #3026 - [VUE-2] and [VUE-3] typescript type declarations are missing
* Fixed #3028 - Parent task turned into leaf after removing child task
* Fixed #3029 - Child nodes not removed after collapsing parent node in tree grid
* Fixed #3030 - editorClass has no effect on TaskEdit config
* Fixed #3041 - Should be possible to define a type on editorConfig of TaskEdit feature

# 4.1.5 - 2021-06-09

## FEATURES / ENHANCEMENTS

* Gantt now has a `minHeight` of `10em` by default. This assures that the Gantt will get a size even if no other sizing
  rules are applied for the element it is rendered to. When the default `minHeight` is driving the height, a warning is
  shown on the console to let the dev know that sizing rules are missing. The warning is not shown if a `minHeight` is
  explicitly configured (Fixed #2915)
* [TYPINGS] API singleton classes are correctly exported to typings (Fixed #2752)

## BUG FIXES

* Fixed #674 - Setting field value or visibility does not work in beforeTaskEditShow when field has "name" property
  specified
* Fixed #2889 - [ANGULAR] Project model event listeners do not fire on production angular build
* Fixed #2955 - Constraint type column combo filtering issue
* Fixed #2985 - RowReorder drag proxy element misplaced
* Fixed #2986 - ResourceAssigmentColumn initials duplicated after resizing column
* Fixed #2990 - [ANGULAR] Preventable async events don't work
* Fixed #3001 - Excel export - excel reports error when percent done column is exported

# 4.1.4 - 2021-05-28

## FEATURES / ENHANCEMENTS

* TypeScript definitions updated to use typed `Partial<>` parameters where available
* New migration guide describing how to migrate an Ext JS-based Gantt demo app to use Bryntum Gantt (Fixed #378)
* You can now access the combo box for the "Add New" column using its `combo` property (Fixed #2938)
* Buttons now has a new style `b-transparent` that renders them without background or borders (Fixed #2853)
* [NPM] repository package `@bryntum/gantt` now includes source code (Fixed #2723)
* [NPM] repository package `@bryntum/gantt` now includes minified versions of bundles (Fixed #2842)
* [FRAMEWORKS] Frameworks demos packages dependencies updated to support Node v12

## API CHANGES

* CSS classes for baseline elements changed slightly so make sure to revise any styling you have used based on
  `b-baseline-milestone` CSS class (removed). Each baseline task now has `b-task-baseline` and milestones have
  `b-task-baseline-milestone`

## BUG FIXES

* Fixed #1848 - Manually scheduled summary tasks slack value
* Fixed #2104 - "Core" code not isomorphic
* Fixed #2119 - Manually scheduled tasks are always critical
* Fixed #2702 - Baseline duration is calculated differently than for regular tasks
* Fixed #2775 - Combo replaces its store data on set value if filterParamName defined
* Fixed #2828 - Memory leak when replacing project instance
* Fixed #2834 - Core should not use b-fa for icon prefix
* Fixed #2914 - Crash after destroying Gantt with custom tip config object
* Fixed #2921 - Timeaxis configuration error on wrongly calculated project date range
* Fixed #2931 - Baseline milestone lack unique CSS class for styling

# 4.1.3 - 2021-05-13

## FEATURES / ENHANCEMENTS

* Percent Bar feature allows to use a custom field instead of percentDone (Fixed #2739)
* Bumped the built in version of FontAwesome Free to 5.15.3 and added missing imports to allow stacked icons etc
* Bumped the `@babel/preset-env` config target to `chrome: 75` for the UMD and Module bundles. This decreased bundle
  sizes and improved performance for modern browsers
* TaskResize now has a configurable `tooltipTemplate` so you can easily show custom contents in the resizing tooltip
  See updated 'tooltips' demo to try it out (Fixed #2244)
* Updated Angular Wrappers to be compatible with Angular 6-7 in production mode for target `es2015`

## API CHANGES

* The locale key that defines the width of the task editor was moved to Scheduler Pro, since it can also use Gantt's
  task editor. If you are using a locale based custom width for it, you will need to update your locale. Please see the
  upgrade guide (Fixed #2789)
* [DEPRECATED] TaskDrag#dragTipTemplate was renamed to `tooltipTemplate` to better match the naming scheme of other
  features
* [DEPRECATED] The `startText`, `endText`, `startClockHtml`, `endClockHtml`, `dragData` params of the TaskDrag
  dragTipTemplate / tooltipTemplate methods have been deprecated and will be removed in 5.0

## BUG FIXES

* Fixed #2313 - Filter operator should use contains search if "*" used
* Fixed #2543 - Task editor doesn't reset not saved data if clicked Cancel and reopen
* Fixed #2604 - Gantt trial LWC does not render task elements
* Fixed #2665 - Timeline does not render events when used as container item
* Fixed #2766 - Max call stack error if schedulingconflict event has listeners
* Fixed #2772 - When task resize feature is disabled, cursor should not change to ew-resize in start-resize areas
* Fixed #2773 - Uncaught TypeError with certain feature combinations
* Fixed #2776 - WBS column exports padded value
* Fixed #2778 - Wrong module declaration in typings file
* Fixed #2818 - Milliseconds are not displayed correctly in Gantt headers
* Fixed #2871 - Export - Percent done column doesn't render when showCircle is true

# 4.1.2 - 2021-04-27

## BUG FIXES

* Fixed #2760 - [WRAPPERS] Missing taskDragFeature, TaskDragCreateFeature, TaskResizeFeature configs in Gantt
* Fixed #2761 - Task editor padding missing

# 4.1.1 - 2021-04-23

## FEATURES / ENHANCEMENTS

* Scheduler / Gantt / Calendar will now react when CTRL-Z key to undo / redo recent changes made. Behavior can be
  controlled with the new `enableUndoRedoKeys` config (Fixed #2532)
* New React Gantt Resource Histogram demo has been added

## BUG FIXES

* Fixed #868 - Should be possible to show all available context menus programmatically
* Fixed #1913 - "Already entered replica" error when setting taskStore.data with syncDataOnLoad flag
* Fixed #1987 - DOCS: React guide needs a section on how to listen for events
* Fixed #2138 - ResourceHistogram is not refreshed after inline data reset and load again
* Fixed #2266 - Extra icons are displayed during row reordering in advanced demo
* Fixed #2488 - TaskEditor tab configuration in beforeTaskEditShow does not work correct
* Fixed #2493 - GeneralTab defines the height of the TaskEditor
* Fixed #2538 - Error when closing assignment field picker with filter applied
* Fixed #2618 - Crash when using Gantt without 'dependenciesFeature'
* Fixed #2635 - Milestone Resize Error
* Fixed #2636 - [WRAPPERS] Features are not updated at runtime
* Fixed #2647 - Timeline doesn't render without appendTo config
* Fixed #2679 - on-owner events should be added to owner too in docs
* Fixed #2681 - Yarn. Package trial alias can not be installed
* Fixed #2728 - Lag unit should be based on task durationUnit (if omitted) when setting lag for predecessors/successors

# 4.1.0 - 2021-04-02

## FEATURES / ENHANCEMENTS

* We are happy to announce that Bryntum Gantt now can be directly installed using our npm registry
  We've updated all our frameworks demos to use `@bryntum` npm packages. See them in `examples/frameworks` folder
  Please refer to "Npm packages" guide in docs for registry login and usage information
* Improved styling guide with more examples
* New "custom-taskbar" example showing how to customize the task bar to include a number for every time axis tick
  (Fixed #2572)
* ProjectModel now exposes a `changes` property returning an object with the current changes in its stores
* Bryntum demos were updated with XSS protection code. `StringHelper.encodeHtml` and `StringHelper.xss` functions were
  used for this
* Parent task bars now have 2em max-height to look nicer in taller rows
* Added new Vue Cell Renderer demo to show Vue Components as cell renderers (Partial fix #946)
* Added new Vue 3 example for Gantt (Fixed #1435)
* `ResourceAssignmentColumn` now shows resource initials if no avatar image exists. `ResourceAssignmentGrid` resource
  column now shows a resource avatar, or initials if no avatar image exists (Fixed #2202)
* Updated React SharePoint Fabric demo to use Gantt toolbar component
* Added new React 17 demo for Gantt with Timeline widget. The example also implements theme switching (Fixed #1823 and
  Fixed #2213)
* Added new Vue 3 Simple demo to show how to use Bryntum Gantt in Vue 3 (Fixed #1315)
* Rollups Angular demo was updated for Angular 10 (Fixed #2361)
* Updated Angular/React/Vue frameworks Advanced demos to not use wrapping Panel (Fixed #2165)

## API CHANGES

* [BREAKING] Removed RequireJS demos and integration guides in favor of modern ES6 Modules technology (Fixed #1963)
* [BREAKING] `init` method is no longer required in Lightning Web Components and was removed from the LWC bundle
* [DEPRECATED] CrudManager/ProjectModel `commit` was deprecated in favor of `acceptChanges`
* [DEPRECATED] CrudManager/ProjectModel `commitCrudStores` was deprecated in favor of `acceptChanges`
* [DEPRECATED] CrudManager/ProjectModel `reject` was deprecated in favor of `revertChanges`
* [DEPRECATED] CrudManager/ProjectModel `rejectCrudStores` was deprecated in favor of `revertChanges`
* [DEPRECATED] In the `DependencyCreation` feature, the `data` param of all events was deprecated. All events now have
  useful documented top level params

## BUG FIXES

* Fixed #888 - Copy / Cut / Paste task API + context menu entries
* Fixed #1525 - Improve Localization guide
* Fixed #1678 - The dirty indicator is not shown after changing duration when showDirty is enabled
* Fixed #1689 - Investigate sharing static resource between multiple LWC on the same page
* Fixed #1964 - Selecting one record highlights two elements on specific screen size
* Fixed #1968 - MS Project import demo should make imported data phantom
* Fixed #1983 - [REACT] JSX renderer not supported for TreeColumn
* Fixed #2065 - Adding manually scheduled parent task as predecessor from the cell editor fails
* Fixed #2089 - Adding new assignments from ResourceAssignmentColumn should respect data field mapping
* Fixed #2117 - TaskStore reports having changes after filtering tasks
* Fixed #2203 - Improve Project data loading / syncing docs
* Fixed #2211 - Add test coverage for XSS
* Fixed #2220 - Exception when modifying new task in advanced demo
* Fixed #2221 - Task start/end/duration go blank when pressing Enter in duration field of new task
* Fixed #2226 - Undo button reacts when critical path button is clicked
* Fixed #2297 - Hiding task menu subitems is broken
* Fixed #2249 - MSP importer returns success response with java exception as data
* Fixed #2323 - Dependency drag creation fails
* Fixed #2330 - Assignment change not recorded correctly
* Fixed #2335 - Changes returned in onSync are sent back in the next onSync call
* Fixed #2342 - Wrong validation successor when change successor to dependent task
* Fixed #2351 - Crash when changing Start Date after setting new project
* Fixed #2359 - Update readme files in all framework demos in all products
* Fixed #2363 - TaskModel should have public "expanded" field
* Fixed #2372 - TaskEditor doesn't reset cell editor on reopen if invalid value entered
* Fixed #2373 - Some cyclic dependencies for Successors incorrectly validated by TaskEditor
* Fixed #2377 - Prevent End Date from being set before start date
* Fixed #2379 - Add minified version of *.lite.umd.js to the bundle
* Fixed #2382 - project.load() throws an error when called on filtered store
* Fixed #2400 - Sync failure messages displayed in `syncMask` where not auto-closing
* Fixed #2420 - Duration filter is not restored from state properly when custom filterFn is specified
* Fixed #2434 - Content encoding issues (XSS related)
* Fixed #2441 - Demo control sizes and styling issues
* Fixed #2460 - Comma should be a valid decimal separator in DurationField
* Fixed #2464 - WBS field is now updated correctly on indent/outdent
* Fixed #2486 - Month/year picker is not aligned to date picker properly
* Fixed #2491 - Make a field on a dependency model to disable it
* Fixed #2492 - Removed dependency is rendered
* Fixed #2517 - Crash when deleting task
* Fixed #2578 - Progress circle display artefacts

# 4.0.8 - 2021-01-27

## FEATURES / ENHANCEMENTS

* Task Editor start/end date fields now support entering of time if they are configured with `keepTime` config as
  `entered` (Fixed #1685) and if the fields `format` includes time info
* Project (Crud Manager) now supports less strict `sync` response format allowing to respond only server side changes
  See `supportShortSyncResponse` config for details
* Added preventable beforeIndent/beforeOutdent events on TaskStore (Fixed #2288)

## API CHANGES

* [BREAKING] Project (Crud Manager) default behaviour has been changed to allow `sync` response to include only
  server-side changes
  Previously it was mandatory to mention each updated/removed record in the response to confirm the changes
  With this release the project automatically confirms changes of all updated/removed records mentioned in
  corresponding request
  To revert to previous strict behaviour please use `supportShortSyncResponse` config

## BUG FIXES

* Fixed #1970 - Infinite requests if wrong response received
* Fixed #2214 - Exception when creating new task tree in PHP demo
* Fixed #2217 - Task editor throws when constraint type field is disabled
* Fixed #2263 - Dependency is not redrawn after changing dependency type
* Fixed #2286 - Non persistable field modification should not add record to update request package if `writeAllFields`
  is true

# 4.0.7 - 2021-01-12

## BUG FIXES

* Fixed #1815 - Dependency lines missing after changing project start date on filtered task store
* Fixed #2118 - Undo/redo popup titles are not localized
* Fixed #2178 - ResourceAssignmentColumn#itemTpl config is broken

# 4.0.6 - 2020-12-29

## FEATURES / ENHANCEMENTS

* The picker for DependencyField now also displays a dependencies identifier, as defined by the `dependencyIdField`
  config (Fixed #2078)
* Added support of imageUrl field to ResourceAssignmentColumn (Fixed #1914)
* Tasks in the predecessor / successor tabs in the TaskEditor are now sorted by name
* Tasks in the name column combo editor inside the predecessor / successor tabs in the TaskEditor are now sorted by name
  (Fixed #1790)

## BUG FIXES

* Fixed #1388 - Dependency creation tooltip styling broken in Safari
* Fixed #1992 - Manually scheduled summary tasks should allow editing of their duration and end date
* Fixed #1993 - Port task/dependency isEditable method from Ext Gantt
* Fixed #2025 - Predecessor and Successor don't work as expected with locales
* Fixed #2060 - Add sequenceNumber column to examples
* Fixed #2095 - Task editor shows incorrect set of constraints for the parent task
* Fixed #2136 - Changing task dependencies in cell editor leads to remove + add actions
* Fixed #2171 - Resource assignment cell content is rendered incorrectly for the first task

# 4.0.5 - 2020-12-15

## API CHANGES

* [DEPRECATED] `TaskModel#wbsIndex` is deprecated in favor of `TaskModel#wbsValue`

## BUG FIXES

* Fixed #1314 - Fix for ASPNET demo build in Windows cmd environment
* Fixed #1938 - Sorter should be reapplied after initial project calculation
* Fixed #2050 - Duration filter is applied incorrectly
* Fixed #2070 - wbsIndex field removed by mistake
* Fixed #2079 - WBS filter doesn't work from the context menu
* Fixed #2080 - WBS filter is not applied correctly
* Fixed #2081 - TaskModel.setBaseline call with the index greater than 1 when task has no baselines fails
* Fixed #2087 - CellEdit#addNewAtEnd not respected

# 4.0.4 - 2020-12-09

## API CHANGES

* TaskEdit feature now exposes an 'isEditing' boolean to detect if the editor is currently visible (Fixed #1935)

## FEATURES / ENHANCEMENTS

* Added config to specify allowed units (`DurationField.allowedUnits`) for the duration field (Fixed #1891)
* A new config `discardPortals` on the React wrapper, that controls the behaviour of cell renderers using React
  components. Set to `false` (default) to enhance performance. Set to `true` to limit memory consumption
* A new config dependencyIdField to set the Task field to use when creating / displaying a dependency between two
  tasks (Fixed #681)

## BUG FIXES

* Fixed #1229 - Dependency fields fromTask/toTask are not serialized
* Fixed #1485 - Task Editor centered config doesn't have effect
* Fixed #1812 - Make tables look better in docs
* Fixed #1842 - Resource assignment column does not trigger beforeFinishCellEdit and finishCellEdit events
* Fixed #1869 - Very low performance of React cell renderers
* Fixed #1881 - Incorrect response to CrudManager sync leads to infinite request loop
* Fixed #1885 - WBS column filter returns no results when you type visible WBS value
* Fixed #1920 - Crash when setting constraint
* Fixed #1931 - Gantt demos localization issues
* Fixed #1934 - Crash when replacing gantt dataset while task editor is open
* Fixed #1940 - TaskEditor´s beforeClose event is not triggered when clicking on Cancel button
* Fixed #1946 - Multi sort UI is broken columns with `sortable` function
* Fixed #1962 - Dependencies are not refreshed when replace resources
* Fixed #2013 - Code editor styles broken in Custom Task menu demo
* Fixed #2020 - Spin up does not honor instantUpdate setting
* Fixed #2026 - Row reorder broken when header menu is disabled

# 4.0.3 - 2020-11-17

## FEATURES / ENHANCEMENTS

* A new Scheduler widget type `undoredo` has been added which, when added to the `tbar` of a scheduling widget
  (such as a `Scheduler`, `Gantt`, or `Calendar`), provides undo and redo functionality
* `gantt.umd.js` and `gantt.lite.umd.js` bundles are now compiled with up-to-date `@babel/preset-env` webpack preset
  with no extra polyfilling. This change decreases size for the bundle by ~20% and offers performance enhancements for
  supported browsers
* [DEPRECATED] `gantt.lite.umd.js` was deprecated in favor of `gantt.umd.js` and will be removed in version 5.0
* The behaviour of our WBS column now more closely matches that of MS Project, keeping the initial values when sorting
  and filtering instead of always generating new (Fixed #1788)

## BUG FIXES

* Fixed #1681 - React applications are compiled with patched `react-scripts` presets. Check
  `examples/react/_scripts/readme.md` for more information
* Fixed #1724 - Crash after drag drop with manually scheduled parent task
* Fixed #1773 - Duration column filter issue
* Fixed #1774 - Filter popup closes when field trigger is clicked
* Fixed #1809 - Browser hangs on when certain data is loaded
* Fixed #1838 - Resource assignment column sorting doesn't work
* Fixed #1849 - Rollups and baselines combined are overlapping
* Fixed #1866 - Negative Lag calculation is broken
* Fixed #1867 - TaskEditor will not show if it ever hides without stopping editing

# 4.0.2 - 2020-11-04

## BUG FIXES

* Fixed #1745 - MS Project Export version 2013 compatibility
* Fixed #1787 - After loading a Project without date range set on the Gantt chart, it should set Gantt start/end dates
  based on the project

# 4.0.1 - 2020-11-03

## FEATURES / ENHANCEMENTS

* Constraint type column now has a proper list based filter (Fixed #1772)
* Resource assignment column is now filterable (Fixed #1767)

## API CHANGES

* [BREAKING] AssignmentField now has a picker which is an AssigmentGrid, where as previously the field's picker
  *contained* the grid. Please update any configuration code for the 'grid' of the picker to instead configure the
  picker directly. See the upgrade guide for more information

## BUG FIXES

* Fixed #1377 - Grouping and sorting is available in predecessors grid header context menu, but features don't work
* Fixed #1669 - Assignment picker malfunctioning if groups are collapsed
* Fixed #1706 - Toolbar should not be exported
* Fixed #1708 - Changing rowHeight and barMargin breaks dependency rendering
* Fixed #1712 - Skip non-exportable columns in export dialog window
* Fixed #1723 - Exception when exporting gantt to multiple pages

# 4.0.0 - 2020-10-19

## FEATURES / ENHANCEMENTS

* [BREAKING] Dropped Support for Edge 18 and older. Our Edge <=18 fixes are still in place and active, but we will not
  be adding more fixes. Existing fixes will be removed in a later version
* [BREAKING] The `Core/adapter` directory has been removed. There are no Widget adapters. All Widget classes register
  themselves  with the `Widget` class, and the `Widget` class is the source of Widget `type` mapping and Widget
  registration and lookup by `id`
* Gantt ships with a new version of the built in calculation engine, which should greatly improve its performance in
  many scenarios - especially on larger datasets. A lighter version of the engine is also used in the new Scheduler Pro,
  allowing them to pair up easily. To highlight this, a new `gantt-schedulerpro` demo was added. It shows Gantt sharing
  a project with Scheduler Pro (Fixed #892)
* Context menu features refactoring: naming was simplified by removing the word "Context" in feature names and in event
  names, introduced named objects for menu items, split context menu features by area of responsibility, made TaskMenu
  feature responsible for cell menu items. Please check out the upgrade guide for details (Fixed #128)
* New `resourcehistogram` demo showing the Histogram widget paired with the Gantt chart
* Added new exporter: MultiPageVertical. It fits content horizontally and then generates vertical pages to fit
  vertical content. (Fixed #1092)
* Added new configuration toggleParentTasksOnClick. It disables the default behaviour of collapsing/expanding parent
  tasks when clicking their task bar. (Fixed #1240)
* Added new exporter feature: mspExport. It generates a XML file locally that can be imported in Microsoft Project. A
  new `msprojectexport` demo was added. (Fixed #1250)
* Gantt now extends `Panel` instead of `Container`. This allows you to easily add toolbars to it (Fixed #1417)
* New custom-rendering demo showing how to add custom HTML markup to the task bar content element
* Added `gantt.lite.umd.js` module that does not include `Promise` polyfill. This module is primarily intended to be
  used with Angular to prevent `zone.js` polyfills overwrite
* Added a property to get critical paths information from the project. See the Gantt `ProjectModel.criticalPaths` for
  details
* Added a new way of cycles handling that basically ignores them. That mode is used by default for data loading stage
  So instead of throwing exceptions when loading the data, cycles will be reported in the browser console (fixed #1640)
* Assigning a calendar to a task/resource/project model (via `setCalendar` call or using `calendar` property)
  will automatically cause adding of the calendar to the calendar manager store
* Calendars guide has been updated: added more examples and details on calendars effect on the scheduling process
* Added experimental support for Salesforce Locking Service (Fixed #359). The distributed bundle only supports modern
  browsers (no IE11 or non-chromium based Edge), since Salesforce drops support for these in January 1st 2021 too
* Added Lightning Web Component demo, see `examples/salesforce/src/lwc`

## API CHANGES

* [BREAKING] `TaskModel.calendar` property behavior has been changed. Now it returns the task own calendar only (so it
  could be `null` if the task has no own calendar specified). To get the effective calendar used by the task please use
  `TaskModel.effectiveCalendar` which refers to the actual calendar used by the task (either the tasks own calendar if
  provided or the project calendar)
* [BREAKING] The `Default`, `Light` and `Dark` themes were renamed to `Classic`, `Classic-Light` and `Classic-Dark`
  This change highlights the fact that they are variations of the same theme, and that it is not the default theme
  (Stockholm is our default theme since version 2.0)
* [DEPRECATED] `TaskContextMenu` feature was renamed to `TaskMenu`
* [DEPRECATED] `TaskEditor#durationDecimalPrecision` config was renamed to `durationDisplayPrecision`. Its value
  is now always provided from the Gantt instance upon creation
* Cell context menu items are handled by `TaskMenu` feature now, because grid row and all cells in it represent a task
  record (Partial fix #128)
* Localization `GanttCommon.dependencyTypes` moved to `DependencyType.short`
* Cycle exceptions format has been changed. Now it consists of two parts
  The first part is less detailed and more user friendly. It just enumerates tasks that build the cycle
  And second part shows full list of involved identifiers for those who need detailed info
* Task menu for the TimeAxis schedule area is shown by default now. For details, see the `enableCellContextMenu` of
  `Gantt.column.TimeAxisColumn`
* Gantt `CrudManager` class has beed removed in favor of `ProjectModel` using which also implements Crud Manager API
* Propagation caused by data loading has been changed and now supports two alternative ways (fixed #1346)
  The changes happened due to the propagation are applied either:
  1. silently: no store `change`/`update` events are triggered, records aren't modified after the propagation. This mode
     is used by default
  2. not silently: store `change`/`update` events are triggered, records are modified after the propagation. Which in
     turn might cause data persisting if project `autoSync` is enabled
  Please check Project `silenceInitialCommit` config for details
* Gantt's "main" stores (EventStore, ResourceStore, AssignmentStore and DependencyStore) has had their event
  triggering modified to make sure data is in a calculated state when relevant events are triggered. This affects the
  timing of the `add`, `remove`, `removeAll`, `change` and `refresh` events. Please see the upgrade guide for more
  information (Fixed #1486)
* Model fields in derived classes are now merged with corresponding model fields (by name) in super classes. This allows
  serialization and other attributes to be inherited when a derived class only wants to change the `defaultValue` or
  other attribute of the field
* The `dateFormat` config for `type='date'` model fields has been simplified to `format`
* Model date fields are serialized by default according to the field `format`
* Field `serialize` function `this` has been changed to refer the field definition (it used to refer the model instance
  before)
* The following previously deprecated members/classes was removed:
  - `TaskEditorTab`
  - `CalendarField`*
  - `ConstraintTypePicker`*
  - `DependencyTypePicker`*
  - `EffortField`*
  - `ModelCombo`*
  - `SchedulingModePicker`*
  - `EventLoader`*
  - `ReadyStatePropagator`*
  - `AdvancedTab`*
  - `DependencyTab`*
  - `FormTab`*
  - `GeneralTab`*
  - `NotesTab`*
  - `PredecessorsTab`*
  - `ResourcesTab`*
  - `SuccessorsTab`*

  \* - removed from Gantt sources but still available from SchedulerPro

## BUG FIXES

* Fixed #267 - Preserve endDate for "Manually scheduled" summary task
* Fixed #534 - Dependency line jumps while scrolling vertically
* Fixed #812 - Adding incorrect predecessor throws exception
* Fixed #853 - Add-> Predecessor from context menu stuck in disabled mode
* Fixed #856 - Sync triggered (fromSide and toSide removed) after opening and saving unmodified dependency
* Fixed #958 - Column sorting causes record modifications
* Fixed #1001 - Typings missing for Gantt
* Fixed #1043 - Critical paths lines stay highlighted after move or resize the task to non critical
* Fixed #1046 - Critical milestone gets extra background applied
* Fixed #1049 - Unintended baseline transitions on drop
* Fixed #1074 - Duplicated task when reordering while a filter exists
* Fixed #1090 - Milestone task label overlaps dependency arrow
* Fixed #1208 - Should show indicators when are outside of timeline but in date interval
* Fixed #1218 - ComboBox list should be anchored to top/bottom sides only
* Fixed #1249 - Columns lines are not exported correctly
* Fixed #1252 - Adding predecessor removes dependency line to the successor
* Fixed #1255 - Zooming performance tuning
* Fixed #1270 - Adding a new task registered as 2 transactions when computer is slow
* Fixed #1288 - Gantt taskRender event does not pass task element
* Fixed #1294 - Dependencies line are not redrawn on sorting
* Fixed #1331 - Constraint removal is not revertable in task editor
* Fixed #1340 - TaskStore doesn't extend AjaxStore
* Fixed #1347 - Translation missing in bigdataset demo
* Fixed #1348 - Dependencies not rendered after changing to 10k tasks in bigdataset demo
* Fixed #1383 - Scale column in resource histogram should not be editable
* Fixed #1387 - Focus outline broken for parent tasks
* Fixed #1390 - Parent task not rendered in rollups demo
* Fixed #1433 - Critical paths lines stay partially gray when has more than 1 dependency
* Fixed #1467 - MSProject export demo issue
* Fixed #1470 - Replacing dataset is very slow
* Fixed #1475 - Deprecate tabsConfig and extraItems properly
* Fixed #1540 - Unquoted column.id in selectors
* Fixed #1543 - Paths disappearing on scroll
* Fixed #1548 - [ANGULAR] Investigate zone.js loading order and set it to Angular default
* Fixed #1559 - Show task menu for empty part of timeaxis
* Fixed #1633 - Re-applying JSON to DependencyStore removes newly created dependency
* Fixed #1643 - Propagating text not translated in big dataset demo
* Fixed #1644 - Fixed `NumberField` enforcement of min/max values to allow typing beyond those ranges
* Fixed #1646 - Error on project.setCalendar method call
* Fixed #1652 - Document STM on ProjectModel
* Fixed #1657 - Setting tasks on Vue wrapper reinitialises STM

# 2.1.9 - 2020-08-26

## FEATURES/ENHANCEMENTS

* No Gantt specific changes, but Grid and Scheduler changes are included

# 2.1.8 - 2020-08-11

## BUG FIXES

* Fixed #1214 - Gantt error on applyState
* Fixed #1244 - Initial export options are shown incorrectly in the export dialog
* Fixed #1284 - Exception when trying to open context menu on row border

# 2.1.7 - 2020-07-24

## BUG FIXES

* Fixed #910 - Crash when exporting to PDF if schedule area has no width
* Fixed #933 - Exported PDF corrupt after adding task
* Fixed #953 - Load mask appearing on top of export progress
* Fixed #969 - Multi page export of more than 100 tasks fails
* Fixed #970 - Export feature yields corrupted PDF when chart is scrolled down
* Fixed #972 - Export feature does not export dependencies unless visible first
* Fixed #973 - Export feature does not respect left grid section width
* Fixed #988 - Deleted tasks appear after reapplying filters
* Fixed #1172 - Wrapper should not relay store events to the instance
* Fixed #1180 - Exported grid should end with the last row

# 2.1.6 - 2020-07-10

## FEATURES/ENHANCEMENTS

* Added Docker image of the PDF Export Server. See server README for details. (Fixed #905)

## API CHANGES

* [DEPRECATED] To avoid risk of confusing the Gantt instance with the calculation engine, `ganttEngine` has been
  deprecated in favor of `ganttInstance` for all framework wrappers (Angular, React, Vue). Fixed #776

## BUG FIXES

* Fixed #858 - Sync tries to remove assignment added on a previous cancelled task edit
* Fixed #968 - Task editing is broken after saving new resource
* Fixed #984 - Indenting a lot of tasks causes incorrect indentation
* Fixed #1056 - enableCellContextMenu: false doesn't disable context menu in Gantt
* Fixed #1131 - Task editing is broken after canceling new resource
* Fixed #1139 - `Duration` column error Tooltip not show up when `finalizeCellEditor` returns false

# 2.1.5 - 2020-06-09

## FEATURES/ENHANCEMENTS

* Updated Font Awesome Free to v5.13.0

## BUG FIXES

* Fixed #801 - Document wrapperCls param in taskRenderer
* Fixed #815 - Gantt %-done bar should be semi-transparent
* Fixed #827 - nonWorkingTime feature stops working with large resources
* Fixed #838 - Unexpected lag between tasks with dependencies and assignment
* Fixed #852 - Project lines appear even if feature is disabled
* Fixed #859 - Crash when dragging task and mouse moves over timeline element
* Fixed #860 - Crash if dragging task with dependency to a filtered out task
* Fixed #862 - Crash if opening Gantt demo in Iran timezone

# 2.1.4 - 2020-05-19

## BUG FIXES

* Fixed #772 - undefined query parameter in CrudManager URLs
* Fixed #783 - Crash if schedule grid is collapsed with progressline enabled

# 2.1.3 - 2020-05-14

## BUG FIXES

* Fixed #257 - Task not rendered correctly after drag drop
* Fixed #268 - Wrong sync request on dependency creation
* Fixed #527 - Gantt sends wrong server request when adding a resource
* Fixed #553 - Loadmask not hidden after load fails
* Fixed #558 - Crash when mouseout happens on a task terminal of a task being removed
* Fixed #559 - Crash if zooming with schedule collapsed
* Fixed #566 - Constraint type: "MUST START ON" not working
* Fixed #577 - Moving task that is partially outside the view fails with an exception
* Fixed #580 - Child calendars does not include intervals from parent
* Fixed #649 - autoSync not triggered when deleting task in TaskEditor
* Fixed #671 - Gantt localization of New task/milestone is broken
* Fixed #675 - Task context menu localization is broken
* Fixed #733 - Changing start date of manual task does not move successors
* Fixed #740 - Should be possible to pass task instance to from/to fields when create a new dependency
* Fixed #744 - Drag drop / resize using touch shows empty tooltip
* Fixed #748 - Effort is updated for effort driven task

# 2.1.2 - 2020-04-17

## FEATURES / ENHANCEMENTS

* The gantt.module.js bundle is now lightly transpiled to ECMAScript 2015 using Babel to work with more browsers out of
  the box
* The PDF Export feature scrolls through the dataset in a more efficient manner (Fixed #578)

## BUG FIXES

* Fixed #123 - Successors and predecessors stores in TaskEditor should not be filtered when task nodes are collapsed
* Fixed #367 - No 'change' event fired after indent operation
* Fixed #464 - Dependencies are not refreshed after filtering with schedule region collapsed
* Fixed #490 - Project can't be loaded with console error Cannot read property 'startDate' of undefined
* Fixed #495 - Ctrl/Cmd Drag a task fails with exception
* Fixed #506 - Adding a milestone for a task fails if the task is ahead the project start date
* Fixed #508 - Wrong rollup rendering on changing zoom level
* Fixed #543 - Having TaskEdit feature disabled breaks TaskContextMenu
* Fixed #544 - Task indicators shown even if they are not part of the time axis

# 2.1.1 - 2020-03-27

## FEATURES / ENHANCEMENTS

* Added new demo showing integration with .NET backend and .NET Core backend (Fixed #300)
* New .NET integration guide added to the docs

## API CHANGES

* GanttDateColumn no longer shows its step triggers by default. Enable the triggers by setting the `step` value
  available on the DateColumn class

## BUG FIXES

* Fixed #399 - Task incorrectly rendered after duration change
* Fixed #409 - Crash when clicking next time arrow in event editor if end date is cleared
* Fixed #418 - Resource assignment column not refreshed after resource update
* Fixed #424 - New resource record throws exception when serializing if propagate wasn't called
* Fixed #426 - Gantt throws when trying to load invalid empty calendar id
* Fixed #429 - Crash if project is loaded with task editor open
* Fixed #430 - Gantt selection not updated after project reload
* Fixed #436 - Crash when exporting to PDF in Angular demo
* Fixed #438 - Rollups are not rendered for collapsed parent node
* Fixed #442 - Default resource images not loaded
* Fixed #444 - Phantom parent id is not included to changeset package and children are
* Fixed #445 - React: Scheduler crashes when features object passed as prop
* Fixed #446 - TaskEditor does not detach from project on consecutive edits
* Fixed #447 - Should round percentDone value for tasks in task editor
* Fixed #449 - Issues when using filter field in assignment editor
* Fixed #450 - Date column too narrow to fit its cell editor
* Fixed #451 - collapseAll does not update selection
* Fixed #457 - Docker container with gantt ASP.NET Core demo cannot connect to MySQL container
* Fixed #458 - Crash when clicking leaf row in undo grid
* Fixed #463 - Filter not applied when deleting character

# 2.1.0 - 2020-03-11

## FEATURES / ENHANCEMENTS

* Indicators for constraint date, early and late dates and more can be added per task row using the new Indicators
  feature. See the new `indicators` demo
* Deadline support was added in form of a field on `TaskModel` and a `DeadlineDateColumn` to display and edit it
  Compatible with the new Indicators feature (Fixed #235)
* Resource Assignment column can now show avatars for resources. See new `showAvatars` config used in the updated
  advanced demo (Fixed #381)
* AssignmentGrid's selection model can now be customised like any regular Grid (Fixed #370)
* Font Awesome 5 Pro was replaced with Font Awesome 5 Free as the default icon font (MIT / SIL OFL license)

## API CHANGES

* [DEPRECATED] The `tplData` param to `taskRenderer` was renamed to `renderData` to better reflect its purpose. The old
  name has been deprecated and will be removed in version 4

## BUG FIXES

* Fixed #255 - Tasks disappear after adding tasks with schedule region collapsed
* Fixed #330 - Id collision happens when you add or move records after filters are cleared
* Fixed #338 - Crash when mouse over splitter during dependency creation
* Fixed #352 - Crash when clicking Units cell of newly added assignment row in task editor
* Fixed #353 - Crash upon load if using Iran Standard Time time zone
* Fixed #366 - writeAllFields is not honored in ProjectModel
* Fixed #391 - Crash when clicking outside assignment editor with cell editing active

# 2.0.4 - 2020-02-24

## API CHANGES

* [DEPRECATED] PercentDoneCircleColumn, use PercentDoneColumn instead with `showCircle` config enabled

## BUG FIXES

* Fixed #159 - Context menu differs in schedule vs grid
* Fixed #215 - PDF export feature doesn't work on zoomed page
* Fixed #286 - Parent node expanded after reorder
* Fixed #296 - Missing title for "New column" in Gantt demos
* Fixed #297 - Note column not updated after set to empty value
* Fixed #317 - Outdent should maintain task parent index
* Fixed #326 - "Graph cycle detected" exception when reordering node
* Fixed #331 - Crash when trying to scroll a task into view if gantt panel is collapsed

# 2.0.3 - 2020-02-13

## FEATURES / ENHANCEMENTS

* ProgressBar feature now has an `allowResize` config to enable or disable resizing (Fixed #242)
* Added a new Rollup column allowing control of which tasks should roll up. Added a new Rollup field to the Advanced tab
  (Fixed #259)

## BUG FIXES

* Fixed #040 - Focusing a task partially outside of timeaxis extends timeaxis
* Fixed #067 - Wrong typedef of ProjectModel in gantt.umd.d.ts
* Fixed #139 - Dependencies not painted after converting task to milestone
* Fixed #154 - Cannot type into duration field of new task
* Fixed #244 - Dependency drawn after being deleted
* Fixed #256 - Progress line not redrawn after an invalid drop
* Fixed #262 - Resizing to small width which doesn't update data gets UI out of sync
* Fixed #240 - Crash when editing assignment twice
* Fixed #272 - TaskEdit allows to assign same resource to a Task multiple times
* Fixed #274 - Crash after adding subtask
* Fixed #283 - Gantt Baselines example tooltips not localized

# 2.0.2 - 2020-01-30

## FEATURES / ENHANCEMENTS

* PDF export server was refactored. Removed websocket support until it is implemented on a client side
  Added logging. Added configuration file (see `app.config.js`) which can be overriden by CLI options
  Multipage export performance was increased substantially (see `max-workers` config in server readme)
  (Fixed #112)

## BUG FIXES

* Fixed #95  - Task end date moves to the previous day when business calendar is used
* Fixed #155 - Task editor displaced upon show
* Fixed #237 - Project lines not shown after project load

# 2.0.1 - 2020-01-17

## FEATURES / ENHANCEMENTS

* Added new Angular examples: Rollups and Time ranges
* PDF Export feature uses first task's name or *Gantt* as the default file name (Fixed #117)

## BUG FIXES

* Fixed #53  - Cell editing is broken when a column uses a field that is missing in the model
* Fixed #94  - Non-symmetric left/right margin for labels
* Fixed #103 - Wrong date format in timeline labels
* Fixed #115 - Project Start field highlighted as invalid while page is loading
* Fixed #118 - Constraint / Start date columns should not include hour info by default
* Fixed #126 - Scheduling engine docs missing
* Fixed #132 - Not possible to open task editor for new task while it's open
* Fixed #134 - 'b-' CSS class seen in task editor element
* Fixed #140 - Crash if calling scrollTaskIntoView on an unscheduled task
* Fixed #142 - Crash when adding a task below an unscheduled task
* Fixed #149 - Timeline widget only shows tasks in expanded parent nodes
* Fixed #160 - Task label not vertically centered
* Fixed #161 - Drag creating dates on an unscheduled task does not set duration
* Fixed #162 - Gantt is not restored properly after export
* Fixed #165 - Name field turns red/invalid upon save
* Fixed #166 - Cannot save unscheduled task with ENTER key
* Fixed #172 - Should not be possible to create dependency between already linked tasks

# 2.0.0 - 2019-12-19

## FEATURES / ENHANCEMENTS

* Gantt has a new rendering pipeline, built upon a method of syncing changes to DOM developed for the vertical mode in
  Scheduler. This change allows us to remove about 1000 lines of code in this release, making maintenance and future
  development easier
* Added support for exporting the Gantt chart to PDF and PNG. It is showcased in several examples, pdf-export for
  Angular, React and Vue frameworks, as well as in examples/export. The feature requires a special export server,
  which you can find in the examples/_shared/server folder. You will find more instructions in the README.md file in
  each new demo. (Fixed A#6268)

## API CHANGES

* [BREAKING] (for those who build from sources): "Common" package was renamed to "Core", so all our basic classes
  should be imported from `lib/Core/`
* [BREAKING] Gantt `nonWorkingTime` feature class replaced with `SchedulerPro/feature/ProNonWorkingTime` which uses
  project's calendar to obtain non-working time
* Gantt `nonWorkingTime` feature is now enabled by default

## BUG FIXES

# 1.2.2 - 2019-11-21

## BUG FIXES

* Fixed #13 - Dragging progress bar handle causes task move

# 1.2.1 - 2019-11-15

## BUG FIXES
* `exporttoexcel` demo broken with bundles

# 1.2.0 - 2019-11-06

## FEATURES / ENHANCEMENTS

* Added support for rollups feature (Fixed A#4774)
* Added a thinner version of Gantt called `GanttBase`. It is a Gantt without default features, allowing smaller custom
  builds using for example WebPack. See the new `custom-build` demo for a possible setup (Fixed A#7883)
* Experimental: The React wrapper has been updated to support using React components (JSX) in cell renderers and as cell
  editors. Please check out the updated React demos to see how it works (Fixed A#7334, Fixed A#9043)
* Added Export to Excel demo (Fixed A#9133)
* Added a new 'Aggregated column demo' that shows how to add a custom column summing values (Fixed A#9211)
* Support for disabling features at runtime has been improved, all features except Tree can now be disabled at any time
* Widgets may now adopt a preexisting DOM node to use as their encapsulating `element`. This reduces DOM footprint when
  widgets are being placed inside existing applications, or when used inside UI frameworks which provide a DOM node. See
  the `adopt` config option (Fixed A#9414)
* The task context menu has been augmented to add indent and outdent. (Fixed A#4779)

## BUG FIXES

* Fixed A#8976 - Prevent task editor from closing if there is an invalid field
* Fixed A#9146 - "No rows to display" shown while loading data
* Fixed A#9161 - Locked grid scroll is reset upon task bar click
* Fixed A#9243 - Date columns change format after zooming
* Fixed A#9253 - Recreating Gantt when a tab in taskeditor is disabled leads to exception
* Fixed A#9416 - Adding a resource in the TaskEditor, then clicking Save throws an error
* Fixed A#9304 - Tasks duplicated on drag
* Fixed A#9240 - Duration misrendered when editing
* Fixed A#9242 - Sync is called on TaskEdit dialog cancel when autosync is true

# 1.1.5 - 2019-09-09

## FEATURES / ENHANCEMENTS

* Added a new `showCircle` config to PercentDoneColumn that renders a circular progress bar of the percentDone field
  value (Fixed A#9162)

## BUG FIXES

* Fixed A#8548 - DOCS: `propagate` missing in Project docs
* Fixed A#8763 - Crash after editing predecessors
* Fixed A#8967 - PHP demo: error when removing tasks with children
* Fixed A#9092 - TaskStore id collision
* Fixed A#9148 - Crash after resizing task progress bar in Timeline demo
* Fixed A#9163 - STYLING: Milestone displaced

# 1.1.4 - 2019-08-28

## FEATURES / ENHANCEMENTS

* Added Tooltips demo that shows how to customize the task tooltip (Fixed A#9109)

## API CHANGES

* The `TaskEdit#getEditor()` function was made public, can be used to retrieve the TaskEditor instance

## BUG FIXES

* Fixed A#8560 - Adding task below last task creates empty row
* Fixed A#8618 - STYLING: Dark theme nonworking time headers look bad
* Fixed A#8619 - STYLING: Dark theme check column unchecked checkboxes are invisible
* Fixed A#8690 - STYLING: Selected task innerEl rendition needs to be more of a contrast so that the current, possibly
  multiple selection can be seen at a glance
* Fixed A#8844 - PHP demo: dragging and tooltip are broken after a newly created task is saved
* Fixed A#9008 - Progress bar resizable in readOnly mode
* Fixed A#9073 - vue drag-from-grid demo cannot be built with yarn
* Fixed A#9084 - Task row disappears on Drag'n'Drop
* Fixed A#9087 - Resource Avatar images reloaded upon every change to Task model
* Fixed A#9093 - Phantom dependencies are rendered after clearing task store
* Fixed A#9097 - STYLING: Toolbar fields misaligned in advanced demo
* Fixed A#9108 - 'beforeTaskEdit' only fired once if listener returns false

# 1.1.3 - 2019-08-19

## FEATURES / ENHANCEMENTS

* Added React Basic Gantt demo with TypeScript (Fixed A#8977)
* Added support for importing MS Project MPP files (see 'msprojectimport' demo). Requires JAVA and PHP on the backend
  See README in the example dir for details (Fixed A#8987)

## BUG FIXES

* Fixes A#8336 - Switching locale in advanced demo takes ~2 seconds
* Fixed A#8653 - Unexpected task scheduling after undo operation
* Fixed A#8712 - PHP demo: after creating a new task and saving it, when try to interact with the task demo fails with
  exceptions
* Fixed A#8715 - PHP demo: after creating a new task and saving it selection is broken
* Fixed A#8716 - Dependency line for a deleted dependency is redrawn after it's "to" side is appended to its "from" side
* Fixed A#8884 - Critical paths demo is broken online
* Fixed A#8885 - tabsConfig is not taken into account by TaskEditor
* Fixed A#8966 - PHP demo: task sort order is not stored
* Fixed A#8988 - React demo in trial distribution refers to scheduler folder which may not exist
* Fixed A#8995 - Progress bar in some tasks cannot be resized after some point
* Fixed A#9006 - Pan feature doesn't work in Gantt
* Fixed A#9027 - ColumnLines feature doesn't work in Gantt

# 1.1.2 - 2019-07-05

## BUG FIXES

* Fixed A#8804 - Error / warnings in console of web components demo
* Fixed A#8805 - Animations not working
* Fixed A#8811 - Crash when using context menu in web components demo
* Fixed A#8839 - Save/Delete/Cancel button order in TaskEditor should match order in EventEditor

# 1.1.1 - 2019-06-27

## FEATURES / ENHANCEMENTS

* Added Integration Guide for Vue, Angular and React (Fixed A#8686)
* Added new config option `tabsConfig` for `taskEdit` feature (Fixed A#8765)

## BUG FIXES

* Fixed A#8754 - Sluggish drag drop experience in advanced demo
* Fixed A#8778 - Baselines disappear if scrolling down and back up
* Fixed A#8785 - Passing listeners to editor widget in TaskEditor removes internal listeners

# 1.1.0 - 2019-06-20

## FEATURES / ENHANCEMENTS

* There is now a `Baselines` feature which shows baselines for tasks. A task's data block may now contain
  a `baselines` property which is an array containing baseline data blocks which must contain at least
  `startDate` and `endDate`. See the new example for details. (Fixed A#6286)
* New `CriticalPaths` feature which visualizes the project critical paths. Check how it works in the new `criticalpaths`
  demo. (Fixed A#6269)
* New `ProgressLine` feature - a vertical graph that provides the highest level view of schedule progress. Check how it
  works in the new `progressline` demo. (Fixed A#8643)
* New `EarlyStartDate`, `EarlyEndDate`, `LateStartDate`, `LateEndDate` and `TotalSlack` columns. Check how they works in
  the new `criticalpaths` demo. (Fixed A#6285)

## API CHANGES

## BUG FIXES

* Fixed A#8539 - Some task editor fields turns red moments before editor is closed after clicking save
* Fixed A#8602 - TaskEditor should invalidate an end date < start date
* Fixed A#8603 - STYLING: Milestones lack hover color
* Fixed A#8604 - Clicking task element does not select the row
* Fixed A#8632 - Task end date/duration is not properly editing after cancel
* Fixed A#8665 - Task interaction events are not documented
* Fixed A#8707 - Resizing column expands collapsed section

# 1.0.2 - 2019-06-03

## FEATURES / ENHANCEMENTS

* New integration demo with Ext JS Modern toolkit (Fixed A#8447)
* New webcomponents demo (Fixed A#8495)
* TaskEdit feature now fires an event before show to prevent editing or to show a custom editor (Fixed A#8510)
* TaskEdit feature now optionally shows a delete button
* Gantt repaints dependencies asynchronously when dependency or task is changed. Use `dependenciesDrawn` event to know
  when dependency lines are actually painted. `draw`, `drawDependency` and  `drawForEvent` are still synchronous

## API CHANGES

* [DEPRECATED] TaskEditor's `extraWidgets` config was deprecated and will be removed in a future version. Please use
  `extraItems` instead

## BUG FIXES

* Fixed A#7925 - Dependency line should only be drawn once on dependency change
* Fixed A#8517 - Angular demo tasks animate into view
* Fixed A#8518 - React + Vue demos broken rendering
* Fixed A#8520 - Labels demo timeaxis incorrectly configured
* Fixed A#8529 - Pan feature reacts when dragging task bar
* Fixed A#8516 - Customizing resourceassignment picker demo issues
* Fixed A#8532 - Adding task above/below of a milestone creates a task with wrong dates
* Fixed A#8533 - Cannot destroy ButtonGroup
* Fixed A#8556 - Add Task button throws in extjs modern demo
* Fixed A#8586 - Add new column header not localized properly

# 1.0.1 - 2019-05-24

## FEATURES / ENHANCEMENTS

* Delimiter used in Successors and Predecessors columns is now configurable, defaulting to ; (Fixed A#8292)
* New `timeranges` demo showing how to add custom date indicator lines as well as date ranges to the Gantt chart
  (Fixed A#8320)
* Demos now have a built in code editor that allows you to play around with their code (Chrome only) and CSS
  (Fixed A#7210)
* [BREAKING] Context menu Features are configured in a slightly different way in this version. If you have used
  the `extraItems` or `processItems` options to change the contents of the shown menu, this code must be
  updated. Instead of using `extraItems`, use `items`

  The `items` config is an *`Object`* rather than an array. The property values are your new submenu configs, and the
  property name is the menu item name. In this way, you may add new items easily, but also, you may override the
  configuration of the default menu items that we provide

  The default menu items now all have documented names (see the `defaultItems` config of the Feature), so you may apply
  config objects which override default config. To remove a provided default completely, specify the config value as
  `false`

  This means that the various `showXxxxxxxInContextMenu` configs in the Gantt are now ineffective. Simply
  use for example, `items : { addTaskAbove : false }` to remove a provided item by name

  `processItems` now recieves its `items` parameter as an `Object`, so finding predefined named menu items to mutate is
  easier. Adding your own entails adding a new named config object. Use the `weight` config to affect the menu item
  order. Provided items are `weight : 0`. Weight values may be negative to cause your new items  (Fixed A#8287)

## BUG FIXES

* Fixed A#7561 - Should be able to use Grid & Scheduler & Gantt bundles on the same page
* Fixed A#8075 - TimeRanges store not populated if incoming CrudManager dataset contains data
* Fixed A#8210 - Terminals not visible when hovering task after creating dependency
* Fixed A#8261 - ProjectLines not painted after propagation complete
* Fixed A#8264 - Reordering a task into a parent task doesn't recalculate the parent
* Fixed A#8275 - Framework integrations missing value in start date field
* Fixed A#8276 - Crash if invoking task editor for unscheduled task
* Fixed A#8279 - Gantt PHP demo requestPromise.abort is not a function in AjaxTransport.js
* Fixed A#8293 - Gantt advanced demo. Graph cycle detected
* Fixed A#8295 - Gantt umd bundle doesn't work in angular
* Fixed A#8296 - Typings for gantt.umd bundles are incomplete
* Fixed A#8325 - Some translations are missing (NL)
* Fixed A#8334 - Clicking on a blank space selects a task and scrolls it into view
* Fixed A#8341 - Task elements are missing after adding new tasks
* Fixed A#8342 - Collapsing all records fails in advanced demo
* Fixed A#8357 - TaskEditor needs to provide a simple way of adding extra fields to each tab
* Fixed A#8381 - loadMask not shown if Project is using autoLoad true
* Fixed A#8384 - Crash in React demo when clicking Edit button
* Fixed A#8390 - Undoing project start date change doesn't update project start line
* Fixed A#8391 - Progress bar element overflows task bar on hover if task is narrow
* Fixed A#8394 - CrudManager reacts incorrectly and tries to save empty changeset
* Fixed A#8397 - Inserting two tasks at once breaks normal view
* Fixed A#8404 - addTaskBelow fails on 2nd call
* Fixed A#8457 - Rendering broken after adding subtask to parent
* Fixed A#8462 - Error throw in undoredo example when second transaction is canceled
* Fixed A#8475 - STYLING: Misalignment of resource assignment filter field
* Fixed A#8494 - Exception thrown when adding task via context menu
* Fixed A#8496 - Crash in Gantt docs when viewing ResourceTimeRanges

# 1.0.0 - 2019-04-26

* Today we are super excited to share with you the 1.0 GA of our new Bryntum Gantt product. It is a powerful and high
  performance Gantt chart component for any web application. It is built from the ground up with pure JavaScript and
  TypeScript, and integrates easily with React, Angular, Vue or any other JS framework you are already using

* For a full introduction, please see our blog post for more details about this release. In our docs page you will find
  extensive API documentation including a getting started guide

* Blog post: https://bryntum.com/blog/announcing-bryntum-gantt-1-0