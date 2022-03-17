"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
    t.setWindowSize(1024, 768);
  });
  t.it('Should change responsive levels', async t => {
    gantt = await t.getGanttAsync({
      columns: [{
        type: 'name',
        field: 'name',
        width: 250
      }, {
        type: 'duration',
        responsiveLevels: {
          small: {
            hidden: true
          },
          medium: {
            hidden: true
          },
          large: {
            hidden: false
          }
        }
      }],
      responsiveLevels: {
        medium: {
          levelWidth: 800
        },
        large: {
          levelWidth: '*'
        }
      }
    });
    t.chain({
      waitForAnimationFrame: null
    }, async () => {
      t.is(gantt.responsiveLevel, 'large', 'Starts as large');
      t.is(gantt.columns.getAt(1).hidden, false, 'Last column not hidden');
    }, {
      waitForEvent: [gantt, 'resize'],
      trigger: () => {
        t.setWindowSize(599, 768);
      }
    }, {
      waitForSelector: '.b-responsive-medium'
    }, async () => {
      t.is(gantt.responsiveLevel, 'medium', 'Changed to medium after resize to 599px');
      t.selectorExists('.b-responsive-medium', 'Styled as medium');
      t.selectorNotExists('.b-responsive-large', 'Not as large');
      t.selectorNotExists('.b-responsive-small', 'And not as small');
      t.is(gantt.columns.getAt(1).hidden, true, 'Last column hidden');
    });
  });
});