import { StringHelper, Gantt, ProjectModel } from '../../build/gantt.module.js?457330';
import shared from '../_shared/shared.module.js?457330';

const project = new ProjectModel({
    transport : {
        load : {
            url : '../_datasets/launch-saas.json'
        }
    },
    // This config enables response validation and dumping of found errors to the browser console.
    // It's meant to be used as a development stage helper only so please set it to false for production systems.
    validateResponse : true
});

new Gantt({
    project,
    appendTo          : 'container',
    dependencyIdField : 'sequenceNumber',
    rowHeight         : 80,
    resourceImagePath : '../_shared/images/users/',
    columns           : [
        {
            type     : 'name',
            text     : 'Customized Name Column',
            width    : 450,
            renderer : ({ record }) => ({
                // Return a DomConfig object describing our custom markup with task name + 3 icons
                // Please see https://bryntum.com/docs/grid/api/Core/helper/DomHelper#typedef-DomConfig for more information.
                children : [
                    {
                        tag  : 'span',
                        html : StringHelper.encodeHtml(record.name)
                    },
                    {
                        class    : 'b-actions',
                        children : [
                            {
                                tag     : 'i',
                                class   : 'edit b-fa b-fa-fw b-fa-pen',
                                dataset : { btip : 'Edit' }
                            },
                            {
                                tag     : 'i',
                                class   : 'add b-fa b-fa-fw b-fa-plus',
                                dataset : { btip : 'Add task' }
                            },
                            {
                                tag     : 'i',
                                class   : 'menu b-fa b-fa-fw b-fa-ellipsis-h',
                                dataset : { btip : 'Task menu' }
                            },
                            {
                                tag     : 'progress',
                                max     : 100,
                                value   : record.percentDone,
                                dataset : { btip : `${record.renderedPercentDone}% completed` }
                            }
                        ]
                    }
                ]
            })
        }
    ],

    onCellClick({ target, record, event }) {
        switch (target.classList[0]) {
            case 'edit':
                this.editTask(record);
                break;

            case 'menu':
                this.features.taskMenu.showContextMenu(event, { anchor : true, target, align : 'l-r' });
                break;

            case 'add':
                if (record.isLeaf) {
                    this.addTaskBelow(record);
                }
                else {
                    this.addSubtask(record);
                }
                break;
        }
    },

    viewPreset : {
        base      : 'weekAndDayLetter',
        tickWidth : 50
    },

    // Custom task contents, showing avatars of the assigned resources
    taskRenderer({ taskRecord, renderData }) {
        if (taskRecord.isLeaf && !taskRecord.isMilestone) {
            // For leaf tasks we return some custom elements, described as DomConfig objects.
            // Please see https://bryntum.com/docs/grid/api/Core/helper/DomHelper#typedef-DomConfig for more information.
            return [
                {
                    tag   : 'div',
                    class : 'taskName',
                    html  : StringHelper.encodeHtml(taskRecord.name)
                },
                ...taskRecord.resources.map(resource => ({
                    tag     : 'img',
                    src     : resource.image !== false ? this.resourceImagePath + resource.name.toLowerCase() + '.jpg' : null,
                    dataset : {
                        resourceId : resource.id
                    }
                })
                )
            ];
        }
    }
});

project.load();
