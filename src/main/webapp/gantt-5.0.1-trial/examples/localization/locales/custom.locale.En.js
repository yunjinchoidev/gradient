import LocaleManager from '../../../lib/Core/localization/LocaleManager.js';
//<umd>
import LocaleHelper from '../../../lib/Core/localization/LocaleHelper.js';
import En from '../../../lib/Gantt/localization/En.js';

const customEnLocale = {

    extends : 'En',

    App : {
        'Localization demo' : 'Localization demo'
    },

    Button : {
        'Add column'    : 'Add column',
        Apply           : 'Apply',
        'Display hints' : 'Display hints',
        'Remove column' : 'Remove column'
    },

    Checkbox : {
        'Auto apply'  : 'Auto apply',
        Automatically : 'Automatically'
    },

    CodeEditor : {
        'Code editor'   : 'Code editor',
        'Download code' : 'Download code'
    },

    Column : {
        Duration : 'Duration',
        Finish   : 'Finish',
        Name     : 'Name',
        Start    : 'Start',
        WBS      : 'WBS'
    },

    Combo : {
        Theme    : 'Select theme',
        Language : 'Select locale',
        Size     : 'Select size'
    },

    Tooltip : {
        infoButton       : 'Click to show info and switch theme or locale',
        codeButton       : 'Click to show the built in code editor',
        hintCheck        : 'Check to automatically display hints when loading the example',
        fullscreenButton : 'Fullscreen'
    },

    Shared : {
        'Full size'      : 'Full size',
        'Locale changed' : 'Locale changed',
        'Phone size'     : 'Phone size'
    }

};

// Publishing locales to be loaded automatically (for umd bundles)
LocaleHelper.publishLocale('En', En);
LocaleHelper.publishLocale('En-Custom', customEnLocale);
//</umd>

// Or extending locales directly
LocaleManager.extendLocale('En', customEnLocale);
