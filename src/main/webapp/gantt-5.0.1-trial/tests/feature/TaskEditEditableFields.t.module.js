import { TaskModel } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let gantt;

    t.beforeEach(() => gantt?.destroy());

    t.it('Task editor takes into account task.isEditable() method result when disabling fields', t => {

        class MyTaskModel extends TaskModel {
            isEditable(fieldName) {
                if (this.id === 1) return false;
                if (this.id === 2) return true;
            }
        }

        gantt = t.getGantt({
            project : {
                taskModelClass : MyTaskModel,
                tasksData      : [
                    {
                        id        : 1,
                        startDate : '2020-12-11',
                        duration  : 1
                    },
                    {
                        id        : 2,
                        startDate : '2020-12-11',
                        duration  : 1
                    }
                ]
            },
            features : {
                taskTooltip : false
            }
        });

        t.chain(
            { diag : 'Asserting all fields are disabled for task #1' },

            { dblClick : '[data-task-id="1"]' },

            { waitForSelector : '.b-taskeditor' },

            async() => {
                Object.entries(gantt.features.taskEdit.editor.widgetMap).forEach(([ref, widget]) => {
                    if (widget.isField) {
                        t.ok(widget.disabled, `${ref} disabled`);
                    }
                });
            },

            { click : '.b-popup-close' },

            { waitForSelectorNotFound : '.b-taskeditor' },

            { diag : 'Asserting all fields are enabled for task #2' },

            { dblClick : '[data-task-id="2"]' },

            { waitForSelector : '.b-taskeditor' },

            () => {
                Object.entries(gantt.features.taskEdit.editor.widgetMap).forEach(([ref, widget]) => {
                    if (widget.isField) {
                        t.notOk(widget.disabled, `${ref} disabled`);
                    }
                });
            }

        );
    });

});
