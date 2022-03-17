StartTest(t => {
    const gantt = bryntum.query('gantt');

    t.it('Should export Gantt to Microsoft Project', async t => {
        await t.waitForPropagate(gantt.project);

        const
            exporter      = gantt.features.mspExport,
            xml           = exporter.convertToXml(exporter.generateExportData()),
            xmlDoc        = new DOMParser().parseFromString(xml, 'text/xml'),
            tasksEl       = xmlDoc.getElementsByTagName('Tasks')[0],
            calendarsEl   = xmlDoc.getElementsByTagName('Calendars')[0],
            firstTaskDate = tasksEl.getElementsByTagName('Task')[0].querySelector(':scope>Start').textContent;

        t.ok(gantt.features.mspExport, 'mspExport feature is here');

        t.is(calendarsEl.childNodes.length, gantt.calendarManagerStore.count + gantt.resourceStore.count, 'proper number of calendars exported');
        t.is(tasksEl.childNodes.length, gantt.taskStore.count, 'proper number of tasks exported');
        // TODO: feature to export assignments in progress
        // t.is(xmlDoc.getElementsByTagName('Assignments')[0].childNodes.length, gantt.assignmentStore.count, 'proper number of assignments exported');
        t.is(xmlDoc.getElementsByTagName('Resources')[0].childNodes.length, gantt.resourceStore.count, 'proper number of resources exported');

        t.is(calendarsEl.getElementsByTagName('Calendar')[0].getElementsByTagName('WeekDays')[0].childNodes.length, 7, 'proper number of week days on 1st calendar exported');
        t.is(firstTaskDate, '2019-01-14T00:00:00', '1st task start date exported is correct');
    });
});
