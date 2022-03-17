import { sp } from "@pnp/sp";
import "@pnp/sp/webs";
import "@pnp/sp/lists";
import "@pnp/sp/items";
import "@pnp/sp/site-users";
import { IItemAddResult } from "@pnp/sp/items";

import ITaskList from './ITaskList';
import { TaskListHelper as Helper } from "./TaskListHelper";
import { UpdateAction } from "./UpdatePackage";
import { Response } from './Response';

/**
 * Proxy to handle tasklist updates.
 */
export default class SPTaskList implements ITaskList {

  // assignments and deps are not stored we handle id management locally
  public assignmentId = 0;
  public dependencyId = 0;

  /**
   * Delete items from the tasklist.
   * @param listId
   * @param actions
   */
  public deleteTaskListItems(listId: string, actions: UpdateAction[]): Promise<UpdateAction[]> {

    const list = sp.web.lists.getById(listId);

    // We only need to delete the parents
    actions.forEach(action => {
       const parent = actions.find(item => {
         return item.record.id === action.record.ParentIDId;
       });
       if (parent) {
         action['skip'] = true;
       }
    });

    return new Promise((resolve, reject) => {
      if (actions.length) {
        let batch = sp.web.createBatch();
        actions.forEach(action => {
          const listItem = list.items.getById(action.record.id);
          if (!action.skip) {
            listItem.inBatch(batch).delete().catch((err) => {
              reject();
            });
          }
        });
        batch.execute().then(result => {
          resolve(actions);
        }).catch(reject);
      } else resolve(actions);
    });
  }

  /**
   * Add new items to the tasklist
   *
   * @param listId
   * @param actions
   */
  public addTaskListItems(listId: string, actions: UpdateAction[]): Promise<UpdateAction[]> {

    const list = sp.web.lists.getById(listId);
    let actionCounter = 0;

    return new Promise((resolve, reject) => {
      if (actions.length) {

        const finish = (error = false) => {
          if (!error) {
            actionCounter++;
            // Resolve when all records are processed and id's newly created are retrieved
            if (actionCounter === actions.length) {
              resolve(actions);
            }
          } else {
            reject(error);
          }
        };

        const batch = sp.web.createBatch();

        actions.forEach(action => {
            list.items.inBatch(batch).add(action.data).then(result => {
              Object.assign(action.data, result.data);
              // Id is needed to unphantom new records and to be able to add child nodes later on
              action.data['id'] = result.data['Id'];
              finish();
            }).catch(finish);
        });

        batch.execute().catch(finish);
      } else {
        resolve(actions);
      }
    });
  }

  /**
   * Batch update on tasklist items
   *
   * @param listId
   * @param actions
   */
  public updateTaskListItems(listId: string, actions: UpdateAction[]): Promise<UpdateAction[]> {

    const list = sp.web.lists.getById(listId);

    return new Promise((resolve, reject) => {
      list.getListItemEntityTypeFullName().then(entityTypeFullName => {

        const batch = sp.web.createBatch();

        actions.forEach(action => {
          const listItem = list.items.getById(action.record.id);
            listItem.inBatch(batch).update(action.data, "*", entityTypeFullName).catch(error => {
              reject(error);
            });
        });

        batch.execute().then(result => {
          resolve(actions);
        }).catch(reject);
      });
    });
  }

  /**
   * Get the whole project structure at once by processing a SP TaskList.
   *
   * Assignments are retrieved from AssignedToId
   * Dependencies are retrieved from PredecessorsId
   * Resources are the unfiltered site users
   *
   * Returns a Response which the crudmanager can load.
   *
   * @param listId
   */
  public getTaskListItems(listId: string): Promise<Response> {

    const response = new Response();

    return new Promise((resolve, reject) => {

      sp.web.lists.getById(listId).items.select('*,ParentIDId').getAll().then((tasks) => {

        tasks.forEach(task => {
          task['id'] = task['Id'];
          Object.keys(task).forEach(prop => {
             if (task[prop] === null) {
               delete task[prop];
             }
          });

          // Fetch the dependencies as predecessors from the PredecessorId multi lookup field
          const predecessors = task.PredecessorsId || [];
          predecessors.forEach(predecessor => {
            response.dependencies.rows.push({ fromTask: predecessor, toTask: task.id, id: ++this.dependencyId });
          });
          task.PredecessorsId = predecessors;

          // Fetch the assignment from the AssignmentToId multi lookup field
          const assignments = task.AssignedToId || [];
          assignments.forEach(assignment => {
            response.assignments.rows.push({ event: task.id, resource: assignment, id: ++this.assignmentId });
          });
          task.AssignedToId = assignments;

          task['PercentComplete'] = task['PercentComplete'] * 100;// SP stores percent done as percentage value
        });

        // flat loading is not supported at the moment, create a tree structure for loading
        response.tasks.rows = Helper.getRootNodes(tasks);

        // Get all site users. you might want to filter some out
        sp.web.siteUsers().then((users) => {
          response.resources.rows = users;
          resolve(response);
        });
      }).catch(reject);
    });
  }
}
