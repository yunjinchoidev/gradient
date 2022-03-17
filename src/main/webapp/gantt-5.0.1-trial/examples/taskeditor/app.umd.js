"use strict";

var {
  Combo,
  Grid,
  List,
  Gantt,
  ProjectModel,
  TaskModel
} = bryntum.gantt;
var baseColors = ['maroon', 'red', 'orange', 'yellow', 'olive', 'green', 'purple', 'fuchsia', 'lime', 'teal', 'aqua', 'blue', 'navy', 'black', 'gray', 'silver', 'white'];

class ColorField extends Combo {
  // Factoryable type name
  static get type() {
    return 'colorfield';
  }

  static get defaultConfig() {
    return {
      clearable: true,
      items: baseColors,
      picker: {
        cls: 'b-color-picker-container',
        itemCls: 'b-color-picker-item',
        itemTpl: item => `<div style="background-color:${item.id}"></div>`
      }
    };
  }

} // Register this widget type with its Factory


ColorField.initClass();
/**
 * @module FilesTab
 */

/**
 * @internal
 */

class FilesTab extends Grid {
  // Factoryable type name
  static get type() {
    return 'filestab';
  }

  static get defaultConfig() {
    return {
      title: 'Files',
      defaults: {
        labelWidth: 200
      },
      columns: [{
        text: 'Files attached to task',
        field: 'name',
        type: 'template',
        template: data => `<i class="b-fa b-fa-fw b-fa-${data.record.data.icon}"></i>${data.record.data.name}`
      }]
    };
  }

  loadEvent(eventRecord) {
    var files = [];

    for (var i = 0; i < Math.random() * 10; i++) {
      var nbr = Math.round(Math.random() * 5);

      switch (nbr) {
        case 1:
          files.push({
            name: `Image${nbr}.pdf`,
            icon: 'image'
          });
          break;

        case 2:
          files.push({
            name: `Charts${nbr}.pdf`,
            icon: 'chart-pie'
          });
          break;

        case 3:
          files.push({
            name: `Spreadsheet${nbr}.pdf`,
            icon: 'file-excel'
          });
          break;

        case 4:
          files.push({
            name: `Document${nbr}.pdf`,
            icon: 'file-word'
          });
          break;

        case 5:
          files.push({
            name: `Report${nbr}.pdf`,
            icon: 'chart-line'
          });
          break;
      }
    }

    this.store.data = files;
  }

} // Register this widget type with its Factory


FilesTab.initClass();
/**
 * @module ResourceList
 */

/**
 * @internal
 */

class ResourceList extends List {
  // Factoryable type name
  static get type() {
    return 'resourcelist';
  }

  static get configurable() {
    return {
      title: 'Resources',
      cls: 'b-inline-list',
      items: [],
      itemTpl: resource => {
        return `
                    <img src="../_shared/images/users/${resource.name.toLowerCase()}.jpg">
                    <div class="b-resource-detail">
                        <div class="b-resource-name">${resource.name}</div>
                        <div class="b-resource-city">
                            ${resource.city}
                            <i data-btip="Deassign resource" class="b-icon b-icon-trash"></i>
                        </div>
                    </div>
                `;
      }
    };
  } // Called by the owning TaskEditor whenever a task is loaded


  loadEvent(taskRecord) {
    this.taskRecord = taskRecord;
    this.store.data = taskRecord.resources;
  } // Called on item click


  onItem({
    event,
    record
  }) {
    if (event.target.matches('.b-icon-trash')) {
      // Unassign the clicked resource record from the currehtly loaded task
      this.taskRecord.unassign(record); // Update our store with the new assignment set

      this.store.data = this.taskRecord.resources;
    }
  }

} // Register this widget type with its Factory


ResourceList.initClass();

class MyModel extends TaskModel {
  static get fields() {
    return [{
      name: 'deadline',
      type: 'date'
    }, {
      name: 'color'
    }];
  }

}

var project = window.project = new ProjectModel({
  taskModelClass: MyModel,
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
    taskEdit: {
      items: {
        generalTab: {
          // change title of General tab
          title: 'Common',
          items: {
            customDivider: {
              html: '',
              dataset: {
                text: 'Custom fields'
              },
              cls: 'b-divider',
              flex: '1 0 100%'
            },
            deadlineField: {
              type: 'datefield',
              name: 'deadline',
              label: 'Deadline',
              flex: '1 0 50%',
              cls: 'b-inline'
            },
            colorField: {
              type: 'colorfield',
              name: 'color',
              label: 'Color',
              flex: '1 0 50%',
              cls: 'b-inline'
            },
            priority: {
              type: 'radiogroup',
              name: 'priority',
              label: 'Priority',
              flex: '1 0 100%',
              options: {
                high: 'High',
                med: 'Medium',
                low: 'Low'
              }
            }
          }
        },
        // remove Notes tab
        notesTab: false,
        // add custom Files tab to the second position
        filesTab: {
          type: 'filestab',
          weight: 110
        },
        // add custom Resources tab to the third position
        resourcesTab: {
          type: 'resourcelist',
          weight: 120,
          title: 'Resources'
        }
      }
    }
  },
  taskRenderer: ({
    taskRecord,
    renderData
  }) => {
    if (taskRecord.color) {
      renderData.style += `background-color:${taskRecord.color}`;
    }
  },
  columns: [{
    type: 'name',
    field: 'name',
    text: 'Name',
    width: 250
  }, {
    type: 'date',
    field: 'deadline',
    text: 'Deadline'
  }],
  project,
  dependencyIdField: 'sequenceNumber'
});
project.load();