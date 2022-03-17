import { DateHelper, StringHelper, Gantt, ProjectModel } from '../../build/gantt.module.js?457330';
import shared from '../_shared/shared.module.js?457330';

const project = new ProjectModel({
    transport : {
        load : {
            url : '../_datasets/launch-saas.json'
        }
    },
    // This config enables response validation and dumping of found errors to the browser console.
    // It's meant to be used as a development stage helper only so please set it to false for production systems.
    validateResponse : true,

    taskStore : {
        fields : ['priority', 'cost']
    }
});

const
    durationGrouper = task => `${task.duration} ${DateHelper.getLocalizedNameOfUnit(task.durationUnit, task.duration !== 1)}`,
    priorityGrouper = task => `${StringHelper.capitalize(task.priority)} priority`,
    costGrouper     = task => `$${task.cost}`;

const gantt = new Gantt({
    appendTo : 'container',

    features : {
        treeGroup : {
            levels : [priorityGrouper]
        }
    },

    project,

    columns : [
        { type : 'name', width : 250 }
    ],

    tbar : [
        {
            type : 'label',
            text : 'Group by'
        },
        {
            type        : 'buttongroup',
            ref         : 'buttons',
            toggleGroup : true,
            items       : [
                {
                    text    : 'Priority',
                    pressed : true,
                    async onToggle({ pressed }) {
                        if (pressed) {
                            buttons.disable();
                            await gantt.group([priorityGrouper]);
                            buttons.enable();
                        }
                    }
                },
                {
                    text : 'Duration',
                    async onToggle({ pressed }) {
                        if (pressed) {
                            buttons.disable();
                            // 0 days, 1 day, 2 days etc
                            await gantt.group([durationGrouper]);
                            buttons.enable();
                        }

                    }
                },
                {
                    text : 'Cost',
                    async onToggle({ pressed }) {
                        if (pressed) {
                            buttons.disable();
                            // 0 days, 1 day, 2 days etc
                            await gantt.group([costGrouper]);
                            buttons.enable();
                        }

                    }
                },
                {
                    text : 'Duration + Priority',
                    async onToggle({ pressed }) {
                        if (pressed) {
                            buttons.disable();
                            await gantt.group([durationGrouper, priorityGrouper]);
                            buttons.enable();
                        }
                    }
                },
                {
                    text : 'none',
                    async onToggle({ pressed }) {
                        if (pressed) {
                            buttons.disable();
                            await gantt.clearGroups();
                            buttons.enable();
                        }
                    }
                }
            ]
        }
    ]
});

const { buttons } = gantt.widgetMap;

project.load();
