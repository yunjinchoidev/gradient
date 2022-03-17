import ITaskList from "./ITaskList";
import { UpdateAction } from "./UpdatePackage";
const gantt_project: any = require('../../../resources/data/launch-saas.json');

import { Response } from "./Response";

/**
 * Mock proxy for dev mode, doing nothing.
 */
class MockTaskList implements ITaskList {

  // Made public for SPDemoData creation
  public ganttProject = gantt_project;

  public addTaskListItems(listId: string, actions: UpdateAction[]): Promise<UpdateAction[]> {
    return new Promise((resolve, reject) => {resolve(actions); });
  }

  public updateTaskListItems(listId: string, actions: UpdateAction[]): Promise<UpdateAction[]> {
    return new Promise((resolve, reject) => {resolve(actions); });
  }

  public deleteTaskListItems(listId: string, actions: UpdateAction[]): Promise<UpdateAction[]> {
    return new Promise((resolve, reject) => {resolve(actions); });
  }

  // Returns the `saas-launch.json` demo project for dev mode
  public getTaskListItems(listId: string): Promise<Response> {
    return new Promise((resolve, reject) => {
      const response = new Response();
      response.assignments = gantt_project.assignments;
      response.dependencies = gantt_project.dependencies;
      response.resources = gantt_project.resources;
      response.tasks = gantt_project.tasks;
      resolve(response);
    });
  }
}

export default MockTaskList;
