
import { Combo } from '@bryntum/gantt';

const baseColors = [
    'maroon', 'red', 'orange', 'yellow',
    'olive', 'green', 'purple', 'fuchsia',
    'lime', 'teal', 'aqua', 'blue', 'navy',
    'black', 'gray', 'silver', 'white'
];

export default class ColorField extends Combo {
    /**
     * Original class name getter. See Widget.$name docs for the details.
     */
    static get $name() {
        return 'ColorField';
    }

    // Factoryable type name
    static get type() {
        return 'colorfield';
    }

    static get defaultConfig() {
        return {
            clearable : true,
            items     : baseColors,
            picker    : {
                cls     : 'b-color-picker-container',
                itemCls : 'b-color-picker-item',
                itemTpl : item => `<div style="background-color:${item.id}"></div>`
            }
        };
    }
}

// Register this widget type with its Factory
ColorField.initClass();
