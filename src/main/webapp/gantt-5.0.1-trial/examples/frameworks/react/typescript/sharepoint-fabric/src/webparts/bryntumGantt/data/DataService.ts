import {
  Environment,
  EnvironmentType
} from '@microsoft/sp-core-library';
import  { WebPartContext } from "@microsoft/sp-webpart-base";
import MockService from "./service/MockService";
import SPService from "./service/SPService";
import Service from "./service/Service";

/**
 * Retrieve the service based on EnvironmentType, Mock or Tenant
 */
export default class DataService {

   public static getService(context: WebPartContext): Service {
     let service: Service;
     if (Environment.type === EnvironmentType.SharePoint ||
      Environment.type === EnvironmentType.ClassicSharePoint) {
      service = new SPService();
    } else {
      service = new MockService();
    }

     return service;
  }
}
