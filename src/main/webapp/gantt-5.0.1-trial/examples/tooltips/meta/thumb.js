/* global gantt */
const
    el  = document.querySelector('.b-gantt-task-wrap'),
    tip = gantt.features.taskTooltip.tooltip;

tip.activeTarget = el;
tip.updateContent();
tip.showBy(el);
// raise flag for thumb generator indicating page is ready for taking screenshot
window.__thumb_ready = true;
