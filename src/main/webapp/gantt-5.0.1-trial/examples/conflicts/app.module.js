import { Gantt } from '../../build/gantt.module.js?457330';
import shared from '../_shared/shared.module.js?457330';
/* eslint-disable no-unused-vars */

const gantt = new Gantt({
    appendTo : 'container',

    project : {
        autoLoad  : true,
        transport : {
            load : {
                url : '../_datasets/constraints.json'
            }
        }
    },

    features : {
        indicators : {
            items : {
                deadlineDate   : false,
                earlyDates     : false,
                lateDates      : false,
                // display constraint indicators
                constraintDate : true
            }
        },
        dependencyEdit : true
    },

    tbar : {
        cls   : 'b-demo-toolbar',
        items : [
            {
                text : 'Add invalid dependency',
                icon : 'b-fa b-fa-bug',
                cls  : 'b-invalid-dependency-button',
                onClick() {
                    // Here we add an invalid dependency linking "Install Apache" task to itself
                    // which naturally creates a cycle.
                    // This action triggers task rescheduling which then detects the cycle
                    // and informs user about it.

                    gantt.dependencyStore.add({ fromTask : 11, toTask : 11 });
                }
            },
            {
                text : 'Use invalid calendar',
                icon : 'b-fa b-fa-bug',
                cls  : 'b-invalid-calendar-button',
                onClick() {
                    // Here we add an invalid calendar and assign it to "Install Apache" task.
                    // The calendar has no working intervals and thus cannot be used for scheduling,
                    // Assigning of the calendar triggers task rescheduling which then detects the issue
                    // and informs user about it.

                    const [calendar] = gantt.calendarManagerStore.add({
                        name                     : 'My Calendar',
                        // we setup a global not working interval on the calendar but
                        // not provide any single working one so the calendar has zero working periods
                        unspecifiedTimeIsWorking : false
                    });

                    gantt.taskStore.getById(11).calendar = calendar;
                }
            }
        ]
    }

});
