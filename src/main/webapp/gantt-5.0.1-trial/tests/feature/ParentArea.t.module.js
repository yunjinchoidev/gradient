
StartTest(t => {
    let gantt;

    t.beforeEach(() => gantt?.destroy());

    t.it('Should render parent area around child tasks when parent is expanded', async t => {
        gantt = t.getGantt({
            autoHeight : true,
            forceFit   : true,

            project : {
                tasksData : [
                    {
                        id       : 1,
                        name     : 'Write docs',
                        expanded : true,
                        children : [
                            {
                                id        : 2,
                                name      : 'Proof-read docs',
                                startDate : '2021-06-02',
                                endDate   : '2021-06-05'
                            },
                            {
                                id        : 3,
                                name      : 'Release docs',
                                startDate : '2021-06-05',
                                endDate   : '2021-06-10'
                            }
                        ]
                    },

                    {
                        id       : 4,
                        name     : 'Discuss with client',
                        expanded : true,
                        children : [
                            {
                                id        : 5,
                                name      : 'C-level discussion',
                                startDate : '2021-06-10',
                                endDate   : '2021-06-15'
                            },
                            {
                                id        : 6,
                                name      : 'UX team issues',
                                startDate : '2021-06-15',
                                duration  : 0
                            }
                        ]
                    }
                ],

                dependenciesData : [
                    {
                        from : 2,
                        to   : 3
                    },
                    {
                        from : 3,
                        to   : 4
                    },
                    {
                        from : 5,
                        to   : 6
                    }
                ]
            },

            columns : [
                { type : 'name', width : 250 }
            ],

            features : {
                projectLines : false,
                parentArea   : true
            }
        });

        await t.waitForSelector('.b-parent-area');

        t.selectorCountIs('.b-parent-area', 2, '2 areas found');

        const rect = t.rect('.b-parent-area');

        t.isApprox(rect.height, gantt.rowHeight * 3 - gantt.barMargin, 'Correct height');
        t.isApprox(rect.width, gantt.taskStore.first.duration * gantt.tickSize, 0.5, 'Correct width');

        await t.click('.b-expanded');

        t.selectorNotExists('.b-gantt-task-wrap:not(.b-expanded) .b-parent-area', 'First area no longer visible');

        await gantt.collapseAll();

        t.selectorNotExists('.b-parent-area[data-task-id="parent-area-4"]', '2nd area no longer visible');

        await gantt.expandAll();

        t.elementIsVisible('.b-parent-area[data-task-id="parent-area-1"]', '1st area visible');
        t.elementIsVisible('.b-parent-area[data-task-id="parent-area-4"]', '2nd area visible');
    });

    t.it('Should draw area around collapsed child tasks', async t => {
        gantt = t.getGantt({
            autoHeight : true,
            forceFit   : true,

            project : {
                tasksData : [
                    {
                        id       : 1,
                        name     : 'Write docs',
                        expanded : true,
                        children : [
                            {
                                id        : 2,
                                name      : 'Proof-read docs',
                                startDate : '2021-06-02',
                                endDate   : '2021-06-05'
                            },
                            {
                                id        : 3,
                                name      : 'Release docs',
                                startDate : '2021-06-05',
                                endDate   : '2021-06-10',
                                expanded  : true,
                                children  : [
                                    {
                                        id        : 5,
                                        name      : 'C-level discussion',
                                        startDate : '2021-06-10',
                                        endDate   : '2021-06-15'
                                    },
                                    {
                                        id        : 6,
                                        name      : 'UX team issues',
                                        startDate : '2021-06-15',
                                        duration  : 0
                                    }
                                ]
                            },
                            {
                                id        : 4,
                                name      : 'Release docs',
                                startDate : '2021-06-05',
                                endDate   : '2021-06-10',
                                children  : [
                                    {
                                        id        : 15,
                                        name      : 'C-level discussion',
                                        startDate : '2021-06-10',
                                        endDate   : '2021-06-15'
                                    },
                                    {
                                        id        : 16,
                                        name      : 'UX team issues',
                                        startDate : '2021-06-15',
                                        duration  : 0
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        id   : 8,
                        name : 'Last node'
                    }
                ],

                dependenciesData : [
                    {
                        from : 2,
                        to   : 3
                    },
                    {
                        from : 3,
                        to   : 4
                    },
                    {
                        from : 5,
                        to   : 6
                    }
                ]
            },

            columns : [
                { type : 'name', width : 250 }
            ],

            features : {
                projectLines : false,
                parentArea   : true
            }
        });

        await t.waitForSelector('.b-parent-area');

        t.selectorCountIs('.b-parent-area', 2, '2 areas found');

        const rect = t.rect('.b-parent-area');

        t.isApprox(rect.height, gantt.rowHeight * 6 - gantt.barMargin, 'Height should encapsulate last child (nested)');
        t.isApprox(rect.width, gantt.taskStore.first.duration * gantt.tickSize, 0.5, 'Correct width');
    });

    t.it('Should update parent area when child tasks are expanded / collapsed', async t => {
        gantt = t.getGantt({
            autoHeight : true,
            forceFit   : true,

            project : {
                tasksData : [
                    {
                        id       : 1,
                        name     : 'Write docs',
                        expanded : true,
                        children : [
                            {
                                id        : 2,
                                name      : 'Proof-read docs',
                                startDate : '2021-06-02',
                                endDate   : '2021-06-05'
                            },
                            {
                                id        : 3,
                                name      : 'Nested parent',
                                startDate : '2021-06-05',
                                endDate   : '2021-06-10',
                                expanded  : true,
                                children  : [
                                    {
                                        id        : 5,
                                        name      : 'C-level discussion',
                                        startDate : '2021-06-10',
                                        endDate   : '2021-06-15'
                                    },
                                    {
                                        id        : 6,
                                        name      : 'UX team issues',
                                        startDate : '2021-06-15',
                                        duration  : 0
                                    }
                                ]
                            },
                            {
                                id        : 4,
                                name      : 'Nested nested parent',
                                startDate : '2021-06-05',
                                endDate   : '2021-06-10',
                                children  : [
                                    {
                                        id        : 15,
                                        name      : 'C-level discussion',
                                        startDate : '2021-06-10',
                                        endDate   : '2021-06-15'
                                    },
                                    {
                                        id        : 16,
                                        name      : 'UX team issues',
                                        startDate : '2021-06-15',
                                        duration  : 0
                                    }
                                ]
                            }
                        ]
                    }
                ],

                dependenciesData : [
                    {
                        from : 2,
                        to   : 3
                    },
                    {
                        from : 3,
                        to   : 4
                    },
                    {
                        from : 5,
                        to   : 6
                    }
                ]
            },

            columns : [
                { type : 'name', width : 250 }
            ],

            features : {
                projectLines : false,
                parentArea   : true
            }
        });

        await t.waitForSelector('.b-parent-area');

        t.selectorCountIs('.b-parent-area', 2, '2 areas found');

        let rect = t.rect('.b-parent-area');

        t.isApprox(rect.height, gantt.rowHeight * 6 - gantt.barMargin, 'Height should encapsulate 6 rows');
        t.isApprox(rect.width, gantt.taskStore.first.duration * gantt.tickSize, 0.5, 'Correct width');

        await gantt.collapse(3);

        rect = t.rect('.b-parent-area');

        t.isApprox(rect.height, gantt.rowHeight * 4 - gantt.barMargin, 'Height should encapsulate 4 rows after child is collapsed');

        await gantt.expand(3);

        rect = t.rect('.b-parent-area');

        t.isApprox(rect.height, gantt.rowHeight * 6 - gantt.barMargin, 'Height should encapsulate 6 rows after child expand');
    });

    t.it('Should update parent area when child tasks are removed / added / updated', async t => {
        gantt = t.getGantt({
            autoHeight            : true,
            forceFit              : true,
            enableEventAnimations : false,

            project : {
                tasksData : [
                    {
                        id       : 1,
                        name     : 'Write docs',
                        expanded : true,
                        children : [
                            {
                                id        : 3,
                                name      : 'Nested parent',
                                startDate : '2021-06-05',
                                endDate   : '2021-06-10',
                                expanded  : true,
                                children  : [
                                    {
                                        id        : 5,
                                        name      : 'C-level discussion',
                                        startDate : '2021-06-10',
                                        endDate   : '2021-06-15'
                                    },
                                    {
                                        id        : 6,
                                        name      : 'UX team issues',
                                        startDate : '2021-06-15',
                                        duration  : 5
                                    }
                                ]
                            }
                        ]
                    }
                ]
            },

            columns : [
                { type : 'name', width : 250 }
            ],

            features : {
                projectLines : false,
                parentArea   : true
            }
        });

        await t.waitForSelector('.b-parent-area');

        t.selectorCountIs('.b-parent-area', 2, '2 areas found');

        let rect = t.rect('.b-parent-area');

        t.isApprox(rect.height, gantt.rowHeight * 4 - gantt.barMargin, 'Height should encapsulate 6 rows');
        t.isApprox(rect.width, gantt.taskStore.first.duration * gantt.tickSize, 0.5, 'Correct width');

        gantt.taskStore.remove(5);
        await gantt.project.commitAsync();

        rect = t.rect('.b-parent-area');

        t.isApprox(rect.height, gantt.rowHeight * 3 - gantt.barMargin, 'Height should encapsulate 3 rows after child is removed');

        gantt.taskStore.getById(3).appendChild({ name : 'new' });
        await gantt.project.commitAsync();

        rect = t.rect('.b-parent-area');

        t.isApprox(rect.height, gantt.rowHeight * 4 - gantt.barMargin, 'Height should encapsulate 4 rows after child add');

        await gantt.taskStore.getById(6).setDuration(10);

        t.hasApproxWidth('.b-parent-area', 220, 'Width changed on update');
    });

    t.it('Should paint parent area when child tasks are outside rendered block both before & after', async t => {
        gantt = t.getGantt({
            forceFit : true,

            height  : 400,
            project : {
                tasksData : [
                    {
                        id       : 1,
                        name     : 'Write docs',
                        expanded : true,
                        children : [
                            {
                                id        : 3,
                                name      : 'Nested parent',
                                startDate : '2021-06-05',
                                endDate   : '2021-06-10',
                                expanded  : true,
                                children  : [
                                    {
                                        id        : 5,
                                        name      : 'C-level discussion',
                                        startDate : '2021-06-10',
                                        endDate   : '2021-06-15'
                                    },
                                    {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                                    {
                                        id        : 6,
                                        name      : 'UX team issues',
                                        startDate : '2021-06-15',
                                        duration  : 5
                                    }
                                ]
                            }
                        ]
                    }
                ]
            },

            columns : [
                { type : 'name', width : 250 }
            ],

            features : {
                projectLines : false,
                parentArea   : true
            }
        });

        await t.waitForSelector('.b-parent-area');

        gantt.scrollable.y = 1000;
        const rect = t.rect('.b-parent-area');

        t.isApprox(rect.height, (gantt.rowHeight * gantt.taskStore.count) - gantt.barMargin, 'Height should encapsulate 6 rows');
        t.isApprox(rect.width, gantt.taskStore.first.duration * gantt.tickSize, 0.5, 'Correct width');
    });

    t.it('Should support disabling the feature', async t => {
        gantt = t.getGantt({
            autoHeight : true,
            forceFit   : true,

            project : {
                tasksData : [
                    {
                        id       : 1,
                        name     : 'Write docs',
                        expanded : true,
                        children : [
                            {
                                id        : 2,
                                name      : 'Proof-read docs',
                                startDate : '2021-06-02',
                                endDate   : '2021-06-05'
                            },
                            {
                                id        : 3,
                                name      : 'Nested parent',
                                startDate : '2021-06-05',
                                endDate   : '2021-06-10',
                                expanded  : true,
                                children  : [
                                    {
                                        id        : 5,
                                        name      : 'C-level discussion',
                                        startDate : '2021-06-10',
                                        endDate   : '2021-06-15'
                                    },
                                    {
                                        id        : 6,
                                        name      : 'UX team issues',
                                        startDate : '2021-06-15',
                                        duration  : 0
                                    }
                                ]
                            },
                            {
                                id        : 4,
                                name      : 'Nested nested parent',
                                startDate : '2021-06-05',
                                endDate   : '2021-06-10',
                                children  : [
                                    {
                                        id        : 15,
                                        name      : 'C-level discussion',
                                        startDate : '2021-06-10',
                                        endDate   : '2021-06-15'
                                    },
                                    {
                                        id        : 16,
                                        name      : 'UX team issues',
                                        startDate : '2021-06-15',
                                        duration  : 0
                                    }
                                ]
                            }
                        ]
                    }
                ],

                dependenciesData : [
                    {
                        from : 2,
                        to   : 3
                    },
                    {
                        from : 3,
                        to   : 4
                    },
                    {
                        from : 5,
                        to   : 6
                    }
                ]
            },

            columns : [
                { type : 'name', width : 250 }
            ],

            features : {
                projectLines : false,
                parentArea   : true
            }
        });

        await t.waitForSelector('.b-parent-area');

        t.selectorCountIs('.b-parent-area', 2, '2 areas found');

        gantt.features.parentArea.disabled = true;

        t.selectorNotExists('.b-parent-area', 'No areas');

        gantt.features.parentArea.disabled = false;

        t.selectorCountIs('.b-parent-area', 2, '2 areas found');
    });
});
