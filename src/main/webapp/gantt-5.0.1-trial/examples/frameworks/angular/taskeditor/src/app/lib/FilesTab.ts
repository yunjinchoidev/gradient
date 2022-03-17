// Bryntum umd lite bundle comes without polyfills to support Angular's zone.js
import { Grid, Store } from '@bryntum/gantt/gantt.lite.umd.js';

/**
 * @module FilesTab
 */

/**
 * @internal
 */
export default class FilesTab extends Grid {

    /**
     * Original class name getter. See Widget.$name docs for the details.
     */
    static get $name(): string {
        return 'FilesTab';
    }

    // Factoryable type name
    static get type(): string {
        return 'filestab';
    }

    static get defaultConfig(): object {
        return {
            title    : 'Files',
            defaults : {
                labelWidth : 200
            },
            columns : [{
                text     : 'Files attached to task',
                field    : 'name',
                type     : 'template',
                template : data => `<i class="b-fa b-fa-fw b-fa-${data.record.data.icon}"></i>${data.record.data.name}`
            }]
        };
    }

    loadEvent(eventRecord): void {
        const files = [];

        for (let i = 0; i < Math.random() * 10; i++) {
            const nbr = Math.round(Math.random() * 5);

            switch (nbr) {
                case 1:
                    files.push({
                        name : `Image${nbr}.pdf`,
                        icon : 'image'
                    });
                    break;
                case 2:
                    files.push({
                        name : `Charts${nbr}.pdf`,
                        icon : 'chart-pie'
                    });
                    break;
                case 3:
                    files.push({
                        name : `Spreadsheet${nbr}.pdf`,
                        icon : 'file-excel'
                    });
                    break;
                case 4:
                    files.push({
                        name : `Document${nbr}.pdf`,
                        icon : 'file-word'
                    });
                    break;
                case 5:
                    files.push({
                        name : `Report${nbr}.pdf`,
                        icon : 'user-chart'
                    });
                    break;
            }
        }

        (this.store as Store).data = files;
    }
}

// Register this widget type with its Factory
FilesTab.initClass();
