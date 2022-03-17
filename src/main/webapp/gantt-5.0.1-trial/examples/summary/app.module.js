import { Gantt, ProjectModel, StringHelper, DateHelper } from '../../build/gantt.module.js?457330';
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

const gantt = new Gantt({
    appendTo : 'container',

    project,
    tickSize          : 60,
    dependencyIdField : 'sequenceNumber',

    columns : [
        { type : 'name', width : 250, sum : 'count', summaryRenderer : ({ sum }) => 'Summary' }
    ],

    features : {
        summary : {
            renderer : ({ taskStore, startDate, endDate }) => {
                // Find all intersecting task and render the count in each cell
                const intersectingTasks = taskStore.query(task => DateHelper.intersectSpans(task.startDate, task.endDate, startDate, endDate));

                return intersectingTasks.length;
            }
        }
    }
});

project.load();
