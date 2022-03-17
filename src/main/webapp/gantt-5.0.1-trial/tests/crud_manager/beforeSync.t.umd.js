"use strict";

/* globals ProjectModel */
StartTest(t => {
  let project;
  t.beforeEach(() => {
    var _project;

    return (_project = project) === null || _project === void 0 ? void 0 : _project.destroy();
  }); // https://github.com/bryntum/support/issues/520

  t.it('Should not crash on sync if canceled', async t => {
    t.mockUrl('load', {
      responseText: JSON.stringify({
        success: true,
        tasks: {
          rows: [{
            id: 1,
            leaf: true,
            startDate: '2020-03-17',
            duration: 2
          }]
        }
      })
    });
    project = new ProjectModel({
      silenceInitialCommit: false,
      transport: {
        load: {
          url: 'load'
        },
        sync: {
          url: 'sync'
        }
      }
    });
    await project.load();
    project.on({
      beforeSync() {
        return false;
      }

    });
    t.firesOnce(project, 'syncCanceled', 'Canceled event fired');
    let error = 0;
    await project.sync().catch(e => {
      error++;
      t.fail('Error is captured');
    });
    t.is(error, 0, 'No errors captured');
  });
  t.it('Should crash on sync if not canceled', async t => {
    t.mockUrl('load', {
      responseText: JSON.stringify({
        success: true,
        tasks: {
          rows: [{
            id: 1,
            leaf: true,
            startDate: '2020-03-17',
            duration: 2
          }]
        }
      })
    });
    project = new ProjectModel({
      silenceInitialCommit: false,
      transport: {
        load: {
          url: 'load'
        },
        sync: {
          url: 'sync'
        }
      }
    });
    await project.load();
    t.wontFire(project, 'syncCanceled', 'Sync not canceled');
    let error = 0;
    await project.sync().catch(e => {
      error++;
      t.pass('Error is captured');
    });
    t.is(error, 1, 'One error captured');
  });
});