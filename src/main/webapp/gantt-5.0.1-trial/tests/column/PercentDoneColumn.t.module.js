
StartTest(t => {

    let gantt;

    t.beforeEach(t => gantt?.destroy?.());

    t.it('Should not be possible to edit parent', t => {
        gantt = t.getGantt({
            columns : [
                { type : 'name' },
                // IMPORTANT TODO: Remove width from this to check the scrollbar appearing/disappearing
                // feedback loop. Since we always *round* the
                // calculated tick width results in an infinite feedback loop.
                // It calculates tick width 20, which narrows the timeAxis, which shows no
                // scrollbars which results in a resize, and then the mistake is made, it calculates
                // the tickSize as 21 which causes a horizontal scrollbar which causes a vertical
                // scrollbar, so the width shrinks, and a resize fires and the tick with drops back to 20
                // and round we go forever.
                { type : 'percentdone', width : 80 }
            ]
        });

        t.chain(
            { waitForEvent : [gantt.project, 'load'] },
            { waitForRowsVisible : gantt },

            next => {
                t.selectorExists('[data-index=2] [data-column=percentDone]:textEquals(70%)', 'Cell rendered correctly');
                next();
            },

            { dblClick : '[data-index=2] [data-column=percentDone]' },

            { type : '60[ENTER]', clearExisting : true },

            next => {
                const bar = document.querySelector('.id11 .b-task-percent-bar');
                t.is(bar.style.width, '60%', 'Percent bar updated');
                next();
            },

            // Cannot edit parent
            { dblClick : '.b-tree-parent-row [data-column=percentDone]' },

            () => {
                t.selectorNotExists('.b-editor', 'Editor not shown for parent task');
            }
        );
    });

    // https://github.com/bryntum/support/issues/3184
    t.it('Should add css classes to empty/full progress circle', async t => {
        gantt = await t.getGanttAsync({
            columns : [
                { type : 'name' },
                { type : 'percentdone', showCircle : true }
            ]
        });

        t.selectorCountIs('.b-percentdone-circle.b-empty', 4, 'Empty cls applied correctly');
        t.selectorNotExists('.b-percentdone-circle.b-full', 'Full cls not applied initially');

        gantt.taskStore.getById(11).percentDone = 100;

        await t.waitForSelector('.b-percentdone-circle.b-full');

        t.pass('Full cls applied');
    });

    // https://github.com/bryntum/support/issues/3284
    t.it('Should be possible to use any model field', async t => {
        gantt = await t.getGanttAsync({
            tasks : [
                { foo : 30 }
            ],
            columns : [
                { type : 'name' },
                { type : 'percentdone', field : 'foo' }
            ]
        });

        t.selectorExists('.b-number-cell:contains(30)', 'Configured field was used');
    });

    t.it('Should show 0 if no value is present', async t => {
        gantt = await t.getGanttAsync({
            tasks : [
                { }
            ],
            columns : [
                { type : 'name' },
                { type : 'percentdone', field : 'foo' }
            ]
        });

        t.selectorExists('.b-number-cell:contains(0%)');
    });
});
