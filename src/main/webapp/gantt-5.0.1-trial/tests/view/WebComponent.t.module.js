
StartTest(t => {
    let cmp;

    t.mockUrl('data.json', {
        delay        : 0,
        responseText : JSON.stringify({
            success   : true,
            resources : {
                rows : [
                    { id : 'a', name : 'Mystery man' }
                ]
            },
            assignments : {
                rows : [
                    {
                        id       : 'a1',
                        resource : 'a',
                        event    : 1
                    }
                ]
            },
            tasks : {
                rows : [
                    {
                        id        : 1,
                        name      : 'Bridge repair',
                        startDate : '2019-01-13T08:00:00',
                        duration  : 4
                    }
                ]
            }
        })
    });

    t.beforeEach(t => {
        cmp && cmp.remove();

        document.body.innerHTML = `
            <bryntum-gantt 
                stylesheet="../build/gantt.stockholm.css?457330" 
                data-view-preset="weekAndDayLetter" 
                data-start-date="2019-01-13" 
                data-end-date="2019-03-17" 
                data-dependency-id-field="sequenceNumber"
            >
                <column data-type="name" data-width="250">Name</column>
                <column data-type="startdate">Start</column>
                <column data-type="duration">Duration</column>
                <column data-type="addnew"></column>
                <project data-load-url="data.json"></project>
                <feature data-name="nonWorkingTime"></feature>
            </bryntum-gantt>`;

        cmp = document.body.querySelector('bryntum-gantt');
    });

    t.it('Should not trigger DragHelper#mousedown when clicking outside web component root', async t => {
        document.body.style.padding = '10em';
        await t.waitForSelector('bryntum-gantt -> .b-gantt-task');

        const spy = t.spyOn(cmp.widget.features.percentBar.drag.constructor.prototype, 'onMouseDown');
        await t.click('body', null, null, null, [1, 1]);

        t.expect(spy).not.toHaveBeenCalled();
    });

    t.it('Should show task tooltip in ShadowRoot´s float root', async t => {
        await t.moveCursorTo([1, 1]);

        cmp = document.querySelector('gantt');

        await t.waitForSelector('bryntum-gantt -> [data-task-id="1"]');
        await t.waitForSelectorNotFound('bryntum-gantt -> .b-mask');

        await t.moveCursorTo('bryntum-gantt -> [data-task-id="1"]');
        await t.waitForSelector('bryntum-gantt -> .b-float-root .b-tooltip');
    });

    t.it('Should show task editor in ShadowRoot´s float root', async t => {
        await t.doubleClick('bryntum-gantt -> [data-task-id="1"]');
        await t.waitForSelector('bryntum-gantt -> .b-float-root .b-taskeditor');
    });
});
