"use strict";

var {
  Gantt,
  ProjectModel
} = bryntum.gantt;
var project = new ProjectModel({
  transport: {
    load: {
      url: '../_datasets/launch-saas.json'
    }
  },
  // This config enables response validation and dumping of found errors to the browser console.
  // It's meant to be used as a development stage helper only so please set it to false for production systems.
  validateResponse: true
});
var gantt = new Gantt({
  appendTo: 'container',
  project: project,
  dependencyIdField: 'sequenceNumber',
  features: {
    excelExporter: {
      // Choose the date format for date fields
      dateFormat: 'YYYY-MM-DD HH:mm'
    }
  },
  subGridConfigs: {
    locked: {
      flex: 1
    },
    normal: {
      flex: 2
    }
  },
  columns: [{
    type: 'wbs'
  }, {
    type: 'name',
    width: 250
  }, {
    type: 'startdate'
  }, {
    type: 'duration'
  }, {
    type: 'effort'
  }, {
    type: 'resourceassignment'
  }, {
    type: 'percentdone',
    width: 70
  }, {
    type: 'predecessor',
    width: 112
  }, {
    type: 'successor',
    width: 112
  }, {
    type: 'schedulingmodecolumn'
  }, {
    type: 'calendar'
  }, {
    type: 'constrainttype'
  }, {
    type: 'constraintdate'
  }, {
    type: 'addnew'
  }],
  tbar: [{
    type: 'button',
    text: 'Export as .xslx',
    ref: 'excelExportBtn',
    icon: 'b-fa-file-export',
    onAction: () => {
      var filename = gantt.project.taskStore.first && gantt.project.taskStore.first.name;
      gantt.features.excelExporter.export({
        filename
      });
    }
  }]
});
project.load();