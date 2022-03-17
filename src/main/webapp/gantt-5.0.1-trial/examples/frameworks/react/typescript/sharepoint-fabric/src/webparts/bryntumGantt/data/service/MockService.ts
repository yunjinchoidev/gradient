import MockTaskList from "./proxy/MockTaskList";
import Service from "./Service";
import MockTaskModel from "../model/MockTaskModel";

/**
 * Service for localhost
 */
export default class MockService extends Service {

  constructor() {
    super({
      taskModelClass: MockTaskModel
    });

    this.isMock = true;
    this.proxy = new MockTaskList();
  }
}
