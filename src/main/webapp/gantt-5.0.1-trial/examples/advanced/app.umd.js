"use strict";

var {
  Toolbar,
  Toast,
  DateHelper,
  CSSHelper,
  Column,
  ColumnStore,
  TaskModel,
  Gantt
} = bryntum.gantt;
/**
 * @module GanttToolbar
 */

/**
 * @extends Core/widget/Toolbar
 */

class GanttToolbar extends Toolbar {
  // Factoryable type name
  static get type() {
    return 'gantttoolbar';
  }

  static get $name() {
    return 'GanttToolbar';
  }

  static get configurable() {
    return {
      items: [{
        type: 'buttonGroup',
        items: [{
          color: 'b-green',
          ref: 'addTaskButton',
          icon: 'b-fa b-fa-plus',
          text: 'Create',
          tooltip: 'Create new task',
          onAction: 'up.onAddTaskClick'
        }]
      }, {
        ref: 'undoRedo',
        type: 'undoredo',
        items: {
          transactionsCombo: null
        }
      }, {
        type: 'buttonGroup',
        items: [{
          ref: 'expandAllButton',
          icon: 'b-fa b-fa-angle-double-down',
          tooltip: 'Expand all',
          onAction: 'up.onExpandAllClick'
        }, {
          ref: 'collapseAllButton',
          icon: 'b-fa b-fa-angle-double-up',
          tooltip: 'Collapse all',
          onAction: 'up.onCollapseAllClick'
        }]
      }, {
        type: 'buttonGroup',
        items: [{
          ref: 'zoomInButton',
          icon: 'b-fa b-fa-search-plus',
          tooltip: 'Zoom in',
          onAction: 'up.onZoomInClick'
        }, {
          ref: 'zoomOutButton',
          icon: 'b-fa b-fa-search-minus',
          tooltip: 'Zoom out',
          onAction: 'up.onZoomOutClick'
        }, {
          ref: 'zoomToFitButton',
          icon: 'b-fa b-fa-compress-arrows-alt',
          tooltip: 'Zoom to fit',
          onAction: 'up.onZoomToFitClick'
        }, {
          ref: 'previousButton',
          icon: 'b-fa b-fa-angle-left',
          tooltip: 'Previous time span',
          onAction: 'up.onShiftPreviousClick'
        }, {
          ref: 'nextButton',
          icon: 'b-fa b-fa-angle-right',
          tooltip: 'Next time span',
          onAction: 'up.onShiftNextClick'
        }]
      }, {
        type: 'datefield',
        ref: 'startDateField',
        label: 'Project start',
        // required  : true, (done on load)
        flex: '0 0 17em',
        listeners: {
          change: 'up.onStartDateChange'
        }
      }, {
        type: 'combo',
        ref: 'projectSelector',
        label: 'Choose project',
        editable: false,
        width: '20em',
        displayField: 'name',
        value: 1,
        store: {
          data: [{
            id: 1,
            name: 'Launch SaaS',
            url: '../_datasets/launch-saas.json'
          }, {
            id: 2,
            name: 'Build web app for customer',
            url: '../_datasets/tasks-workedhours.json'
          }]
        },
        listeners: {
          select: 'up.onProjectSelected'
        }
      }, '->', {
        type: 'textfield',
        ref: 'filterByName',
        cls: 'filter-by-name',
        flex: '0 0 13.5em',
        // Label used for material, hidden in other themes
        label: 'Find tasks by name',
        // Placeholder for others
        placeholder: 'Find tasks by name',
        clearable: true,
        keyStrokeChangeDelay: 100,
        triggers: {
          filter: {
            align: 'end',
            cls: 'b-fa b-fa-filter'
          }
        },
        onChange: 'up.onFilterChange'
      }, {
        type: 'button',
        ref: 'featuresButton',
        icon: 'b-fa b-fa-tasks',
        text: 'Settings',
        tooltip: 'Toggle features',
        toggleable: true,
        menu: {
          onItem: 'up.onFeaturesClick',
          onBeforeShow: 'up.onFeaturesShow',
          // "checked" is set to a boolean value to display a checkbox for menu items. No matter if it is true or false.
          // The real value is set dynamically depending on the "disabled" config of the feature it is bound to.
          items: [{
            text: 'UI settings',
            icon: 'b-fa-sliders-h',
            menu: {
              cls: 'settings-menu',
              layoutStyle: {
                flexDirection: 'column'
              },
              onBeforeShow: 'up.onSettingsShow',
              defaults: {
                type: 'slider',
                showValue: true
              },
              items: [{
                ref: 'rowHeight',
                text: 'Row height',
                min: 30,
                max: 70,
                onInput: 'up.onRowHeightChange'
              }, {
                ref: 'barMargin',
                text: 'Bar margin',
                min: 0,
                max: 10,
                onInput: 'up.onBarMarginChange'
              }, {
                ref: 'duration',
                text: 'Animation duration',
                min: 0,
                max: 2000,
                step: 100,
                onInput: 'up.onAnimationDurationChange'
              }]
            }
          }, {
            text: 'Draw dependencies',
            feature: 'dependencies',
            checked: false
          }, {
            text: 'Task labels',
            feature: 'labels',
            checked: false
          }, {
            text: 'Critical paths',
            feature: 'criticalPaths',
            tooltip: 'Highlight critical paths',
            checked: false
          }, {
            text: 'Project lines',
            feature: 'projectLines',
            checked: false
          }, {
            text: 'Highlight non-working time',
            feature: 'nonWorkingTime',
            checked: false
          }, {
            text: 'Enable cell editing',
            feature: 'cellEdit',
            checked: false
          }, {
            text: 'Show column lines',
            feature: 'columnLines',
            checked: true
          }, {
            text: 'Show baselines',
            feature: 'baselines',
            checked: false
          }, {
            text: 'Show rollups',
            feature: 'rollups',
            checked: false
          }, {
            text: 'Show progress line',
            feature: 'progressLine',
            checked: false
          }, {
            text: 'Show parent area',
            feature: 'parentArea',
            checked: false
          }, {
            text: 'Hide schedule',
            cls: 'b-separator',
            subGrid: 'normal',
            checked: false
          }]
        }
      }]
    };
  } // Called when toolbar is added to the Gantt panel


  updateParent(parent, was) {
    super.updateParent(parent, was);
    this.gantt = parent;
    parent.project.on({
      load: 'updateStartDateField',
      refresh: 'updateStartDateField',
      thisObj: this
    });
    this.styleNode = document.createElement('style');
    document.head.appendChild(this.styleNode);
  }

  setAnimationDuration(value) {
    var me = this,
        cssText = `.b-animating .b-gantt-task-wrap { transition-duration: ${value / 1000}s !important; }`;
    me.gantt.transitionDuration = value;

    if (me.transitionRule) {
      me.transitionRule.cssText = cssText;
    } else {
      me.transitionRule = CSSHelper.insertRule(cssText);
    }
  }

  updateStartDateField() {
    var {
      startDateField
    } = this.widgetMap;
    startDateField.value = this.gantt.project.startDate; // This handler is called on project.load/propagationComplete, so now we have the
    // initial start date. Prior to this time, the empty (default) value would be
    // flagged as invalid.

    startDateField.required = true;
  } // region controller methods


  async onAddTaskClick() {
    var {
      gantt
    } = this,
        added = gantt.taskStore.rootNode.appendChild({
      name: this.L('New task'),
      duration: 1
    }); // run propagation to calculate new task fields

    await gantt.project.propagateAsync(); // scroll to the added task

    await gantt.scrollRowIntoView(added);
    gantt.features.cellEdit.startEditing({
      record: added,
      field: 'name'
    });
  }

  onEditTaskClick() {
    var {
      gantt
    } = this;

    if (gantt.selectedRecord) {
      gantt.editTask(gantt.selectedRecord);
    } else {
      Toast.show(this.L('First select the task you want to edit'));
    }
  }

  onExpandAllClick() {
    this.gantt.expandAll();
  }

  onCollapseAllClick() {
    this.gantt.collapseAll();
  }

  onZoomInClick() {
    this.gantt.zoomIn();
  }

  onZoomOutClick() {
    this.gantt.zoomOut();
  }

  onZoomToFitClick() {
    this.gantt.zoomToFit({
      leftMargin: 50,
      rightMargin: 50
    });
  }

  onShiftPreviousClick() {
    this.gantt.shiftPrevious();
  }

  onShiftNextClick() {
    this.gantt.shiftNext();
  }

  onStartDateChange({
    value,
    oldValue
  }) {
    if (value) {
      this.gantt.startDate = DateHelper.add(value, -1, 'week');
      this.gantt.project.setStartDate(value);
    }
  }

  onProjectSelected({
    record
  }) {
    this.gantt.project.load(record.url);
  }

  onFilterChange({
    value
  }) {
    if (value === '') {
      this.gantt.taskStore.clearFilters();
    } else {
      value = value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
      this.gantt.taskStore.filter({
        filters: task => task.name && task.name.match(new RegExp(value, 'i')),
        replace: true
      });
    }
  }

  onFeaturesClick({
    source: item
  }) {
    var {
      gantt
    } = this;

    if (item.feature) {
      var feature = gantt.features[item.feature];
      feature.disabled = !feature.disabled;
    } else if (item.subGrid) {
      var subGrid = gantt.subGrids[item.subGrid];
      subGrid.collapsed = !subGrid.collapsed;
    }
  }

  onFeaturesShow({
    source: menu
  }) {
    var {
      gantt
    } = this;
    menu.items.map(item => {
      var {
        feature
      } = item;

      if (feature) {
        // a feature might be not presented in the gantt
        // (the code is shared between "advanced" and "php" demos which use a bit different set of features)
        if (gantt.features[feature]) {
          item.checked = !gantt.features[feature].disabled;
        } // hide not existing features
        else {
          item.hide();
        }
      } else if (item.subGrid) {
        item.checked = gantt.subGrids[item.subGrid].collapsed;
      }
    });
  }

  onSettingsShow({
    source: menu
  }) {
    var {
      gantt
    } = this,
        {
      rowHeight,
      barMargin,
      duration
    } = menu.widgetMap;
    rowHeight.value = gantt.rowHeight;
    barMargin.value = gantt.barMargin;
    barMargin.max = gantt.rowHeight / 2 - 5;
    duration.value = gantt.transitionDuration;
  }

  onRowHeightChange({
    value,
    source
  }) {
    this.gantt.rowHeight = value;
    source.owner.widgetMap.barMargin.max = value / 2 - 5;
  }

  onBarMarginChange({
    value
  }) {
    this.gantt.barMargin = value;
  }

  onAnimationDurationChange({
    value
  }) {
    this.gantt.transitionDuration = value;
    this.styleNode.innerHTML = `.b-animating .b-gantt-task-wrap { transition-duration: ${value / 1000}s !important; }`;
  }

  onCriticalPathsClick({
    source
  }) {
    this.gantt.features.criticalPaths.disabled = !source.pressed;
  } // endregion


}

; // Register this widget type with its Factory

GanttToolbar.initClass();
/**
 * @module StatusColumn
 */

/**
 * A column showing the status of a task
 *
 * @extends Gantt/column/Column
 * @classType statuscolumn
 */

class StatusColumn extends Column {
  static get $name() {
    return 'StatusColumn';
  }

  static get type() {
    return 'statuscolumn';
  }

  static get isGanttColumn() {
    return true;
  }

  static get defaults() {
    return {
      // Set your default instance config properties here
      field: 'status',
      text: 'Status',
      editor: false,
      cellCls: 'b-status-column-cell',
      htmlEncode: false,
      filterable: {
        filterField: {
          type: 'combo',
          items: ['Not Started', 'Started', 'Completed', 'Late']
        }
      }
    };
  } //endregion


  renderer({
    record
  }) {
    var status = record.status;
    return status ? {
      tag: 'i',
      className: `b-fa b-fa-circle ${status}`,
      html: status
    } : '';
  } // * reactiveRenderer() {
  //     const
  //         percentDone = yield this.record.$.percentDone;
  //         //endDate     = yield this.record.$.endDate;
  //
  //     let status;
  //
  //     if (percentDone >= 100) {
  //         status = 'Completed';
  //     }
  //     // else if (endDate < Date.now()) {
  //     //     status = 'Late';
  //     // }
  //     else if (percentDone > 0) {
  //         status = 'Started';
  //     }
  //
  //     return status ? {
  //         tag       : 'i',
  //         className : `b-fa b-fa-circle ${status}`,
  //         html      : status
  //     } : '';
  // }


}

ColumnStore.registerColumnType(StatusColumn); // here you can extend our default Task class with your additional fields, methods and logic

class Task extends TaskModel {
  static get fields() {
    return ['status' // For status column
    ];
  }

  get isLate() {
    return !this.isCompleted && this.deadlineDate && Date.now() > this.deadlineDate;
  }

  get status() {
    var status = 'Not started';

    if (this.isCompleted) {
      status = 'Completed';
    } else if (this.isLate) {
      status = 'Late';
    } else if (this.isStarted) {
      status = 'Started';
    }

    return status;
  }

}

var gantt = new Gantt({
  appendTo: 'container',
  dependencyIdField: 'wbsCode',
  project: {
    // Let the Project know we want to use our own Task model with custom fields / methods
    taskModelClass: Task,
    transport: {
      load: {
        url: '../_datasets/launch-saas.json'
      }
    },
    autoLoad: true,
    // The State TrackingManager which the UndoRedo widget in the toolbar uses
    stm: {
      autoRecord: true
    },
    // Reset Undo / Redo after each load
    resetUndoRedoQueuesAfterLoad: true,
    // This config enables response validation and dumping of found errors to the browser console.
    // It's meant to be used as a development stage helper only so please set it to false for production systems.
    validateResponse: true
  },
  startDate: '2019-01-12',
  endDate: '2019-03-24',
  resourceImageFolderPath: '../_shared/images/users/',
  scrollTaskIntoViewOnCellClick: true,
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
    type: 'resourceassignment',
    width: 120,
    showAvatars: true
  }, {
    type: 'percentdone',
    showCircle: true,
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
    type: 'statuscolumn'
  }, {
    type: 'deadlinedate'
  }, {
    type: 'addnew'
  }],
  subGridConfigs: {
    locked: {
      flex: 3
    },
    normal: {
      flex: 4
    }
  },
  columnLines: false,
  features: {
    baselines: {
      disabled: true
    },
    dependencyEdit: true,
    filter: true,
    labels: {
      left: {
        field: 'name',
        editor: {
          type: 'textfield'
        }
      }
    },
    parentArea: {
      disabled: true
    },
    progressLine: {
      disabled: true,
      statusDate: new Date(2019, 0, 25)
    },
    rollups: {
      disabled: true
    },
    rowReorder: {
      showGrip: true
    },
    timeRanges: {
      showCurrentTimeLine: true
    }
  },
  tbar: {
    type: 'gantttoolbar'
  }
});