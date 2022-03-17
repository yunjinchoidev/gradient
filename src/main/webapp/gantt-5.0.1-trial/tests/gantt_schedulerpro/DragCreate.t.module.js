import { ProjectModel, SchedulerPro } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let schedulerpro;

    t.beforeEach(function() {
        schedulerpro?.destroy();
    });

    // https://github.com/bryntum/support/issues/3190
    t.it('Should support drag creating when using a Gantt project model', async t => {
        const ganttProject = new ProjectModel({
            resourcesData : [{
                id   : 'r1',
                name : 'Buldozer'
            }]
        });

        schedulerpro = new SchedulerPro({
            project    : ganttProject,
            appendTo   : document.body,
            startDate  : new Date(2019, 0, 1),
            endDate    : new Date(2019, 0, 31),
            viewPreset : 'weekAndMonth',
            features   : {
                taskEdit : false
            },

            columns : [
                { text : 'Name', field : 'name', width : 130 }
            ]
        });

        t.is(schedulerpro.store, schedulerpro.resourceStore, 'ResourceStore setup correctly');

        t.chain(
            { waitForProjectReady : schedulerpro, desc : 'Wait for project ready' },
            { drag : '.b-grid-row[data-index=0] .b-sch-timeaxis-cell', offset : [50, '50%'], by : [100, 0] },
            { waitForProjectReady : schedulerpro, desc : 'Wait for project ready' },
            () => {
                t.is(schedulerpro.taskStore.count, 1, '1 task added');
                t.is(schedulerpro.taskStore.first.isCreating, false, 'isCreating correct');
            }
        );
    });
});
