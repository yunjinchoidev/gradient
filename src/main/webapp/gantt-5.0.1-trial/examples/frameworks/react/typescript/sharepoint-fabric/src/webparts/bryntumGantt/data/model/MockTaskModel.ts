import LookupTaskModel from "./LookupTaskModel";

/**
 * Model used in dev mode
 */
class MockTaskModel extends LookupTaskModel {

  constructor(config: any) {
    super(config);
  }

  static get fields() {
    return [
      { name: 'startDate', dataSource: 'startDate', type : 'date' },
      { name: 'endDate', dataSource: 'endDate', type : 'date' },
      { name: 'percentDone', dataSource: 'percentDone', type : 'number', serialize: val => val / 100, defaultValue : 0 },
      { name: 'ParentIDId' },
      { name: 'name', dataSource: 'name' },
      { name: 'predecessorId', dataSource: 'PredecessorsId', convert: this.setIntArrayAsStringValue, defaultValue: ''},
      { name: 'assignedToId', dataSource: 'AssignedToId', convert: this.setIntArrayAsStringValue, defaultValue: ''}
    ];
  }
}

export default MockTaskModel;
