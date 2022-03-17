import { ObjectHelper, Container, SchedulerPro } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let container, gantt, schedulerPro, project;

    t.beforeEach(() => container?.destroy());

    function createGanttAndSchedulerPro({ partnered = true, ganttCfg = {}, schedulerCfg = {} } = {}) {

        gantt = t.getGantt(ObjectHelper.assign({
            appendTo : null,
            flex     : 1,
            features : {
                taskTooltip : false
            },
            startDate : new Date(2010, 1, 3),
            endDate   : new Date(2010, 4, 24),
            project   : t.getProjectData()
        }, ganttCfg));

        project = gantt.project;

        if (partnered) {
            ObjectHelper.assign(schedulerCfg, {
                partner : gantt,
                project
            });
        }

        schedulerPro = SchedulerPro.new({
            flex     : 1,
            features : {
                taskTooltip : false
            },
            columns : [{ type : 'name' }]
        }, schedulerCfg);

        container = new Container({
            appendTo : document.body,
            style    : 'flex-flow: column nowrap; height: 100%; align-items: stretch;',
            items    : [
                gantt,
                { type : 'splitter' },
                schedulerPro
            ]
        });
    }

    // https://github.com/bryntum/bryntum-suite/issues/1513
    t.it('Should be possible to delete a task in Gantt chart', t => {
        createGanttAndSchedulerPro();

        t.chain(
            { waitForPropagate : project },
            {
                waitFor : 'SelectorNotFound',
                args    : ['.b-sch-dependency[depId="30"]'],
                trigger : () => project.taskStore.remove(project.taskStore.getById(117))
            },
            {
                waitFor : 'Event',
                args    : [schedulerPro, 'dependenciesDrawn'],
                trigger : () => schedulerPro.scrollable.scrollBy(0, 10)
            },
            () => {
                t.selectorNotExists('.b-sch-dependency[depId="30"]', 'No dependency lines appeared after scroll');
            }
        );
    });

    // https://github.com/bryntum/bryntum-suite/issues/1456
    t.it('Should be possible to edit a task in Scheduler chart', t => {
        createGanttAndSchedulerPro();

        t.chain(
            { waitForPropagate : project },
            { doubleClick : '.b-schedulerpro [data-event-id="115"]', desc : 'Click on an event in Scheduler' },
            { waitForSelector : '.b-gantttaskeditor', desc : 'Editor is shown' },
            () => {
                t.ok(schedulerPro.features.taskEdit.editor.anchoredTo.closest('[data-event-id="115"]'), 'Target element is a corresponding task in Scheduler');
                t.notOk(gantt.features.taskEdit.editor, 'Gantt editor is not active');
            }
        );
    });

    t.it('Should be possible to edit a task in Gantt chart', t => {
        createGanttAndSchedulerPro();

        t.chain(
            { waitForPropagate : project },
            { doubleClick : '.b-gantt [data-task-id="120"]', desc : 'Click on a task in Gantt' },
            { waitForSelector : '.b-gantttaskeditor', desc : 'Editor is shown' },
            () => {
                t.ok(gantt.features.taskEdit.editor.anchoredTo.closest('[data-task-id="120"]'), 'Target element is a corresponding task in Gantt');
                t.notOk(schedulerPro.features.taskEdit.editor, 'SchedulerPro editor is not created');
            }
        );
    });

    t.it('Should be possible to edit a task with no resources in Gantt chart', t => {
        createGanttAndSchedulerPro();

        project.taskStore.rootNode.appendChild(project.taskStore.last.copy(9000));

        t.chain(
            { waitForPropagate : project },
            { doubleClick : '[data-task-id="9000"]', desc : 'Click on the task in Gantt' },
            { waitForSelector : '.b-gantttaskeditor', desc : 'Editor is shown' }
        );
    });

    t.it('Should be possible to double click to create a task in Scheduler', t => {
        createGanttAndSchedulerPro();

        t.chain(
            { doubleClick : '.b-schedulerpro .b-sch-timeaxis-cell', offset : [10, 10] },
            { waitForSelector : '.b-gantttaskeditor', desc : 'Editor is shown' },
            { type : 'foo[ENTER]' },
            { waitForSelector : '.b-schedulerpro .b-sch-event-wrap:contains(foo)', desc : 'New event created' }
        );
    });

    t.it('Should support allowOverlap when TaskStore is used as a store', t => {
        createGanttAndSchedulerPro();

        schedulerPro.allowOverlap = false;
        schedulerPro.zoomToFit();

        t.chain(
            {
                drag     : '.b-schedulerpro .b-sch-event:textEquals(New task 4)',
                to       : '.b-schedulerpro .b-sch-event:textEquals(New task 5)',
                dragOnly : true
            },

            async() => {
                t.selectorExists('.b-tooltip:contains(Event overlaps)', 'Overlaps found');
            },

            { moveCursorBy : [-150, 0] },

            async() => {
                t.selectorNotExists('.b-tooltip:contains(Event overlaps)', 'Overlaps found');
            }
        );
    });

    // https://github.com/bryntum/support/issues/3191
    t.it('Should set correct startDate on dragCreate if gantt project used', async t => {
        createGanttAndSchedulerPro();

        // Wait to make sure UI is not read-only
        await project.commitAsync();

        let startDate;
        schedulerPro.on('dragcreatestart', (event) => {
            startDate = schedulerPro.eventStore.last.startDate;
        });

        await t.dragBy('.b-schedulerpro .b-grid-row[data-index=0] .b-sch-timeaxis-cell', [100, 0], null, null, null, true, [350, '50%']);

        const lastStartDate = schedulerPro.eventStore.last.startDate;
        t.is(lastStartDate, startDate, 'startDate has not changed after event drag');
    });

});
