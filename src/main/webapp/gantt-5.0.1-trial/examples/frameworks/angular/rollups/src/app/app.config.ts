/**
 * Application config file
 */

// Bryntum umd lite bundle comes without polyfills to support Angular's zone.js
import { ProjectModel } from '@bryntum/gantt/gantt.lite.umd.js';

const project  = new ProjectModel({
    autoLoad  : true,
    transport : {
        load : {
            url : 'assets/data/tasks.json'
        }
    },
    // This config enables response validation and dumping of found errors to the browser console.
    // It's meant to be used as a development stage helper only so please set it to false for production systems.
    validateResponse : true
});

const ganttConfig = {
    project,

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

    viewPreset : 'monthAndYear',

    // Allow extra space for rollups
    rowHeight : 50,
    barMargin : 7,

    columnLines : true,

    features : {
        rollups : true
    }

};

export default ganttConfig;
