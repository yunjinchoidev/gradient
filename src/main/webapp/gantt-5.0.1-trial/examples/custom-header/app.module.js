import { DateHelper, Gantt, ProjectModel } from '../../build/gantt.module.js?457330';
import shared from '../_shared/shared.module.js?457330';

const project = new ProjectModel({
    transport : {
        load : {
            url : '../_datasets/launch-saas.json'
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
    resourceImagePath : '../_shared/images/users/',
    columns           : [
        {
            type : 'name'
        }
    ],

    viewPreset : {
        columnLinesFor : 2,
        timeResolution : {
            unit      : 'day',
            increment : 1
        },

        headers : [
            {
                unit       : 'month',
                dateFormat : 'MMM YYYY',
                align      : 'start'
            },
            {
                unit     : 'week',
                renderer : (startDate, endDate) => `Week ${DateHelper.format(startDate, 'WW')}`
            },
            {
                unit       : 'day',
                dateFormat : 'dd'
            },
            {
                unit       : 'day',
                dateFormat : 'DD'
            },
            {
                unit     : 'day',
                renderer : (startDate, endDate, headerConfig, index) => index % 4 === 0 ? Math.round(Math.random() * 5) : ''
            }
        ]
    }
});

project.load();
