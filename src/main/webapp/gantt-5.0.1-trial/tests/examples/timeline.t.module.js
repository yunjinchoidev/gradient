StartTest(async t => {
    await t.waitForSelector('.b-gantt-task');
    await t.waitForSelector('.b-sch-event-wrap:contains(Configure firewall)');
    t.selectorCountIs('.b-timeline .b-sch-event-wrap:not(.b-released)', 6);

    t.it('Should use sane sizes', async t => {
        await t.click('button:contains(Large)');

        t.hasApproxHeight('.b-timeline .b-grid-panel-body', 265, 'Large height');
        t.isApprox(parseInt(window.getComputedStyle(t.query('.b-milestone .b-sch-event-content')[0], '::before').fontSize), 47, 'Large milestone');
        t.isGreater(t.rect('.b-gantt').top, t.rect('.b-milestone label').bottom + 10, 'Space below label');
        t.isGreater(t.rect('.b-milestone label').top, t.rect('.b-timeline .b-grid-cell').bottom + 10, 'Space above label');

        await t.click('button:contains(Medium)');

        t.hasApproxHeight('.b-timeline .b-grid-panel-body', 167, 'Medium height');
        t.isApprox(parseInt(window.getComputedStyle(t.query('.b-milestone .b-sch-event-content')[0], '::before').fontSize), 26, 'Medium milestone');
        t.isGreater(t.rect('.b-gantt').top, t.rect('.b-milestone label').bottom + 10, 'Space below label');
        t.isGreater(t.rect('.b-milestone label').top, t.rect('.b-timeline .b-grid-cell').bottom + 10, 'Space above label');

        await t.click('button:contains(Small)');

        t.hasApproxHeight('.b-timeline .b-grid-panel-body', 139, 'Small height');
        t.isApprox(parseInt(window.getComputedStyle(t.query('.b-milestone .b-sch-event-content')[0], '::before').fontSize), 20, 'Small milestone');
        t.isGreater(t.rect('.b-gantt').top, t.rect('.b-milestone label').bottom + 10, 'Space below label');
        t.isGreater(t.rect('.b-milestone label').top, t.rect('.b-timeline .b-grid-cell').bottom + 10, 'Space above label');
    });

    t.it('Should resize timeline when clicking buttons', async t => {
        await t.click('button:contains(Large)');
        t.selectorCountIs('.b-timeline .b-sch-event-wrap:not(.b-released)', 6);
    });
});
