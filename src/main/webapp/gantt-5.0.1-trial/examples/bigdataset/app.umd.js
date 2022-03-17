"use strict";

function ownKeys(object, enumerableOnly) { var keys = Object.keys(object); if (Object.getOwnPropertySymbols) { var symbols = Object.getOwnPropertySymbols(object); enumerableOnly && (symbols = symbols.filter(function (sym) { return Object.getOwnPropertyDescriptor(object, sym).enumerable; })), keys.push.apply(keys, symbols); } return keys; }

function _objectSpread(target) { for (var i = 1; i < arguments.length; i++) { var source = null != arguments[i] ? arguments[i] : {}; i % 2 ? ownKeys(Object(source), !0).forEach(function (key) { _defineProperty(target, key, source[key]); }) : Object.getOwnPropertyDescriptors ? Object.defineProperties(target, Object.getOwnPropertyDescriptors(source)) : ownKeys(Object(source)).forEach(function (key) { Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key)); }); } return target; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

var {
  Gantt,
  ProjectModel,
  AsyncHelper,
  ProjectGenerator
} = bryntum.gantt;

var toggleCustom = show => {
  taskCountField.hidden = projectSizeField.hidden = !show;
},
    applyPreset = count => {
  toggleCustom(false);
  projectSizeField.value = 50;
  taskCountField.value = count;
  gantt.generateDataset();
};

var busy = false;
var gantt = new Gantt({
  appendTo: 'container',
  emptyText: '',
  dependencyIdField: 'sequenceNumber',
  columns: [{
    type: 'name',
    field: 'name',
    text: 'Name',
    width: 200
  }, {
    type: 'startdate',
    text: 'Start date'
  }, {
    type: 'duration',
    text: 'Duration'
  }],
  columnLines: false,

  // If you try approach B or C below you need to define a project here
  // project : {
  //     taskStore       : { useRawData : true },
  //     dependencyStore : { useRawData : true }
  // },
  async generateDataset(count = taskCountField.value) {
    var _gantt$project;

    // Bail out if we are already generating a dataset (it is async)
    if (busy) {
      return;
    }

    busy = true;

    if (count > 1000) {
      gantt.mask('Generating tasks');
    } // Required to allow browser to update DOM before task generation starts


    await AsyncHelper.sleep(100);
    var config = await ProjectGenerator.generateAsync(count, projectSizeField.value); // Required to allow browser to update DOM before calculations starts

    await AsyncHelper.sleep(10); //
    // Alternative approaches that should have similar performance:
    //
    // A) Replace entire project with a new project

    (_gantt$project = gantt.project) === null || _gantt$project === void 0 ? void 0 : _gantt$project.destroy();
    gantt.project = new ProjectModel(_objectSpread({
      // The `useRawData` settings below speeds record creation up a bit by not cloning the raw data objects,
      // instead uses them directly as is
      taskStore: {
        useRawData: true
      },
      dependencyStore: {
        useRawData: true
      }
    }, config));
    gantt.startDate = gantt.project.startDate;

    if (count > 1000) {
      gantt.unmask();
    } // B) Replace store data per store
    // gantt.taskStore.data = config.tasksData;
    // gantt.dependencyStore.data = config.dependenciesData;
    // C) Replace store data via project
    // gantt.project.loadInlineData(config);


    gantt.project.on({
      dataReady() {
        busy = false;
      }

    });
  },

  tbar: ['Presets', {
    type: 'buttongroup',
    toggleGroup: true,
    items: [{
      text: '1K tasks',
      pressed: true,
      ref: '1kButton',
      tasks: 1000
    }, {
      text: '5K tasks',
      ref: '5kButton',
      tasks: 5000
    }, {
      text: '10K tasks',
      ref: '10kButton',
      tasks: 10000
    }, {
      text: 'Custom',
      ref: 'customButton',

      onClick() {
        toggleCustom(true);
      }

    }],

    onClick({
      source: button
    }) {
      if (button.tasks) {
        applyPreset(button.tasks);
      }
    }

  }, '->', {
    type: 'number',
    ref: 'taskCountField',
    label: 'Tasks',
    tooltip: 'Enter number of tasks to generate and press [ENTER]. Tasks are divided into blocks of ten',
    value: 1000,
    min: 10,
    max: 10000,
    width: 'auto',
    inputWidth: '5em',
    step: 10,
    hidden: true,

    onChange({
      userAction
    }) {
      if (userAction) {
        gantt.generateDataset();
      }
    }

  }, {
    type: 'number',
    ref: 'projectSizeField',
    label: 'Project size',
    tooltip: 'Enter number of tasks that should be connected into a "project" (multipliers of 10)',
    min: 10,
    max: 1000,
    value: 50,
    width: 'auto',
    inputWidth: '4em',
    step: 10,
    hidden: true,

    onChange({
      userAction
    }) {
      if (userAction) {
        gantt.generateDataset();
      }
    }

  }]
});
var {
  taskCountField,
  projectSizeField
} = gantt.widgetMap;
gantt.generateDataset();