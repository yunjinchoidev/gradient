/**
 * Application configuration
 */
import { TaskModel } from '@bryntum/gantt';

import './components/ColorField'; // custom color field
import './components/FilesTab'; // custom files tab

class MyModel extends TaskModel {
    static get fields() {
        return [{ name: 'deadline', type: 'date' }, { name: 'color' }];
    }
}

const ganttConfig = {
    project: {
        autoLoad: true,
        taskModelClass: MyModel,
        transport: {
            load: {
                url: 'data/launch-saas.json'
            }
        },
        // This config enables response validation and dumping of found errors to the browser console.
        // It's meant to be used as a development stage helper only so please set it to false for production systems.
        validateResponse : true
    },
    columns: [
        { type: 'name', field: 'name', text: 'Name', width: 250 },
        { type: 'date', field: 'deadline', text: 'Deadline' }
    ],
    taskRenderer: ({ taskRecord, renderData }) => {
        if (taskRecord.color) {
            renderData.style += `background-color:${taskRecord.color}`;
        }
    },

    taskEditFeature: {
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
                    }
                }
            },
            // remove Notes tab
            notesTab: false,
            // add custom Files tab to the second position
            filesTab: {
                type: 'filestab',
                weight: 110
            }
        }
    }
};

export { ganttConfig };
