/**
 * Application config file
 */

import { ProjectModel } from '@bryntum/gantt/gantt.lite.umd.js';

const project = new ProjectModel({
    transport : {
        load : {
            url : 'assets/data/timeranges.json'
        }
    },

    autoLoad : true,

    // This config enables response validation and dumping of found errors to the browser console.
    // It's meant to be used as a development stage helper only so please set it to false for production systems.
    validateResponse : true
});

export const ganttConfig = {
    project : project,
    columns : [
        { type : 'name', field : 'name', width : 250 }
    ],
    features : {
        timeRanges : {
            enableResizing      : true,
            showCurrentTimeLine : false,
            showHeaderElements  : true
        }
    }
};

export const gridConfig = {
    columns : [
        {
            text  : 'Time ranges',
            flex  : 1,
            field : 'name'
        },
        {
            type  : 'date',
            text  : 'Start Date',
            width : 110,
            align : 'right',
            field : 'startDate'
        },
        {
            type          : 'number',
            text          : 'Duration',
            width         : 100,
            field         : 'duration',
            min           : 0,
            instantUpdate : true,
            renderer      : (data): string => `${data.record.duration} d`
        }],
    features : {
        stripe : true,
        sort   : 'startDate'
    }
};
