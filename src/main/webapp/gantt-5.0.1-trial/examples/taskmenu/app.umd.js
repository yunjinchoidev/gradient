"use strict";

var {
  Gantt,
  AjaxHelper,
  ProjectModel,
  DateHelper,
  WidgetHelper
} = bryntum.gantt;
var project = window.project = new ProjectModel({
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
    taskMenu: {
      items: {
        // Add extra menu items available on all tasks
        moveToNextDay: {
          icon: 'b-fa b-fa-calendar',
          text: 'Move to next day',
          cls: 'b-separator',

          onItem({
            taskRecord
          }) {
            taskRecord.shift(1, 'day');
          }

        },
        milestoneAction: {
          icon: 'b-fa b-fa-hippo',
          text: 'Milestone action',

          onItem() {
            WidgetHelper.toast('Performed milestone action');
          }

        },
        // Customize the built in "Edit task" item
        editTask: {
          icon: 'b-fa b-fa-edit'
        }
      },

      // Customize items dynamically
      processItems({
        taskRecord,
        items
      }) {
        // Hide "Delete task" for parents
        if (taskRecord.isParent) {
          items.deleteTask = false;
        } // Hide custom "Milestone action" if not a milestone


        if (!taskRecord.isMilestone) {
          items.milestoneAction = false;
        }
      }

    }
  },
  columns: [{
    type: 'name',
    field: 'name',
    text: 'Name',
    width: 250
  }],
  project,
  dependencyIdField: 'sequenceNumber'
});
project.load();