import { ProjectModel, PredecessorsTab, LocaleManager, Localizable, DependencyField, DependencyTypePicker } from '../../build/gantt.module.js?457330';

StartTest(t => {
    let project;

    t.beforeEach(async(t, next) => {
        project = new ProjectModel({
            eventsData : (() => {
                return [...new Array(5).keys()].map(index => {
                    return {
                        id        : index + 1,
                        name      : index + 1,
                        startDate : '2017-01-16',
                        duration  : 1
                    };
                });
            })(),
            dependenciesData : [
                { fromEvent : 1, toEvent : 5, type : 0 },
                { fromEvent : 2, toEvent : 5, type : 1 },
                { fromEvent : 3, toEvent : 5, type : 2 },
                { fromEvent : 4, toEvent : 5, type : 3 }
            ]
        });

        project.commitAsync().then(() => {
            // Wait for locales to load
            t.waitFor(() => window.bryntum.locales, next);
        });
    });

    t.it('Should localize dependency type in PredecessorsTab (long names)', async(t) => {

        const depGrid = new PredecessorsTab({
            appendTo : document.body
        });

        depGrid.height = 300;

        depGrid.loadEvent(project.eventStore.getById(5));

        const localesToAssert = Object.keys(window.bryntum.locales);

        const assertLocale = localeId => {
            // wait till localization is applied and then assert
            t.waitForEvent(LocaleManager, 'locale', () => {
                const long = Localizable().L('L{DependencyType.long}');

                Array.from(document.querySelectorAll('.b-grid-row [data-column="type"]')).forEach((el, index) => {
                    t.contentLike(el, long[index], `Dependency type ${index} is localized properly in ${localeId}`);
                });

                const nextLocaleId = localesToAssert.shift();

                // continue if we have more locale(s) to assert
                if (nextLocaleId) {
                    assertLocale(nextLocaleId);
                }
                else {
                    depGrid.destroy();

                    t.livesOk(() => t.applyLocale('En'), 'Listener is removed properly');
                }
            });

            t.applyLocale(localeId);
        };

        // start locales asserting
        assertLocale(localesToAssert.shift());
    });

    t.it('Should localize dependency type in DependencyField (short names)', async(t) => {

        const field = new DependencyField({
            appendTo  : document.body,
            otherSide : 'from',
            ourSide   : 'to'
        });

        field.value = project.dependencyStore.getRange();

        const localesToAssert = Object.keys(window.bryntum.locales);

        const assertLocale = localeId => {
            // wait till localization is applied and then assert
            t.waitForEvent(LocaleManager, 'locale', () => {
                const short = Localizable().L('L{DependencyType.short}');

                t.is(field.input.value, `1${short[0]};2${short[1]};3;4${short[3]}`, 'Dependency type is ok');

                const nextLocaleId = localesToAssert.shift();

                // continue if we have more locale(s) to assert
                if (nextLocaleId) {
                    assertLocale(nextLocaleId);
                }
                else {
                    field.destroy();

                    t.livesOk(() => t.applyLocale('En'), 'Listeners destroyed correctly');
                }
            });

            t.applyLocale(localeId);
        };

        // start locales asserting
        assertLocale(localesToAssert.shift());
    });

    t.it('Should localize dependency type in DependencyTypePicker (long names)', async(t) => {

        const picker = new DependencyTypePicker({
            appendTo : document.body
        });

        const localesToAssert = Object.keys(window.bryntum.locales);

        const assertLocale = localeId => {
            // wait till localization is applied and then assert
            t.waitForEvent(LocaleManager, 'locale', () => {
                const long = Localizable().L('L{DependencyType.long}');

                picker.showPicker();

                long.forEach((item, index) => {
                    t.contentLike(`.b-list .b-list-item[data-index=${index}]`, item, `Dependency type ${item} is localized`);
                });

                const nextLocaleId = localesToAssert.shift();

                // continue if we have more locale(s) to assert
                if (nextLocaleId) {
                    assertLocale(nextLocaleId);
                }
                else {
                    picker.destroy();

                    t.livesOk(() => t.applyLocale('En'), 'Listener is removed properly');
                }
            });

            t.applyLocale(localeId);
        };

        // start locales asserting
        assertLocale(localesToAssert.shift());
    });
});
