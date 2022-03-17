const gantt = new Gantt({
    appendTo   : targetElement,
    autoHeight : true,
    rowHeight  : 40,
    barMargin  : 4,
    flex       : 1,

    tasks : [
        {
            id        : 1,
            name      : 'Math course',
            expanded  : true,
            startDate : '2019-01-07',
            endDate   : '2019-01-12',
            children  : [
                {
                    id        : 2,
                    name      : 'Module 1',
                    startDate : '2019-01-07',
                    duration  : 2
                },
                {
                    id        : 3,
                    name      : 'Module 2',
                    startDate : '2019-01-09',
                    duration  : 2
                },
                {
                    id        : 4,
                    name      : 'Exams',
                    startDate : '2019-01-11',
                    duration  : 0
                }
            ]
        }
    ],

    dependencies : [
        {
            id        : 1,
            fromEvent : 2,
            toEvent   : 3
        },
        {
            id        : 2,
            fromEvent : 3,
            toEvent   : 4,
            lag       : 1
        }
    ],

    startDate : new Date(2019, 0, 6),
    endDate   : new Date(2019, 0, 10),

    features : {
        taskMenu : {
            disabled : true
        }
    },

    tbar : [
        {
            text        : 'Disable Task menu',
            toggleable  : true,
            pressed     : true,
            icon        : 'b-fa b-fa-square',
            pressedIcon : 'b-fa b-fa-check-square',
            color       : 'b-blue b-raised',
            onToggle({ pressed }) {
                gantt.features.taskMenu.disabled = pressed;
            }
        }
    ]
});
