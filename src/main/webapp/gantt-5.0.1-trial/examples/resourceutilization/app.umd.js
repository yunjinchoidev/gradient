"use strict";

var {
  Gantt,
  ProjectModel,
  ResourceUtilization,
  Splitter,
  DateHelper,
  AvatarRendering
} = bryntum.gantt;
var project = new ProjectModel({
  transport: {
    load: {
      url: '../_datasets/launch-saas-overallocated.json'
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
  viewPreset: 'weekAndDayLetter',
  tickSize: 40,
  columnLines: true,
  startDate: '2022-01-14',
  columns: [{
    type: 'name',
    width: 280
  }, {
    type: 'resourceassignment',
    showAvatars: true,
    width: 170
  }]
});
new Splitter({
  appendTo: 'container'
});
var resourceUtilization = new ResourceUtilization({
  appendTo: 'container',
  project,
  partner: gantt,
  rowHeight: 40,
  showBarTip: true,
  resourceImageFolderPath: '../_shared/images/users/',
  // barTooltipTemplate      : TODO,
  columns: [{
    type: 'tree',
    field: 'name',
    width: 280,
    text: 'Resource / Task',

    renderer({
      record,
      grid,
      value
    }) {
      // lets show event start/end for assignment row
      if (record.origin.isResourceModel) {
        if (!this.avatarRendering) {
          this.avatarRendering = new AvatarRendering({
            element: grid.element
          });
        }

        var resource = record.origin;
        return {
          class: 'b-resource-info',
          children: [this.avatarRendering.getResourceAvatar({
            initials: resource.initials,
            color: resource.eventColor,
            iconCls: resource.iconCls,
            imageUrl: resource.image ? `${grid.resourceImageFolderPath}${resource.image}` : null
          }), value]
        };
      } else {
        return value;
      }
    }

  }, {
    cellCls: 'taskDateRange',

    renderer({
      record,
      value
    }) {
      // Show event start/end for assignment row
      if (record.origin.isAssignmentModel) {
        var task = record.origin.event;
        return DateHelper.format(task.startDate, 'MMM Do') + ' - ' + DateHelper.format(task.endDate, 'MMM Do');
      }

      return '';
    }

  }],
  bbar: {
    cls: 'utilization-toolbar',
    height: '3em',
    items: [{
      type: 'checkbox',
      ref: 'showBarTip',
      text: 'Enable bar tooltip',
      tooltip: 'Check to show tooltips when moving mouse over bars',
      checked: true,
      onAction: 'up.onShowBarTipToggle'
    }]
  },

  onShowBarTipToggle({
    source
  }) {
    resourceUtilization.showBarTip = source.checked;
  }

});