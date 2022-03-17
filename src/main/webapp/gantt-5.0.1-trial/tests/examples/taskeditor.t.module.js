StartTest(t => {
    const gantt = bryntum.query('gantt');

    let task;

    t.chain(
        { waitForRowsVisible : gantt },

        { dblclick : '.b-gantt-task-wrap[data-task-id="15"]' },

        {
            waitFor : () => {
                if (gantt.features.taskEdit.editor?.containsFocus) {
                    task = gantt.features.taskEdit.editor.loadedRecord;
                    return true;
                }
            }
        },

        { waitForSelector : '.b-taskeditor', desc : 'Task editor appeared' },
        { waitForSelector : '.b-tabpanel-tab:textEquals(Common)', desc : 'Renamed General -> Common tab appeared' },
        { waitForSelectorNotFound : '.b-tabpanel-tab:textEquals(Notes)', desc : 'Notes tab is removed' },

        async() => {
            t.ok(gantt.taskEdit.editor.widgetMap.deadlineField, 'Custom Deadline field appeared');
        },

        { waitForSelector : '.b-tabpanel-tab :textEquals(Files)', desc : 'Files tab appeared' },

        { click : '.b-colorfield .b-icon-picker' },

        { click : '.b-color-picker-item[data-id=red]' },

        { click : '.b-button:contains(Save)' },

        {
            waitFor : () => {
                const element = gantt.getElementFromTaskRecord(task);
                return window.getComputedStyle(element).backgroundColor === 'rgb(255, 0, 0)';
            }
        },

        () => {
            t.pass('Color changed');
        }
    );
});
