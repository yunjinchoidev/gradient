/**
 * App component script
 */
import { AfterViewInit, Component, ViewChild } from '@angular/core';
import { BryntumGanttComponent, BryntumGridComponent, BryntumSplitterComponent } from '@bryntum/gantt-angular';
import { Gantt, GanttConfig, Grid, GridConfig, Store } from '@bryntum/gantt/gantt.lite.umd.js';
import { ganttConfig, gridConfig } from './app.config';

@Component({
    selector    : 'app-root',
    templateUrl : './app.component.html',
    styleUrls   : ['./app.component.scss']
})
export class AppComponent implements AfterViewInit {
    title: string = document.title;
    ganttConfig: Partial<GanttConfig> = ganttConfig;
    gridConfig: Partial<GridConfig> = gridConfig;

    private gantt: Gantt;
    private grid: Grid;
    private timeRangeStore: Store;

    @ViewChild(BryntumGanttComponent, { static : false }) ganttComponent: BryntumGanttComponent;
    @ViewChild(BryntumGridComponent, { static : false }) gridComponent: BryntumGridComponent;
    @ViewChild(BryntumSplitterComponent, { static : false }) splitterComponent: BryntumSplitterComponent;

    ngAfterViewInit(): void {
        // Store instance
        this.gantt = this.ganttComponent.instance;
        this.grid = this.gridComponent.instance;
        this.timeRangeStore = this.gantt.features.timeRanges.store;
        this.grid.store = this.timeRangeStore;
    }

    onAddRange(): void {
        this.timeRangeStore.add({
            name      : 'New range',
            startDate : new Date(2019, 1, 27),
            duration  : 5
        });
    }

    onShowHeaders({ checked }: any): void {
        this.gantt.features.timeRanges.showHeaderElements = checked;
    }
}
