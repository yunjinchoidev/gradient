"use strict";

StartTest(t => {
  t.it('Check German locale', t => {
    t.chain( // assume default language is German
    {
      waitForSelector: '[data-column="name"] .b-grid-header-text:textEquals(Vorgangsname)',
      desc: 'Column is written in German'
    }, {
      moveCursorTo: '[data-task-id="11"] .b-gantt-task'
    }, {
      waitForSelector: '.b-gantt-task-tooltip :textEquals(Beginnt:)',
      desc: 'Tooltip is written in German'
    }, {
      dblClick: '[data-task-id="11"] .b-gantt-task'
    }, {
      waitForSelector: '.b-taskeditor :textEquals(Abgeschlossen in Prozent)',
      desc: 'Editor is written in German'
    }, {
      click: '.b-taskeditor .b-popup-close'
    }, {
      click: '.b-button[data-ref=infoButton]'
    }, {
      click: '.b-combo[data-ref=localeCombo] input'
    }, // Switch to English locale
    {
      click: '.b-list :textEquals(English)'
    }, {
      waitForSelector: '[data-column="name"] .b-grid-header-text:textEquals(Name)',
      desc: 'Column is written in English'
    }, {
      moveCursorTo: '[data-task-id="11"] .b-gantt-task',
      offset: ['99%', '50%']
    }, {
      waitForSelector: '.b-gantt-task-tooltip :textEquals(Start:)',
      desc: 'Tooltip is written in English'
    }, {
      dblClick: '[data-task-id="11"] .b-gantt-task'
    }, {
      waitForSelector: '.b-taskeditor :textEquals(% complete)',
      desc: 'Editor is written in English'
    });
  });
  t.it('Check all locales', async t => {
    await t.click('[data-ref=infoButton]');

    for (const locale of ['English', 'Nederlands', 'Svenska', 'Русский', 'Deutsch']) {
      t.diag(`Checking locale ${locale}`);
      const value = document.querySelector('[data-ref=localeCombo] input').value; // Change to the locale if necessary

      if (value !== locale) {
        await t.click('[data-ref=localeCombo] input');
        await t.click(`.b-list-item:contains(${locale})`); // Change triggers hide of the info popup

        await t.waitForSelectorNotFound('[data-ref=localeCombo] input'); // Show the info popup again

        await t.click('[data-ref=infoButton]'); // This must exist

        await t.waitForSelector('.info-popup .b-checkbox');
      }

      await t.moveMouseTo('.info-popup .b-checkbox');
      await t.waitForSelector('.b-tooltip-shared');
      t.contentNotLike('.b-tooltip-shared', /L{/, 'Tooltip is localized');
    }
  });
});