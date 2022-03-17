/**
 * App component script
 */
import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { BryntumGanttComponent, BryntumProjectModelComponent } from '@bryntum/gantt-angular';
import { Gantt, ProjectModel } from '@bryntum/gantt/gantt.lite.umd.js';
import { ganttConfig, projectConfig } from './app.config';
import { DataService } from './data.service';

@Component({
    selector    : 'app-root',
    templateUrl : './app.component.html',
    styleUrls   : ['./app.component.scss'],
    providers   : [DataService]
})
export class AppComponent implements AfterViewInit, OnInit {

    tasks        = [];
    dependencies = [];
    resources    = [];
    assignments  = [];
    calendars    = [];
    timeRanges   = [];

    ganttConfig = ganttConfig;
    projectConfig = projectConfig;

    private gantt!: Gantt;
    private project!: ProjectModel;
    private dataSet = 0;

    @ViewChild('gantt') ganttComponent!: BryntumGanttComponent;
    @ViewChild('project') projectComponent!: BryntumProjectModelComponent;

    // Inject data service
    constructor(private dataService:DataService) {}

    ngOnInit(): void {
        // Get initial data
        Object.assign(this, this.dataService.getData());
    }

    ngAfterViewInit(): void {
        // Store Gantt and project instances
        this.project = this.projectComponent.instance;
        this.gantt = this.ganttComponent.instance;

        // Assign project to gantt
        this.gantt.project = this.project;
    }

    onChangeData(): void {
        Object.assign(this, this.dataService.getData());
    }

}
