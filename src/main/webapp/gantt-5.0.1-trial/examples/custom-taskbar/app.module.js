import { Gantt, ProjectModel, TaskModel, DateHelper } from '../../build/gantt.module.js?457330';
import shared from '../_shared/shared.module.js?457330';

class MyTask extends TaskModel {
    static get fields() {
        return [
            'hoursWorked'
        ];
    }

    get workedHoursByDay() {
        const
            me                                         = this,
            { startDate, endDate, isParent, duration } = me;

        // With Gantt using early rendering we can get here before dates are normalized, if so bail out to not cache
        // invalid values below
        if (!startDate || !endDate || !duration) {
            return;
        }

        if (!isParent && me._workedHoursByDay?.duration === duration && me._workedHoursByDay.startDateMs === startDate.getTime()) {
            return me._workedHoursByDay;
        }

        const
            durationInDays   = DateHelper.getDurationInUnit(startDate, endDate, 'd', false),
            workedHoursByDay = Array(durationInDays || 0).fill(0),
            calendar         = me.project.calendar,
            hoursWorked      = me.hoursWorked || [];

        let index = 0;

        // Rollup values from parent task's immediate children
        for (let i = 0; i < durationInDays; i++) {
            const
                intervalStart = DateHelper.add(startDate, i, 'd'),
                intervalEnd   = DateHelper.add(intervalStart, 1, 'd');

            if (calendar.isWorkingTime(intervalStart, intervalEnd)) {
                if (isParent) {
                    workedHoursByDay[i] = this.children.reduce((total, child) => {
                        if (DateHelper.intersectSpans(child.startDate, child.endDate, intervalStart, intervalEnd)) {
                            const startDiff = DateHelper.getDurationInUnit(startDate, child.startDate, 'd');
                            return total += child.workedHoursByDay[i - startDiff];
                        }
                        else {
                            return total;
                        }
                    }, 0);
                }
                else {
                    workedHoursByDay[i] = hoursWorked[index];
                }
                index++;
            }
        }

        // Cache by start + duration
        workedHoursByDay.startDateMs = startDate.getTime();
        workedHoursByDay.duration = duration;

        me._workedHoursByDay = workedHoursByDay;

        return workedHoursByDay;
    }
}

const project = new ProjectModel({
    taskModelClass : MyTask,
    autoLoad       : true,
    transport      : {
        load : {
            url : '../_datasets/tasks-workedhours.json'
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
    rowHeight         : 45,
    barMargin         : 0,
    startDate         : new Date(2021, 2, 22),
    endDate           : new Date(2021, 4, 22),

    columns : [
        { type : 'name', width : 250 }
    ],

    viewPreset : {
        base      : 'weekAndDayLetter',
        tickWidth : 40
    },

    // Custom task contents, showing avatars of the assigned resources
    taskRenderer({ taskRecord }) {
        if (!taskRecord.isMilestone) {
            const workedHoursByDay = taskRecord.workedHoursByDay || [];

            // For leaf tasks we return some custom elements, described as DomSync config objects.
            // Please see https://bryntum.com/docs/gantt/api/Core/helper/DomHelper#function-createElement-static for more information.
            return [
                {
                    tag   : 'div',
                    class : 'totalHours',
                    text  : workedHoursByDay.reduce((total, value) => {
                        return total + value;
                    }, 0)
                },
                {
                    tag      : 'div',
                    class    : 'hoursWorked',
                    children : workedHoursByDay.map(workedHours => {
                        return {
                            text : workedHours
                        };
                    })
                }
            ];
        }
    }
});
