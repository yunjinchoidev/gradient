import LocaleManager from '../../../lib/Core/localization/LocaleManager.js';
//<umd>
import LocaleHelper from '../../../lib/Core/localization/LocaleHelper.js';
import Nl from '../../../lib/Gantt/localization/Nl.js';

const customNlLocale = {

    extends : 'Nl',

    App : {
        'Localization demo' : 'Lokalisatiedemo'
    },

    Button : {
        'Add column'    : 'Kolom toevoegen',
        'Remove column' : 'Kolom verwijderen',
        'Display hints' : 'Hints weergeven',
        Apply           : 'Еoepassen'
    },

    Checkbox : {
        'Auto apply'  : 'Automatisch toepassen',
        Automatically : 'Automatisch'
    },

    CodeEditor : {
        'Code editor'   : 'Code editor',
        'Download code' : 'Download code'
    },

    Column : {
        Duration : 'Looptijd',
        Finish   : 'Af hebben',
        Name     : 'Naam',
        Start    : 'Begin',
        WBS      : 'WBS'
    },

    Combo : {
        Theme    : 'Selecteer thema',
        Language : 'Selecteer landinstelling',
        Size     : 'Selecteer grootte'
    },

    Shared : {
        'Full size'      : 'Volledige grootte',
        'Locale changed' : 'Taal is veranderd',
        'Phone size'     : 'Grootte telefoon'
    },

    Tooltip : {
        infoButton       : 'Klik om informatie weer te geven en van thema of land te wisselen',
        codeButton       : 'Klik om de ingebouwde code-editor te tonen',
        hintCheck        : 'Vink deze optie aan om automatisch hints weer te geven bij het laden van het voorbeeld',
        fullscreenButton : 'Volledig scherm'
    }

};

// Publishing locales to be loaded automatically (for umd bundles)
LocaleHelper.publishLocale('Nl', Nl);
LocaleHelper.publishLocale('Nl-Custom', customNlLocale);
//</umd>

// Or extending locales directly for app which uses source code
LocaleManager.extendLocale('Nl', customNlLocale);
