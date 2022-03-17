new Container({
    appendTo : targetElement,

    items : [
        // radio with default look
        {
            type         : 'radio',
            name         : 'radios',
            text         : 'Default',
            checkedValue : 'A'
        },

        // blue radio
        {
            type         : 'radio',
            color        : 'b-blue',
            name         : 'radios',
            text         : 'Blue',
            checkedValue : 'B'
        },

        // orange radio, checked
        {
            type         : 'radio',
            color        : 'b-orange',
            name         : 'radios',
            checked      : true,
            text         : 'Orange (checked)',
            checkedValue : 'C'
        },

        // orange radio, checked
        {
            type         : 'radio',
            disabled     : true,
            name         : 'radios',
            text         : 'Disabled',
            checkedValue : 'D'
        }
    ]
})
