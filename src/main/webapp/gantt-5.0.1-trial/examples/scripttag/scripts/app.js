const { Gantt, ProjectModel, TrialButton } = bryntum.gantt;

const project = new ProjectModel({
    transport : {
        load : {
            url : '../_datasets/launch-saas.json'
        }
    }
});

new Gantt({
    appendTo : 'container',

    project,

    dependencyIdField : 'sequenceNumber',

    columns : [
        { type : 'name', field : 'name', text : 'Name', width : 250 }
    ],

    height : 385
});


new TrialButton({
    appendTo  : 'download-trial',
    cls       : 'b-green b-raised',
    productId : 'gantt'
});


project.load();
