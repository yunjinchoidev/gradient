"use strict";

var {
  Gantt,
  AjaxHelper,
  ProjectModel,
  DateHelper,
  WidgetHelper
} = bryntum.gantt;
/* eslint-disable no-unused-vars,no-undef */

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
  columns: [{
    type: 'name',
    field: 'name',
    text: 'Name',
    width: 250
  }],
  project,
  dependencyIdField: 'sequenceNumber',
  listeners: {
    // Listener called before the built in task menu is shown
    taskMenuBeforeShow({
      taskRecord,
      event
    }) {
      // Hide all visible context menus
      $('.dropdown-menu:visible').hide(); // Set data, set position, and show custom task menu

      $('#customTaskMenu').data({
        taskId: taskRecord.id
      }).css({
        top: event.y,
        left: event.x
      }).show(); // Prevent built in task menu

      return false;
    }

  }
});
project.load(); // Hide all visible context menus by global click

$(document).on('click', () => {
  $('.dropdown-menu:visible').hide();
}); // Task menu handlers

$('#customTaskMenu button').on('click', function () {
  var taskId = $(this).parent().data('taskId'),
      taskRecord = gantt.taskStore.getById(taskId),
      ref = $(this).data('ref');

  switch (ref) {
    // "1 day ahead" menu item implementation
    case 'move':
      taskRecord.shift(1, 'day');
      break;
    // "Edit" menu item implementation

    case 'edit':
      gantt.editTask(taskRecord);
      break;
    // "Remove" menu item implementation

    case 'remove':
      gantt.taskStore.remove(taskId);
      break;
  }
});