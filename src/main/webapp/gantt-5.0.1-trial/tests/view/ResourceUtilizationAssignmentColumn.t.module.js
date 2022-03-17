import { ResourceUtilization, BrowserHelper, ProjectModel, Gantt } from '../../build/gantt.module.js?457330';

StartTest(t => {

    let
        project,
        resourceStore,
        assignmentStore,
        gantt,
        panel;

    t.beforeEach(() => ResourceUtilization.destroy(panel));

    async function setup(panelConfig) {

        gantt = Gantt.new({
            appendTo  : document.body,
            startDate : new Date(2015, 0, 5),
            endDate   : new Date(2015, 0, 19),
            height    : 200,
            columns   : [{ type : 'resourceassignment' }],
            project   : ProjectModel.new({
                resourcesData : [
                    { id : 1, name : 'Mike' },
                    { id : 2, name : 'Dan' }
                ],
                assignmentsData : [
                    { id : 1, event : 1, resource : 1, units : 50 },
                    { id : 2, event : 2, resource : 1, units : 50 },
                    { id : 3, event : 3, resource : 2 },
                    { id : 4, event : 4, resource : 2 }
                ],
                dependenciesData : [],
                eventsData       : [
                    {
                        id        : 1,
                        name      : 'Task 1',
                        startDate : new Date(2015, 0, 5),
                        duration  : 3
                    },
                    {
                        id        : 2,
                        name      : 'Task 2',
                        startDate : new Date(2015, 0, 5),
                        duration  : 5
                    },
                    {
                        id        : 3,
                        name      : 'Task 3',
                        startDate : new Date(2015, 0, 5),
                        duration  : 3
                    },
                    {
                        id        : 4,
                        name      : 'Task 4',
                        startDate : new Date(2015, 0, 5),
                        duration  : 5
                    }
                ]
            })
        });

        panel = ResourceUtilization.new({
            appendTo : document.body,
            partner  : gantt,
            project  : gantt.project
        }, panelConfig);

        project = panel.project;

        ({
            resourceStore,
            assignmentStore
        } = project);

        await project.commitAsync();

        await panel.expandAll();
    }

    const noClasses = { 'b-underallocated' : false, 'b-overallocated' : false };

    async function assertRecordRow(t, record, values) {
        await t.waitForSelector(`.b-grid-row[data-id=${record.id}] .b-resourceutilization-cell .b-histogram`);

        const
            rowEl   = panel.getRowById(record).getElement('normal'),
            barEls  = rowEl.querySelectorAll('.b-histogram rect'),
            textEls = rowEl.querySelectorAll('.b-histogram text');

        t.is(barEls.length, values.length, 'proper number of bars');
        t.is(textEls.length, values.length, 'proper number of texts');

        values.forEach(({ date, text, classes }, index) => {

            for (const [cls, state] of Object.entries(classes)) {
                t[state ? 'hasCls' : 'hasNotCls'](barEls[index], cls, `${index}: bar has ${state ? '' : 'no'} ${cls} css class`);
            }

            t.is(textEls[index].innerHTML, text, `${index}: proper text`);

            // Firefox report incorrect scaled svg size
            // https://bugzilla.mozilla.org/show_bug.cgi?id=1633679
            if (!BrowserHelper.isFirefox && !BrowserHelper.isEdge) {
                t.isApprox(barEls[index].getBoundingClientRect().left, panel.getCoordinateFromDate(date, false), 0.5, `${index}: bar has proper coordinate`);
            }
        });
    }

    t.it('Refresh on assignment column editing', async t => {

        await setup();

        t.diag('Changing assignment 1 units to 100%');

        await t.doubleClick('.b-resourceassignment-cell');

        await t.click('.b-fieldtrigger');

        await t.doubleClick(':textEquals(50%)');

        await t.type(null, '100');

        await t.click('label:textEquals(Save)');

        // clicking next row to finish editing & apply the change
        await t.click(':nth-of-type(3) .b-resourceassignment-cell');

        t.diag('Assert resource 1 row');

        const mike = panel.store.getModelByOrigin(resourceStore.getById(1));

        await assertRecordRow(t, mike, [
            { date : new Date(2015, 0, 5), text : '36', classes : { 'b-underallocated' : false, 'b-overallocated' : true } },
            { date : new Date(2015, 0, 6), text : '36', classes : { 'b-underallocated' : false, 'b-overallocated' : true } },
            { date : new Date(2015, 0, 7), text : '36', classes : { 'b-underallocated' : false, 'b-overallocated' : true } },
            { date : new Date(2015, 0, 8), text : '12', classes : { 'b-underallocated' : true, 'b-overallocated' : false } },
            { date : new Date(2015, 0, 9), text : '12', classes : { 'b-underallocated' : true, 'b-overallocated' : false } }
        ]);

        t.diag('Assert assignment 1 row');

        await assertRecordRow(t, panel.store.getModelByOrigin(assignmentStore.getById(1)), [
            { date : new Date(2015, 0, 5), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 6), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 7), text : '24', classes : noClasses }
        ]);

        t.diag('Assert assignment 2 row');

        await assertRecordRow(t, panel.store.getModelByOrigin(assignmentStore.getById(2)), [
            { date : new Date(2015, 0, 5), text : '12', classes : noClasses },
            { date : new Date(2015, 0, 6), text : '12', classes : noClasses },
            { date : new Date(2015, 0, 7), text : '12', classes : noClasses },
            { date : new Date(2015, 0, 8), text : '12', classes : noClasses },
            { date : new Date(2015, 0, 9), text : '12', classes : noClasses }
        ]);

        t.diag('Asserting other records stayed intact...');

        t.diag('Assert resource 2 row');

        await assertRecordRow(t, panel.store.getModelByOrigin(resourceStore.getById(2)), [
            { date : new Date(2015, 0, 5), text : '48', classes : { 'b-underallocated' : false, 'b-overallocated' : true } },
            { date : new Date(2015, 0, 6), text : '48', classes : { 'b-underallocated' : false, 'b-overallocated' : true } },
            { date : new Date(2015, 0, 7), text : '48', classes : { 'b-underallocated' : false, 'b-overallocated' : true } },
            { date : new Date(2015, 0, 8), text : '24', classes : { 'b-underallocated' : false, 'b-overallocated' : false } },
            { date : new Date(2015, 0, 9), text : '24', classes : { 'b-underallocated' : false, 'b-overallocated' : false } }
        ]);

        t.diag('Assert assignment 3 row');

        await assertRecordRow(t, panel.store.getModelByOrigin(assignmentStore.getById(3)), [
            { date : new Date(2015, 0, 5), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 6), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 7), text : '24', classes : noClasses }
        ]);

        t.diag('Assert assignment 4 row');

        await assertRecordRow(t, panel.store.getModelByOrigin(assignmentStore.getById(4)), [
            { date : new Date(2015, 0, 5), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 6), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 7), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 8), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 9), text : '24', classes : noClasses }
        ]);

        t.diag('Asserting assignment #1 removal');

        await t.doubleClick('.b-resourceassignment-cell');

        // clicking remove icon
        await t.click('.b-close-icon');

        await t.click('label:textEquals(Save)');

        // clicking next row to finish editing & apply the change
        await t.click(':nth-of-type(3) .b-resourceassignment-cell');

        await t.waitFor(() => panel.store.count === 5);

        t.diag('Assert resource 1 row');

        await assertRecordRow(t, panel.store.getModelByOrigin(resourceStore.getById(1)), [
            { date : new Date(2015, 0, 5), text : '12', classes : { 'b-underallocated' : true, 'b-overallocated' : false } },
            { date : new Date(2015, 0, 6), text : '12', classes : { 'b-underallocated' : true, 'b-overallocated' : false } },
            { date : new Date(2015, 0, 7), text : '12', classes : { 'b-underallocated' : true, 'b-overallocated' : false } },
            { date : new Date(2015, 0, 8), text : '12', classes : { 'b-underallocated' : true, 'b-overallocated' : false } },
            { date : new Date(2015, 0, 9), text : '12', classes : { 'b-underallocated' : true, 'b-overallocated' : false } }
        ]);

        t.diag('Assert assignment 2 row');

        await assertRecordRow(t, panel.store.getModelByOrigin(assignmentStore.getById(2)), [
            { date : new Date(2015, 0, 5), text : '12', classes : noClasses },
            { date : new Date(2015, 0, 6), text : '12', classes : noClasses },
            { date : new Date(2015, 0, 7), text : '12', classes : noClasses },
            { date : new Date(2015, 0, 8), text : '12', classes : noClasses },
            { date : new Date(2015, 0, 9), text : '12', classes : noClasses }
        ]);

        t.diag('Asserting other records stayed intact...');

        t.diag('Assert resource 2 row');

        await assertRecordRow(t, panel.store.getModelByOrigin(resourceStore.getById(2)), [
            { date : new Date(2015, 0, 5), text : '48', classes : { 'b-underallocated' : false, 'b-overallocated' : true } },
            { date : new Date(2015, 0, 6), text : '48', classes : { 'b-underallocated' : false, 'b-overallocated' : true } },
            { date : new Date(2015, 0, 7), text : '48', classes : { 'b-underallocated' : false, 'b-overallocated' : true } },
            { date : new Date(2015, 0, 8), text : '24', classes : { 'b-underallocated' : false, 'b-overallocated' : false } },
            { date : new Date(2015, 0, 9), text : '24', classes : { 'b-underallocated' : false, 'b-overallocated' : false } }
        ]);

        t.diag('Assert assignment 3 row');

        await assertRecordRow(t, panel.store.getModelByOrigin(assignmentStore.getById(3)), [
            { date : new Date(2015, 0, 5), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 6), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 7), text : '24', classes : noClasses }
        ]);

        t.diag('Assert assignment 4 row');

        await assertRecordRow(t, panel.store.getModelByOrigin(assignmentStore.getById(4)), [
            { date : new Date(2015, 0, 5), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 6), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 7), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 8), text : '24', classes : noClasses },
            { date : new Date(2015, 0, 9), text : '24', classes : noClasses }
        ]);

    });

});
