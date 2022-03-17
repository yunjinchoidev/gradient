"use strict";

var {
  DragHelper,
  Toast,
  TreeGrid,
  AvatarRendering,
  Container,
  ProjectModel
} = bryntum.gantt;

class Drag extends DragHelper {
  static get configurable() {
    return {
      callOnFunctions: true,
      // Don't drag the actual row element, we clone an image instead
      cloneTarget: true,
      // We size the cloned element using CSS
      autoSizeClonedTarget: false,
      // Stack all dragged DOM nodes together
      unifiedProxy: true,
      // Only allow drops on gantt task bars
      dropTargetSelector: '.b-gantt-task-wrap,.b-gantt .b-grid-row',
      // Allow drag of row elements inside the resource grid
      targetSelector: '.b-grid-row',
      // Drag just the avatar, not the full row
      proxySelector: '.b-resource-avatar',
      gantt: null,
      grid: null
    };
  }

  onDragStart({
    context
  }) {
    var {
      grid,
      gantt
    } = this,
        {
      grabbed
    } = context; // save a reference to the resource so we can access it later

    context.resourceRecord = grid.getRecordFromElement(grabbed);
    context.relatedElements = grid.selectedRecords.map(rec => rec !== context.resourceRecord && grid.rowManager.getRowFor(rec).element).filter(el => el);
    gantt.enableScrollingCloseToEdges(gantt.timeAxisSubGrid); // To enable a hover effect on the grid rows while moving the mouse

    gantt.element.classList.add('b-dragging-resource');
  }

  onDrag({
    context,
    event
  }) {
    var targetTask = context.taskRecord = this.gantt.resolveTaskRecord(event.target);
    context.valid = Boolean(targetTask && !targetTask.resources.includes(context.resourceRecord));
  } // Drop callback after a mouse up. If drop is valid, the element is animated to its final position before the data transfer


  async onDrop({
    context
  }) {
    var {
      gantt,
      grid
    } = this,
        {
      taskRecord,
      resourceRecord
    } = context;

    if (context.valid) {
      // Valid drop, provide a point to animate the proxy to before finishing the operation
      var resourceAssignmentCell = gantt.getCell({
        column: gantt.columns.get('assignments'),
        record: taskRecord
      }),
          avatarContainer = resourceAssignmentCell.querySelector('.b-resource-avatar-container'); // Before we finalize the drop and update the task record, transition the element to the target point

      if (avatarContainer) {
        await this.animateProxyTo(avatarContainer, {
          align: 'l0-r0'
        });
      }

      grid.selectedRecords.forEach(resourceRecord => {
        if (!taskRecord.resources.includes(resourceRecord)) {
          taskRecord.assign(resourceRecord);
        }
      });
    } else if (taskRecord !== null && taskRecord !== void 0 && taskRecord.resources.includes(resourceRecord)) {
      Toast.show(`Task is already assigned to ${resourceRecord.name}`);
    }

    gantt.element.classList.remove('b-dragging-resource');
    gantt.disableScrollingCloseToEdges(gantt.timeAxisSubGrid);
  }

  updateGantt(gantt) {
    // Configure DragHelper with gantt's scrollManager to allow scrolling while dragging
    this.scrollManager = gantt.scrollManager;
    this.outerElement = this.grid.element;
  }

}

class ResourceGrid extends TreeGrid {
  // Original class name getter. See Widget.$name docs for the details.
  static get $name() {
    return 'ResourceGrid';
  } // Factoryable type name


  static get type() {
    return 'resourcegrid';
  }

  static get configurable() {
    return {
      resourceImagePath: '../_shared/images/users/',
      selectionMode: {
        row: true,
        multiSelect: true
      },
      columns: [{
        type: 'tree',
        text: 'Resources',
        showEventCount: false,
        field: 'name',
        renderer: ({
          record,
          grid,
          value
        }) => ({
          class: 'b-resource-info',
          children: [grid.avatarRendering.getResourceAvatar({
            initials: record.initials,
            color: record.eventColor,
            iconCls: record.iconCls,
            imageUrl: record.image ? `${grid.resourceImagePath}${record.image}` : null
          }), value]
        }),
        flex: 1
      }]
    };
  }

  afterConstruct() {
    this.avatarRendering = new AvatarRendering({
      element: this.element
    });
  }

}

; // Register this widget type with its Factory

ResourceGrid.initClass();
var project = new ProjectModel({
  resourceStore: {
    tree: true
  },
  transport: {
    load: {
      url: 'data/launch-saas.json'
    }
  },
  // This config enables response validation and dumping of found errors to the browser console.
  // It's meant to be used as a development stage helper only so please set it to false for production systems.
  validateResponse: true
});
var container = new Container({
  appendTo: 'container',
  items: [{
    type: 'gantt',
    project,
    flex: 1,
    ref: 'gantt',
    dependencyIdField: 'sequenceNumber',
    resourceImageFolderPath: '../_shared/images/users/',
    features: {
      taskTooltip: false
    },
    subGridConfigs: {
      locked: {
        flex: 1,
        minWidth: 300
      },
      normal: {
        minWidth: 250,
        flex: 2
      }
    },
    columns: [{
      type: 'name',
      minWidth: 200
    }, {
      type: 'resourceassignment',
      width: 200,
      showAvatars: true
    }, {
      type: 'startdate'
    }, {
      type: 'duration'
    }]
  }, {
    type: 'splitter'
  }, {
    // The type is defined in the ./lib/ResourceGrid.js class
    type: 'resourcegrid',
    ref: 'resourceGrid',
    width: 200,
    // Gantt stores are contained by a project, pass resourceStore to the grid to allow it to access resources
    store: project.resourceStore
  }]
});
project.load();
var drag = new Drag({
  grid: container.widgetMap.resourceGrid,
  gantt: container.widgetMap.gantt,
  constrain: false
});