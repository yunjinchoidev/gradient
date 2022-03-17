import { Gantt, ProjectModel, DateHelper } from '../../build/gantt.module.js?457330';
import shared from '../_shared/shared.module.js?457330';



const project = new ProjectModel({
    autoLoad  : true,
    transport : {
        load : {
            url : '../_datasets/launch-saas.json'
        }
    },
    // This config enables response validation and dumping of found errors to the browser console.
    // It's meant to be used as a development stage helper only so please set it to false for production systems.
    validateResponse : true
});

const headerTpl = ({ currentPage, totalPages }) => `
    <div class="demo-export-header">
        <img src="resources/logo.png"/>
        <dl>
            <dt>Date: ${DateHelper.format(new Date(), 'll LT')}</dt>
            <dd>${totalPages ? `Page: ${currentPage + 1}/${totalPages}` : ''}</dd>
        </dl>
    </div>`;

const footerTpl = () => '<div class="demo-export-footer"><h3>© 2020 Bryntum AB</h3></div>';

const gantt = new Gantt({
    // We don't need to export demo header
    appendTo : 'container',

    emptyText : '',

    project,

    dependencyIdField : 'sequenceNumber',

    columns : [
        { type : 'name', field : 'name', text : 'Name', width : 200 },
        { type : 'startdate', text : 'Start date' },
        { type : 'duration', text : 'Duration' }
    ],

    columnLines : false,

    features : {
        pdfExport : {
            exportServer            : 'http://localhost:8080/',
            translateURLsToAbsolute : 'http://localhost:8080/resources/',
            headerTpl,
            footerTpl
        }
    },

    tbar : [
        {
            type : 'button',
            ref  : 'exportButton',
            icon : 'b-fa-file-export',
            text : 'Export to PDF',
            onClick() {
                gantt.features.pdfExport.showExportDialog();
            }
        }
    ]
});
