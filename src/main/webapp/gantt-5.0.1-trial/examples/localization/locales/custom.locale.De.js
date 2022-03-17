// prepare "namespace"
window.bryntum         = window.bryntum || {};
window.bryntum.locales = window.bryntum.locales || {};

// This will be a truthy empty string so it can be used as a localized result.
const emptyString = new String(); // eslint-disable-line no-new-wrappers

// put the locale under window.bryntum.locales to make sure it is discovered automatically
window.bryntum.locales.De = {

    localeName : 'De',
    localeDesc : 'Deutsch',

    App : {
        'Localization demo' : 'Lokalisierungs-Demo'
    },

    //region Common

    Object : {
        Yes      : 'Ja',
        No       : 'Nein',
        Cancel   : 'Stornieren',
        Ok       : 'OK',
        Save     : 'Sparen',
        newEvent : 'neues Event'
    },

    //endregion

    //region Shared localization

    Button : {
        'Add column'    : 'Spalte hinzufügen',
        Apply           : 'Anwenden',
        'Display hints' : 'Tipps anzeigen',
        'Remove column' : 'Spalte entfernen'
    },

    Checkbox : {
        'Auto apply'    : 'Automatisch anwenden',
        Automatically   : 'Automatisch',
        toggleRowSelect : 'Zeilenauswahl umschalten',
        toggleSelection : 'Auswahl des gesamten Datensatzes umschalten'
    },

    CodeEditor : {
        'Code editor'   : 'Code-Editor',
        'Download code' : 'Code herunterladen'
    },

    Combo : {
        noResults          : 'Keine Ergebnisse',
        Theme              : 'Thema wählen',
        Language           : 'Gebietsschema auswählen',
        Size               : 'Wähle die Größe aus',
        recordNotCommitted : 'Datensatz konnte nicht hinzugefügt werden',
        addNewValue        : value => `${value} hinzufügen`
    },

    Tooltip : {
        infoButton       : 'Klicken Sie hier, um Informationen anzuzeigen und das Thema oder Gebietsschema zu wechseln',
        codeButton       : 'Klicken Sie hier, um den integrierten Code-Editor anzuzeigen',
        hintCheck        : 'Aktivieren Sie diese Option, um beim Laden des Beispiels automatisch Hinweise anzuzeigen',
        fullscreenButton : 'Ganzer Bildschirm'
    },

    Shared : {
        'Locale changed' : 'Sprache geändert',
        'Full size'      : 'Volle Größe',
        'Phone size'     : 'Telefongröße'
    },

    UndoRedo : {
        Undo           : 'Rückgängig machen',
        Redo           : 'Wiederholen',
        UndoLastAction : 'Letzte Aktion rückgängig machen',
        RedoLastAction : 'Wiederholen Sie die letzte rückgängig gemachte Aktion'
    },

    //endregion

    //region Columns

    InactiveColumn : {
        Inactive : 'Inaktiv'
    },

    AddNewColumn : {
        'New Column' : 'Neue Spalte hinzufügen...'
    },

    EarlyStartDateColumn : {
        'Early Start' : 'Frühes Startdatum'
    },

    EarlyEndDateColumn : {
        'Early End' : 'Frühes Ende'
    },

    LateStartDateColumn : {
        'Late Start' : 'Später Start'
    },

    LateEndDateColumn : {
        'Late End' : 'Spätes Ende'
    },

    TotalSlackColumn : {
        'Total Slack' : 'Gesamte Pufferzeit'
    },

    CalendarColumn : {
        Calendar : 'Kalender'
    },

    ConstraintDateColumn : {
        'Constraint Date' : 'Einschränkung Datum'
    },

    ConstraintTypeColumn : {
        'Constraint Type' : 'Einschränkung'
    },

    DeadlineDateColumn : {
        Deadline : 'Frist'
    },

    DependencyColumn : {
        'Invalid dependency' : 'Ungültige Abhängigkeit gefunden, Änderung rückgängig gemacht'
    },

    DurationColumn : {
        Duration : 'Dauer'
    },

    EffortColumn : {
        Effort : 'Aufwand'
    },

    EndDateColumn : {
        Finish : 'Fertig stellen'
    },

    EventModeColumn : {
        'Event mode' : 'Ereignismodus',
        Manual       : 'Manuell',
        Auto         : 'Auto'
    },

    ManuallyScheduledColumn : {
        'Manually scheduled' : 'Manuell geplant'
    },

    MilestoneColumn : {
        Milestone : 'Meilenstein'
    },

    NameColumn : {
        Name : 'Vorgangsname'
    },

    NoteColumn : {
        Note : 'Notiz'
    },

    PercentDoneColumn : {
        '% Done' : '% erledigt'
    },

    PredecessorColumn : {
        Predecessors : 'Vorgänger'
    },

    ResourceAssignmentColumn : {
        'Assigned Resources' : 'Zugwiesene Ressourcen',
        'more resources'     : 'Zusätzliche Ressourcen'
    },

    ResourceInfoColumn : {
        eventCountText : function(data) {
            return data + ' Veranstaltung' + (data !== 1 ? 'en' : '');
        }
    },

    RollupColumn : {
        Rollup : 'Rollup'
    },

    SchedulingModeColumn : {
        'Scheduling Mode' : 'Modus'
    },

    ShowInTimelineColumn : {
        'Show in timeline' : 'Zur Zeitachse hinzufügen'
    },

    SequenceColumn : {
        Sequence : '#'
    },

    StartDateColumn : {
        Start : 'Anfang'
    },

    SuccessorColumn : {
        Successors : 'Nachfolger'
    },

    WBSColumn : {
        WBS      : 'WBS',
        renumber : 'Neu nummerieren'
    },

    //endregion

    //region Engine

    ConflictEffectDescription : {
        descriptionTpl : 'Diese Aktion führt zu einem Planungskonflikt für: {0} und {1}'
    },

    ConstraintIntervalDescription : {
        dateFormat : 'LL'
    },

    ProjectConstraintIntervalDescription : {
        startDateDescriptionTpl : 'Projektanfangstermin {0}',
        endDateDescriptionTpl   : 'Projektendtermin {0}'
    },

    DependencyConstraintIntervalDescription : {
        descriptionTpl : 'Abhängigkeit ({2}) von "{3}" zu "{4}"'
    },

    RemoveDependencyResolution : {
        descriptionTpl : 'Lösche Abhängigkeit von "{1}" zu "{2}"'
    },

    DeactivateDependencyResolution : {
        descriptionTpl : 'Deaktiviere Abhängigkeit von "{1}" zu "{2}"'
    },

    DateConstraintIntervalDescription : {
        startDateDescriptionTpl : 'Aufgabe "{2}" {3} {0} Einschränkung',
        endDateDescriptionTpl   : 'Aufgabe "{2}" {3} {1} Einschränkung',
        constraintTypeTpl       : {
            startnoearlierthan  : 'Muss anfangen am',
            startnolaterthan    : 'Muss enden am',
            muststarton         : 'Ende nicht früher als',
            mustfinishon        : 'Ende nicht später als',
            finishnoearlierthan : 'Anfang nicht früher als',
            finishnolaterthan   : 'Anfang nicht später als'
        }
    },

    RemoveDateConstraintConflictResolution : {
        descriptionTpl : 'Einschränkung "{1}" aufheben'
    },

    RemoveDependencyCycleEffectResolution : {
        descriptionTpl : 'Lösche Abhängigkeit'
    },

    DeactivateDependencyCycleEffectResolution : {
        descriptionTpl : 'Deaktiviere Abhängigkeit'
    },

    CycleEffectDescription : {
        descriptionTpl : 'Ein Planungszyklus wurde gefunden. Die folgenden Aufgaben bilden den Planungszyklus: {0}'
    },

    EmptyCalendarEffectDescription : {
        descriptionTpl : '"{0}" Kalender hat keine Arbeitszeitintervalle.'
    },

    Use24hrsEmptyCalendarEffectResolution : {
        descriptionTpl : 'Verwenden Sie den 24-Stunden-Kalender (Montag - Freitag).'
    },

    Use8hrsEmptyCalendarEffectResolution : {
        descriptionTpl : 'Verwenden Sie den 8-Stunden-Kalender (Montag - Freitag 08:00-12:00, 13:00-17:00).'
    },

    //endregion

    //region Gantt

    DependencyField : {
        invalidDependencyFormat : 'Ungültige Abhängigkeit Format'
    },

    ProjectLines : {
        'Project Start' : 'Projektstart',
        'Project End'   : 'Projektabende'
    },

    TaskTooltip : {
        Start    : 'Beginnt',
        End      : 'Endet',
        Duration : 'Dauer',
        Complete : 'Erledigt'
    },

    AssignmentGrid : {
        Name     : 'Ressourcenname',
        Units    : 'Einheiten',
        unitsTpl : function(value) {
            return value.value ? value.value + '%' : '';
        }
    },

    SchedulerProBase : {
        propagating     : 'Projekt berechnen',
        storePopulation : 'Daten werden geladen',
        finalizing      : 'Finalisieren'
    },

    Gantt : {
        Edit                   : 'Buchung redigieren',
        Indent                 : 'Herunterstufen',
        Outdent                : 'Heraufstufen',
        'Convert to milestone' : 'Zu Meilenstein konvertieren',
        Add                    : 'Hinzufügen...',
        'New task'             : 'Neue Aufgabe',
        'New milestone'        : 'Neue Meilenstein',
        'Task above'           : 'Aufgabe vor',
        'Task below'           : 'Aufgabe unter',
        'Delete task'          : 'Lösche Aufgabe(n)',
        Milestone              : 'Meilenstein',
        'Sub-task'             : 'Unteraufgabe',
        Successor              : 'Nachfolger',
        Predecessor            : 'Vorgänger',
        changeRejected         : 'Scheduling Engine hat die Änderungen abgelehnt'
    },

    Indicators : {
        earlyDates   : 'Früh  start/ende',
        lateDates    : 'Spät start/ende',
        deadlineDate : 'Frist',
        Start        : 'Start',
        End          : 'Ende'
    },

    SchedulingIssueResolutionPopup : {
        'Cancel changes'   : 'Abbrechen der Änderung',
        schedulingConflict : 'Planungskonflikt',
        emptyCalendar      : 'Kalenderfehler',
        cycle              : 'Planungszyklus',
        Apply              : 'Verwenden'
    },

    CycleResolutionPopup : {
        dependencyLabel        : 'Bitte wählen Sie eine Abhängigkeit aus, um eine untenstehende Änderung auf anzuwenden:',
        invalidDependencyLabel : 'Es gibt ungültige Abhängigkeiten, die behoben werden müssen:'
    },

    //endregion

    //region SchedulerPro

    DependencyType : {
        SS           : 'AA',
        SF           : 'EA',
        FS           : 'AE',
        FF           : 'EE',
        StartToStart : 'Anfang-Anfang',
        StartToEnd   : 'Anfang-Ende',
        EndToStart   : 'Enge-Anfang',
        EndToEnd     : 'Enge-Ende',
        short        : [
            'AA',
            'EA',
            'AE',
            'EE'
        ],
        long : [
            'Anfang-Anfang',
            'Anfang-Ende',
            'Enge-Anfang',
            'Enge-Ende'
        ]
    },

    ConstraintTypePicker : {
        none                : 'Keiner',
        muststarton         : 'Ende nicht früher als',
        mustfinishon        : 'Ende nicht später als',
        startnoearlierthan  : 'Muss anfangen am',
        startnolaterthan    : 'Muss enden am',
        finishnoearlierthan : 'Anfang nicht früher als',
        finishnolaterthan   : 'Anfang nicht später als'
    },

    CalendarField : {
        'Default calendar' : 'Standardkalender'
    },

    TaskEditorBase : {
        Information   : 'Informationen',
        Save          : 'Sparen',
        Cancel        : 'Stornieren',
        Delete        : 'Löschen',
        calculateMask : 'Aufgaben berechnen...',
        saveError     : 'Kann nicht speichern, bitte korrigieren Sie zuerst die Fehler'
    },

    SchedulerTaskEditor : {
        editorWidth : '30em'
    },

    GanttTaskEditor : {
        editorWidth : '54em'
    },

    SchedulerGeneralTab : {
        labelWidth   : '15em',
        General      : 'Generell',
        Name         : 'Name',
        Resources    : 'Resourcen',
        '% complete' : 'Abgeschlossen in Prozent',
        Duration     : 'Dauer',
        Start        : 'Start',
        Finish       : 'Ende',
        Preamble     : 'Präambel',
        Postamble    : 'Postambel'
    },

    SchedulerAdvancedTab : {
        labelWidth           : '15em',
        Advanced             : 'Fortgeschritten',
        Calendar             : 'Kalender',
        'Manually scheduled' : 'Manuell geplant',
        'Constraint type'    : 'Einschränkungstyp',
        'Constraint date'    : 'Datum der Einschränkung',
        Inactive             : 'Inaktiv'
    },

    GeneralTab : {
        labelWidth   : '15em',
        General      : 'Generell',
        Name         : 'Name',
        '% complete' : 'Abgeschlossen in Prozent',
        Duration     : 'Dauer',
        Start        : 'Start',
        Finish       : 'Ende',
        Effort       : 'Anstrengung',
        Dates        : 'Datumsangaben'
    },

    AdvancedTab : {
        labelWidth           : '15em',
        Advanced             : 'Fortgeschritten',
        Calendar             : 'Kalender',
        'Scheduling mode'    : 'Planungsmodus',
        'Effort driven'      : 'Mühe getrieben',
        'Manually scheduled' : 'Manuell geplant',
        'Constraint type'    : 'Einschränkungstyp',
        'Constraint date'    : 'Datum der Einschränkung',
        Constraint           : 'Einschränkung',
        Rollup               : 'Rollup',
        Inactive             : 'Inaktiv'
    },

    DependencyTab : {
        Predecessors      : 'Vorgänger',
        Successors        : 'Nachfolger',
        ID                : 'ID',
        Name              : 'Name',
        Type              : 'Typ',
        Lag               : 'Verzögern',
        cyclicDependency  : 'Die zyklische Abhängigkeit wurde erkannt',
        invalidDependency : 'Ungültige Abhängigkeit'
    },

    ResourcesTab : {
        Resources : 'Ressourcen',
        Resource  : 'Ressource',
        Units     : 'Einheiten',
        unitsTpl  : function(value) {
            return value.value ? value.value + '%' : '';
        }
    },

    NotesTab : {
        Notes : 'Notizen'
    },

    SchedulingModePicker : {
        Normal           : 'Normal',
        'Fixed Duration' : 'Feste Dauer',
        'Fixed Units'    : 'Feste Einheiten',
        'Fixed Effort'   : 'Feste Arbeit'
    },

    ResourceHistogram : {
        barTipInRange         : '<b>{resource}</b> {startDate} - {endDate}<br>{allocated} von {available} verfügbar',
        barTipOnDate          : '<b>{resource}</b> am {startDate}<br>{allocated} von {available} verfügbar',
        groupBarTipAssignment : '<b>{resource}</b> - <span class="{cls}">{allocated} von {available}</span>',
        groupBarTipInRange    : '{startDate} - {endDate}<br><span class="{cls}">{allocated} von {available}</span> vergeben:<br>{assignments}',
        groupBarTipOnDate     : 'Am {startDate}<br><span class="{cls}">{allocated} von {available}</span> vergeben:<br>{assignments}',
        plusMore              : '+{value} mehr'
    },

    ResourceUtilization : {
        barTipInRange         : '<b>{event}</b> {startDate} - {endDate}<br><span class="{cls}">{allocated}</span> verfügbar',
        barTipOnDate          : '<b>{event}</b> am {startDate}<br><span class="{cls}">{allocated}</span> allocated',
        groupBarTipAssignment : '<b>{event}</b> - <span class="{cls}">{allocated}</span>',
        groupBarTipInRange    : '{startDate} - {endDate}<br><span class="{cls}">{allocated} von {available}</span> vergeben:<br>{assignments}',
        groupBarTipOnDate     : 'Am {startDate}<br><span class="{cls}">{allocated} von {available}</span> allocated:<br>{assignments}',
        plusMore              : '+{value} mehr',
        nameColumnText        : 'Ressource / Aufgabe'
    },

    //endregion

    //region Mixins

    CrudManagerView : {
        serverResponseLabel : 'Serverantwort:'
    },

    //endregion

    //region Features

    ColumnPicker : {
        column          : 'Splate',
        columnsMenu     : 'Spalten',
        hideColumn      : 'Versteck spalte',
        hideColumnShort : 'Versteck',
        newColumns      : 'Neue Spalten'
    },

    Filter : {
        applyFilter  : 'Filter anwenden',
        filter       : 'Filter',
        editFilter   : 'Filter redigieren',
        on           : 'Auf',
        before       : 'Vor',
        after        : 'Nach',
        equals       : 'Gleichen',
        lessThan     : 'Weniger als',
        moreThan     : 'Mehr als',
        removeFilter : 'Filter entfernen'
    },

    FilterBar : {
        enableFilterBar  : 'Filterleiste anzeigen',
        disableFilterBar : 'Filterleiste ausblenden'
    },

    Group : {
        group                : 'Gruppe',
        groupAscending       : 'Aufsteigend gruppieren',
        groupDescending      : 'Absteigend gruppieren',
        groupAscendingShort  : 'Aufsteigend',
        groupDescendingShort : 'Absteigend',
        stopGrouping         : 'Stoppen gruppierung',
        stopGroupingShort    : 'Stoppen'
    },

    HeaderMenu : {
        moveBefore : text => `Verschieben Sie vor "${text}"`,
        moveAfter  : text => `Verschieben Sie nach "${text}"`
    },

    MergeCells : {
        mergeCells  : 'Zellen zusammenführen',
        menuTooltip : 'Zellen mit gleichem Inhalt zusammenführen, wenn nach dieser Spalte sortiert'
    },

    Search : {
        searchForValue : 'Suche nach Wert'
    },

    Sort : {
        sort                   : 'Sorte',
        sortAscending          : 'Aufsteigend sortierung',
        sortDescending         : 'Absteigend sortierung',
        multiSort              : 'Multi sortieren',
        removeSorter           : 'Sortierung entfernen',
        addSortAscending       : 'Aufsteigend sortieren hinzufügen',
        addSortDescending      : 'Absteigend sortieren hinzufügen',
        toggleSortAscending    : 'Ändern Sie auf aufsteigend',
        toggleSortDescending   : 'Zu absteigend wechseln',
        sortAscendingShort     : 'Aufsteigend',
        sortDescendingShort    : 'Absteigend',
        removeSorterShort      : 'Entfernen',
        addSortAscendingShort  : '+ Aufsteigend',
        addSortDescendingShort : '+ Absteigend'
    },

    Summary : {
        'Summary for' : function(date) {
            return 'Zusammenfassung für ' + date;
        }
    },

    //endregion

    //region Trial

    TrialButton : {
        downloadTrial : 'Demo herunterladen'
    },

    TrialPanel : {
        title            : 'Bitte Felder ausfüllen',
        name             : 'Name',
        email            : 'Email',
        company          : 'Gesellschaft',
        product          : 'Produkt',
        cancel           : 'Abbrechen',
        submit           : 'Einreichen',
        downloadStarting : 'Download startet, bitte warten...'
    },

    //endregion

    //region Grid

    RatingColumn : {
        cellLabel : column => `${column.text} ${column.location?.record ? `Bewertung : ${column.location.record[column.field]}` : ''}`
    },

    GridBase : {
        loadFailedMessage  : 'Wird geladen, bitte versuche es erneut!',
        syncFailedMessage  : 'Datensynchronisation fehlgeschlagen!',
        unspecifiedFailure : 'Nicht spezifizierter Fehler',
        networkFailure     : 'Netzwerkfehler',
        parseFailure       : 'Serverantwort konnte nicht analysiert werden',
        loadMask           : 'Laden...',
        syncMask           : 'Speichere Änderungen, bitte warten...',
        noRows             : 'Keine Zeilen zum Anzeigen',
        moveColumnLeft     : 'Bewegen Sie sich zum linken Bereich',
        moveColumnRight    : 'Bewegen Sie sich nach rechts',
        moveColumnTo       : function(region) {
            return 'Spalte verschieben nach ' + region;
        }
    },

    CellMenu : {
        removeRow : 'Zeile'
    },

    //region Export

    PdfExport : {
        'Waiting for response from server' : 'Warten auf Antwort vom Server...',
        'Export failed'                    : 'Export fehlgeschlagen',
        'Server error'                     : 'Serverfehler',
        'Generating pages'                 : 'Seiten generieren...'
    },

    ExportDialog : {
        width          : '40em',
        labelWidth     : '12em',
        exportSettings : 'Exporteinstellungen',
        export         : 'Export',
        exporterType   : 'Kontrolliere die Paginierung',
        cancel         : 'Stornieren',
        fileFormat     : 'Datei Format',
        rows           : 'Reihen',
        alignRows      : 'Zeilen ausrichten',
        columns        : 'Säulen',
        paperFormat    : 'Papierformat',
        orientation    : 'Orientierung',
        repeatHeader   : 'Header wiederholen'
    },

    ExportRowsCombo : {
        all     : 'Alle Zeilen',
        visible : 'Sichtbare Zeilen'
    },

    ExportOrientationCombo : {
        portrait  : 'Porträt',
        landscape : 'Landschaft'
    },

    RowCopyPaste : {
        copyRecord  : 'Kopieren',
        cutRecord   : 'Schnittn',
        pasteRecord : 'Einfügen'
    },

    EventCopyPaste : {
        copyEvent  : 'Kopieren',
        cutEvent   : 'Schnitt',
        pasteEvent : 'Einfügen'
    },

    TaskCopyPaste : {
        copyTask  : 'Kopieren',
        cutTask   : 'Schnitt',
        pasteTask : 'Einfügen'
    },

    SinglePageExporter : {
        singlepage : 'Einzelne Seite'
    },

    MultiPageExporter : {
        multipage     : 'Mehrere Seiten',
        exportingPage : function(data) {
            return 'Seite exportieren ' + data.currentPage + '/' + data.totalPages;
        }
    },

    MultiPageVerticalExporter : {
        multipagevertical : 'Mehrere Seiten (vertikal)',
        exportingPage     : function(data) {
            return 'Seite exportieren ' + data.currentPage + '/' + data.totalPages;
        }
    },

    ScheduleRangeCombo : {
        completeview : 'Vollständiger Zeitplan',
        currentview  : 'Sichtbarer Zeitplan',
        daterange    : 'Datumsbereich',
        completedata : 'Vollständiger Zeitplan (für alle Veranstaltungen)'
    },

    SchedulerExportDialog : {
        'Schedule range' : 'Zeitplanbereich ',
        'Export from'    : 'Von',
        'Export to'      : 'Zu'
    },

    //endregion

    //endregion

    //region Widgets

    FilePicker : {
        file : 'Datei'
    },

    DateField : {
        invalidDate : 'Ungültige Datumseingabe'
    },

    DatePicker : {
        gotoPrevYear  : 'Gehe zum Vorjahr',
        gotoPrevMonth : 'Gehe zum vorherigen Monat',
        gotoNextMonth : 'Weiter zum nächsten Monat',
        gotoNextYear  : 'Weiter zum nächsten Jahr'
    },

    Field : {
        // native input ValidityState statuses
        badInput        : 'Ungültiger Feldwert',
        patternMismatch : 'Der Wert sollte einem bestimmten Muster entsprechen',
        rangeOverflow   : function(value) {
            return 'Der Wert muss größer als oder gleich ' + value.max + ' sein';
        },
        rangeUnderflow : function(value) {
            return 'Der Wert muss größer als oder gleich ' + value.min + ' sein';
        },
        stepMismatch : 'Der Wert sollte zum Schritt passen',
        tooLong      : 'Der Wert sollte kürzer sein',
        tooShort     : 'Der Wert sollte länger sein',
        typeMismatch : 'Der Wert muss in einem speziellen Format vorliegen',
        valueMissing : 'Dieses Feld wird benötigt',

        invalidValue          : 'Ungültiger Feldwert',
        minimumValueViolation : 'Mindestwertverletzung',
        maximumValueViolation : 'Maximalwertverletzung',
        fieldRequired         : 'Dieses Feld wird benötigt',
        validateFilter        : 'Der Wert muss aus der Liste ausgewählt werden'
    },

    List : {
        loading : 'Beladung...'
    },

    PagingToolbar : {
        firstPage : 'Gehe zur ersten Seite',
        prevPage  : 'Zurück zur letzten Seite',
        page      : 'Seite',
        nextPage  : 'Gehe zur nächsten Seite',
        lastPage  : 'Gehe zur letzten Seite',
        reload    : 'Aktuelle Seite neu laden',
        noRecords : 'Keine Zeilen zum Anzeigen',
        pageCountTemplate(store) {
            return `von ${store.lastPage}`;
        },
        summaryTemplate(store) {
            const start = (store.currentPage - 1) * store.pageSize + 1;

            return `Ergebnisse ${start} - ${start + store.pageSize - 1} von ${store.allCount}`;
        }
    },

    PanelCollapser : {
        Collapse : 'Reduzieren',
        Expand   : 'Erweitern'
    },

    Popup : {
        close : 'Popup schließen'
    },

    NumberFormat : {
        locale   : 'de',
        currency : 'EUR'
    },

    DurationField : {
        invalidUnit : 'Ungültige Einheit'
    },

    TimeField : {
        invalidTime : 'Ungültige Zeitangabe'
    },

    TimePicker : {
        hour   : 'Stunde',
        minute : 'Minute'
    },

    //endregion

    //region Dates

    DateHelper : {
        locale         : 'de',
        weekStartDay   : 1,
        // Non-working days which match weekends by default, but can be changed according to schedule needs
        nonWorkingDays : {
            0 : true,
            6 : true
        },
        // Days considered as weekends by the selected country, but could be working days in the schedule
        weekends : {
            0 : true,
            6 : true
        },
        unitNames : [
            { single : 'Millisekunde', plural : 'Millisekunden', abbrev : 'ms' },
            { single : 'Sekunde', plural : 'Sekunden', abbrev : 's' },
            { single : 'Minute', plural : 'Minuten', abbrev : 'min' },
            { single : 'Stunde', plural : 'Stunden', abbrev : 'std' },
            { single : 'Tag', plural : 'Tage', abbrev : 't' },
            { single : 'Woche', plural : 'Wochen', abbrev : 'W' },
            { single : 'Monat', plural : 'Monathe', abbrev : 'mon' },
            { single : 'Quartal', plural : 'Quartal', abbrev : 'Q' },
            { single : 'Jahr', plural : 'Jahre', abbrev : 'jahr' },
            { single : 'Dekade', plural : 'Jahrzehnte', abbrev : 'dek' }
        ],
        // Used to build a RegExp for parsing time units.
        // The full names from above are added into the generated Regexp.
        // So you may type "2 w" or "2 wk" or "2 week" or "2 weeks" into a DurationField.
        // When generating its display value though, it uses the full localized names above.
        unitAbbreviations : [
            ['mil'],
            ['s', 'sec'],
            ['m', 'min'],
            ['h', 'hr'],
            ['d'],
            ['w', 'wk'],
            ['mo', 'mon', 'mnt'],
            ['q', 'quar', 'qrt'],
            ['y', 'yr'],
            ['dek']
        ],
        parsers : {
            L  : 'DD.MM.YYYY',
            LT : 'HH:mm'
        },
        ordinalSuffix : function(number) {
            return number;
        }
    },

    //endregion

    //region Scheduler

    ExcelExporter : {
        'No resource assigned' : 'Keine Ressource zugewiesen'
    },

    Dependencies : {
        from    : 'Von',
        to      : 'Zo',
        valid   : 'Gültig',
        invalid : 'Ungültig'
    },

    DependencyEdit : {
        From              : 'Von',
        To                : 'Zu',
        Type              : 'Typ',
        Lag               : 'Verzögern',
        'Edit dependency' : 'Abhängigkeit bearbeiten',

        Save         : 'Speichern',
        Delete       : 'Löschen',
        Cancel       : 'Abbrechen',
        StartToStart : 'Anfang-Anfang',
        StartToEnd   : 'Anfang-Ende',
        EndToStart   : 'Ende-Anfang',
        EndToEnd     : 'Ende-Ende',

        // this field appears in the Gantt
        Active : 'Aktiv'
    },

    EventEdit : {
        Name         : 'Name',
        Resource     : 'Ressource',
        Start        : 'Start',
        End          : 'Ende',
        Save         : 'Speichern',
        Delete       : 'Löschen',
        Cancel       : 'Abbrechen',
        'Edit event' : 'Buchung redigieren',
        Repeat       : 'Wiederholen'
    },

    TaskEdit : {
        'Edit task'            : 'Aufgabe bearbeiten',
        ConfirmDeletionTitle   : 'Löschung bestätigen',
        ConfirmDeletionMessage : 'Möchten Sie das Ereignis wirklich löschen?'
    },

    SchedulerBase : {
        'Add event'      : 'Ereignis hinzufügen',
        'Delete event'   : 'Buchung löschen',
        'Unassign event' : 'Ereignis nicht zuordnen'
    },

    EventDrag : {
        eventOverlapsExisting : 'Ereignis überlappt vorhandenes Ereignis für diese Ressource',
        noDropOutsideTimeline : 'Event wird möglicherweise nicht vollständig außerhalb der Timeline gelöscht'
    },

    TimeAxisHeaderMenu : {
        pickZoomLevel   : 'Zoomen',
        activeDateRange : 'Datumsbereich',
        startText       : 'Anfangsdatum',
        endText         : 'Endtermin',
        todayText       : 'Heute'
    },

    EventFilter : {
        filterEvents : 'Aufgaben filtern',
        byName       : 'Namentlich'
    },

    TimeRanges : {
        showCurrentTimeLine : 'Aktuelle Zeitleiste anzeigen'
    },

    PresetManager : {
        minuteAndHour : {
            topDateFormat : 'ddd DD.MM, HH:mm'
        },
        hourAndDay : {
            topDateFormat : 'ddd DD.MM'
        },
        weekAndDay : {
            displayDateFormat : 'HH:mm'
        }
    },

    RecurrenceConfirmationPopup : {
        'delete-title'              : 'Du löschst ein Ereignis',
        'delete-all-message'        : 'Möchten Sie alle Vorkommen dieses Ereignisses löschen?',
        'delete-further-message'    : 'Möchten Sie dieses und alle zukünftigen Vorkommen dieses Ereignisses oder nur das ausgewählte Vorkommen löschen?',
        'delete-further-btn-text'   : 'Alle zukünftigen Ereignisse löschen',
        'delete-only-this-btn-text' : 'Nur dieses Ereignis löschen',

        'update-title'              : 'Sie ändern ein sich wiederholendes Ereignis',
        'update-all-message'        : 'Möchten Sie alle Vorkommen dieses Ereignisses ändern?',
        'update-further-message'    : 'Möchten Sie nur dieses Vorkommen des Ereignisses oder dieses und aller zukünftigen Ereignisse ändern?',
        'update-further-btn-text'   : 'Alle zukünftigen Ereignisse',
        'update-only-this-btn-text' : 'Nur dieses Ereignis',

        Yes    : 'Ja',
        Cancel : 'Abbrechen',

        width : 600
    },

    RecurrenceLegend : {
        // list delimiters
        ' and '         : ' und ',
        // frequency patterns
        Daily           : 'Täglich',
        'Weekly on {1}' : function(data) {
            return 'Wöchentlich am ' + data.days;
        },
        'Monthly on {1}' : function(data) {
            return 'Monatlich am ' + data.days;
        },
        'Yearly on {1} of {2}' : function(data) {
            return 'Jährlich am ' + data.days + ' von ' + data.months;
        },
        'Every {0} days' : function(data) {
            return 'Alle ' + data.interval + ' Tage';
        },
        'Every {0} weeks on {1}' : function(data) {
            return 'Alle ' + data.interval + ' Wochen am ' + data.days;
        },
        'Every {0} months on {1}' : function(data) {
            return 'Alle ' + data.interval + ' Monate auf ' + data.days;
        },
        'Every {0} years on {1} of {2}' : function(data) {
            return 'Alle ' + data.interval + ' Jahre auf ' + data.days + ' von ' + data.months;
        },
        // day position translations
        position1     : 'ersten',
        position2     : 'zweiten',
        position3     : 'dritten',
        position4     : 'vierten',
        position5     : 'fünften',
        'position-1'  : 'letzten',
        // day options
        day           : 'Tag',
        weekday       : 'Wochentag',
        'weekend day' : 'Wochenend-Tag',
        // {0} - day position info ("the last"/"the first"/...)
        // {1} - day info ("Sunday"/"Monday"/.../"day"/"weekday"/"weekend day")
        // For example:
        //  "the last Sunday"
        //  "the first weekday"
        //  "the second weekend day"
        daysFormat    : function(data) {
            return data.position + ' ' + data.days;
        }
    },

    RecurrenceEditor : {
        'Repeat event'      : 'Ereignis wiederholen',
        Cancel              : 'Abbrechen',
        Save                : 'Speichern',
        Frequency           : 'Häufigkeit',
        Every               : 'Jede(n/r)',
        DAILYintervalUnit   : 'Tag',
        WEEKLYintervalUnit  : 'Woche',
        MONTHLYintervalUnit : 'Monat',
        YEARLYintervalUnit  : 'Jahr',
        Each                : 'Jeder',
        'On the'            : 'Am',
        'End repeat'        : 'Ende',
        'time(s)'           : 'Zeit'
    },

    RecurrenceDaysCombo : {
        day           : 'Tag',
        weekday       : 'Wochentag',
        'weekend day' : 'Wochenend-Tag'
    },

    RecurrencePositionsCombo : {
        position1    : 'ersten',
        position2    : 'zweiten',
        position3    : 'dritten',
        position4    : 'vierten',
        position5    : 'fünften',
        'position-1' : 'letzten'
    },

    RecurrenceStopConditionCombo : {
        Never     : 'Niemals',
        After     : 'Nach',
        'On date' : 'Am Tag'
    },

    RecurrenceFrequencyCombo : {
        Daily   : 'täglich',
        Weekly  : 'wöchentlich',
        Monthly : 'monatlich',
        Yearly  : 'jährlich'
    },

    RecurrenceCombo : {
        None   : 'Nie',
        Custom : 'Benutzerdefiniert...'
    },

    //endregion

    //region Examples

    Column : {
        columnLabel       : column => `${column.text ? `${column.text} spalte. ` : ''}SPACE für Kontextmenü${column.sortable ? ', ENTER zum Sortieren' : ''}`,
        cellLabel         : emptyString,
        Name              : 'Name',
        Age               : 'Alter',
        City              : 'Stadt',
        Food              : 'Essen',
        Color             : 'Farbe',
        'First name'      : 'Vorname',
        Surname           : 'Nachname',
        Team              : 'Team',
        Score             : 'Ergebnis',
        Rank              : 'Rang',
        Percent           : 'Prozent',
        Birthplace        : 'Geburstort',
        Start             : 'Anfang',
        Finish            : 'Ende',
        Template          : 'Vorlage (template)',
        Date              : 'Datum',
        Check             : 'Check',
        Contact           : 'Kontakt',
        Favorites         : 'Favoriten',
        'Customer#'       : 'Kunde#',
        When              : 'Wann',
        Brand             : 'Marke',
        Model             : 'Modell',
        'Personal best'   : 'Persönlicher rekord',
        'Current rank'    : 'Aktueller rang',
        Hometown          : 'Heimatstadt',
        Satisfaction      : 'Zufriedenheit',
        'Favorite color'  : 'Lieblingsfarbe',
        Rating            : 'Wertung',
        Cooks             : 'Zuberaiten',
        Birthday          : 'Geburstag',
        Staff             : 'Personal',
        Machines          : 'Maschinen',
        Type              : 'Typ',
        'Task color'      : 'Aufgabe farbe',
        'Employment type' : 'Beschäftigungsverhältnis',
        Capacity          : 'Kapazität',
        'Production line' : 'Fließband',
        Company           : 'Firma',
        End               : 'Ende'
    }

    //endregion

};
