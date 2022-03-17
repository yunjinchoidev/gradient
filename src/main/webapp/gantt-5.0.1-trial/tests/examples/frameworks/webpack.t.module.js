StartTest(t => {
    t.setWindowSize([1024, 500]);

    const gantt = bryntum.query('ganttbase');

    t.it('Webpack demo sanity test', t => {
        t.chain(
            { waitFor : () => gantt, desc : 'gantt is here' },
            { waitForSelector : '.demo-header' },
            { waitForSelector : '.b-gantt-task' },
            () => {
                const
                    headerElement = document.querySelector('.demo-header'),
                    headerRect = headerElement.getBoundingClientRect();
                t.isApproxPx(headerRect.top, 0, 'Header has valid top');
                t.is(window.getComputedStyle(headerElement).backgroundColor, 'rgb(38, 103, 200)', 'Header has valid color');
                t.is(gantt.taskStore.count, 41, 'Task store count is ok');
                t.ok(document.querySelectorAll('.b-gantt-task').length >= 24, 'Rendered task selector count is ok');
            }
        );
    });
});
