"use strict";

StartTest(t => {
  let editor, gantt;
  t.beforeEach((t, next) => {
    var _editor, _gantt;

    (_editor = editor) === null || _editor === void 0 ? void 0 : _editor.destroy();
    (_gantt = gantt) === null || _gantt === void 0 ? void 0 : _gantt.destroy(); // Wait for locales to load

    t.waitFor(() => window.bryntum.locales, next);
  });
  t.describe('Should localize TaskEditor', t => {
    Object.keys(window.bryntum.locales).forEach(name => {
      t.it(`${name} locale is ok`, async t => {
        editor = new TaskEditor({
          appendTo: document.body
        }); // editor.show();

        const locale = t.applyLocale(name);
        const tabs = editor.widgetMap.tabs.tabBar.tabs;
        t.is(tabs[0].text, locale.GeneralTab.General, 'General tab localization is ok');
        t.is(tabs[1].text, locale.DependencyTab.Predecessors, 'Predecessors tab localization is ok');
        t.is(tabs[2].text, locale.DependencyTab.Successors, 'Successors tab localization is ok');
        t.is(tabs[3].text, locale.ResourcesTab.Resources, 'Resources tab localization is ok');
        t.is(tabs[4].text, locale.AdvancedTab.Advanced, 'Advanced tab localization is ok');
        t.is(tabs[5].tooltipText, locale.NotesTab.Notes, 'Notes tab localization is ok');
        t.is(document.querySelector('.b-gantt-taskeditor .b-header-title').textContent, locale.TaskEditorBase.Information, 'Information currentLocale is ok');
        t.is(editor.widgetMap.saveButton.element.textContent, locale.TaskEditorBase.Save, 'Save button currentLocale is ok');
        t.is(editor.widgetMap.cancelButton.element.textContent, locale.TaskEditorBase.Cancel, 'Cancel button currentLocale is ok');
      });
    });
  });
  t.it('Should update task editor date pickers weekStartDay on switching locales', t => {
    gantt = t.getGantt({
      features: {
        taskTooltip: false
      }
    });
    t.chain({
      waitForRowsVisible: gantt
    }, async () => {
      const locale = t.applyLocale('En');
      t.is(locale.DateHelper.weekStartDay, 0, 'English week starts from Sunday');
    }, {
      doubleClick: '[data-task-id="11"]'
    }, {
      click: '.b-pickerfield[data-ref="startDate"] .b-icon-calendar'
    }, {
      waitForSelector: '.b-calendar-day-header[data-column-index="0"][data-cell-day="0"]',
      desc: 'Start date: Week starts with correct day'
    }, {
      type: '[ESC]'
    }, {
      click: '.b-pickerfield[data-ref="endDate"] .b-icon-calendar'
    }, {
      waitForSelector: '.b-calendar-day-header[data-column-index="0"][data-cell-day="0"]',
      desc: 'End date: Week starts with correct day'
    }, {
      type: '[ESC]'
    }, async () => {
      const locale = t.applyLocale('Ru');
      t.is(locale.DateHelper.weekStartDay, 1, 'Russian week starts from Monday');
    }, // Make sure UI transformation is finished when the new editor width specified for Russian locale is applied
    {
      waitForAnimationFrame: null
    }, {
      click: '.b-pickerfield[data-ref="startDate"] .b-icon-calendar'
    }, {
      waitForSelector: '.b-calendar-day-header[data-column-index="0"][data-cell-day="1"]',
      desc: 'Start date: Week starts with correct day'
    }, {
      type: '[ESC]'
    }, {
      click: '.b-pickerfield[data-ref="endDate"] .b-icon-calendar'
    }, {
      waitForSelector: '.b-calendar-day-header[data-column-index="0"][data-cell-day="1"]',
      desc: 'End date: Week starts with correct day'
    });
  });
  t.it('Should localize TaskEditor width', t => {
    Object.keys(window.bryntum.locales).forEach(name => {
      t.it(`Checking ${name} locale`, t => {
        const locale = t.applyLocale(name),
              eventEditorWidth = locale.TaskEditorBase.editorWidth;

        if (/em/.test(eventEditorWidth)) {
          const size = parseInt(eventEditorWidth),
                fontSize = parseInt(window.getComputedStyle(editor.element).fontSize),
                expectedWidth = size * fontSize;
          t.is(editor.width, expectedWidth, 'Width is properly localized');
        }
      });
    });
  });
});