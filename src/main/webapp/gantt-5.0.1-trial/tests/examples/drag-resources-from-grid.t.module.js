import { Toast } from '../../build/gantt.module.js?457330';

StartTest(t => {
    const resourceGrid = bryntum.query('resourcegrid');

    t.it('Should be possible to drag a single resource onto a task to assign', async t => {
        await t.dragTo({
            source   : '.b-tree-cell-value:contains(Celia)',
            target   : '.b-grid-cell:contains(Setup web server)',
            dragOnly : true
        });

        t.selectorCountIs('.b-dragging', 1, 'Dragging 1 item');
        await t.mouseUp();
        await t.waitForSelectorNotFound('.b-dragging');
        await t.waitForSelector('.b-tree-parent-row[data-id="1"] .b-resource-avatar-container img[src*=celia]');
    });

    t.it('Should handle selecting 2 items', async t => {
        resourceGrid.selectedRecords = [resourceGrid.store.getById(1), resourceGrid.store.last];

        await t.dragTo({
            source : '.b-tree-cell-value:contains(Celia)',
            target : '.b-grid-cell:contains(Setup web server)'
        });

        await t.waitForSelectorNotFound('.b-dragging');
        await t.waitForSelector('.b-tree-parent-row[data-id="1"] .b-resource-avatar-container img[src*=celia]');
    });

    t.it('Should not be possible to assign a resource that is already assigned', async t => {
        const spy = t.spyOn(Toast, 'show');
        await t.dragTo({
            source : '.b-tree-cell-value:contains(Celia)',
            target : '.b-grid-cell:contains(Setup web server)'
        });

        await t.waitForSelectorNotFound('.b-dragging');

        t.expect(spy).toHaveBeenCalled(1);
    });

    t.it('Should be possible to drag multiple resources onto a task to assign many at once', async t => {
        resourceGrid.selectedRecords = resourceGrid.store.rootNode.firstChild.children.slice(0, 3);

        await t.dragTo({
            source     : '.b-tree-cell-value:contains(Celia)',
            fromOffset : [10, '50%'],
            toOffset   : [10, 1],
            target     : '.b-grid-cell:contains(Launch SaaS)'
        });

        await t.waitForSelectorNotFound('.b-dragging');
        await t.waitForSelector('.b-tree-parent-row[data-id="1000"] .b-resource-avatar-container img[src*=celia]');
        await t.waitForSelector('.b-tree-parent-row[data-id="1000"] .b-resource-avatar-container img[src*=lee]');
        await t.waitForSelector('.b-tree-parent-row[data-id="1000"] .b-resource-avatar-container img[src*=macy]');
    });
});
