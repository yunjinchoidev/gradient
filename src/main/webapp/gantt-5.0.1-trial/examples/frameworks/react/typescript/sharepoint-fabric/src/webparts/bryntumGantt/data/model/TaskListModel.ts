import { ProjectModel } from '@bryntum/gantt';
import Service from '../service/Service';

/**
 * The Project model for the gantt chart
 *  https://bryntum.com/docs/gantt/api/Gantt/model/ProjectModel
 */
class TaskListModel extends ProjectModel {

    public autoSync: boolean;// Is set to true after loading

    private service: Service;

    private _isTaskListModel;

    public set isTaskListModel(value: boolean) {
        this._isTaskListModel = value;
    }

    public get isTaskListModel() {
        return this._isTaskListModel;
    }

    constructor(config) {
        super(config);
        this.isTaskListModel = true;
        this.service = config.service;
        // Any change in the dependency store needs to be reflected to the taskStore in the task PredecessorId field.
        this.dependencyStore.on('change', this.onDependencyChange.bind(this));
        // Only support F-S types for the default SharePoint SPTaskList
        (<any> this.dependencyStore).isValidDependency = (dependencyOrFromId, toId, type) => {
            return type === 2;
        };
        // Any change in the assignment store needs to be reflected to the taskStore in the task AssignedToId field.
        this.assignmentStore.on('change', this.onAssignmentChange.bind(this));
    }

    protected getTask(id) {
        if (id) {
            return id.isTask ? id : this.taskStore.getById(id);
        }
    }

    private onAssignmentChange(source) {
        const records = source.records || (source.record ? [source.record] : []);
        records.forEach(record => {
            const id = record.resource ? record.resourceId : null;
            const task = this.getTask(record.task || record.event);
            task.setFieldChangeToLookupField(source.action, 'assignedToId', id);
        });
    }

    private onDependencyChange(source) {
        const records = source.records || (source.record ? [source.record] : []);
        records.forEach(record => {
            const id = record.fromTask ? record.fromTask.id : null;
            const task = this.getTask(record.toTask);
            if (task) {
                task.setFieldChangeToLookupField(source.action, 'predecessorId', id);
            }
        });
    }

    // Override of the crudmanager to bypass Ajax response, no decoding needed
    public decode(response: any): any {
        return response;
    }

    // Override of the crudmanager to bypass Ajax response, no encoding needed
    public encode(requestConfig: any): string {
        return requestConfig;
    }

    /**
   * Use the List Proxy instead of the default AjaxRequest
   * @param request
   */
    public sendRequest(request: any): Promise<any> {
        return new Promise((resolve, reject) => {
            switch (request.type) {
                case 'load':
                    return this.service.load(request);
                case 'sync':
                    return this.service.sync(request);
            }
        });
    }

    // Bug fix to catch unhandled reject in model
    public processPromise(reject, resolve, context) {
        const
            { rawResponse, response } = context;

        // @ts-ignore
        if (resolve && this.isValidResponse(rawResponse, response)) {
            resolve(context);
        }
    }
}

export default TaskListModel;
