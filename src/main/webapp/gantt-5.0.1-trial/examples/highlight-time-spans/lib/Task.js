import TaskModel from '../../../lib/Gantt/model/TaskModel.js';
import DateHelper from '../../../lib/Core/helper/DateHelper.js';

export default class Task extends TaskModel {
    get minStartDate() {
        return this.project.startDate;
    }

    get maxEndDate() {
        return this.project.endDate;
    }
}
