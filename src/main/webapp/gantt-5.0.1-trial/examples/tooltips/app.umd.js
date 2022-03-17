"use strict";

var {
  Gantt,
  ProjectModel,
  TaskTooltip,
  DateHelper,
  StringHelper
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
  features: {
    taskTooltip: {
      template(data) {
        var me = this,
            {
          taskRecord
        } = data; // Return the result of the feature's default template, with custom markup appended

        return TaskTooltip.defaultConfig.template.call(me, data) + `<table border="0" cellspacing="0" cellpadding="0">
                        <tr><td>${me.L('Scheduling Mode')}:</td><td>${taskRecord.schedulingMode}</td></tr>
                        <tr><td>${me.L('Calendar')}:</td><td>${taskRecord.effectiveCalendar.name}</td></tr>
                        <tr><td>${me.L('Critical')}:</td><td>${taskRecord.critical ? me.L('Yes') : me.L('No')}</td></tr>
                    </table>`;
      }

    },
    taskDrag: {
      // Custom tooltip for when a task is dragged
      tooltipTemplate({
        taskRecord,
        startDate
      }) {
        return StringHelper.xss`<h4 style="margin:0 0 1em 0">Custom drag drop tooltip</h4>${taskRecord.name}: ${DateHelper.format(startDate, 'MMM D')}`;
      }

    },
    taskResize: {
      // A minimal end date tooltip
      tooltipTemplate({
        record,
        endDate
      }) {
        return DateHelper.format(endDate, 'MMM D');
      }

    }
  },
  project,
  dependencyIdField: 'sequenceNumber',
  resourceImageFolderPath: '../_shared/images/users/',
  columns: [{
    type: 'name',
    field: 'name',
    width: 250
  }, {
    type: 'resourceassignment',
    width: 120,
    showAvatars: true,

    avatarTooltipTemplate({
      resourceRecord,
      assignmentRecord,
      overflowCount
    }) {
      return `
                    <div><span>Name</span>${resourceRecord.name}</div>
                    <div><span>City</span>${resourceRecord.city}</div>
                    <div><span>Units</span>${assignmentRecord.units} %</div>  
                    ${overflowCount > 0 ? `<div class="overflow">+${overflowCount} more</div>` : ''}                
                `;
    }

  }]
});
project.load();