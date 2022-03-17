import { BrowserHelper } from '../../../build/gantt.module.js?457330';

/* global Gantt */
StartTest(t => {
    let gantt;

    t.beforeEach(() => Gantt.destroy(gantt));

    t.it('Should export Gantt project to MSP XML format', async t => {

        gantt = await t.getGanttAsync({
            features : {
                mspExport : {
                    listeners : {
                        dataCollected : ({ data }) => {
                            // override exported data before converting it to XML
                            data.Name = 'FOO';
                        }
                    }
                }
            }
        });

        t.firesOk({
            observable : gantt,
            events     : {
                beforeMspExport : 2,
                mspExport       : 1
            },
            desc : 'Correct Gantt events fired'
        });

        const
            { taskStore }  = gantt,
            task1 = taskStore.getById(1000);

        // update first task name w/ non ASCII symbols
        task1.name = 'АБВГД ABCDE';

        const { mspExport } = gantt.features;

        t.firesOk({
            observable : mspExport,
            events     : {
                dataCollected : 1
            },
            desc : 'Correct MspExport events fired'
        });

        // we'll cancel 1st export call
        gantt.on({
            beforeMspExport : () => false,
            once            : true
        });

        // mock BrowserHelper.download()
        BrowserHelper.download = () => {};

        gantt.on({
            mspExport : ({ config, data, fileContent }) => {
                const
                    xmlDoc = new DOMParser().parseFromString(fileContent, 'text/xml'),
                    taskEls = xmlDoc.getElementsByTagName('Task');

                t.is(xmlDoc.querySelector('Project>Name').textContent, 'FOO', 'project name is correct');

                // sum + 1 to consider the project calendar (gantt.project.calendar) that is not present in the calendarManagerStore
                t.is(xmlDoc.querySelectorAll('Calendar').length, gantt.calendarManagerStore.count + 1, 'proper number of calendars exported');
                t.is(taskEls.length, taskStore.count, 'proper number of tasks exported');
                t.is(xmlDoc.querySelectorAll('Assignment').length, gantt.assignmentStore.count, 'proper number of assignments exported');
                t.is(xmlDoc.querySelectorAll('Resource').length, gantt.resourceStore.count, 'proper number of resources exported');

                t.is(xmlDoc.querySelector('Calendar WeekDays').querySelectorAll('WeekDay').length, 7, 'proper number of week days on 1st calendar exported');

                t.is(taskEls[0].querySelector(':scope>Start').textContent, '2017-01-16T00:00:00', 'task1 start date exported is correct');
                t.is(taskEls[0].querySelector(':scope>Name').textContent, 'АБВГД ABCDE', 'task1 name exported is correct');

                t.is(taskEls[1].querySelector(':scope>Start').textContent, '2017-01-16T00:00:00', 'task2 start date exported is correct');
                t.is(taskEls[1].querySelector(':scope>Name').textContent, 'Planning', 'task2 name exported is correct');

                t.diag('Assert baselines exporting');

                const task1BaselineEls = taskEls[0].getElementsByTagName('Baseline');

                t.is(task1BaselineEls.length, 2, 'proper number of baselines for 1st task');

                t.diag('Assert task1 baselines exporting');

                let baselineEl = task1BaselineEls[0];

                t.is(baselineEl.getElementsByTagName('Start')[0].textContent, '2017-01-14T00:00:00', '1st task 0th baseline start date exported is correct');
                t.is(baselineEl.getElementsByTagName('Finish')[0].textContent, '2017-02-17T00:00:00', '1st task 0th baseline end date exported is correct');
                t.is(baselineEl.getElementsByTagName('Number')[0].textContent, '0', '1st task 0th baseline index exported is correct');
                t.is(baselineEl.getElementsByTagName('Duration')[0].textContent, 'PT24H0M0S', '1st task 0th baseline duration exported is correct');

                baselineEl = task1BaselineEls[1];

                t.is(baselineEl.getElementsByTagName('Start')[0].textContent, '2017-01-15T00:00:00', '1st task 1st baseline start date exported is correct');
                t.is(baselineEl.getElementsByTagName('Finish')[0].textContent, '2017-02-18T00:00:00', '1st task 1st baseline end date exported is correct');
                t.is(baselineEl.getElementsByTagName('Number')[0].textContent, '1', '1st task 1th baseline index exported is correct');
                t.is(baselineEl.getElementsByTagName('Duration')[0].textContent, 'PT24H0M0S', '1st task 1st baseline duration exported is correct');

                t.diag('Assert task2 baselines exporting');

                const task2BaselineEls = taskEls[1].getElementsByTagName('Baseline');

                t.is(task2BaselineEls.length, 2, 'proper number of baselines for 2nd task');

                baselineEl = task2BaselineEls[0];

                t.is(baselineEl.getElementsByTagName('Start')[0].textContent, '2017-01-14T00:00:00', '2nd task 0th baseline start date exported is correct');
                t.is(baselineEl.getElementsByTagName('Finish')[0].textContent, '2017-02-24T00:00:00', '2nd task 0th baseline end date exported is correct');
                t.is(baselineEl.getElementsByTagName('Number')[0].textContent, '0', '2nd task oth baseline index exported is correct');
                t.is(baselineEl.getElementsByTagName('Duration')[0].textContent, 'PT24H0M0S', '2nd task 0th baseline duration exported is correct');

                baselineEl = task2BaselineEls[1];

                t.is(baselineEl.getElementsByTagName('Start')[0].textContent, '2017-01-15T00:00:00', '2nd task 1st baseline start date exported is correct');
                t.is(baselineEl.getElementsByTagName('Finish')[0].textContent, '2017-02-25T00:00:00', '2nd task 1st baseline end date exported is correct');
                t.is(baselineEl.getElementsByTagName('Number')[0].textContent, '1', '2nd task 1th baseline index exported is correct');
                t.is(baselineEl.getElementsByTagName('Duration')[0].textContent, 'PT24H0M0S', '2nd task 1st baseline duration exported is correct');
            }
        });

        mspExport.export();

        mspExport.export();
    });

    // https://github.com/bryntum/support/issues/3235
    t.it('mspExport feature export() method uses proper way of encoding strings', async t => {

        gantt = await t.getGanttAsync({
            features : {
                mspExport : true
            }
        });

        // update first task name w/ non ASCII symbols
        gantt.taskStore.first.name = 'АБВГД ABCDE';

        const async = t.beginAsync();

        // mock BrowserHelper.download used by the mspExport feature
        BrowserHelper.download = async(filename, url) => {
            const
                response = await fetch(url),
                xml      = await response.text(),
                xmlDoc   = new DOMParser().parseFromString(xml, 'text/xml');

            t.is(filename, `${gantt.taskStore.first.name}.xml`, 'file name is correct');
            t.like(xml, 'АБВГД ABCDE', 'proper task name found in the exported data');
            t.is(xmlDoc.querySelector('Task > Name').firstChild.nodeValue, gantt.taskStore.first.name, '1st task name exported is correct');

            t.endAsync(async);
        };

        gantt.features.mspExport.export({
            filename : `${gantt.taskStore.first.name}.xml`
        });
    });

    // https://github.com/bryntum/support/issues/3400
    t.it('Should handle exporting unscheduled tasks', async t => {
        gantt = await t.getGanttAsync({
            features : {
                mspExport : true
            },
            tasks : [
                { id : 1, name : 'unplanned' }
            ]
        });

        const async = t.beginAsync();

        BrowserHelper.download = async(filename, url) => {
            const
                response = await fetch(url),
                xml      = await response.text(),
                xmlDoc   = new DOMParser().parseFromString(xml, 'text/xml');

            t.is(xmlDoc.querySelector('Task > Name').firstChild.nodeValue, gantt.taskStore.first.name, 'Task name exported is correct');

            t.endAsync(async);
        };

        gantt.features.mspExport.export({
            filename : 'foo.xml'
        });
    });

    // https://github.com/bryntum/support/issues/3821
    t.it('Should handle exporting unscheduled tasks', async t => {
        gantt = await t.getGanttAsync({
            features : {
                mspExport : true
            },
            tasks : [
                {
                    id       : 1,
                    name     : 'Collapsed 1',
                    children : [
                        { id : 11, name : 'child 11' },
                        { id : 12, name : 'child 12' }
                    ]
                },
                {
                    id       : 2,
                    name     : 'Collapsed 2',
                    children : [
                        { id : 21, name : 'child 21' },
                        { id : 22, name : 'child 22' }
                    ]
                }
            ]
        });

        const async = t.beginAsync();

        BrowserHelper.download = async(filename, url) => {
            const
                response = await fetch(url),
                xml      = await response.text(),
                xmlDoc   = new DOMParser().parseFromString(xml, 'text/xml');

            const taskEls = xmlDoc.getElementsByTagName('Task');

            t.is(taskEls.length, 6, 'proper number of tasks exported');

            t.endAsync(async);
        };

        gantt.features.mspExport.export({
            filename : 'foo.xml'
        });
    });

    // https://github.com/bryntum/support/issues/3900
    t.it('Should use number values for UIDs', async t => {

        gantt = await t.getGanttAsync({
            features : {
                mspExport : true
            },
            dependencies : [{ fromEvent : 'a', toEvent : 'b' }],
            tasks        : [
                { id : 'a', name : 'a' },
                { id : 'b', name : 'b' }
            ]
        });

        const async = t.beginAsync();

        BrowserHelper.download = async(filename, url) => {
            const
                response = await fetch(url),
                xml      = await response.text(),
                xmlDoc   = new DOMParser().parseFromString(xml, 'text/xml');

            const taskEls = xmlDoc.getElementsByTagName('Task');

            t.is(taskEls[0].querySelector(':scope>UID').textContent, gantt.project.taskStore.getById('a').internalId, 'proper value used for task #a UID');
            t.is(taskEls[1].querySelector(':scope>UID').textContent, gantt.project.taskStore.getById('b').internalId, 'proper value used for task #b UID');
            t.is(taskEls[1].querySelector('PredecessorUID').textContent, gantt.project.taskStore.getById('a').internalId, 'proper value used for task #b predecessor UID');

            t.endAsync(async);
        };

        gantt.features.mspExport.export({
            filename : 'foo.xml'
        });
    });

    // https://github.com/bryntum/support/issues/4107
    t.it('Should use project time unit conversion rates', async t => {

        gantt = await t.getGanttAsync({
            startDate : new Date(2022, 1, 3),
            endDate   : new Date(2022, 1, 5),
            project   : {
                calendar      : 1,
                startDate     : '2022-02-03T08:00:00',
                hoursPerDay   : 8,
                daysPerWeek   : 5,
                daysPerMonth  : 20,
                calendarsData : [
                    {
                        id        : 1,
                        intervals : [
                            {
                                recurrentStartDate : 'every weekday at 16:00',
                                recurrentEndDate   : 'every weekday at 08:00',
                                isWorking          : false
                            }
                        ]
                    }
                ],
                eventsData : [
                    {
                        id                : 1,
                        name              : 'Task 1',
                        manuallyScheduled : true,
                        startDate         : '2022-02-03T08:00:00',
                        duration          : 1
                    }
                ]
            },
            features : {
                mspExport : true
            }
        });

        const async = t.beginAsync();

        BrowserHelper.download = async(filename, url) => {
            const
                response = await fetch(url),
                xml      = await response.text(),
                xmlDoc   = new DOMParser().parseFromString(xml, 'text/xml'),
                task     = gantt.project.taskStore.getById(1),
                taskEls  = xmlDoc.getElementsByTagName('Task');

            t.endAsync(async);

            // sanity check
            t.is(task.endDate, new Date(2022, 1, 3, 16), 'task endDate is correct');

            t.is(taskEls[0].querySelector(':scope>Duration').textContent, 'PT8H0M0S', 'exported Duration value is correct');
            t.is(taskEls[0].querySelector(':scope>ManualDuration').textContent, 'PT8H0M0S', 'exported ManualDuration value is correct');
            t.is(taskEls[0].querySelector(':scope>UID').textContent, task.internalId, 'exported UID is correct');
        };

        gantt.features.mspExport.export();
    });

    // https://github.com/bryntum/support/issues/4104
    t.it('Should use project task identifiers for exported assignments', async t => {

        gantt = await t.getGanttAsync({
            startDate : new Date(2022, 1, 3),
            endDate   : new Date(2022, 1, 5),
            project   : {
                tasksData : [
                    {
                        id        : 1,
                        name      : 'Task 1',
                        startDate : '2022-02-03',
                        duration  : 1
                    }
                ],
                resourcesData   : [{ id : 1, name : 'foo' }],
                assignmentsData : [{ id : 1, resource : 1, event : 1 }]
            },
            features : {
                mspExport : true
            }
        });

        const async = t.beginAsync();

        BrowserHelper.download = async(filename, url) => {
            const
                response      = await fetch(url),
                xml           = await response.text(),
                xmlDoc        = new DOMParser().parseFromString(xml, 'text/xml'),
                assignmentEls = xmlDoc.getElementsByTagName('Assignment');

            t.endAsync(async);

            t.is(assignmentEls[0].querySelector(':scope>TaskUID').textContent, gantt.project.taskStore.getById(1).internalId, 'assignment TaskUID value is correct');
        };

        gantt.features.mspExport.export();
    });

});
