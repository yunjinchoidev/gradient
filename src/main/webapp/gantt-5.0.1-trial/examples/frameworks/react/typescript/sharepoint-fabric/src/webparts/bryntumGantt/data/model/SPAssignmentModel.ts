import { AssignmentModel } from '@bryntum/gantt';

class SPAssignmentModel extends AssignmentModel {

    constructor(config: any) {
        super(config);
    }

    // We do not store assignment units in the TaskList or other list in this demo.
    static get fields() {
        return [
            { name : 'units', readOnly : true }
        ];
    }
}

export default SPAssignmentModel;
