"use strict";

var {
  Gantt,
  ProjectModel,
  ResourceHistogram,
  Splitter
} = bryntum.gantt;
var project = window.project = new ProjectModel({
  startDate: '2019-01-16',
  endDate: '2019-02-13',
  transport: {
    load: {
      url: '../_datasets/launch-saas.json'
    }
  },
  autoLoad: true,
  // This config enables response validation and dumping of found errors to the browser console.
  // It's meant to be used as a development stage helper only so please set it to false for production systems.
  validateResponse: true
});
var gantt = new Gantt({
  project,
  dependencyIdField: 'sequenceNumber',
  resourceImageFolderPath: '../_shared/images/users/',
  appendTo: 'container',
  features: {
    labels: {
      left: {
        field: 'name',
        editor: {
          type: 'textfield'
        }
      }
    }
  },
  viewPreset: 'weekAndDayLetter',
  columnLines: true,
  columns: [{
    type: 'name',
    width: 280
  }, {
    type: 'resourceassignment',
    showAvatars: true,
    width: 170
  }],
  startDate: '2019-01-11'
});
new Splitter({
  appendTo: 'container'
});
var histogram = window.histogram = new ResourceHistogram({
  appendTo: 'container',
  project,
  hideHeaders: true,
  partner: gantt,
  rowHeight: 50,
  showBarTip: true,
  resourceImagePath: '../_shared/images/users/',
  features: {
    scheduleTooltip: false,
    group: {
      field: 'city'
    }
  },
  columns: [{
    type: 'resourceInfo',
    field: 'name',
    showEventCount: false,
    flex: 1
  }],
  tbar: {
    cls: 'histogram-toolbar',
    height: '3em',
    items: [{
      type: 'checkbox',
      ref: 'showBarText',
      text: 'Show bar texts',
      tooltip: 'Check to show resource allocation in the bars',
      checked: false,
      onAction: 'up.onShowBarTextToggle'
    }, {
      type: 'checkbox',
      ref: 'showMaxEffort',
      text: 'Show max allocation',
      tooltip: 'Check to display max resource allocation line',
      checked: true,
      onAction: 'up.onShowMaxAllocationToggle'
    }, {
      type: 'checkbox',
      ref: 'showBarTip',
      text: 'Enable bar tooltip',
      tooltip: 'Check to show tooltips when moving mouse over bars',
      checked: true,
      onAction: 'up.onShowBarTipToggle'
    }]
  },

  onShowBarTextToggle({
    source
  }) {
    histogram.showBarText = source.checked;
  },

  onShowMaxAllocationToggle({
    source
  }) {
    histogram.showMaxEffort = source.checked;
  },

  onShowBarTipToggle({
    source
  }) {
    histogram.showBarTip = source.checked;
  }

});