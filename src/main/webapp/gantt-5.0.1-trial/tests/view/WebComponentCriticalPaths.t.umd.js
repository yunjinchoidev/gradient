"use strict";

StartTest(t => {
  let cmp;
  t.mockUrl('data.json', {
    delay: 0,
    responseText: JSON.stringify({
      tasks: {
        rows: [{
          id: 1,
          name: 'task1',
          startDate: '2021-08-30',
          duration: 1
        }, {
          id: 2,
          name: 'task2',
          startDate: '2021-08-31',
          duration: 1
        }]
      },
      dependencies: {
        rows: [{
          id: 1,
          from: 1,
          to: 2
        }]
      }
    })
  });
  t.beforeEach(t => {
    var _cmp;

    return (_cmp = cmp) === null || _cmp === void 0 ? void 0 : _cmp.remove();
  }); // https://github.com/bryntum/support/issues/3346

  t.it('Should render critical paths', async t => {
    document.body.innerHTML = `
            <bryntum-gantt
                stylesheet="../build/gantt.stockholm.css"
                data-start-date="2021-08-30"
                data-end-date="2021-09-02"
            >
                <project data-load-url="data.json"></project>
                <feature data-name="criticalPaths" data-disabled="false"></feature>
            </bryntum-gantt>`;
    cmp = document.body.querySelector('bryntum-gantt');
    await t.waitForSelector('bryntum-gantt -> .b-gantt.b-gantt-critical-paths');
    t.pass('Critical path feature CSS class is added');
    await t.waitForSelector('bryntum-gantt -> .b-sch-dependency.b-critical');
    t.pass('Dependency got highlighted');
    await t.waitForSelector('bryntum-gantt -> .b-gantt-task.b-critical');
    t.pass('Critical tasks are highlighted');
  });
});