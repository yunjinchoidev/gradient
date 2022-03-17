/**
 * Application configuration
 */
const useGanttConfig = function () {
    return {
        project: {
            autoLoad: true,
            transport: {
                load: {
                    url: './data/launch-saas.json'
                }
            },
            // This config enables response validation and dumping of found errors to the browser console.
            // It's meant to be used as a development stage helper only so please set it to false for production systems.
            validateResponse : true
        },

        dependencyIdField: 'sequenceNumber',

        columns: [{ type: 'name', width: 250 }],

        // Custom task content, display task name on child tasks
        taskRenderer({ taskRecord }) {
            if (taskRecord.isLeaf && !taskRecord.isMilestone) {
                return taskRecord.name;
            }
        }
    };
};

const sliderConfig = {
    text: 'Set Bar Margin',
    min: 0,
    max: 15,
    width: '14em',
    showTooltip: false
};

export { useGanttConfig, sliderConfig };
