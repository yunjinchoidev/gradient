"use strict";

function ownKeys(object, enumerableOnly) { var keys = Object.keys(object); if (Object.getOwnPropertySymbols) { var symbols = Object.getOwnPropertySymbols(object); enumerableOnly && (symbols = symbols.filter(function (sym) { return Object.getOwnPropertyDescriptor(object, sym).enumerable; })), keys.push.apply(keys, symbols); } return keys; }

function _objectSpread(target) { for (var i = 1; i < arguments.length; i++) { var source = null != arguments[i] ? arguments[i] : {}; i % 2 ? ownKeys(Object(source), !0).forEach(function (key) { _defineProperty(target, key, source[key]); }) : Object.getOwnPropertyDescriptors ? Object.defineProperties(target, Object.getOwnPropertyDescriptors(source)) : ownKeys(Object(source)).forEach(function (key) { Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key)); }); } return target; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

var {
  Gantt,
  ProjectModel,
  AsyncHelper,
  Toast
} = bryntum.gantt; // TODO : Make it work with CrudManager

var project = new ProjectModel({
  startDate: new Date(2021, 0, 1),
  endDate: new Date(2021, 1, 14),
  // This config enables response validation and dumping of found errors to the browser console.
  // It's meant to be used as a development stage helper only so please set it to false for production systems.
  validateResponse: true,
  // Render tasks as early as possible, before performing calculations. The Gantt chart will be read-only until
  // calculations are finished (note that this is the default, only here to highlight the fact that it is
  // configurable)
  delayCalculation: true,
  // This setting is on by default for delayed calculations, enable it for legacy load to display a mask
  // showing calculation progress
  enableProgressNotifications: true
});
var gantt = new Gantt({
  appendTo: 'container',
  project,
  emptyText: '',
  dependencyIdField: 'sequenceNumber',
  columns: [{
    type: 'name',
    width: 250
  }],
  tbar: [{
    type: 'buttongroup',
    ref: 'reloadButtons',
    items: [{
      ref: 'earlyButton',
      text: 'Early render reload',
      icon: 'b-fa-bolt',

      onClick() {
        project.delayCalculation = true;
        loadData();
      }

    }, {
      ref: 'legacyButton',
      text: 'Legacy render reload',
      icon: 'b-fa-hourglass',

      onClick() {
        project.delayCalculation = false;
        loadData();
      }

    }]
  }]
});
var start,
    json = null;

async function loadData() {
  gantt.widgetMap.reloadButtons.disabled = true;
  gantt.mask('Loading data'); // Give UI a chance to show the mask

  await AsyncHelper.sleep(100); // Only load over the network first time

  if (!json) {
    // Load pre-normalized data using fetch
    var data = await fetch('data/large10k.json'); // Convert it to json to be able to load it into the project below

    json = await data.json();
  } // This is a reload, remove all tasks to visually see new ones arriving
  // (since it is the same dataset it wont be noticeable otherwise)
  else {
    // Clear tasks & dependencies
    await project.loadInlineData({
      tasksData: [],
      dependenciesData: []
    }); // The clear above also clears the mask, put it back

    gantt.mask('Loading data'); // Give UI a chance to remove them

    await AsyncHelper.sleep(100);
  } // Measure time until tasks are rendered


  start = performance.now();
  gantt.on({
    // Listen rendering of first task
    async renderTask() {
      var elapsed = performance.now() - start; // Give UI a chance to draw

      await AsyncHelper.sleep(100); // Display elapsed time in a toast

      Toast.show(`10k tasks visible after ${Math.round(elapsed) / 1000}s`);
      gantt.widgetMap.reloadButtons.disabled = false;
      gantt.unmask();
    },

    once: true
  }); // Load json into the project

  await project.loadInlineData(_objectSpread({}, json));
}

loadData();