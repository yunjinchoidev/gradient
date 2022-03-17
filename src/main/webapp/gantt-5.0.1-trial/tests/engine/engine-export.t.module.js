/* eslint-disable no-undef */
//This test is only for module/umd testing and doesn't require imports

StartTest(t => {

    t.it('Scheduler Pro Engine classes are exported from bundle', t => {
        t.ok(SchedulerProProjectMixin, 'SchedulerProProjectMixin is exported');
        t.ok(ConstrainedEarlyEventMixin, 'ConstrainedEarlyEventMixin is exported');
        t.ok(HasDateConstraintMixin, 'HasDateConstraintMixin is exported');
        t.ok(HasPercentDoneMixin, 'HasPercentDoneMixin is exported');
        t.ok(ScheduledByDependenciesEarlyEventMixin, 'ScheduledByDependenciesEarlyEventMixin is exported');
        t.ok(SchedulerProAssignmentMixin, 'SchedulerProAssignmentMixin is exported');
        t.ok(SchedulerProDependencyMixin, 'SchedulerProDependencyMixin is exported');
        t.ok(SchedulerProEvent, 'SchedulerProEvent is exported');
        t.ok(SchedulerProHasAssignmentsMixin, 'SchedulerProHasAssignmentsMixin is exported');
        t.ok(SchedulerProResourceMixin, 'SchedulerProResourceMixin is exported');
    });

    t.it('Gantt Engine classes are exported from bundle', t => {
        t.ok(GanttProjectMixin, 'GanttProjectMixin is exported');
        t.ok(ConstrainedByParentMixin, 'ConstrainedByParentMixin is exported');
        t.ok(ConstrainedLateEventMixin, 'ConstrainedLateEventMixin is exported');
        t.ok(GanttAssignmentMixin, 'GanttAssignmentMixin is exported');
        t.ok(GanttEvent, 'GanttEvent is exported');
        t.ok(GanttHasAssignmentsMixin, 'GanttHasAssignmentsMixin is exported');
        t.ok(HasCriticalPathsMixin, 'HasCriticalPathsMixin is exported');
        t.ok(HasEffortMixin, 'HasEffortMixin is exported');
        t.ok(HasSchedulingModeMixin, 'HasSchedulingModeMixin is exported');
        t.ok(ScheduledByDependenciesLateEventMixin, 'ScheduledByDependenciesLateEventMixin is exported');
        t.ok(FixedDurationMixin, 'FixedDurationMixin is exported');
        t.ok(FixedEffortMixin, 'FixedEffortMixin is exported');
        t.ok(FixedUnitsMixin, 'FixedUnitsMixin is exported');
    });

});
