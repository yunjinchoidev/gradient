/**
 * folder  : example folder under ./examples
 * group   : browser page group
 * title   : example title
 * build   : true if example needs building
 * offline : true if example is not available online
 * since   : package version since example is available
 * updated : package version for which example was updated
 */
window.examples = [
    // Features
    { folder : 'basic', group : 'Features', title : 'Basic' },
    { folder : 'aggregation-column', group : 'Features', title : 'Aggregation column' },
    { folder : 'baselines', group : 'Features', title : 'Baselines', since : '1.1.0' },
    { folder : 'conflicts', group : 'Features', title : 'Scheduling conflict resolution popup', since : '5.0.0' },
    { folder : 'criticalpaths', group : 'Features', title : 'Critical paths', since : '1.1.0' },
    { folder : 'grouping', group : 'Features', title : 'Grouping', since : '5.0' },
    { folder : 'grid-sections', group : 'Features', title : 'Grid Sections', since : '5.0.0' },
    { folder : 'highlight-time-spans', group : 'Features', title : 'Highlight time spans', since : '5.0' },
    { folder : 'inactive-tasks', group : 'Features', title : 'Inactive tasks', since : '4.3.0' },
    { folder : 'indicators', group : 'Features', title : 'Indicators', since : '2.1.0' },
    { folder : 'infinite-scroll', group : 'Features', title : 'Infinite timeline scrolling', since : '4.2.0' },
    { folder : 'labels', group : 'Features', title : 'Labels' },
    { folder : 'parent-area', group : 'Features', title : 'Parent area', since : '5.0.0' },
    { folder : 'pin-successors', group : 'Features', title : 'Pin successors during drag drop', since : '5.0.0' },
    { folder : 'progressline', group : 'Features', title : 'Progress line', since : '1.1.0' },
    { folder : 'responsive', group : 'Features', title : 'Responsive' },
    { folder : 'rollups', group : 'Features', title : 'Rollups', since : '1.2.0' },
    { folder : 'static', group : 'Features', title : 'Static mode', since : '4.2.7' },
    { folder : 'state', group : 'Features', title : 'Storing and restoring state', since : '5.0.0' },
    { folder : 'summary', group : 'Features', title : 'Summary feature', since : '4.3.2' },
    { folder : 'timeranges', group : 'Features', title : 'Time Ranges', updated : '1.3' },
    { folder : 'undoredo', group : 'Features', title : 'Undo/Redo' },

    // Export
    { folder : 'exporttoexcel', group : 'Export & Import', title : 'Export to Excel' },
    { folder : 'msprojectexport', group : 'Export & Import', title : 'Export to MS Project', since : '4.0' },
    { folder : 'msprojectimport', group : 'Export & Import', title : 'Import MS Project MPP files', since : '1.1.3' },
    { folder : 'export', group : 'Export & Import', title : 'Export to PDF / PNG', since : '2.0' },

    // Customization
    { folder : 'custom-header', group : 'Customization', title : 'Custom time axis header', since : '4.2.5' },
    { folder : 'custom-rendering', group : 'Customization', title : 'Customizing task bar contents', since : '4.0', updated : '4.1.1' },
    { folder : 'resourceassignment', group : 'Customization', title : 'Customizing the resource assignment picker', since : '1.0.1' },
    { folder : 'custom-taskbar', group : 'Customization', title : 'Customized task bar', since : '4.1.0' },
    { folder : 'taskeditor', group : 'Customization', title : 'Customizing the task editor', updated : '5.0' },
    { folder : 'taskmenu', group : 'Customization', title : 'Customizing the task menu' },
    { folder : 'tooltips', group : 'Customization', title : 'Customized tooltips', since : '1.1.4', updated : '4.3.3' },
    { folder : 'localization', group : 'Customization', title : 'Localization' },
    { folder : 'theme', group : 'Customization', title : 'Theme browser' },

    // Drag drop
    { folder : 'drag-resources-from-grid', group : 'Drag & Drop', title : 'Drag resources from a grid', since : '4.3.4' },
    { folder : 'drag-from-grid', group : 'Drag & Drop', title : 'Drag unplanned tasks from a grid', since : '4.3.1' },

    // Additional widgets
    { folder : 'resourcehistogram', group : 'Additional widgets', title : 'Resource histogram widget', since : '4.0' },
    { folder : 'resourceutilization', group : 'Additional widgets', title : 'Resource utilization widget', since : '5.0' },
    { folder : 'timeline', group : 'Additional widgets', title : 'Timeline widget' },

    // Power demos
    { folder : 'advanced', group : 'Power demos', title : 'Advanced', updated : '5.0' },
    { folder : 'bigdataset', group : 'Power demos', title : 'Big data set', since : '4.0' },
    { folder : 'early-render', group : 'Power demos', title : 'Early render vs legacy render', since : '5.0' },
    { folder : 'gantt-schedulerpro', group : 'Power demos', title : 'Gantt + Scheduler Pro', since : '4.0' },
    { folder : 'gantt-taskboard', group : 'Power demos', title : 'Gantt + TaskBoard', since : '5.0' },

    // Integration
    { folder : 'custom-taskmenu', group : 'Integration', title : 'Replace the task menu', since : '4.0' },
    { folder : 'esmodule', group : 'Integration', title : 'Include using EcmaScript module' },
    { folder : 'extjsmodern', group : 'Integration', title : 'ExtJS Modern App integration', overlay : 'extjs', version : 'ExtJS 6.5.3', since : '1.0.2' },
    { folder : 'php', group : 'Integration', overlay : 'php', title : 'Backend in PHP', offline : true },
    { folder : 'salesforce', group : 'Integration', title : 'Integrate with Salesforce Lightning (offline)', offline : true, since : '4.0' },
    { folder : 'scripttag', group : 'Integration', title : 'Include using a script tag' },
    { folder : 'webcomponents', group : 'Integration', title : 'Use as web component', since : '1.0.2' },

    // Integration/DotNet
    { folder : 'frameworks/aspnet', group : 'Integration', title : 'ASP.NET', overlay : 'dotnet', offline : true, since : '2.1.1' },
    { folder : 'frameworks/aspnetcore', group : 'Integration', title : 'ASP.NET Core', overlay : 'dotnet', offline : true, since : '2.1.1' },

    // Integration/Webpack
    { folder : 'frameworks/webpack', group : 'Integration', title : 'Custom build using WebPack', overlay : 'webpack', version : 'WebPack 4', since : '1.2', offline : true },

    // Integration/Angular
    { folder : 'frameworks/angular/advanced', group : 'Integration/Angular', title : 'Angular Advanced', overlay : 'angular', version : 'Angular 13', updated : '4.3.4', build : true },
    { folder : 'frameworks/angular/inline-data', group : 'Integration/Angular', title : 'Inline data in Angular Gantt', overlay : 'angular', version : 'Angular 13', since : '5.0.0', build : true },
    { folder : 'frameworks/angular/gantt-schedulerpro', group : 'Integration/Angular', title : 'Angular Gantt + Scheduler Pro', overlay : 'angular', version : 'Angular 13', updated : '4.3.4', build : true, since : '4.2.0' },
    { folder : 'frameworks/angular/pdf-export', group : 'Integration/Angular', title : 'Angular PDF/PNG export', overlay : 'angular', version : 'Angular 8', build : true, since : '2.0' },
    { folder : 'frameworks/angular/rollups', group : 'Integration/Angular', title : 'Angular Rollups', overlay : 'angular', version : 'Angular 8', build : true, since : '2.0.1' },
    { folder : 'frameworks/angular/taskeditor', group : 'Integration/Angular', title : 'Angular Task editor customization', overlay : 'angular', version : 'Angular 13', updated : '4.3.4', build : true, since : '1.0.2' },
    { folder : 'frameworks/angular/timeranges', group : 'Integration/Angular', title : 'Angular Time ranges', overlay : 'angular', version : 'Angular 8', build : true, since : '2.0.1' },

    // Integration/Ionic
    { folder : 'frameworks/ionic/ionic-4', group : 'Integration/Ionic', title : 'Integrate with Ionic', build : true, overlay : 'ionic', version : 'Ionic 4', since : '4.3.0' },

    // 'Integration/React
    { folder : 'frameworks/react/javascript/advanced', group : 'Integration/React', title : 'React Advanced', overlay : 'react', version : 'React 16', build : true },
    { folder : 'frameworks/react/javascript/basic', group : 'Integration/React', title : 'React Basic', overlay : 'react', version : 'React 16', build : true, since : '1.1.2', updated : '1.3' },
    { folder : 'frameworks/react/javascript/gantt-schedulerpro', group : 'Integration/React', title : 'React Gantt + Scheduler Pro', overlay : 'react', version : 'React 17', build : true, since : '4.2.0' },
    { folder : 'frameworks/react/javascript/inline-data', group : 'Integration/React', title : 'Inline data in React Gantt', overlay : 'react', version : 'React 17', since : '5.0.0', build : true },
    { folder : 'frameworks/react/javascript/pdf-export', group : 'Integration/React', title : 'React PDF/PNG export', overlay : 'react', version : 'React 16', build : true, since : '2.0' },
    { folder : 'frameworks/react/javascript/resource-histogram', group : 'Integration/React', title : 'React Gantt Resource Histogram', overlay : 'react', version : 'React 17', build : true, since : '4.1.1' },
    { folder : 'frameworks/react/javascript/rollups', group : 'Integration/React', title : 'React Rollups', overlay : 'react', version : 'React 16', build : true, since : '2.0.1' },
    { folder : 'frameworks/react/javascript/taskeditor', group : 'Integration/React', title : 'React Task editor customization', overlay : 'react', version : 'React 16', build : true, since : '2.0.1' },
    { folder : 'frameworks/react/javascript/timeline', group : 'Integration/React', title : 'React Gantt Timeline', overlay : 'react', version : 'React 17', build : true, since : '4.1' },
    { folder : 'frameworks/react/javascript/timeranges', group : 'Integration/React', title : 'React Time ranges', overlay : 'react', version : 'React 16', build : true, since : '2.0.1' },
    { folder : 'frameworks/react/typescript/basic', group : 'Integration/React', title : 'React Basics with TypeScript', overlay : 'react', version : 'React 16', build : true, since : '1.1.3' },
    { folder : 'frameworks/react/typescript/sharepoint-fabric', group : 'Integration/React', title : 'React SharePoint Workbench with TypeScript', overlay : 'react', version : 'React 16', build : true, offline : true, since : '4.0.4', updated : '4.1.0' },

    // Integration/Vue
    { folder : 'frameworks/vue/javascript/advanced', group : 'Integration/Vue', title : 'Vue Advanced', overlay : 'vue', version : 'Vue 2', build : true },
    { folder : 'frameworks/vue/javascript/gantt-schedulerpro', group : 'Integration/Vue', title : 'Vue Gantt + Scheduler Pro', overlay : 'vue', version : 'Vue 2', build : true, since : '4.2.0' },
    { folder : 'frameworks/vue/javascript/inline-data', group : 'Integration/Vue', title : 'Inline data in Vue Gantt', overlay : 'vue', version : 'Vue 2', since : '5.0.0', build : true },
    { folder : 'frameworks/vue/javascript/pdf-export', group : 'Integration/Vue', title : 'Vue PDF/PNG export', overlay : 'vue', version : 'Vue 2', build : true, since : '2.0' },
    { folder : 'frameworks/vue/javascript/rollups', group : 'Integration/Vue', title : 'Vue Rollups', overlay : 'vue', version : 'Vue 2', build : true, since : '2.0.1' },
    { folder : 'frameworks/vue/javascript/taskeditor', group : 'Integration/Vue', title : 'Vue Task editor customization', overlay : 'vue', version : 'Vue 2', build : true, since : '2.0.1' },
    { folder : 'frameworks/vue/javascript/timeranges', group : 'Integration/Vue', title : 'Vue Time ranges', overlay : 'vue', version : 'Vue 2', build : true, since : '2.0.1' },
    { folder : 'frameworks/vue/javascript/vue-renderer', group : 'Integration/Vue', title : 'Vue Cell Renderer', overlay : 'vue', version : 'Vue 2', build : true, since : '4.1' },

    // Integration/Vue-3
    { folder : 'frameworks/vue-3/javascript/gantt-schedulerpro', group : 'Integration/Vue', title : 'Vue 3 Gantt + Scheduler Pro', overlay : 'vue', version : 'Vue 3', build : true, since : '4.2.0' },
    { folder : 'frameworks/vue-3/javascript/inline-data', group : 'Integration/Vue', title : 'Inline data in Vue 3 Gantt', overlay : 'vue', version : 'Vue 3', since : '5.0.0', build : true },
    { folder : 'frameworks/vue-3/javascript/simple', group : 'Integration/Vue', title : 'Vue 3 Simple', overlay : 'vue', version : 'Vue 3', build : true, since : '4.1' }
];
