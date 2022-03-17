"use strict";

StartTest(t => {
  const taskSelector = '[data-task-id="11"]';
  t.it('Rendering', t => {
    t.chain({
      waitForSelector: '.b-gantt'
    }, {
      waitForSelector: '.b-gantt-task'
    });
  });
  t.it('Context Menu', t => {
    t.chain({
      contextmenu: '.b-sch-header-timeaxis-cell:textEquals(Sun 20 Jan 2019)'
    }, {
      waitForSelector: '.b-menu-text:textEquals(Filter tasks)'
    }, {
      waitForSelector: '.b-menu-text:textEquals(Zoom)'
    }, {
      waitForSelector: '.b-menu-text:textEquals(Date range)'
    });
  });
  t.it('Task Editor', t => {
    t.chain({
      waitForSelector: taskSelector,
      desc: 'Task appears'
    }, {
      dblClick: taskSelector
    }, {
      waitForSelector: '.b-gantt-taskeditor',
      desc: 'Task editor opens'
    }, {
      click: ':textEquals(Common)'
    }, {
      waitForSelector: 'button.b-active:textEquals(Common)',
      desc: 'Can activate Common tab'
    }, {
      click: ':textEquals(Successors)'
    }, {
      waitForSelector: 'button.b-active:textEquals(Successors)',
      desc: 'Can activate Successors tab'
    }, {
      click: ':textEquals(Predecessors)'
    }, {
      waitForSelector: 'button.b-active:textEquals(Predecessors)',
      desc: 'Can activate Predecessors tab'
    }, {
      click: ':textEquals(Resources)'
    }, {
      waitForSelector: 'button.b-active:textEquals(Resources)',
      desc: 'Can activate Resources tab'
    }, {
      click: ':textEquals(Advanced)'
    }, {
      waitForSelector: 'button.b-active:textEquals(Advanced)',
      desc: 'Can activate Advanced tab'
    }, {
      click: ':textEquals(Common)'
    }, {
      waitForSelector: 'button.b-active:textEquals(Common)'
    }, {
      type: '[BACKSPACE][BACKSPACE][BACKSPACE][BACKSPACE][BACKSPACE][BACKSPACE]',
      target: '[name="name"]'
    }, {
      type: 'N',
      target: '[name="name"]',
      options: {
        shiftKey: true
      }
    }, {
      type: 'gnix',
      target: '[name="name"]'
    }, {
      click: ':textEquals(Save)'
    }, {
      waitForSelector: '.b-tree-cell-value:textEquals(Install Ngnix)',
      desc: 'Can edit and save task name'
    });
  });
  t.it('Tooltips', t => {
    t.chain({
      moveMouseTo: '[data-task-id="1"]'
    }, {
      waitForSelector: '.b-gantt-task-title:textEquals(Setup web server)'
    });
  });
});