import { Gantt, AjaxHelper, Toast, VersionHelper } from '../../build/gantt.module.js?457330';
import shared from '../_shared/shared.module.js?457330';
class Importer {

    constructor(config) {
        this.gantt = config.gantt;
        this.defaultColumns = config.defaultColumns;
    }

    async importData(data) {
        const
            me      = this,
            // TODO: clone fields/configs from original project
            project = new me.gantt.projectModelClass({
                silenceInitialCommit : false
                // To save imported data provide `sync` url and set `autoSync` true, or call `gantt.project.sync()` manually after data is imported.
                // autoSync             : true,
                // transport            : {
                //     sync : {
                //         url : 'syncUrl'
                //     }
                // }
            });

        me.project         = project;
        me.calendarManager = project.calendarManagerStore;
        me.taskStore       = project.taskStore;
        me.assignmentStore = project.assignmentStore;
        me.resourceStore   = project.resourceStore;
        me.dependencyStore = project.dependencyStore;

        Object.assign(me, {
            calendarMap : {},
            resourceMap : {},
            taskMap     : {}
        });

        me.importCalendars(data);

        const tasks = me.getTaskTree(Array.isArray(data.tasks) ? data.tasks : [data.tasks]);

        me.importResources(data);
        me.importAssignments(data);

        me.taskStore.rootNode.appendChild(tasks[0].children);

        me.importDependencies(data);

        me.importProject(data);

        // Assign the new project to the gantt before launching commitAsync()
        // to let Gantt resolve possible scheduling conflicts
        me.gantt.project = project;

        await me.project.commitAsync();

        me.importColumns(data);

        return project;
    }

    // region RESOURCES
    importResources(data) {
        this.resourceStore.add(data.resources.map(this.processResource, this));
    }

    processResource(data) {
        const { id } = data;

        delete data.id;

        data.calendar = this.calendarMap[data.calendar];

        const resource = new this.resourceStore.modelClass(data);

        this.resourceMap[id] = resource;

        return resource;
    }
    // endregion

    // region DEPENDENCIES
    importDependencies(data) {
        this.dependencyStore.add(data.dependencies.map(this.processDependency, this));
    }

    processDependency(data) {
        const
            me = this,
            { fromEvent, toEvent } = data;

        delete data.id;

        const dep = new me.dependencyStore.modelClass(data);

        dep.fromEvent = me.taskMap[fromEvent].id;
        dep.toEvent = me.taskMap[toEvent].id;

        return dep;
    }
    // endregion

    // region ASSIGNMENTS
    importAssignments(data) {
        this.assignmentStore.add(data.assignments.map(this.processAssignment, this));
    }

    processAssignment(data) {
        const me = this;

        delete data.id;

        return new me.assignmentStore.modelClass({
            units    : data.units,
            event    : me.taskMap[data.event],
            resource : me.resourceMap[data.resource]
        });
    }
    // endregion

    // region TASKS
    getTaskTree(tasks) {
        return tasks.map(this.processTask, this);
    }

    processTask(data) {
        const
            me = this,
            { id, children } = data;

        delete data.children;
        delete data.id;
        delete data.milestone;

        data.calendar = me.calendarMap[data.calendar];

        const t = new me.taskStore.modelClass(data);

        if (children) {
            t.appendChild(me.getTaskTree(children));
        }

        t._id = id;
        me.taskMap[t._id] = t;

        return t;
    }
    // endregion

    // region CALENDARS
    processCalendarChildren(children) {
        return children.map(this.processCalendar, this);
    }

    processCalendar(data) {
        const
            me = this,
            { id, children } = data,
            intervals = data.intervals;

        delete data.children;
        delete data.id;

        const t = new me.calendarManager.modelClass(Object.assign(data, { intervals }));

        if (children) {
            t.appendChild(me.processCalendarChildren(children));
        }

        t._id = id;
        me.calendarMap[t._id] = t;

        return t;
    }

    // Entry point of calendars loading
    importCalendars(data) {
        this.calendarManager.add(this.processCalendarChildren(data.calendars.children));
    }
    // endregion

    // region Columns

    importColumns(data) {
        let columns = data.columns.map(this.processColumn, this).filter(column => column);

        const columnStore = this.gantt.subGrids.locked.columns;

        // if no columns extracted apply default set (if configured)
        if (!columns.length && this.defaultColumns) {
            columns = this.defaultColumns;
        }

        if (columns.length) {
            columnStore.removeAll(true);
            columnStore.add(columns);
        }
    }

    processColumn(data) {
        const columnClass = this.gantt.columns.constructor.getColumnClass(data.type);

        // ignore unknown columns (or columns that classes are not loaded)
        if (columnClass) {
            return Object.assign({ region : 'locked' }, data);
        }
    }

    // endregion

    importProject(data) {
        if ('calendar' in data.project) {
            data.project.calendar = this.calendarMap[data.project.calendar];
        }
        Object.assign(this.project, data.project);
    }
}



const gantt = new Gantt({
    appendTo : 'container',

    startDate : '2019-01-08',
    endDate   : '2019-04-01',

    subGridConfigs : {
        locked : {
            flex : 3
        },
        normal : {
            flex : 4
        }
    },

    project : {
        transport : {
            load : {
                url : '../_datasets/launch-saas.json'
            }
        },
        autoLoad : true,

        // This config enables response validation and dumping of found errors to the browser console.
        // It's meant to be used as a development stage helper only so please set it to false for production systems.
        validateResponse : true
    },

    dependencyIdField : 'sequenceNumber',

    columns : [
        { type : 'name', field : 'name', text : 'Name', width : 250 }
    ],

    viewPreset : 'weekAndDayLetter',

    tbar : [
        {
            type         : 'filepicker',
            ref          : 'input',
            buttonConfig : {
                text : 'Pick file',
                icon : 'b-fa-folder-open'
            },
            listeners : {
                change : ({ files }) => {
                    if (files.length) {
                        sendBtn.enable();
                    }
                    else {
                        sendBtn.disable();
                    }
                },
                clear : () => {
                    sendBtn.disable();
                }
            }
        },
        {
            type     : 'button',
            ref      : 'sendBtn',
            text     : 'Import data',
            cls      : 'b-load-button',
            icon     : 'b-fa-file-import',
            disabled : true,
            onClick  : () => {
                const { files } = input;

                if (files) {
                    const formData = new FormData();

                    formData.append('mpp-file', files[0]);

                    // test environment support
                    if (VersionHelper.isTestEnv) formData.append('test', 1);

                    gantt.maskBody('Importing project ...');

                    AjaxHelper.post('php/load.php', formData, { parseJson : true })
                        .then(async({ parsedJson }) => {
                            if (parsedJson.success && parsedJson.data) {

                                const { project } = gantt;

                                // Import the uploaded mpp-file data (will make a new project and assign it to the gantt)
                                await importer.importData(parsedJson.data);

                                // destroy old project
                                project.destroy();

                                // set the view start date to the loaded project start
                                gantt.setStartDate(gantt.project.startDate);
                                await gantt.scrollToDate(gantt.project.startDate, { block : 'start' });

                                input.clear();

                                // remove "Importing project ..." mask
                                gantt.unmaskBody();

                                Toast.show('File imported successfully!');
                            }
                            else {
                                onError(`Import error: ${parsedJson.msg}`);
                            }
                        }).catch(response => {
                            onError(`Import error: ${response.error || response.message}`);
                        });
                }
            }
        }
    ]
});

const { input, sendBtn } = gantt.widgetMap;

const importer = new Importer({
    // gantt panel reference
    gantt,
    // Columns that should be shown by the Gantt
    // if the imported file does not provide columns list
    defaultColumns : [
        { type : 'name', field : 'name', width : 250 },
        { type : 'addnew' }
    ]
});

function onError(text) {
    gantt.unmaskBody();
    console.error(text);

    Toast.show({
        html    : text,
        color   : 'b-red',
        style   : 'color:white',
        timeout : 3000
    });
}
