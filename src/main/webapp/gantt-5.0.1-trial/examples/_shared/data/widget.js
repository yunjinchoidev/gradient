// eslint-disable-next-line no-unused-vars
window.introWidget = {
    type       : 'gantt',
    startDate  : new Date(2021, 1, 1),
    endDate    : new Date(2021, 1, 14),
    viewPreset : 'weekAndDayLetter',
    minHeight  : 250,

    columns : [{
        type  : 'name',
        text  : 'Name',
        width : 210
    }],

    tasks : [{
        name        : 'Awesome Project',
        expanded    : true,
        startDate   : new Date(2021, 1, 2),
        percentDone : 50,
        children    : [
            {
                id          : 1,
                name        : 'Develop Cool Product',
                percentDone : 90,
                duration    : 5
            },
            {
                id          : 2,
                name        : 'Launch Product',
                percentDone : 50,
                duration    : 5
            },
            {
                id       : 3,
                name     : 'Presentation',
                duration : 0
            }]
    }],

    dependencies : [
        {
            id        : 1,
            fromEvent : 1,
            toEvent   : 2
        },
        {
            id        : 2,
            fromEvent : 2,
            toEvent   : 3
        }
    ]
};
