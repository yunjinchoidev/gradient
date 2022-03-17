/**
 * Application config file
 */

// Bryntum umd lite bundle comes without polyfills to support Angular's zone.js
import { DateHelper, ProjectModelConfig } from '@bryntum/gantt/gantt.lite.umd.js';

export const projectConfig: Partial<ProjectModelConfig> = {
    calendar     : 'general',
    startDate    : DateHelper.add(DateHelper.clearTime(new Date()), -7, 'day'),
    hoursPerDay  : 24,
    daysPerWeek  : 5,
    daysPerMonth : 20

};
export const ganttConfig = {
    project : {
        // no data
    },

    columns : [
        { type : 'wbs' },
        { type : 'name' }
    ],

    subGridConfigs : {
        locked : {
            flex : 1
        },
        normal : {
            flex : 2
        }
    },

    timeRangesFeature : {
        showCurrentTimeLine : true
    },

    viewPreset : 'weekAndDayLetter',

    columnLines : true

};
