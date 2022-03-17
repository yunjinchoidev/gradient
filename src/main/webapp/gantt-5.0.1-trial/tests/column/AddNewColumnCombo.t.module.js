
StartTest(t => {

    let gantt,
        addNewColumn;

    t.beforeEach(() => {
        gantt?.destroy();
    });

    t.it('Check all extra available columns', (t) => {
        // highlight smaller test body
        document.body.style.border = '1px solid black';

        // get rid of scrollbars
        document.body.style.width = '400px';
        document.body.style.height = '400px';

        const frameHeight = 402;

        gantt = t.getGantt({
            appendTo       : document.body,
            id             : 'gantt',
            height         : frameHeight / 2,
            subGridConfigs : {
                locked : {
                    width : 200
                }
            },
            columns : [
                { type : 'name' },
                { text : 'foo' },
                { text : 'bar' },
                { text : 'baz' },
                { type : 'addnew', width : 80 }
            ]
        });

        addNewColumn = gantt.columns.getAt(4);

        gantt.element.style.marginTop = '50%';

        t.chain(
            { setWindowSize : [frameHeight * 2, frameHeight] },

            { waitForRowsVisible : gantt },

            { click : addNewColumn.combo.input },

            { waitForSelector : '.b-list' },

            async() => {
                const
                    comboElBox  = addNewColumn.combo.element.getBoundingClientRect(),
                    headerBox   = addNewColumn.element.getBoundingClientRect(),
                    pickerElBox = addNewColumn.combo.picker.element.getBoundingClientRect();

                t.isApprox(pickerElBox.top, comboElBox.bottom, 1, 'Picker is below combo');
                t.isApprox(pickerElBox.left, headerBox.left, 1, 'Picker is aligned to header');
                t.isApprox(pickerElBox.height, frameHeight - comboElBox.bottom, 5, 'Picker height is reduced to fit between combo and page bottom');
            },

            { type : 'eff' },

            async() => {
                const
                    comboElBox  = addNewColumn.combo.element.getBoundingClientRect(),
                    headerBox   = addNewColumn.element.getBoundingClientRect(),
                    pickerElBox = addNewColumn.combo.picker.element.getBoundingClientRect();

                t.isApprox(pickerElBox.top, comboElBox.bottom, 1, 'Picker is below combo');
                t.isApprox(pickerElBox.left, headerBox.left, 1, 'Picker is aligned to header');
                t.isApprox(pickerElBox.height, frameHeight - comboElBox.bottom, 5, 'Picker height is reduced to fit between combo and page bottom');
            }
        );
    });
});
