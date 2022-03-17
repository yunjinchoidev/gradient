# Localization

Bryntum Gantt uses locales for translations of texts, date formats and such. This guide shows you how to use one of the
locales that Bryntum Gantt ships with and how to create your own.

## Use an included locale

Bryntum Gantt ships with a collection of locales, located under `build/locales`. These locales are in UMD format and can
be included on page using normal script tags:

```html
<script src="build/locales/gantt.locale.SvSE.js"></script>
```

Each included locale gets registered in a global namespace (bryntum.locales), which is later checked by the Gantt's
[LocaleManager](#Core/localization/LocaleManager). Therefore it is important that they are loaded before the Gantt, so
that their script tags are above the tag for the umd bundle:

```html
<script src="build/locales/gantt.locale.SvSE.js"></script>
<script src="build/gantt.umd.js"></script>
```

The first included locale becomes the default locale, but you can override it by setting the attribute of the script tag
in any order. For example, to set the Dutch locale as the default one use the following tag:

```html
<script data-default-locale="Nl" src="build/gantt.umd.js"></script>
```

Please note that the English locale is part of the Gantt bundle so you never need to include it separately. You can also
use LocaleManager from code to switch locale at any point:

```javascript
// using module bundle
LocaleManager.locale = 'SvSE';

// also possible to reach it from the gantt instance
gantt.localeManager.locale = 'SvSE';
```

## Including a locale in React

The approach described above (using a script tag) should work for all frameworks, but, if you are using a React +
WebPack approach (or similar) you have also the option to include the locale using `import`.

```javascript
import { LocaleManager } from '@bryntum/gantt/gantt.umd';
import SvSE from '@bryntum/gantt/locales/gantt.locale.SvSE';

LocaleManager.locale = SvSE;
```

## Create a custom locale

<a href="../examples/localization" target="_blank">The localization demo</a> has a
custom locale (German, `custom.locale.De.js`). You can inspect it and the demo to see how to create your own and how to
include it.

The translation of Gantt strings is grouped by Gantt class names. Here is a small excerpt from the English locale:

```javascript
Dependencies : {
    from    : 'From',
    to      : 'To',
    valid   : 'Valid',
    invalid : 'Invalid'
},

EventEdit : {
    nameText     : 'Name',
    resourceText : 'Resource',
    startText    : 'Start',
    endText      : 'End',
    saveText     : 'Save',
    deleteText   : 'Delete',
    cancelText   : 'Cancel',
    editEvent    : 'Edit event'
}
```

To translate, replace the string part (like "Edit event") with your translation.

## Register and apply locale

When creating a separate localization file, there are 2 options to register the locale it describes:

- Call [registerLocale](#Core/localization/LocaleManager#function-registerLocale) on the LocaleManager with the
  translation you created:

```javascript
LocaleManager.registerLocale('Es', {
    desc : 'Spanish', locale : {
        localeName : 'Es',
        localeDesc : 'Spanish',
        /* other localization */
    }
});
```

- Set the locale to `window.bryntum.locales`. [LocaleManager](#Core/localization/LocaleManager) will
  register all locales specified this way:

```javascript
// prepare namespace
window.bryntum = window.bryntum || {};
window.bryntum.locales = window.bryntum.locales || {};
// register locale
window.bryntum.locales.Es = {
    localeName : 'Es',
    localeDesc : 'Spanish',
    /* other localization */
}
```

To apply the newly created locale, call [applyLocale](#Core/localization/LocaleManager#function-applyLocale) on
the LocaleManager with the locale name:

```javascript
LocaleManager.applyLocale('Es');
```

## Change date formats

Dates are formatted
using [Intl.DateTimeFormat](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat)
. Full list of locales according to BCP 47 standard is
available [here](http://www.iana.org/assignments/language-subtag-registry/language-subtag-registry). When you create a
custom locale, you need to update DateHelper.locale property according to your country code. For example, if you create
Spanish locale, you need to set:

```javascript
const locale = {
    DateHelper : {
        locale : 'es-ES'
    }
}

LocaleManager.registerLocale('Es', { desc : 'Spanish', locale : locale });
```

Gantt uses ViewPresets to configure the time axis header and the date format used by tooltips and similar. A ViewPreset,
among other things, defines the rows displayed in the time axis header, from one to three levels named bottom, middle
and top. When creating a custom locale, you might want to change the date format for these levels to suite your needs.
This can be achieved by creating an entry for PresetManager with sub entries per ViewPreset.

```javascript
const locale = {

    // ... Other translations here ...

    PresetManager : {
        minuteAndHour : {
            topDateFormat : 'ddd DD.MM, HH:mm'
        },
        hourAndDay    : {
            topDateFormat : 'ddd DD.MM'
        },
        weekAndDay    : {
            displayDateFormat : 'HH:mm'
        }
    }
}

LocaleManager.extendLocale('En', locale);

```

This table lists all the built in ViewPresets, the unit and the date formats they use for the header levels:

|Preset          |Bottom       |Middle                 |Top                  |
|----------------|-------------|-----------------------|---------------------|
|secondAndMinute |             |second, `ss`           |minute, `llll`       |
|minuteAndHour   |             |minute, `mm`           |hour, `ddd MM/DD, hA`|
|hourAndDay      |             |hour, `LT`             |day, `ddd DD/MM`     |
|day             |hour, *      |day, `ddd DD/MM`       |                     |
|dayAndWeek      |             |day, `dd DD`           |week, *              |
|weekAndDay      |day, `DD MMM`|week, `YYYY MMMM DD`   |                     |
|weekAndDayLetter|day, *       |week, `ddd DD MMM YYYY`|                     |
|week            |hour, *      |week, `D d`            |                     |
|weekAndMonth    |             |week, `DD MMM`         |month, `MMM YYYY`    |
|weekDateAndMonth|             |week, `DD`             |month, `YYYY MMMM`   |
|monthAndYear    |             |month, `MMM YYYY`      |year, `YYYY`         |
|year            |             |quarter, *             |year, `YYYY`         |
|manyYears       |year, `YYYY` |year, `YY`             |                     |

In case you want to localize date formats for the default zoom levels in Gantt, these are the ViewPresets used:

* manyYears
* year
* monthAndYear
* weekDateAndMonth
* weekAndMonth
* weekAndDayLetter
* weekAndDay
* hourAndDay
* minuteAndHour
* secondAndMinute

## Change single entries

It is also possible to change the translation of most items one by one at runtime. Try the following approach, but
please note that any string already displayed will not change:

```javascript
gantt.localeManager.locale.EventEdit.deleteText = 'Scrap it';
```


<p class="last-modified">Last modified on 2022-03-04 9:57:13</p>