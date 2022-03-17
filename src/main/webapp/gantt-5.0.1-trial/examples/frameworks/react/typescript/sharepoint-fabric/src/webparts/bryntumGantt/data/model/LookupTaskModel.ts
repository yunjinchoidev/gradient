import { TaskModel } from '@bryntum/gantt';

/**
 * Model with helper functions to set values to a SharePoint Lookup field like AssignToId and PredecessorId.
 */
class LookupTaskModel extends TaskModel {

  // Value stored as comma separated string.
  private getValueAsIntArray(value: string) {
    return value === '' ? [] : value.split(',').map(id => parseInt(id));
  }

  // Used for updating sharepoint lookup fields
  private serializeMultiLookupValue(value) {
    return { results: this.getValueAsIntArray(value) };
  }

  // We store lookup values as a string to detect changes on the model, convert back to original int array
  public getMultiLookupList (field) {
    let value = this.get(field) || '';
    return this.getValueAsIntArray(value);
  }

  // Add/update or remove an item in the multi lookup field
  public setFieldChangeToLookupField(action, field, id) {

    const value = this.getMultiLookupList(field);

    switch (action) {
      case 'remove':
        const index = value.indexOf(id);
        if (value.indexOf(id) !==- 1) {
          value.splice(index, 1);
          this.set(field, value);
        }
        break;
      case 'add':
      case 'update':
        if (value.indexOf(id) === -1) {
          value.push(id);
          this.set(field, value);
        }
        break;
    }
  }

  // We store multi lookup [int] values as string to detect changes on the model
  public static setIntArrayAsStringValue (value) {
    if (Array.isArray(value)) {
      return value.join(',');
    }

    if (value && value.results) {
      return value.results.join(',');
    }

    return (value === null) ? '' : value;
  }
}

export default LookupTaskModel;
