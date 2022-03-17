/**
 * Application configuration
 */
import { DateHelper } from '@bryntum/gantt';

export const ganttConfig = {
    viewPreset: 'weekAndDayLetter',
    timeRangesFeature: {
        showCurrentTimeLine : true
    },
    columns: [{ type: 'name', field: 'name', width: 250 }]
};

export const projectConfig = {
    calendar: 'general',
    startDate: DateHelper.add(DateHelper.clearTime(new Date()), -7, 'day'),
    hoursPerDay: 24,
    daysPerWeek: 5,
    daysPerMonth: 20
};
