import { ResourceModel } from '@bryntum/gantt';

class SPResourceModel extends ResourceModel {

    public static idField;

    constructor(config: any) {
        super(config);
    }

    static get fields() {
        return [
            { name : 'name', dataSource : 'Title' },
            { name : 'email', dataSource : 'Email' }
        ];
    }

}

export default SPResourceModel;
SPResourceModel.idField = 'Id';
