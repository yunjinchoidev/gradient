import { ResourceAssignmentColumn, AssignmentModel } from '../../build/gantt.module.js?457330';
/* global Gantt */

StartTest(t => {

    let gantt;

    t.beforeEach(t => {
        gantt && gantt.destroy();
        gantt = null;
    });

    // Here we check that effort column shows the same value which is showed in its editor #950
    t.it('Should render column properly', async t => {
        gantt = new Gantt({
            appendTo        : document.body,
            rowHeight       : 45,
            taskStore       : t.getTaskStore(),
            resourceStore   : t.getTeamResourceStore(),
            assignmentStore : t.getTeamAssignmentStore(),
            columns         : [
                { type : 'name', width : 170 },
                { type : ResourceAssignmentColumn.type, id : 'resourceassignment', width : 250 }
            ]
        });

        const { project } = gantt;

        let raColumn, gotData = false;

        t.chain(
            async() => project.commitAsync(),

            { waitForRowsVisible : gantt },

            next => {
                raColumn = gantt.columns.getById('resourceassignment');
                next();
            },

            ...project.getEventStore().map(event => async() => {

                await gantt.scrollCellIntoView({ id : event.id, columnId : 'resourceassignment' });

                const idx          = gantt.taskStore.allRecords.indexOf(event),
                    [cellEl]     = t.query(`.b-grid-row[data-index=${idx}] .b-grid-cell[data-column-id=resourceassignment]`),
                    valueElement = document.createElement('div');

                gotData = gotData || cellEl.innerHTML != '';

                raColumn.renderer({ value : event.assignments, cellElement : valueElement });
                t.is(cellEl.innerHTML, valueElement.innerHTML, 'Rendered ok');
            }),

            next => {
                t.ok(gotData, 'Resource assignment column data has been rendered');
            }
        );
    });

    t.it('Editor should be configurable with floating assignments behavior', t => {

        function run(t, float) {
            gantt = new Gantt({
                appendTo        : document.body,
                rowHeight       : 45,
                taskStore       : t.getTaskStore(),
                resourceStore   : t.getTeamResourceStore(),
                assignmentStore : t.getTeamAssignmentStore(),
                columns         : [
                    { type : 'name', text : 'Name', width : 170, field : 'name' },
                    {
                        type   : ResourceAssignmentColumn.type,
                        width  : 250,
                        editor : { store : { floatAssignedResources : float } }
                    }
                ]
            });

            const
                { project }                                    = gantt,
                { eventStore, assignmentStore, resourceStore } = project,
                task1                                          = eventStore.getById(115),
                task1idx                                       = eventStore.allRecords.indexOf(task1),
                Terence                                        = resourceStore.getById(12);

            t.chain(
                async() => project.commitAsync(),

                async() => {
                    t.is(Terence.name, 'Terence', 'Got Terence');

                    // Assigning Terence to task1, Terence is the last resource if sorted just by name, so he will be shown
                    // last if rendered with floatAssignedResources : false config for assignment manipulation store, which
                    // column editor should pass through
                    assignmentStore.add({
                        event    : task1,
                        resource : Terence
                    });

                    await project.propagateAsync();
                },

                { waitForRowsVisible : gantt },

                async() => {
                    t.ok(Array.from(task1.assignments).some(a => a.resource === Terence), 'Terence is assigned to task1');
                },
                { dblClick : () => `.b-grid-row[data-index=${task1idx}] .b-grid-cell[data-column=assignments]` },
                { click : '.b-assignmentfield .b-icon-down' },
                { waitForElementVisible : '.b-assignmentpicker' },
                // Finding Terence row, it should be last row in the grid
                next => {

                    let terenceRow = t.query(`.b-assignmentpicker .b-grid-row:contains(${Terence.name})`);

                    t.ok(terenceRow && terenceRow.length, `Got ${Terence.name} row`);

                    terenceRow = terenceRow[0];

                    const terrenceIndex = Number(terenceRow.dataset.index);

                    t.selectorExists(`.b-assignmentpicker .b-grid-row[data-index=${terrenceIndex}]`, `${Terence.name} row query is valid`);

                    if (float) {
                        t.selectorExists(`.b-assignmentpicker .b-grid-row[data-index=${terrenceIndex + 1}]`, `${Terence.name} row is not the last row`);
                    }
                    else {
                        t.selectorNotExists(`.b-assignmentpicker .b-grid-row[data-index=${terrenceIndex + 1}]`, `${Terence.name} row is the last row`);
                    }
                }
            );
        }

        t.it('Testing with floating resources', t => run(t, true));

        t.it('Testing w/o floating resources', run);
    });

    t.it('Should be possible to edit assignments', async t => {
        gantt = new Gantt({
            appendTo        : document.body,
            rowHeight       : 45,
            taskStore       : t.getTaskStore(),
            resourceStore   : t.getTeamResourceStore(),
            assignmentStore : t.getTeamAssignmentStore(),
            columns         : [
                { type : 'name', text : 'Name', width : 170, field : 'name' },
                { type : ResourceAssignmentColumn.type, id : 'resourceassignment', width : 250 }
            ]
        });

        const { project }                   = gantt,
            { eventStore, resourceStore } = project,
            task1                         = eventStore.getById(115),
            task1idx                      = eventStore.allRecords.indexOf(task1),
            Arcady                        = resourceStore.getById(1);

        let assignmentField;

        t.chain(
            async() => project.commitAsync(),
            { waitForRowsVisible : gantt },
            async() => {
                t.ok(Array.from(task1.assignments).some(a => a.resource.id === Arcady.id), 'Arcady is initially assigned to task1');
            },
            { dblClick : `.b-grid-row[data-index=${task1idx}] .b-grid-cell[data-column=assignments]` },

            next => {
                assignmentField = gantt.features.cellEdit.editorContext.editor.inputField;

                t.click(assignmentField.triggers.expand.element).then(next);
            },

            { waitForElementVisible : '.b-assignmentpicker' },
            { click : '.b-assignmentgrid .b-grid-row[data-index=0] .b-checkbox' },
            { click : '.b-assignmentpicker .b-button:contains(Save)' },
            next => {
                t.notOk(Array.from(assignmentField.value).some(a => a.resource.id === Arcady.id), 'Arcady is now unassigned from task1');
            }
        );
    });

    t.it('Should be possible to remove assignments by removing the chip from the ChipView', async t => {
        gantt = new Gantt({
            appendTo        : document.body,
            rowHeight       : 45,
            taskStore       : t.getTaskStore(),
            resourceStore   : t.getTeamResourceStore(),
            assignmentStore : t.getTeamAssignmentStore(),
            columns         : [
                { type : 'name', text : 'Name', width : 170, field : 'name' },
                { type : ResourceAssignmentColumn.type, id : 'resourceassignment', width : 250 }
            ]
        });

        const { project }    = gantt,
            { eventStore } = project,
            task1          = eventStore.getById(115),
            task1idx       = eventStore.allRecords.indexOf(task1),
            Arcady         = project.resourceStore.getById(1);

        t.chain(
            async() => project.commitAsync(),

            { waitForRowsVisible : gantt },

            async() => {
                t.ok(Array.from(task1.assignments).some(a => a.resource.id === Arcady.id), 'Arcady is initially assigned to task1');
            },

            { dblClick : `.b-grid-row[data-index=${task1idx}] .b-grid-cell[data-column=assignments]` },

            { click : '.b-assignmentfield .b-chip:contains("Arcady") .b-icon-clear' },
            { click : '.b-assignmentpicker .b-button:contains(Save)' },

            next => {
                t.ok(Array.from(task1.assignments).some(a => a.resource.id === Arcady.id), 'Arcady is still assigned from task1');
                next();
            },
            {
                waitForEvent : [gantt, 'navigate'],
                trigger      : { type : '[ENTER]', waitForTarget : false }
            },

            () => {
                t.notOk(Array.from(task1.assignments).some(a => a.resource.id === Arcady.id), 'Arcady is still assigned from task1');
            }
        );
    });

    t.it('Should be possible to make assignments by checking a checkbox', async t => {
        gantt = new Gantt({
            appendTo        : document.body,
            rowHeight       : 45,
            taskStore       : t.getTaskStore(),
            resourceStore   : t.getTeamResourceStore(),
            assignmentStore : t.getTeamAssignmentStore(),
            columns         : [
                { type : 'name', width : 170 },
                { type : ResourceAssignmentColumn.type, id : 'resourceassignment', width : 250 }
            ]
        });

        const { project } = gantt;

        const
            eventStore            = project.eventStore,
            task1                 = eventStore.getById(115),
            task1idx              = eventStore.allRecords.indexOf(task1),
            newlyAssignedResource = project.resourceStore.getAt(2);

        let assignmentField;

        t.chain(
            async() => project.commitAsync(),

            { waitForRowsVisible : gantt },

            async() => {
                t.notOk(Array.from(task1.assignments).some(a => a.resource.id === newlyAssignedResource.id), `${newlyAssignedResource.name} is not initially assigned to task1`);
            },

            { dblClick : `.b-grid-row[data-index=${task1idx}] .b-grid-cell[data-column=assignments]` },

            next => {
                assignmentField = gantt.features.cellEdit.editorContext.editor.inputField;

                t.click(assignmentField.triggers.expand.element).then(next);
            },

            { click : '.b-assignmentgrid .b-grid-row[data-index=2] .b-checkbox' },
            { click : '.b-assignmentpicker .b-button:contains(Save)' },
            next => {
                t.notOk(Array.from(task1.assignments).some(a => a.resource.id === newlyAssignedResource.id), `${newlyAssignedResource.name} is now assigned to task1`);
            }
        );
    });

    t.it('Moving a picker column should not terminate the edit', async t => {
        const run = (t, float) => {

            gantt = new Gantt({
                appendTo        : document.body,
                rowHeight       : 45,
                taskStore       : t.getTaskStore(),
                resourceStore   : t.getTeamResourceStore(),
                assignmentStore : t.getTeamAssignmentStore(),
                columns         : [
                    { type : 'name', width : 170 },
                    {
                        type   : ResourceAssignmentColumn.type,
                        width  : 250,
                        editor : { store : { floatAssignedResources : float } }
                    }
                ]
            });

            const
                project  = gantt.project,
                task1idx = project.eventStore.allRecords.indexOf(project.eventStore.getById(115));

            t.chain(
                async() => project.commitAsync(),

                { waitForRowsVisible : gantt },
                { dblClick : `.b-grid-row[data-index=${task1idx}] .b-grid-cell[data-column=assignments]` },
                { click : '.b-assignmentfield .b-icon-down' },
                { waitForElementVisible : '.b-assignmentpicker' },

                {
                    drag : '.b-assignmentpicker .b-grid-header:contains(Units)',
                    to   : '.b-assignmentpicker .b-grid-header'
                },

                // Picker should still be here
                () => {
                    t.selectorExists('.b-assignmentpicker', 'Picker is still visible');

                    gantt.destroy();
                    gantt = null;
                }
            );
        };

        t.it('Testing with floating resources', t => run(t, true));

        t.it('Testing w/o floating resources', run);
    });

    // Test should run though to completion. There's a throw for duplicated assignments
    t.it('Should not duplicate assignments when editing an unassigned task\'s assignments twice', async t => {
        gantt = new Gantt({
            appendTo        : document.body,
            rowHeight       : 45,
            taskStore       : t.getTaskStore(),
            resourceStore   : t.getTeamResourceStore(),
            assignmentStore : t.getTeamAssignmentStore(),
            columns         : [
                { type : 'name', width : 170 },
                { type : ResourceAssignmentColumn.type, id : 'resourceassignment', width : 250 }
            ]
        });

        const { project } = gantt;

        await project.commitAsync();

        let newTask;

        t.chain(
            { waitForRowsVisible : gantt },

            { contextmenu : () => gantt.getCell({ record : gantt.taskStore.last, column : 1 }) },

            { moveMouseTo : '.b-menuitem:contains(Add)' },

            { click : '.b-menuitem:contains(Task below)' },

            next => {
                newTask = gantt.taskStore.last;
                next();
            },

            { dblClick : () => gantt.getCell({ record : newTask, column : 1 }) },

            { click : () => '.b-assignmentfield .b-fieldtrigger' },

            { waitForElementVisible : '.b-assignmentpicker' },
            { click : '.b-assignmentgrid .b-grid-row[data-index=0] .b-checkbox' },
            { click : '.b-assignmentpicker .b-button:contains(Save)' },

            { type : '[ENTER]', waitForTarget : false },

            next => {
                t.is(newTask.assignments.length, 1, 'one assignment');
                t.is(newTask.assignments[0].resource.name, 'Arcady', 'assigned correct resource');
                t.is(newTask.assignments[0].units, 100, 'allocation % is correct');
                next();
            },

            // Start editing again with the same task.
            // The setProjectEvent should cause a correct data load even though it's the same event
            // as last time editing was invoked. It checks the event's generation now.
            { dblClick : () => gantt.getCell({ record : newTask, column : 1 }) },

            next => {
                t.selectorExists('.b-assignmentfield .b-chip:contains(Arcady 100%)', 'Correct assignment in chip view');
                next();
            },

            { click : () => '.b-assignmentfield .b-fieldtrigger' },

            { waitForElementVisible : '.b-assignmentpicker' },
            { dblclick : '.b-assignmentgrid .b-grid-row[data-index=0] .b-grid-cell[data-column=units]' },
            { click : '.b-spin-down' },
            { click : '.b-assignmentpicker .b-button:contains(Save)' },
            { type : '[ENTER]', waitForTarget : false },

            () => {
                // We allocated Arcady, then changed the units down to 90
                t.is(newTask.assignments.length, 1, 'one assignment');
                t.is(newTask.assignments[0].resource.name, 'Arcady', 'assigned correct resource');
                t.is(newTask.assignments[0].units, 90, 'allocation % is correct');
            }
        );
    });

    t.it('Should render initials if image is not available for the resource', t => {
        gantt = t.getGantt({
            resourceImageFolderPath : 'foo',
            assignments             : [
                { id : 1, event : 11, resource : 1 },
                { id : 2, event : 12, resource : 2 }
            ],
            resources : [
                { id : 1, name : 'Mike Bentley' },
                { id : 2, name : 'Dave Jones' }
            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true
                }
            ]
        });

        t.chain(
            {
                waitForSelector : '.b-resource-initials:contains(MB)',
                desc            : 'resources without images should show initials'
            },
            {
                waitForSelector : '.b-resource-initials:contains(DJ)',
                desc            : 'resources without images should show initials'
            },
            {
                waitForSelectorNotFound : '.b-resource-avatar-container img',
                desc                    : 'no images rendered'
            }
        );
    });

    t.it('Should render special image if resource images are not found', t => {
        gantt = t.getGantt({
            resourceImageFolderPath : 'foo',
            assignments             : [
                { id : 1, event : 11, resource : 1 },
                { id : 2, event : 12, resource : 2 }
            ],
            resources : [
                { id : 1, name : 'Michael Pen', image : 'nope' },
                { id : 2, name : 'Ronald Dump', image : 'nope2' }
            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true
                }
            ]
        });

        t.chain(
            {
                waitForSelectorNotFound : '.b-resource-initials:contains(MP)',
                desc                    : 'resources where image is not found should show initials'
            },
            {
                waitForSelectorNotFound : '.b-resource-initials:contains(RD)',
                desc                    : 'resources where image is not found should show initials'
            }
        );
    });

    t.it('Should render an image by imageUrl', t => {
        gantt = t.getGantt({
            resourceImageFolderPath : 'foo',
            assignments             : [
                { id : 1, event : 11, resource : 1 },
                { id : 2, event : 12, resource : 1 }
            ],
            resources : [
                { id : 1, name : 'Mike', image : 'nope', imageUrl : '../examples/_shared/images/users/amit.jpg' }
            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true
                }
            ]
        });

        t.chain(
            {
                waitForSelector : 'img[src*="examples/_shared/images/users/amit.jpg"]',
                desc            : 'resource uses "imageUrl" instead of "image" if provided'
            }
        );
    });

    t.it('Should render resource image if defined', async t => {
        gantt = await t.getGanttAsync({
            resourceImageFolderPath : '../examples/_shared/images/users/',
            assignments             : [
                { id : 1, event : 11, resource : 1 },
                { id : 2, event : 11, resource : 2, units : 50 },
                { id : 3, event : 11, resource : 3 }
            ],
            resources : [
                { id : 1, name : 'Mike', image : 'mike.jpg' },
                { id : 2, name : 'Dave', image : 'dave.jpg' },
                { id : 3, name : 'Secret Guy' }
            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true,
                    width       : 100
                }
            ]
        });

        t.selectorExists('.b-resource-avatar-container img[src*=mike]', 'Image for Mike found');
        t.selectorExists('.b-resource-avatar-container img[src*=dave]', 'Image for Dave found');

        await t.moveMouseTo('.b-resource-avatar-container .b-resource-avatar');

        await t.waitForSelector('.b-tooltip:textEquals("Dave 50%")');

        await t.moveMouseTo('.b-resource-avatar-container .b-overflow-img .b-resource-avatar');

        await t.waitForSelector('.b-tooltip:textEquals("Mike 100% (+1 more resources)")');
    });

    t.it('Should show tooltip when hovering avatar with failed loading of resource image', async t => {
        gantt = await t.getGanttAsync({
            rowHeight               : 100,
            resourceImageFolderPath : '../examples/_shared/images/users/',
            assignments             : [
                { id : 1, event : 11, resource : 1 },
                { id : 2, event : 12, resource : 2 },
                { id : 3, event : 12, resource : 3 },
                { id : 4, event : 12, resource : 4 }
            ],
            resources : [
                { id : 1, name : 'Mike', image : 'mike.jspg' },
                { id : 2, name : 'Dave', image : 'dave.jpg' },
                { id : 3, name : 'Ongie', image : false },
                { id : 4, name : 'Feng', image : false }
            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true,
                    width       : 150
                }
            ]
        });

        await t.waitForSelector('.b-resource-avatar-container .b-resource-avatar.b-resource-initials');
        await t.waitFor(() => t.rect('.b-resource-avatar-container .b-overflow-img').y === t.rect('.b-resource-avatar-container img.b-resource-avatar').y);

        const
            avatarWithInitialsRect = t.rect('.b-resource-avatar-container .b-resource-avatar.b-resource-initials'),
            avatarWithImageRect    = t.rect('.b-resource-avatar-container img.b-resource-avatar'),
            overflowRect           = t.rect('.b-resource-avatar-container .b-overflow-img');

        t.is(avatarWithInitialsRect.width, avatarWithInitialsRect.height, 'Avatar initials has same width & height');
        t.is(avatarWithImageRect.width, avatarWithImageRect.height, 'Avatar image has same width & height');
        t.is(avatarWithImageRect.height, avatarWithInitialsRect.height, 'Different avatar types have same width & height');
        t.is(overflowRect.height, avatarWithInitialsRect.height, 'Overflow element has same height as avatar');
        t.is(overflowRect.width, avatarWithInitialsRect.width, 'Overflow element has same width as avatar');
        t.is(overflowRect.y, avatarWithImageRect.y, 'Overflow element has same y as avatar');

        await t.moveMouseTo('.b-resource-avatar-container .b-resource-avatar');
        await t.waitForSelector('.b-tooltip:textEquals("Mike 100%")');
    });

    t.it('Should show assigned resources in assignment field chip view when editing is started', t => {
        gantt = t.getGantt({
            resourceImageFolderPath : '../examples/_shared/images/users/',
            assignments             : [
                { id : 1, event : 11, resource : 1, units : 50 },
                { id : 2, event : 12, resource : 2, units : 50 }
            ],
            resources : [
                { id : 1, name : 'Mike', image : 'mike.jpg' },
                { id : 2, name : 'Dave', image : 'dave.jpg' }
            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true,
                    width       : 100
                }
            ]
        });

        t.chain(
            { dblclick : '.b-resource-avatar-container img[src*=mike]' },

            { waitForSelector : '.b-assignment-chipview .b-chip:contains(Mike 50%)' },

            { click : '.b-resource-avatar-container img[src*=dave]' },

            { waitForSelector : '.b-assignment-chipview .b-chip:contains(Dave 50%)' }
        );
    });

    t.it('Should not affect assigned resources if pressing cancel', t => {
        gantt = t.getGantt({
            resourceImageFolderPath : '../examples/_shared/images/users/',
            assignments             : [
                { id : 1, event : 11, resource : 1, units : 50 },
                { id : 2, event : 12, resource : 2, units : 50 }
            ],
            resources : [
                { id : 1, name : 'Mike', image : 'mike.jpg' },
                { id : 2, name : 'Dave', image : 'dave.jpg' }
            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true,
                    width       : 100
                }
            ]
        });

        t.chain(
            { dblclick : '.b-resource-avatar-container img[src*=mike]' },

            { type : '[DOWN]', waitForTarget : false  },

            { click : '.b-assignmentpicker .b-button:contains(Cancel)' },

            { waitForSelector : '.b-assignment-chipview .b-chip:contains(Mike 50%)' },

            { click : '.b-tree-cell' },

            { dblclick : '.b-resource-avatar-container img[src*=mike]' },

            { waitForSelector : '.b-assignment-chipview .b-chip:contains(Mike 50%)' }
        );
    });

    t.it('Should not show field tooltip if no resources are assigned', t => {
        gantt = t.getGantt({
            resourceImageFolderPath : '../examples/_shared/images/users/',
            assignments             : [],
            resources               : [
                { id : 1, name : 'Mike', image : 'mike.jpg' },
                { id : 2, name : 'Dave', image : 'dave.jpg' }
            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true,
                    width       : 100
                }
            ]
        });

        t.chain(
            { dblClick : `.b-grid-row[data-index=3] .b-grid-cell[data-column=assignments]` },
            { type : '[DOWN]', waitForTarget : false },

            { click : '.b-grid-cell.b-check-cell' },

            { click : '.b-assignmentpicker .b-button:contains(Cancel)' },
            { click : `.b-grid-row[data-index=3] .b-grid-cell[data-column=name]` },
            { click : `.b-grid-row[data-index=3] .b-grid-cell[data-column=assignments]` },

            async() => {
                t.selectorNotExists('[data-btip=true]');
            }
        );
    });

    // https://github.com/bryntum/support/issues/391
    t.it('Should not crash when clicking outside assignment editor with cell editing active', t => {
        gantt = t.getGantt({
            resourceImageFolderPath : '../examples/_shared/images/users/',
            assignments             : [],
            resources               : [
                { id : 1, name : 'Mike', image : 'mike.jpg' }
            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true,
                    width       : 100
                }
            ]
        });

        t.chain(
            { dblClick : `.b-grid-row[data-index=3] .b-grid-cell[data-column=assignments]` },
            { type : '[DOWN]', waitForTarget : false },

            { dblClick : '.b-grid-cell[data-column="units"]' },

            { type : '10' },
            { click : '.b-tree-cell' },

            () => t.pass('No crash')
        );
    });

    // https://github.com/bryntum/support/issues/418
    t.it('Should rerender cells after a change in resourceStore', t => {
        gantt = t.getGantt({
            assignments : [
                { id : 1, event : 11, resource : 1, units : 50 }
            ],
            resources : [
                { id : 1, name : 'Mike' }
            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : false
                }
            ]
        });

        t.chain(
            { waitForSelector : '.b-resourceassignment-cell:contains(Mike)' },

            async() => gantt.resourceStore.first.set('name', 'Dave'),

            { waitForSelector : '.b-resourceassignment-cell:contains(Dave)' }
        );
    });

    t.it('Should render defaultResourceImageName if provided', t => {
        gantt = t.getGantt({
            resourceImageFolderPath  : './',
            defaultResourceImageName : 'favicon-gantt.png',
            assignments              : [
                { id : 1, event : 11, resource : 1, units : 50 }
            ],
            resources : [
                { id : 1, name : 'Mike' }
            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true
                }
            ]
        });

        t.chain(
            { waitForSelector : '.b-resource-avatar-container img[src*="favicon-gantt.png"]' }
        );
    });

    t.it('Should render initials if defaultResourceImageName is not found', t => {
        gantt = t.getGantt({
            resourceImageFolderPath  : './',
            defaultResourceImageName : 'foo.png',
            assignments              : [
                { id : 1, event : 11, resource : 1, units : 50 }
            ],
            resources : [
                { id : 1, name : 'Mike Donaldson' }
            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true
                }
            ]
        });

        t.chain(
            { waitForSelectorNotFound : '.b-resource-initials:contains(MP)' }
        );
    });

    t.it('Should support filtering with resource name matching', async t => {
        gantt = t.getGantt({
            features : {
                filter : true
            },
            columns : [
                {
                    id   : 'assignments',
                    type : ResourceAssignmentColumn.type
                }
            ],
            assignments : [
                { id : 1, event : 11, resource : 1 },
                { id : 2, event : 12, resource : 2, units : 50 },
                { id : 3, event : 13, resource : 3 }
            ],
            resources : [
                { id : 1, name : 'Mike' },
                { id : 2, name : 'Dave' },
                { id : 3, name : 'Secret Guy' }
            ]
        });

        gantt.features.filter.showFilterEditor('assignments');

        await t.type(null, 'Mike[ENTER]');

        t.is(gantt.taskStore.count, 3);
        t.is(gantt.taskStore.last.id, 11);

        gantt.features.filter.showFilterEditor('assignments');
        await t.click('.b-icon-remove');

        t.is(gantt.taskStore.count, 15);
    });

    t.it('Should support sorting', async t => {
        gantt = t.getGantt({
            columns : [
                {
                    id   : 'assignments',
                    type : ResourceAssignmentColumn.type
                }
            ],
            tasks : [
                { id : 1, name : 'foo' },
                { id : 2, name : 'bar' },
                { id : 3, name : 'baz' }
            ],
            assignments : [
                { id : 1, event : 1, resource : 1 },
                { id : 2, event : 2, resource : 2, units : 50 },
                { id : 3, event : 3, resource : 3 }
            ],
            resources : [
                { id : 1, name : 'Mike' },
                { id : 2, name : 'Dave' },
                { id : 3, name : 'Secret Guy' }
            ]
        });

        await t.click('.b-grid-header-text-content:contains(Assigned)');
        t.isDeeply(gantt.project.children.map(t => t.id), [2, 1, 3]);

        await t.click('.b-grid-header-text-content:contains(Assigned)');
        t.isDeeply(gantt.project.children.map(t => t.id), [3, 1, 2]);
    });

    // https://github.com/bryntum/support/issues/1842
    t.it('Should fire cell editing events for assignment column', async t => {
        gantt = t.getGantt({
            columns : [
                {
                    id   : 'assignments',
                    type : ResourceAssignmentColumn.type
                }
            ],
            tasks : [
                { id : 1, name : 'foo' },
                { id : 2, name : 'bar' },
                { id : 3, name : 'baz' }
            ],
            assignments : [
                { id : 1, event : 1, resource : 1 },
                { id : 2, event : 2, resource : 2, units : 50 },
                { id : 3, event : 3, resource : 3 }
            ],
            resources : [
                { id : 1, name : 'Mike' },
                { id : 2, name : 'Dave' },
                { id : 3, name : 'Secret Guy' }
            ]
        });

        await gantt.project.propagateAsync();

        t.willFireNTimes(gantt, 'beforeCellEditStart', 2);
        t.firesOnce(gantt, 'beforeFinishCellEdit');
        t.firesOnce(gantt, 'finishCellEdit');
        t.wontFire(gantt, 'cancelCellEdit');
        t.firesOnce(gantt.assignmentStore, 'change');

        t.chain(
            { dblClick : `.b-grid-row[data-index=1] .b-grid-cell[data-column=assignments]` },
            { type : '[DOWN]', waitForTarget : false },
            { dblclick : '.b-assignmentgrid .b-grid-row[data-index=0] .b-grid-cell[data-column=units]' },
            { type : '11', clearExisting : true },

            async() => t.selectorExists('.b-assignmentfield .b-chip:contains(Dave 50%)'),

            { click : '.b-assignmentpicker .b-button:contains(Save)' },
            async() => t.selectorExists('.b-assignmentfield .b-chip:contains(Dave 11%)'),
            { waitForSelector : 'input:focus' },

            { type : '[ENTER]', waitForTarget : false },

            { waitForSelector : '.b-assignmentfield .b-chip:contains(Secret Guy)', desc : 'Cell editing started in row below' },
            async() => t.selectorExists('.b-grid-cell .b-chip:contains(Dave 11%)', 'Cell editing completed ok')
        );
    });

    t.it('Should fire cell editing events for assignment column when cancelling edit', async t => {
        gantt = t.getGantt({
            columns : [
                {
                    id   : 'assignments',
                    type : ResourceAssignmentColumn.type
                }
            ],
            tasks : [
                { id : 1, name : 'foo' },
                { id : 2, name : 'bar' },
                { id : 3, name : 'baz' }
            ],
            assignments : [
                { id : 1, event : 1, resource : 1 },
                { id : 2, event : 2, resource : 2, units : 50 },
                { id : 3, event : 3, resource : 3 }
            ],
            resources : [
                { id : 1, name : 'Mike' },
                { id : 2, name : 'Dave' },
                { id : 3, name : 'Secret Guy' }
            ]
        });

        await gantt.project.propagateAsync();

        t.firesOnce(gantt, 'beforeCellEditStart');
        t.wontFire(gantt, 'beforeFinishCellEdit');
        t.firesOnce(gantt, 'cancelCellEdit');

        t.wontFire(gantt.assignmentStore, 'change');

        t.chain(
            { dblClick : `.b-grid-row[data-index=1] .b-grid-cell[data-column=assignments]` },
            { type : '[DOWN]', waitForTarget : false },
            { dblclick : '.b-assignmentgrid .b-grid-row[data-index=0] .b-grid-cell[data-column=units]' },
            { type : '11', clearExisting : true },

            async() => t.selectorExists('.b-assignmentfield .b-chip:contains(Dave 50%)'),

            { click : '.b-assignmentpicker .b-button:contains(Save)' },
            async() => t.selectorExists('.b-assignmentfield .b-chip:contains(Dave 11%)'),
            { waitForSelector : 'input:focus' },
            { type : '[ESCAPE]', waitForTarget : false },

            async() => t.selectorExists('.b-assignmentfield .b-chip:contains(Dave 50%)', 'Value reverted after first Esc'),

            { type : '[ESCAPE]', waitForTarget : false },
            { waitForSelectorNotFound : '.b-assignmentfield' },
            async() => t.selectorExists('.b-grid-cell .b-chip:contains(Dave 50%)', 'Cell editing cancelled after 2nd Esc')
        );
    });

    t.it('Should support data mapping if cell editor used', async t => {
        class MockAssignmentModel extends AssignmentModel {
            static get fields() {
                return [
                    { name : 'event', dataSource : 'custom_task' },
                    { name : 'resource', dataSource : 'custom_resource' },
                    { name : 'units', dataSource : 'custom_units', type : 'number' }
                ];
            }
        }
        gantt = await t.getGanttAsync({
            project : {
                taskStore : {
                    data : [
                        { id : 1, name : 'foo' },
                        { id : 2, name : 'bar' },
                        { id : 3, name : 'baz' }
                    ]
                },
                assignmentStore : {
                    modelClass : MockAssignmentModel,
                    data       : []
                },
                resourceStore : {
                    data : [
                        { id : 1, name : 'Mike' },
                        { id : 2, name : 'Dave' },
                        { id : 3, name : 'Secret Guy' }
                    ]
                }
            },
            columns : [
                {
                    id   : 'assignments',
                    type : ResourceAssignmentColumn.type
                }
            ]
        });

        t.chain(
            { dblClick : `.b-grid-row[data-index=1] .b-grid-cell[data-column=assignments]` },
            { type : '[DOWN]', waitForTarget : false },
            { click : '.b-assignmentgrid .b-grid-row[data-index=0] .b-checkbox' },
            { dblclick : '.b-assignmentgrid .b-grid-row[data-index=0] .b-grid-cell[data-column=units]' },
            { type : '11', clearExisting : true },
            { waitForElementVisible : '.b-assignmentpicker' },
            { click : '.b-assignmentpicker .b-button:contains(Save)' },
            async() => t.selectorExists('.b-assignmentfield .b-chip:contains(Dave 11%)'),
            { waitForSelector : 'input:focus' },
            { type : '[ENTER]', waitForTarget : false },

            () => {
                const assignment = gantt.project.assignmentStore.getAt(0);
                t.is(assignment.get('custom_units'), 11, 'Untis mapping ok');
                t.is(assignment.get('custom_task')?.id, 1, 'Event mapping ok');
                t.is(assignment.get('custom_resource')?.id, 2, 'Resource mapping ok');
            }
        );
    });

    // https://github.com/bryntum/support/issues/2330
    t.it('Should record assignment change / undo correctly', async t => {
        gantt = t.getGantt({
            columns : [
                {
                    id   : 'assignments',
                    type : ResourceAssignmentColumn.type
                }
            ],

            project : {
                tasksData : [
                    { id : 1, name : 'foo' }
                ],
                assignmentsData : [
                    { id : 1, event : 1, resource : 1, units : 100 }
                ],
                resourcesData : [
                    { id : 1, name : 'Mike' }
                ],
                stm : {
                    autoRecord : true
                }
            }
        });

        await gantt.project.commitAsync();

        gantt.project.stm.enable();
        const assignmentStore = gantt.assignmentStore;

        await t.doubleClick('.b-grid-cell[data-column="assignments"]');
        await t.click('.b-assignmentfield .b-icon-down');
        await t.doubleClick('.b-grid-cell[data-column="units"]');
        await t.type(null, '50[ENTER]', null, null, null, true);
        await t.click('.b-button:contains(Save)');
        await t.click('.b-grid-subgrid[data-region="locked"]');

        await t.waitFor(() => assignmentStore.changes);

        t.isDeeply(assignmentStore.changes, {
            added    : [],
            modified : [assignmentStore.first],
            removed  : []
        }, 'Correct store changes object');

        t.isDeeply(assignmentStore.first.modifications, {
            id    : 1,
            units : 50
        }, 'Correct model modifications');

        await gantt.project.stm.undo();
        await gantt.project.commitAsync();

        t.is(assignmentStore.changes, null, 'No changes detected');
    });

    // https://github.com/bryntum/support/issues/2986
    t.it('Should render initials correctly after resizing column', async t => {
        gantt = t.getGantt({
            assignments : [
                { id : 1, event : 11, resource : 1 },
                { id : 2, event : 11, resource : 2 },
                { id : 3, event : 11, resource : 3 },
                { id : 4, event : 11, resource : 4 },
                { id : 5, event : 11, resource : 5 }
            ],
            resources : [
                { id : 1, name : 'Mike Bentley' },
                { id : 2, name : 'Dave Jones' },
                { id : 3, name : 'Rob Jones' },
                { id : 4, name : 'Kate Jones' },
                { id : 5, name : 'Steve Jones' }

            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true,
                    width       : 100
                },
                {}
            ]
        });

        await t.waitForSelector('.b-resource-initials:contains(DJ)');
        await t.waitForSelector('.b-overflow-img:last-child');

        gantt.columns.getAt(1).width  = 150;

        t.selectorCountIs('.b-overflow-count', 1, 'Should only find overflow count inside last overflow');
    });

    // https://github.com/bryntum/support/issues/3465
    t.it('Should round effort percents correctly', async t => {
        gantt = t.getGantt({
            assignments : [
                { id : 1, event : 11, resource : 1 },
                { id : 2, event : 11, resource : 2 },
                { id : 3, event : 11, resource : 3 },
                { id : 4, event : 11, resource : 4 },
                { id : 5, event : 11, resource : 5 }
            ],
            resources : [
                { id : 1, name : 'Mike Bentley' },
                { id : 2, name : 'Dave Jones' },
                { id : 3, name : 'Rob Jones' },
                { id : 4, name : 'Kate Jones' },
                { id : 5, name : 'Steve Jones' }

            ],
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true,
                    width       : 100
                },
                {}
            ]
        });
        const project = gantt.project;
        const task = gantt.taskStore.getById(11);

        task.set({ schedulingMode : 'FixedEffort' });
        await project.commitAsync();

        task.set({ duration : 12 });
        await project.commitAsync();
        await t.moveMouseTo('[data-id=11] .b-resource-avatar');
        await t.waitForSelector('.b-tooltip-content:contains(83%)');
        await t.doubleClick();
        await t.waitForSelector('.b-chip:contains(83%)');
        await t.click('.b-fieldtrigger');
        await t.waitForSelector('[data-column="units"]:contains(83%)');
    });

    // https://github.com/bryntum/support/issues/3484
    t.it('Should handle resource store being grouped', async t => {
        gantt = t.getGantt({
            project   : null,
            taskStore : {
                data : [{
                    id   : 1,
                    name : 'The task'
                }]
            },
            assignmentStore : {
                data : [
                    { id : 1, event : 1, resource : 1 }
                ]
            },
            resourceStore : {
                groupers : [
                    { field : 'name', ascending : true }
                ],
                data : [
                    { id : 1, name : 'Mike Bentley' },
                    { id : 2, name : 'Dave Jones' }
                ]
            },
            columns : [
                {
                    type        : ResourceAssignmentColumn.type,
                    showAvatars : true,
                    width       : 100
                }
            ]
        });

        await t.doubleClick('.b-grid-cell[data-column="assignments"]');
        await t.click('.b-assignmentfield .b-icon-down');
        await t.click('.b-grid-row[data-index="1"] .b-check-cell input');
        await t.click('.b-assignmentpicker .b-button:contains(Save)');
        await t.type(null, '[ENTER]');
        await gantt.project.commitAsync();

        t.is(gantt.taskStore.first.resources.length, 2, '2 resources now assigned');
    });

    t.it('Should support filtering using context menu\'s Equals test', async t => {
        gantt = t.getGantt({
            features : {
                filter : true
            },
            columns : [
                {
                    id   : 'assignments',
                    type : ResourceAssignmentColumn.type
                }
            ],
            assignments : [
                { id : 1, event : 11, resource : 1 },
                { id : 2, event : 12, resource : 2, units : 50 },
                { id : 3, event : 13, resource : 3 }
            ],
            resources : [
                { id : 1, name : 'Mike' },
                { id : 2, name : 'Dave' },
                { id : 3, name : 'Secret Guy' }
            ]
        });

        await t.doubleClick('.id231 [data-column="assignments"]');

        await t.waitFor(() => gantt.features.cellEdit.editor.containsFocus);

        await t.click(gantt.features.cellEdit.editor.inputField.triggers.expand.element);

        await t.click('.b-grid-row[data-index="1"] .b-grid-cell input[type="checkbox"]');

        await t.click('[data-ref="saveBtn"]');

        // Choose a task assined to Mike. There are two tasks assigned to Mike
        await t.rightClick('.id11 [data-column="assignments"]');

        await t.click('.b-menuitem[data-ref="filterStringEquals"]');

        t.selectorCountIs('.b-grid-subgrid-locked .b-grid-row', 6, 'Result: 2 leaves and 4 ancestors');

        // Correct tasks visible
        t.is(gantt.taskStore.map(t => t.id).toString(), '1000,1,11,2,23,231');

        gantt.store.clearFilters();

        // Choose an unassigned task for the "Equals" comparison.
        // This must filter to show all unassigned tasks.
        await t.rightClick('.b-grid-row.id22  [data-column="assignments"]');

        await t.click('.b-menuitem[data-ref="filterStringEquals"]');

        t.selectorCountIs('.b-grid-subgrid-locked .b-grid-row', 11, 'Result: 6 leaves and 5 ancestors');

        // Correct tasks visible
        t.is(gantt.taskStore.map(t => t.id).toString(), '1000,1,14,2,21,22,23,232,233,234,3');
    });

    // https://github.com/bryntum/support/issues/4118
    t.it('Should trigger add / remove events', async t => {
        gantt = t.getGantt({
            columns : [
                {
                    id   : 'assignments',
                    type : ResourceAssignmentColumn.type
                }
            ],

            project : {
                tasksData : [
                    { id : 1, name : 'foo' }
                ],
                assignmentsData : [
                    { id : 1, event : 1, resource : 1, units : 100 }
                ],
                resourcesData : [
                    { id : 1, name : 'Mike' },
                    { id : 2, name : 'Bob' }
                ],
                stm : {
                    autoRecord : true
                }
            }
        });

        await gantt.project.commitAsync();

        const assignmentStore = gantt.assignmentStore;

        t.firesOnce(assignmentStore, 'add');
        t.firesOnce(assignmentStore, 'remove');

        await t.doubleClick('.b-grid-cell[data-column="assignments"]');
        await t.click('.b-assignmentfield .b-icon-down');

        await t.click('.b-grid-row:contains(Mike) .b-checkbox ');
        await t.click('.b-grid-row:contains(Bob) .b-checkbox ');
        await t.click('.b-button:contains(Save)');
        await t.click('.b-grid-subgrid[data-region="locked"]');

        await t.waitFor(() => assignmentStore.changes);
    });
});
