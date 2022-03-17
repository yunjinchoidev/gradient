/**
 * Application configuration
 */
const ganttConfig = {
    project: {
        autoLoad  : true,
        transport : {
            load: {
                url : 'data/launch-saas.json'
            }
        },
        // This config enables response validation and dumping of found errors to the browser console.
        // It's meant to be used as a development stage helper only so please set it to false for production systems.
        validateResponse : true
    },

    dependencyIdField : 'sequenceNumber',

    columns: [
        {
            type  : 'name',
            width : 250
        },
        {
            htmlEncodeHeaderText : false,

            text   : 'Button<br /><small>Vue Component</small>',
            width  : '9em',
            align  : 'center',
            field  : 'name',
            editor : false,
            vue    : true,
            renderer({ record }) {
                // The object needed by the wrapper to render the component
                return {
                    // Required. Name of the component to render.
                    // The component must be registered globally in main.js
                    // https://vuejs.org/v2/guide/components.html#Dynamic-Components
                    is : 'Button',

                    // `Button` gets its text from `record`
                    record

                    // Any other properties we provide for the Vue component, e.g. `value`.
                };
            }
        }
    ],

    // Custom task content, display task name on child tasks
    taskRenderer({ taskRecord }) {
        if (taskRecord.isLeaf && !taskRecord.isMilestone) {
            return taskRecord.name;
        }
    }
};

export { ganttConfig };
