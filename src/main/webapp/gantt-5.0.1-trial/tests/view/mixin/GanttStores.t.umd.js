"use strict";

StartTest(t => {
  let gantt;
  t.beforeEach(() => {
    var _gantt;

    return (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy();
  }); // https://github.com/bryntum/support/issues/4043

  t.it('Framework friendly configs and properties should work', async t => {
    const tasksData = [{
      id: 1,
      name: 'Task 1',
      startDate: new Date(2020, 0, 17),
      duration: 2,
      durationUnit: 'd'
    }, {
      id: 2,
      name: 'Task 2',
      startDate: new Date(2020, 0, 18),
      duration: 2,
      durationUnit: 'd'
    }, {
      id: 3,
      name: 'Task 3',
      startDate: new Date(2020, 0, 19),
      endDate: new Date(2020, 0, 22)
    }],
          resourcesData = [{
      id: 1,
      name: 'Resource 1'
    }, {
      id: 2,
      name: 'Resource 2'
    }],
          assignmentsData = [{
      id: 1,
      taskId: 1,
      resourceId: 1
    }, {
      id: 2,
      taskId: 1,
      resourceId: 2
    }, {
      id: 3,
      taskId: 2,
      resourceId: 2
    }],
          timeRangesData = [{
      id: 1,
      name: 'Range 1',
      startDate: new Date(2020, 0, 17),
      duration: 2,
      durationUnit: 'd'
    }],
          dependenciesData = [{
      id: 1,
      from: 1,
      to: 2
    }],
          calendarsData = [{
      id: 1,
      startDate: new Date(2020, 0, 17),
      endDate: new Date(2020, 0, 19),
      isWorking: true
    }];
    gantt = new Gantt({
      tasks: tasksData,
      assignments: assignmentsData,
      resources: resourcesData,
      dependencies: dependenciesData,
      timeRanges: timeRangesData,
      calendars: calendarsData
    });
    const {
      project
    } = gantt;
    await project.commitAsync();
    t.is(project.taskStore.count, tasksData.length, 'TaskStore populated');
    t.is(project.assignmentStore.count, assignmentsData.length, 'AssignmentStore populated');
    t.is(project.resourceStore.count, resourcesData.length, 'ResourceStore populated');
    t.is(project.dependencyStore.count, dependenciesData.length, 'DependencyStore populated');
    t.is(project.timeRangeStore.count, timeRangesData.length, 'TimeRangeStore populated');
    t.is(project.calendarManagerStore.count, calendarsData.length, 'CalendarManagerStore populated');
    t.is(gantt.tasks, project.taskStore.records, 'tasks getter');
    t.is(gantt.assignments, project.assignmentStore.records, 'assignments getter');
    t.is(gantt.resources, project.resourceStore.records, 'resources getter');
    t.is(gantt.dependencies, project.dependencyStore.records, 'dependencies getter');
    t.is(gantt.timeRanges, project.timeRangeStore.records, 'timeRanges getter');
    t.is(gantt.calendars, project.calendarManagerStore.records, 'calendars getter');
    Object.assign(gantt, {
      tasks: [],
      assignments: [],
      resources: [],
      dependencies: [],
      timeRanges: [],
      calendars: []
    });
    await project.commitAsync();
    t.is(project.taskStore.count, 0, 'tasks setter');
    t.is(project.assignmentStore.count, 0, 'assignments setter');
    t.is(project.resourceStore.count, 0, 'resources setter');
    t.is(project.dependencyStore.count, 0, 'dependencies setter');
    t.is(project.timeRangeStore.count, 0, 'timeRanges setter');
    t.is(project.calendarManagerStore.count, 0, 'calendars setter');
    Object.assign(gantt, {
      tasks: tasksData,
      assignments: assignmentsData,
      resources: resourcesData,
      dependencies: dependenciesData,
      timeRanges: timeRangesData,
      calendars: calendarsData
    });
    await project.commitAsync();
    t.is(project.taskStore.count, tasksData.length, 'TaskStore repopulated');
    t.is(project.assignmentStore.count, assignmentsData.length, 'AssignmentStore repopulated');
    t.is(project.resourceStore.count, resourcesData.length, 'ResourceStore repopulated');
    t.is(project.dependencyStore.count, dependenciesData.length, 'DependencyStore repopulated');
    t.is(project.timeRangeStore.count, timeRangesData.length, 'TimeRangeStore repopulated');
    t.is(project.calendarManagerStore.count, calendarsData.length, 'CalendarManagerStore repopulated');
  });
});