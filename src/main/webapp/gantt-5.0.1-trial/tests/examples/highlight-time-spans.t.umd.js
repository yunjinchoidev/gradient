"use strict";

StartTest(async t => {
  const gantt = window.gantt;
  await t.waitForRowsVisible(gantt);
  gantt.features.percentBar.disabled = gantt.features.taskResize.disabled = gantt.features.taskResize.dependencies = true;
  gantt.scrollManager.startScrollDelay = 1000;
  t.it('Should highlight start / end delivery window of an event', async t => {
    gantt.zoomToFit();
    await t.click('button:contains(Highlight)');
    await t.waitForSelectorCount('.b-sch-highlighted-range', 2);
    t.pass('2 ranges rendered initially');
    const highlightDivs = t.query('.b-sch-highlighted-range');
    t.isApproxPx(highlightDivs[0].offsetWidth, 2 * gantt.tickSize, 'First span correct width');
    t.isApproxPx(highlightDivs[1].offsetWidth, 2 * gantt.tickSize, 'Second span correct width');
    await t.dragBy({
      source: '[data-task-id="11"]',
      delta: [-50, 0],
      dragOnly: true
    });
    await t.waitForSelectorCount('.b-sch-highlighted-range', 1);
    t.pass('1 highlight range rendered');
    const highlightDivRect = t.rect('.b-sch-highlighted-range:contains(Project boundaries)');
    t.isApproxPx(highlightDivRect.left, gantt.getCoordinateFromDate(gantt.project.startDate, false), 'Correct highlight left');
    t.isApproxPx(highlightDivRect.right, gantt.getCoordinateFromDate(gantt.project.endDate, false), 'Correct highlight right');
    let eventRect = t.rect('.b-dragging');
    t.isApproxPx(eventRect.left, gantt.getCoordinateFromDate(gantt.project.startDate, false), 'Task constrained to the left');
    await t.moveCursorBy([780, 0]);
    eventRect = t.rect('.b-dragging');
    t.isApproxPx(eventRect.right, gantt.getCoordinateFromDate(gantt.project.endDate, false), 'Task constrained to the right');
    await t.mouseUp();
    await t.click('button:contains(Cancel)');
    await t.waitForSelectorNotFound('.b-sch-highlighted-range');
  });
  t.it('Should highlight task boundaries', async t => {
    gantt.zoomToFit();
    await t.click('[data-ref="surroundCheckbox"] input');
    await t.dragBy({
      source: '[data-task-id="11"]',
      delta: [-50, 0],
      dragOnly: true
    });
    await t.waitForSelectorCount('.b-sch-highlighted-range.b-unavailable', 2);
    let eventRect = t.rect('.b-dragging');
    t.isApproxPx(eventRect.left, gantt.getCoordinateFromDate(gantt.project.startDate, false), 'Task constrained to the left');
    await t.moveCursorBy([780, 0]);
    eventRect = t.rect('.b-dragging');
    t.isApproxPx(eventRect.right, gantt.getCoordinateFromDate(gantt.project.endDate, false), 'Task constrained to the right');
    await t.mouseUp();
    await t.click('button:contains(Cancel)');
    await t.waitForSelectorNotFound('.b-sch-highlighted-range');
  });
});