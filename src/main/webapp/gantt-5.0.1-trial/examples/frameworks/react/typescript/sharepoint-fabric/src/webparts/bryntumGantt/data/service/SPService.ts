import Service from "./Service";

import { sp } from "@pnp/sp";
import "@pnp/sp/webs";
import "@pnp/sp/lists";
import "@pnp/sp/items";
import "@pnp/sp/site-users";
import "@pnp/sp/fields";
import { CalendarType, DateTimeFieldFormatType } from "@pnp/sp/fields/types";

import SPTaskList from "./proxy/SPTaskList";
import SPTaskModel from "../model/SPTaskModel";
import SPResourceModel from "../model/SPResourceModel";
import SPAssignmentModel from "../model/SPAssignmentModel";
import SPDependencyModel from "../model/SPDependencyModel";

import SPDemoData from "./SPDemoData";

/**
 * Service used on the Tenant
 */
export default class SPService extends Service {

  constructor() {

    super({
      resourceModelClass: SPResourceModel,
      taskModelClass: SPTaskModel,
      assignmentModelClass: SPAssignmentModel,
      dependencyModelClass: SPDependencyModel
    });

    this.proxy = new SPTaskList();
  }

  /**
   * Create a new tasklist with demo data.
   *
   * @param name
   * @param sampleData
   */
  public ensureList(name: string, sampleData: string): Promise<any> {
    return new Promise<any>((resolve, reject) => {

      sp.web.lists.ensure(name, 'Bryntum demo',171, true,{
        AllowContentTypes: true,
        EnableAttachments: true
      }).then(async listEnsureResult => {

        const list = listEnsureResult.list;
        const data = await list.get();

        if (listEnsureResult.created) {

          const fieldsToAdd = SPTaskModel.additionalFields;

          try {
            for (let i = 0; i < fieldsToAdd.length; i++) {
              const field = fieldsToAdd[i];
              switch (field.type) {
                case 'number':
                  await list.fields.addNumber(field.dataSource, 0, 255);
                  break;
                case 'date':
                  await list.fields.addDateTime(field.dataSource, DateTimeFieldFormatType.DateTime, CalendarType.Gregorian);
                  break;
                case 'boolean':
                  await list.fields.addBoolean(field.dataSource, { DefaultValue: '0' });
                  break;
                default:
                  await list.fields.addText(field.dataSource, 255);
                  break;
              }
            }
          } catch(err) { reject(err); }

          // Add demo data
          const demoData = new SPDemoData();
          if (sampleData === 'fulldemo') {
            await demoData.createFullExample(this.proxy, data.Id);
          } else {
            await demoData.createSingleProjectTask(this.proxy, data.Id);
          }
        }
        resolve(data.Id);
      });
    });
  }

  /**
   * Get all SharePoint tasklists.
   */
  public getTaskLists(): Promise<{key:string, text:string}[]> {
    return new Promise((resolve, reject) => {
      // Template id 171 is the default for a SharePoint TaskList
      sp.web.lists.filter("BaseTemplate eq 171").get().then((lists: any) => {
        if (lists.length > 0) {
          // We filter on `Bryntum demo`.
          resolve(lists.filter(item => item.Description === 'Bryntum demo').map((list: any) => {
            return { key: list.Id, text: list.Title };
          }));
        } else {
          reject({ code: 2, message: 'Please create a tasklist.' });
        }
      });
    });
  }
}
