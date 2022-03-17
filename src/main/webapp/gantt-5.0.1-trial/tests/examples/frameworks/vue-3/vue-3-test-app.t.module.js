StartTest(t => {

    t.it('Rendering', t => {
        t.chain(
            { waitForSelector : '.b-gantt' },
            { waitForSelector : '.b-gantt-task' }
        );
    });

});
