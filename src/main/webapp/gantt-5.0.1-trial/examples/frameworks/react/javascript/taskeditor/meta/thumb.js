/* global bryntum */
const gantt   = bryntum.query('Gantt');
gantt.editTask(gantt.taskStore.getById(23));

// raise flag for thumb generator indicating page is ready for taking screenshot
window.__thumb_ready = true;
