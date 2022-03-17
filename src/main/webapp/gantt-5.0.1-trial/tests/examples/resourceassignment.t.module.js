StartTest(t => {
    const gantt = bryntum.query('gantt');

    t.it('Sanity tests', t => {
        t.chain(
            { dblClick : '.b-grid-row[data-index="4"] .b-resourceassignment-cell' },

            next => {
                t.click(gantt.features.cellEdit.editorContext.editor.inputField.triggers.expand.element);
                next();
            },

            { waitForSelector : '.b-assignmentfield .b-chip:contains(Macy)' },
            { waitForSelector : '.b-assignmentfield .b-chip:contains(Dan)' },
            { waitForSelector : '.b-assignmentfield .b-chip:contains(Dave)' },
            { waitForSelector : '.b-assignmentfield .b-chip:contains(Lee)' },
            { waitForSelector : '.b-assignmentfield .b-chip:contains(Macy)' },

            // Extra column must exist
            {
                waitForSelector : '.b-grid-header:contains(Calendar)'
            },

            // Grouping must be present
            {
                waitForSelector : '.b-group-title:contains(Barcelona)'
            },

            { click : '.b-button:contains(Cancel)' },
            { type : '[ESCAPE]', waitForTarget : false }
        );
    });

    t.it('Should handle selected rows in collapsed groups', async t => {
        t.chain(
            // First block just selects one resource, then collapses the group it's in before saving
            { dblclick : '[data-id="15"] .b-resourceassignment-cell' },
            { click : '.b-icon-down' },
            { click : '.b-grid-row:not(.b-group-row) .b-check-cell' },
            { click : '.b-grid-cell:contains(Barcelona)' },
            { click : 'button:textEquals(Save)' },
            { click : '.b-sch-timeaxis-cell', offset : [30, 36] },

            async() => t.selectorExists('.b-resource-avatar[src*=celia]'),

            // Now we verify picker
            { dblclick : '[data-id="15"] .b-resourceassignment-cell' },
            async() => t.selectorExists('.b-chip:textEquals(Celia 100%)', 'Picker field chip view is ok'),

            { click : '.b-icon-down' },
            { click : '.b-grid-cell:contains(Barcelona)' },
            async() => t.selectorExists('.b-grid-row:not(.b-group-row) .b-check-cell input:checked', 'Celia checked'),
            async() => t.selectorExists('.b-grid-row:not(.b-group-row) [data-column=resourceName]:contains(Celia)', 'Celia text present'),
            { click : '.b-grid-row:not(.b-group-row) .b-checkbox' },
            async() => t.selectorExists('.b-grid-row:not(.b-group-row) [data-column=resourceName]:contains(Celia)', 'Celia text present'),
            { click : 'button:textEquals(Cancel)' }
        );
    });

    t.it('Checking XSS', async t => {
        t.injectXSS(gantt);

        const el = document.querySelector('.b-resource-avatar[data-btip~="XSS"]');

        if (el) {
            await t.doubleClick(el);

            await t.moveMouseBy([0, 50]);
            await t.moveMouseBy([0, -50]);

            await t.waitForSelector('.b-tooltip-content');

            await t.click('.b-icon-down');
        }
        t.pass('XSS test passed');
    });

    // https://github.com/bryntum/support/issues/3959
    t.it('Should not throw construct invoked during object destruction', async t => {
        await t.doubleClick('[data-id="15"] .b-resourceassignment-cell');
        await t.click('.b-icon-down');
        gantt.columns.first.text = 'Foo';
        t.pass('Test passed');
    });

});
