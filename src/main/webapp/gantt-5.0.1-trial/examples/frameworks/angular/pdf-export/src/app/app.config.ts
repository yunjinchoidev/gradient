/**
 * Application config file
 */

// Bryntum umd lite bundle comes without polyfills to support Angular's zone.js
import { ProjectModel } from '@bryntum/gantt/gantt.lite.umd.js';

const project = new ProjectModel({
    transport : {
        load : {
            url : 'assets/data/launch-saas.json'
        }
    },

    autoLoad : true,

    // This config enables response validation and dumping of found errors to the browser console.
    // It's meant to be used as a development stage helper only so please set it to false for production systems.
    validateResponse : true
});

const ganttConfig = {
    columns : [
        { type : 'name', field : 'name', text : 'Name', width : 250 }
    ],
    features : {
        pdfExport : {
            exportServer : 'http://localhost:8080',

            // Development config
            translateURLsToAbsolute : 'http://localhost:4200',

            // For production replace with this one. See README.md for explanation
            // translateURLsToAbsolute : 'http://localhost:8080/resources/', // Trailing slash is important
            keepPathName : false
        }
    },
    project
};

export default ganttConfig;
