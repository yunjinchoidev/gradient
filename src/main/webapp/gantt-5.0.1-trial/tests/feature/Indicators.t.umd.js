"use strict";

StartTest(t => {
  let gantt, gantt2, project;
  t.beforeEach(t => {
    project && project.destroy();
    gantt && gantt.destroy();
    gantt2 && gantt2.destroy();
  });

  async function createGantt(config = {}) {
    project = new ProjectModel({
      tasksData: [{
        id: 1,
        name: 'Task 1',
        expanded: true,
        startDate: '2020-02-24',
        children: [{
          id: 11,
          name: 'Task 11',
          startDate: '2020-02-24',
          duration: 2,
          constraintDate: '2020-02-24',
          constraintType: 'muststarton'
        }, {
          id: 12,
          name: 'Task 12',
          startDate: '2020-02-24',
          duration: 2,
          deadlineDate: '2020-03-05'
        }, {
          id: 13,
          name: 'Task 13',
          startDate: '2020-02-24',
          duration: 2
        }, {
          id: 14,
          name: 'Task 14',
          startDate: '2020-02-24',
          duration: 2
        }]
      }],
      dependenciesData: [{
        fromEvent: 11,
        toEvent: 12
      }, {
        fromEvent: 12,
        toEvent: 13
      }, {
        fromEvent: 13,
        toEvent: 14
      }]
    });
    gantt = t.getGantt(Object.assign({
      features: {
        indicators: true
      },
      rowHeight: 50,
      barMargin: 15,
      enableEventAnimations: false,
      startDate: '2020-02-24',
      project
    }, config));
    await project.commitAsync();
  }

  t.it('Should render default indicators', async t => {
    await createGantt();
    t.selectorExists('.b-indicator.b-early-dates', 'Early start/end date indicator rendered');
    t.selectorExists('.b-indicator.b-late-dates', 'Late start/end date indicator renderred');
    t.selectorExists('.b-indicator.b-constraint-date', 'Constraint date indicator rendered');
    t.selectorExists('.b-indicator.b-deadline-date', 'Deadline indicator rendered');
  });
  t.it('Should render custom indicators', async t => {
    await createGantt({
      features: {
        indicators: {
          items: {
            beer: taskRecord => ({
              startDate: taskRecord.startDate,
              name: 'Beer',
              iconCls: 'b-fa b-fa-beer'
            })
          }
        }
      }
    });
    t.selectorCountIs('.b-indicator .b-fa-beer', gantt.taskStore.count, 'Custom indicators rendered');
  });
  t.it('Should allow toggling indicators', async t => {
    await createGantt({
      features: {
        indicators: {
          items: {
            earlyDates: false,
            beer: taskRecord => ({
              startDate: taskRecord.startDate,
              name: 'Dog',
              iconCls: 'b-fa b-fa-dog'
            })
          }
        }
      }
    });
    t.chain(next => {
      t.selectorNotExists('.b-early-dates', 'Early dates not rendered');
      gantt.features.indicators.items.earlyDates = true;
      gantt.features.indicators.items.beer = false;
      next();
    }, {
      waitForSelector: '.b-early-dates',
      desc: 'Early dates rendered'
    }, {
      waitForSelectorNotFound: '.b-indicator .b-fa-dog',
      desc: 'Custom not rendered'
    });
  });
  t.it('Should update UI on data changes', async t => {
    await createGantt();
    const constraintElement = document.querySelector('.b-indicator.b-constraint-date'),
          deadlineElement = document.querySelector('.b-indicator.b-deadline-date'),
          constraintBox = Rectangle.from(constraintElement),
          deadlineBox = Rectangle.from(deadlineElement);
    t.diag('Changing constraint and deadline dates');
    gantt.taskStore.getById(11).constraintDate = '2020-02-25';
    gantt.taskStore.getById(12).deadlineDate = '2020-03-06';
    await project.commitAsync();
    const deltaConstraint = constraintBox.getDelta(Rectangle.from(constraintElement)),
          deltaDeadline = deadlineBox.getDelta(Rectangle.from(deadlineElement));
    t.selectorCountIs('.b-indicator.b-constraint-date', 1, 'Single constraint indicator');
    t.selectorCountIs('.b-indicator.b-deadline-date', 1, 'Single deadline indicator');
    t.is(document.querySelector('.b-indicator.b-constraint-date'), constraintElement, 'Constraint element reused');
    t.is(document.querySelector('.b-indicator.b-deadline-date'), deadlineElement, 'Deadline element reused');
    t.isApprox(deltaConstraint[0], gantt.tickSize, 0.5, 'Constraint did move correct distance horizontally');
    t.is(deltaConstraint[1], 0, 'Constraint did not move vertically');
    t.isApprox(deltaDeadline[0], gantt.tickSize, 'Deadline did move correct distance horizontally');
    t.is(deltaDeadline[1], 0, 'Deadline did not move vertically');
    t.diag('Nulling deadline date');
    gantt.taskStore.getById(12).deadlineDate = null;
    t.selectorNotExists('.b-indicator.b-deadline-date', 'No deadline indicator');
  });
  t.it('Should not show point-in-time indicators that are outside time axis', async t => {
    await createGantt({
      project: {
        tasksData: [{
          id: 11,
          name: 'Task 11',
          startDate: '2020-03-01',
          duration: 2,
          constraintDate: '2020-03-01',
          constraintType: 'muststarton'
        }]
      },
      features: {
        indicators: {
          items: {
            earlyDates: false,
            beer: taskRecord => ({
              startDate: new Date(2020, 1, 22),
              name: 'Dog',
              iconCls: 'b-fa b-fa-dog'
            })
          }
        }
      }
    });
    t.selectorNotExists('.b-indicator .b-fa-dog', 'Indicators outside axis not rendered');
  });
  t.it('Should show point-in-time indicators that are inside time axis', async t => {
    await createGantt({
      project: {
        tasksData: [{
          id: 11,
          name: 'Task 11',
          startDate: '2020-03-01',
          duration: 2,
          constraintDate: '2020-03-01',
          constraintType: 'muststarton'
        }]
      },
      features: {
        indicators: {
          items: {
            earlyDates: false,
            beer: () => ({
              startDate: new Date(2020, 2, 11),
              iconCls: 'b-fa b-fa-beer',
              name: 'Post-task celebration beer'
            })
          }
        }
      }
    });
    t.chain(next => {
      gantt.shiftNext(2);
      next();
    }, {
      waitForSelectorNotFound: gantt.unreleasedEventSelector + ' .b-task-percent-bar',
      desc: 'Task bar is not showing because is outside of the time axis.'
    }, {
      waitForSelector: '.b-indicator .b-fa-beer',
      desc: 'Indicators inside axis rendered because is inside of the time axis'
    });
  });
  t.it('Should show task bar inside time axis and hide indicator that is outside of the time axis', async t => {
    await createGantt({
      project: {
        tasksData: [{
          id: 11,
          name: 'Task 11',
          startDate: '2020-03-01',
          duration: 2,
          constraintDate: '2020-03-01',
          constraintType: 'muststarton'
        }]
      },
      features: {
        indicators: {
          items: {
            earlyDates: false,
            beer: () => ({
              startDate: new Date(2020, 1, 25),
              name: 'Before the task, walk with dog',
              iconCls: 'b-fa b-fa-dog'
            })
          }
        }
      }
    });
    t.chain(next => {
      gantt.shiftNext();
      next();
    }, {
      waitForSelectorNotFound: '.b-indicator .b-fa-dog',
      desc: 'Indicators is not rendered because is outside of the time axis'
    }, {
      waitForSelector: '.b-task-percent-bar',
      desc: 'Task bar is showing because still is inside of the time axis.'
    });
  }); // https://github.com/bryntum/support/issues/3032

  t.it('Should support providing tooltipTemplate function to provide content to tooltip', async t => {
    await createGantt({
      project: {
        tasksData: [{
          id: 11,
          name: 'Task 11',
          startDate: '2020-03-01',
          duration: 2,
          constraintDate: '2020-03-01',
          constraintType: 'muststarton'
        }]
      },
      features: {
        indicators: {
          items: {
            earlyDates: false,
            beer: () => ({
              startDate: new Date(2020, 1, 25),
              name: 'Dog',
              iconCls: 'b-fa b-fa-dog'
            })
          },

          tooltipTemplate({
            indicator
          }) {
            t.is(indicator.startDate, new Date(2020, 1, 25), 'startDate provided');
            t.is(indicator.name, 'Dog', 'name provided');
            t.is(indicator.taskRecord.id, 11, 'task record provided');
            return 'foo';
          }

        }
      }
    });
    await t.moveCursorTo('.b-fa-dog');
    await t.waitForSelector('.b-tooltip:contains(foo)');
  });
  t.it('Should html encode name in default tooltip template', async t => {
    await createGantt({
      project: {
        tasksData: [{
          id: 11,
          name: 'Task 11',
          startDate: '2020-03-01',
          duration: 2,
          constraintDate: '2020-03-01',
          constraintType: 'muststarton'
        }]
      },
      features: {
        indicators: {
          items: {
            earlyDates: false,
            beer: () => ({
              startDate: new Date(2020, 1, 25),
              name: 'Dog <img src="evil" onerror="foo()"/>',
              iconCls: 'b-fa b-fa-dog'
            })
          }
        }
      }
    });
    await t.moveCursorTo('.b-fa-dog');
    await t.waitForSelector('.b-tooltip');
    t.selectorNotExists('.b-tooltip img', 'Tooltip should show html encoded name');
    t.selectorExists('.b-indicator[data-task-record-id="11"]', 'taskRecordId should be embedded in the dataset of the indicator element');
  });
  t.it('Should respect `disabled` state', async t => {
    await createGantt({
      height: 200,
      features: {
        indicators: {
          disabled: true
        }
      },
      project: {
        tasksData: [{
          id: 11,
          name: 'Task 11',
          startDate: '2020-03-01',
          duration: 2,
          constraintDate: '2020-03-01',
          constraintType: 'muststarton'
        }]
      }
    });
    t.selectorNotExists('.b-indicator', 'No indicators rendered when feature is disabled');
  }); // https://github.com/bryntum/support/issues/3365

  t.it('Should not mutate config object, since it might be reused', async t => {
    const features = {
      indicators: {
        items: {
          earlyDates: false,
          constraintDate: false,
          lateDates: false,
          deadlineDate: false
        }
      }
    };
    await createGantt({
      height: 200,
      features,
      project: {
        tasksData: [{
          id: 11,
          name: 'Task 11',
          startDate: '2020-03-01',
          duration: 2,
          constraintDate: '2020-03-01',
          constraintType: 'muststarton'
        }]
      }
    });
    gantt2 = await t.getGantt({
      height: 200,
      features,
      startDate: '2020-02-24',
      project: {
        tasksData: [{
          id: 11,
          name: 'Task 11',
          startDate: '2020-03-01',
          duration: 2,
          constraintDate: '2020-03-01',
          constraintType: 'muststarton'
        }]
      }
    });
    t.selectorNotExists('.b-indicator', 'No indicators seen');
  });
});