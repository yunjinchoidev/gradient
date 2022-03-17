let project;

if (typeof process !== 'undefined' && typeof require !== 'undefined') {
    Siesta = require('../../../siesta');
    project = new Siesta.Project.NodeJS();
}
else {
    throw new Error('Only runnable in NodeJS');
}

project.configure({
    title        : 'Scheduling Engine Test Suite',
    isEcmaModule : true
});

project.plan(
    {
        group : 'Data',
        items : [
            'nodejs/project.t.js',
            'data/AssignmentStore.t.js'
        ]
    }
);

project.start();
