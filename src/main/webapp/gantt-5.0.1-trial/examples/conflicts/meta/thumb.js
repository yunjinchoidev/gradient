/* global gantt */

gantt.eventStore.getById(11).shift(1, 'hour');

gantt.project.await('schedulingConflict').then(function() {
    window.__thumb_ready = true;
});
