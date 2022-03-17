
StartTest(t => {

    let gantt;

    t.beforeEach(t => {
        gantt && gantt.destroy();
    });

    // https://github.com/bryntum/support/issues/3371
    t.it('Should align label editor correctly', async t => {
        gantt = await t.getGantt({
            features : {
                labels : {
                    right : {
                        field  : 'name',
                        editor : {
                            type : 'textfield'
                        }
                    },
                    left : {
                        field  : 'name',
                        editor : {
                            type : 'textfield'
                        }
                    }
                }
            }
        });

        await t.doubleClick('.b-sch-label-right:contains(Planning)');

        let
            labelRect  = t.rect('.b-sch-label-right:contains(Planning)'),
            editorRect = t.rect('.b-editor');

        t.isApprox(editorRect.left, labelRect.left, 'left ok');
        t.isApprox(editorRect.top, labelRect.top - 10, 'Top ok');
        await t.type(null, '[ESCAPE]');

        await t.waitForSelectorNotFound('.b-editor:visible');

        await t.doubleClick('.b-sch-label-left:contains(Step 1)');

        // Check left label
        labelRect  = t.rect('.b-sch-label-left:contains(Step 1)');
        editorRect = t.rect('.b-editor:visible');

        t.isApprox(editorRect.right, labelRect.right, 'right ok');
        t.isApprox(editorRect.top, labelRect.top - 10, 'Top ok');
    });

    // https://github.com/bryntum/support/issues/3957
    t.it('Should be possible to edit label many times', async t => {
        gantt = await t.getGantt({
            features : {
                labels : {
                    left : {
                        field  : 'name',
                        editor : {
                            type : 'textfield'
                        }
                    }
                }
            }
        });

        await t.doubleClick('.b-sch-label-left:contains(Step 1)');
        await t.waitForSelector('.b-editor');

        await t.type(null, '[ESCAPE]');

        await t.doubleClick('.b-sch-label-left:contains(Step 1)');
        await t.waitForSelector('.b-editor');
    });
});
