/**
 * Application configuration
 */
export const useGanttConfig = function () {
    return {
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

export const useProjectConfig = function () {
    return {
        calendar: 'general',
        startDate: '2022-01-15',
        hoursPerDay: 24,
        daysPerWeek: 5,
        daysPerMonth: 20
    };
};

export const sliderConfig = {
    text: 'Set Bar Margin',
    min: 0,
    max: 15,
    width: '14em',
    showTooltip: false
};
