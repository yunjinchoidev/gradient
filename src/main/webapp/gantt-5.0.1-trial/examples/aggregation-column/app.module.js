import { Gantt, ProjectModel, TaskModel } from '../../build/gantt.module.js?457330';
import shared from '../_shared/shared.module.js?457330';

class MyTaskModel extends TaskModel {
    static get fields() {
        return [
            { name : 'cost', type : 'number' }
        ];
    }
}
// Must happen now so that field definitions are added to the prototype chain's fieldMap
MyTaskModel.exposeProperties();

const
    project = new ProjectModel({
        taskModelClass : MyTaskModel,
        transport      : {
            load : {
                url : '../_datasets/launch-saas.json'
            }
        },
        // This config enables response validation and dumping of found errors to the browser console.
        // It's meant to be used as a development stage helper only so please set it to false for production systems.
        validateResponse : true
    }),

    gantt = new Gantt({
        appendTo : 'container',
        project  : project,

        dependencyIdField : 'sequenceNumber',

        columns : [
            { type : 'sequence' },
            { type : 'name', field : 'name', width : 250 },
            { type : 'startdate' },
            { type : 'duration' },
            {
                type                 : 'aggregate',
                text                 : 'Cost<br><span style="font-size:0.8em">(aggregated)</span>',
                field                : 'cost',
                width                : 100,
                htmlEncode           : false,
                htmlEncodeHeaderText : false,
                renderer             : ({ record, value }) => record.isLeaf ? `$${value || 0}` : `<b>$${value || 0}</b>`
            }
        ],
        features : {
            taskEdit : {
                editorConfig : {
                    height : '37em'
                },
                items : {
                    generalTab : {
                        items : {
                            costGroup : {
                                html    : '',
                                dataset : {
                                    text : 'Cost'
                                },
                                cls  : 'b-divider',
                                flex : '1 0 100%'
                            },
                            costField : {
                                type  : 'number',
                                name  : 'cost',
                                label : 'Cost',
                                flex  : '.5 0',
                                cls   : 'b-inline'
                            }
                        }
                    }
                }
            }
        },
        listeners : {
            // Disable Cost editing for parent tasks
            beforeTaskEdit : ({ taskRecord }) => {
                gantt.taskEdit.editor.widgetMap.costField.disabled = !taskRecord.isLeaf;
            }
        }
    });

project.load();
