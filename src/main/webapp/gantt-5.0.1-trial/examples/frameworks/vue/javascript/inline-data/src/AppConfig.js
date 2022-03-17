/**
 * Application configuration
 */
import { DateHelper } from '@bryntum/gantt';

export const projectConfig = {
    calendar: 'general',
    startDate: DateHelper.add(DateHelper.clearTime(new Date()), -7, 'day'),
    hoursPerDay: 24,
    daysPerWeek: 5,
    daysPerMonth: 20
};

export const ganttConfig = {
    timeRangesFeature: {
        showHeaderElements: true,
        showCurrentTimeLine: true
    },
    viewPreset: 'weekAndDayLetter'
};
