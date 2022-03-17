import { Gantt } from '../../build/gantt.module.js?457330';
import shared from '../_shared/shared.module.js?457330';
/* eslint-disable no-unused-vars */

const gantt = new Gantt({
    appendTo : 'container',

    project : {
        autoLoad  : true,
        transport : {
            load : {
                url : '../_datasets/launch-saas.json'
            }
        }
    },

    dependencyIdField : 'sequenceNumber',

    columns : [
        { type : 'name', width : 250 }
    ],

    tbar : [
        {
            type     : 'checkbox',
            text     : 'Enable parent area highlighting',
            checked  : true,
            onAction : ({ checked }) => gantt.features.parentArea.disabled = !checked
        }
    ],

    features : {
        parentArea : true
    }
});
