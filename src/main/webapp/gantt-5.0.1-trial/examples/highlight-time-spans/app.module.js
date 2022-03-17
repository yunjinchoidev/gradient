import { TaskModel, DateHelper, Gantt } from '../../build/gantt.module.js?457330';
import shared from '../_shared/shared.module.js?457330';

class Task extends TaskModel {
    get minStartDate() {
        return this.project.startDate;
    }

    get maxEndDate() {
        return this.project.endDate;
    }
}

const gantt = new Gantt({
    appendTo : 'container',

    startDate  : new Date(2019, 0, 1),
    endDate    : new Date(2019, 4, 1),
    viewPreset : 'weekAndMonth',
    project    : {
        autoLoad       : true,
        // Let the Project know we want to use our own Task model with custom fields / methods
        taskModelClass : Task,
        transport      : {
            load : {
                url : '../_datasets/constraints.json'
            }
        },

        // This config enables response validation and dumping of found errors to the browser console.
        // It's meant to be used as a development stage helper only so please set it to false for production systems.
        validateResponse : true
    },

    dependencyIdField : 'sequenceNumber',

    columns : [
        { type : 'name', width : 250 }
    ],

    features : {
        timeSpanHighlight : true
    },

    tbar : [
        {
            type       : 'button',
            ref        : 'highlightButton',
            cls        : 'b-blue',
            text       : 'Highlight timespans',
            toggleable : true,
            onToggle   : 'up.onHighlightButtonToggle'
        },
        {
            type : 'checkbox',
            ref  : 'surroundCheckbox',
            text : 'Surround task boundaries when dragging'
        }
    ],

    highlightTaskBoundaries(taskRecord) {
        const
            { minStartDate, maxEndDate } = taskRecord,
            surround = this.widgetMap.surroundCheckbox.checked;

        this.highlightTimeSpan({
            taskRecord,
            // Highlight surrounding area
            surround,
            padding   : 10,
            name      : surround ? 'Outside project' : 'Project boundaries',
            cls       : 'b-task-boundary',
            // The time span to visualize
            startDate : minStartDate,
            endDate   : maxEndDate
        });
    },

    // This method lets you constrain UI interactions like task drag drop and resizing
    getDateConstraints(taskRecord) {
        const { minStartDate, maxEndDate } = taskRecord;

        return {
            start : minStartDate,
            end   : maxEndDate
        };
    },

    onHighlightButtonToggle({ source : button }) {
        if (button.pressed) {
            this.highlightTimeSpans([
                {
                    name      : 'Beta',
                    startDate : new Date(2019, 1, 17),
                    endDate   : new Date(2019, 2, 3)
                },
                {
                    name      : 'Go live',
                    startDate : new Date(2019, 2, 17),
                    endDate   : new Date(2019, 2, 31)
                }
            ]);
        }
        else {
            this.unhighlightTimeSpans();
        }
    },

    listeners : {
        taskDragStart({ taskRecords }) {
            this.widgetMap.highlightButton.pressed = false;
            this.highlightTaskBoundaries(taskRecords[0]);
        },
        taskDragReset() {
            this.unhighlightTimeSpans();
        }
    }
});
