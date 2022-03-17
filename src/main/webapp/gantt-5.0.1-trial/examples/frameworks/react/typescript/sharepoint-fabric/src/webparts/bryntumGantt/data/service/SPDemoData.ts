import { DateHelper } from '@bryntum/gantt';
import MockTaskList from './proxy/MockTaskList';
import ITaskList from './proxy/ITaskList';
import { UpdateAction } from './proxy/UpdatePackage';

export default class SPDemoData {

  /**
   * Create a single project task to start with
   * @param taskList
   * @param listId
   */
  public createSingleProjectTask(taskList: ITaskList, listId: string): Promise<any> {
    const startDate = new Date();
    const endDate = DateHelper.add(startDate, 7, 'days');
    const actions = [new UpdateAction({},{ StartDate: startDate, DueDate: endDate, Title: 'Project start' })];

    return taskList.addTaskListItems(listId, actions);
  }

  /**
   * Create a full blown example based on `launch-saas.json`.
   *
   * @param taskList
   * @param listId
   */
  public createFullExample(taskList: ITaskList, listId: string):Promise<any> {

    const mockData:any =  new MockTaskList().ganttProject;
    const tasks = mockData.tasks.rows;
    const dependencies = mockData.dependencies.rows;
    const firstTask = tasks[0];
    const diff = DateHelper.diff(DateHelper.parse(firstTask.startDate, DateHelper.defaultFormat),new Date(), 'days');
    const generatedIdMap = {};

    const iterateTasks = async (children, parent) => {

      if (children) {
        for (let i = 0; i < children.length; i++) {

          const child = children[i];
          const oldStartDate = DateHelper.parse(child.startDate, DateHelper.defaultFormat);
          const newStartDate = DateHelper.add(oldStartDate, diff, 'days');

          let newEndDate;

          if (child.endDate) {
            newEndDate = DateHelper.add(DateHelper.parse(child.endDate, DateHelper.defaultFormat), diff, 'days');
          } else {
            newEndDate = DateHelper.add(newStartDate, child.duration, 'days');
          }

          // Persist as percentage
          const percentComplete = child.percentDone / 100;

          const data = {
            Title: child.name,
            StartDate: newStartDate,
            DueDate: newEndDate,
            PercentComplete: percentComplete,
          };

          if (parent) {
            data['ParentIDId'] = parent.id;
          }

          const dependency = dependencies.filter(item => {
            return item.toTask === child.id;
          });

          if (dependency.length > 0) {
            data['PredecessorsId'] = { results: dependency.map(item => generatedIdMap[item.fromTask]) };
          }

          const addResult: UpdateAction[] = await taskList.addTaskListItems(listId, [new UpdateAction({}, data) ]);
          generatedIdMap[child.id] = addResult[0].data.id;
          child.id = addResult[0].data.id;
          await iterateTasks(child.children, child);
        }
      }
    };

    return new Promise(async (resolve, reject) => {
      await iterateTasks(tasks, null);
      resolve();
    });
  }
}
