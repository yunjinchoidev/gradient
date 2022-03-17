"use strict";

/**
 * Angular Test demo test
 */
StartTest(t => {
  t.it('Rendering', t => {
    t.chain({
      waitForSelector: '.b-gantt'
    });
  });
  t.it('Project Events', t => {
    const gantt = bryntum.query(widget => widget.$$name === 'Gantt');
    const {
      project
    } = gantt;
    project.loadInlineData({
      tasksData: [{
        name: 'Test task',
        startDate: new Date(2020, 11, 21),
        duration: 10,
        durationUnit: 'd',
        resourceId: 1
      }],
      resourcesData: [{
        id: 1,
        name: 'Resource 1'
      }]
    }); // Project events must be fired when they are defined inline.
    // The inline listeners of the example add these selectors

    t.chain({
      waitForSelector: '.b-test-progress'
    }, {
      waitForSelector: '.b-test-load'
    });
  });
});