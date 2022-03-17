import { DependencyModel } from '@bryntum/gantt';

class SPDependencyModel extends DependencyModel {

    constructor(config: any) {
        super(config);
    }

    // We do not store Lag in this demo.
    static get fields() {
        return [
            { name : 'lag', readOnly : true }
        ];
    }
}

export default SPDependencyModel;
