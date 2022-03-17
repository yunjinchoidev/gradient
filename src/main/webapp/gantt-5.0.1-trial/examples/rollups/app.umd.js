"use strict";

var {
  Gantt,
  ProjectModel
} = bryntum.gantt;
var project = window.project = new ProjectModel({
  transport: {
    load: {
      url: 'data/tasks.json'
    }
  },
  // This config enables response validation and dumping of found errors to the browser console.
  // It's meant to be used as a development stage helper only so please set it to false for production systems.
  validateResponse: true
});
var gantt = new Gantt({
  appendTo: 'container',
  project: project,
  dependencyIdField: 'wbsCode',
  columns: [{
    type: 'wbs'
  }, {
    type: 'name'
  }, {
    type: 'rollup'
  }],
  viewPreset: 'monthAndYear',
  // Allow extra space for rollups
  rowHeight: 50,
  barMargin: 11,
  columnLines: true,
  features: {
    rollups: true
  },
  tbar: [{
    type: 'checkbox',
    label: 'Show Rollups',
    checked: true,

    onAction({
      checked
    }) {
      gantt.features.rollups.disabled = !checked;
    }

  }, {
    type: 'checkbox',
    label: 'Auto update WBS',
    checked: false,

    onAction({
      checked
    }) {
      project.taskStore.wbsMode = checked ? 'auto' : 'manual';
    }

  }]
});
project.load();