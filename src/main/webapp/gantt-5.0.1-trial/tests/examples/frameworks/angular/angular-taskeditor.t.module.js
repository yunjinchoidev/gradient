describe('Test Taskeditor demo', function(t) {
    const
        gantt        = bryntum.query('gantt'),
        taskSelector = '[data-task-id="11"]';

    !gantt.features.taskTooltip.isDestroyed && gantt.features.taskTooltip.destroy();

    t.it('Check task editor tabs', t => {
        t.chain(
            { waitForSelector : taskSelector, desc : 'Task appears' },
            { dblClick : taskSelector },
            { waitForSelector : '.b-gantt-taskeditor', desc : 'Task editor opens' },
            { click : ':textEquals(Common)' },
            { waitForSelector : 'button.b-active:textEquals(Common)', desc : 'Can activate Common tab' },
            { waitForSelector : '.b-textfield label:textEquals(Deadline)', desc : 'Deadline field exists' },
            { waitForSelector : '.b-textfield label:textEquals(Color)', desc : 'Color field exists' },
            { click : ':textEquals(Successors)' },
            { waitForSelector : 'button.b-active:textEquals(Successors)', desc : 'Can activate Successors tab' },
            { click : ':textEquals(Predecessors)' },
            { waitForSelector : 'button.b-active:textEquals(Predecessors)', desc : 'Can activate Predecessors tab' },
            { click : ':textEquals(Resources)' },
            { waitForSelector : 'button.b-active:textEquals(Resources)', desc : 'Can activate Resources tab' },
            { click : ':textEquals(Advanced)' },
            { waitForSelector : 'button.b-active:textEquals(Advanced)', desc : 'Can activate Advanced tab' },
            { click : ':textEquals(Files)' },
            { waitForSelector : 'button.b-active:textEquals(Files)', desc : 'Can activate Files tab' },
            { click : ':textEquals(Common)' },
            { waitForSelectorNotFound : 'i.b-icon-note', desc : 'Notes tab is not present' },
            { click : ':textEquals(Common)' },
            { waitForSelector : 'button.b-active:textEquals(Common)' },
            { type : '[BACKSPACE][BACKSPACE][BACKSPACE][BACKSPACE][BACKSPACE][BACKSPACE]', target : '[name="name"]' },
            { type : 'N', target : '[name="name"]', options : { shiftKey : true } },
            { type : 'gnix', target : '[name="name"]' },
            { click : ':textEquals(Save)' },
            { waitForSelector : '.b-tree-cell-value:textEquals(Install Ngnix)', desc : 'Can edit and save task name' }
        );
    });

});
