
 var ns = window.bryntum?.['gantt'];
 try {
    // If this is a module in webpack, change namespace
    if (module?.exports?.Widget) {
        ns = module.exports;
    }
 } catch (ReferenceError) { }
var {
    GlobalEvents,
    BrowserHelper,
    VersionHelper,
    Widget,
    Toast,
    Override,
    DomHelper,
    GridBase,
    RowManager,
    SchedulerBase,
    HorizontalRendering,
    VerticalRendering,
    SchedulerProBase,
    SchedulerEventRendering,
    GanttBase,
    NewTaskRendering,
} = ns;
(() => {
    //region Common
    const
        HOSTS            = [
            'bryntum.com',
            'cdpn.io',
            'react-gantt.com',
            'vue-gantt.com',
            'vue-scheduler.com',
            'react-scheduler.com',
            'angular-scheduler.com',
            'angular-calendar.com',
            'vue-calendar.com',
            'react-calendar.com',
            'lmctfy.net'
        ].map(host => host.replace('.', '\\.')).join('|'),
        ONE_DAY          = 1000 * 60 * 60 * 24,
        EXPIRING_CLASSES = [];
    if (new RegExp(`^((www|dev)\\.)?${HOSTS}`).test(location.host) || /\/docs/.test(location.href)) {
        return;
    }
    let initialized;
    function initExpiryHelper(owner, baseClass) {
        if (!initialized) {
            initialized = true;
            ExpiryHelper.construct({
                widget : owner
            });
        }
        // do not remove this line (used to distinguish trial bundles by regexp)
        owner.__foo = 'THISISTRIAL';
        window.__bryntum_trial = baseClass.getLKey();
    }
    //endregion
    //region ExpiryHelper
    class ExpiryHelper {
        static construct(config) {
            const
                me            = this,
                product       = 'gantt',
                productName   = 'Gantt',
                version       = VersionHelper.getVersion(product),
                callHomeDelay = VersionHelper.isTestEnv ? 3000 : 1000 * 60,
                blockUrl      = BrowserHelper.queryString.blockUrl;
            Object.assign(me, {
                version,
                product,
                Product          : productName,
                verifyUrl        : VersionHelper.isTestEnv ? blockUrl : 'https://bryntum.com/verify/',
                blocked          : false,
                lastVersionCheck : 0,
                trialKey         : `b-${product}-trial-start`,
                versionCheckKey  : `b-${product}-verify-date`
            }, config);
            if (!VersionHelper.isTestEnv) {
                console.log(`Bryntum ${productName} Trial Version`);
            }
            me.cacheTrialStartTime();
            if (me.isExpired) {
                if (document.readyState === 'complete') {
                    me.onTrialExpired();
                }
                else {
                    document.addEventListener('readystatechange', () => {
                        if (document.readyState === 'complete') {
                            me.onTrialExpired();
                        }
                    });
                }
            }
            // Call home to log trial usage, assuming localStorage access works reliably
            // 1 min delay to be less easily detected
            setTimeout(() => {
                me.updateBlockedStatus();
            }, callHomeDelay);
        }
        static cacheTrialStartTime() {
            const
                me         = this,
                timeString = BrowserHelper.getLocalStorageItem(me.trialKey),
                time       = Number(timeString);
            if (time && !isNaN(time)) {
                me.trialStartTime = time;
            }
            me.trialStartTime = me.trialStartTime || Date.now();
            // First trial access, or no localstorage (no local storage meaning our expiration mechanism won't work. Only remote blocking will end the trial)
            BrowserHelper.setLocalStorageItem(me.trialKey, me.trialStartTime);
        }
        static get isExpired() {
            return  this.blocked || (Date.now() - this.trialStartTime > ONE_DAY * 45) || window.bryntum?.[this.product]?.expired;
        }
        static updateBlockedStatus() {
            const
                me                  = this,
                saveVersionCheckKey = () => BrowserHelper.setLocalStorageItem(me.versionCheckKey, Date.now());
            me.lastVersionCheck = me.lastVersionCheck || BrowserHelper.getLocalStorageItem(me.versionCheckKey) || 0;
            // Max 1 version check per session / day
            if (me.lastVersionCheck && Date.now() - me.lastVersionCheck < ONE_DAY) {
                return;
            }
            if (me.verifyUrl) {
                const
                    url    = encodeURIComponent(location.href),
                    logUrl = `${me.verifyUrl}?pId=${me.product}&v=${me.version}&id=${window.__bryntum_trial}&url=${url}`,
                    img    = new Image();
                img.onload = () => {
                    // 2x2 image means trial is blocked due to violation
                    if (img.naturalWidth === 2) {
                        me.blockTrial();
                    }
                    else {
                        // Just in case
                        saveVersionCheckKey();
                    }
                };
                img.onerror = () => {
                    saveVersionCheckKey();
                };
                img.src = logUrl;
            }
            else {
                saveVersionCheckKey();
            }
        }
        static onTrialExpired() {
            const rootEl = this.widget.rootElement;
            if (!this.didNotify) {
                this.didNotify = true;
                console.warn(`Bryntum ${this.Product} trial version expired. Purchase a license at https://bryntum.com/store or contact us at https://bryntum.com/contact/ for licensing options.`);
                rootEl.floatRoot && Toast.show({
                    html        : `Psst! Your Bryntum ${this.Product} trial has expired. Please see <a href="https://bryntum.com/store">our store</a> for licensing options`,
                    timeout     : 20000,
                    rootElement : rootEl
                });
            }
            DomHelper.removeEachSelector(rootEl, '.b-sch-dependency');
            DomHelper.forEachSelector(rootEl, '.b-container', element => {
                const widget = Widget.fromElement(element, 'widget');
                if (EXPIRING_CLASSES.some(cls => widget instanceof cls)) {
                    this.maskExpiredWidget(widget);
                }
            });
        }
        static blockTrial() {
            this.blocked = true;
            // Get rid of version check timestamp
            BrowserHelper.removeLocalStorageItem(this.versionCheckKey);
            // To force expired state: Set a fake early trial timestamp
            BrowserHelper.setLocalStorageItem(this.trialKey, 1);
            this.onTrialExpired();
        }
        static maskExpiredWidget(widget) {
            widget.mask({
                text  : '<h3 style="margin:0">Trial expired, <a href="https://bryntum.com/store" style="margin:0 3px; color:inherit">click here</a> to buy a license.</h3>',
                icon  : 'b-fa b-fa-frown',
                type  : 'trial',
                cover : 'target'
            });
        }
        static setWaterMark(element, {
            darkColor = 'rgba(255, 255, 255, 0.03)',
            lightColor = 'rgba(240, 240, 240, 0.54)'
        } = {}) {
            // Used for thumbnails
            if (BrowserHelper.queryString.thumb != null) {
                return;
            }
            const
                color     = DomHelper.themeInfo?.name?.toLowerCase().endsWith('-dark') ? darkColor : lightColor,
                svgString = `
                   <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="100%" height="100%" style="font-family:sans-serif;font-weight:900;fill:${color}">
                    <defs>
                        <pattern id="company" patternUnits="userSpaceOnUse" width="400" height="200">
                            <text y="30" font-size="40" id="name">Bryntum</text>
                            <text y="120" x="200" font-size="24" id="trial">Trial Version</text>
                        </pattern>
                        <pattern id="pattern" xlink:href="#company" patternTransform="rotate(-45)">
                            <use xlink:href="#name" /><use xlink:href="#trial" />
                        </pattern>
                    </defs>
                    <rect width="100%" height="100%" fill="url(#pattern)" />
                </svg>`;
            element.style.backgroundImage = `url('data:image/svg+xml;base64,${window.btoa(svgString)}')`;
        };
    }
    //endregion
    //region Common override
    const applyBaseOverride  = baseClass => {
        EXPIRING_CLASSES.push(baseClass);
        Override.apply(class {
            static get target() {
                return {
                    class : baseClass
                };
            }
            onPaintOverride() {
                const
                    me          = this,
                    target      = me.subGrids?.normal || me.subGrids?.[me.regions[0]] || me,
                    { element } = target;
                initExpiryHelper(me, baseClass);
                ExpiryHelper.setWaterMark(element);
                // React to theme changes
                GlobalEvents.on('theme', () => {
                    ExpiryHelper.setWaterMark(element);
                });
                if (ExpiryHelper.isExpired) {
                    ExpiryHelper.maskExpiredWidget(this);
                }
            }
        });
    };
    //endregion
    if (typeof GridBase !== 'undefined') {
        applyBaseOverride(GridBase);
        Override.apply(class {
            static get target() {
                return {
                    class : RowManager
                };
            }
            renderRows() {
                if (!ExpiryHelper.isExpired || this.grid?.isScheduler) {
                    this._overridden.renderRows.apply(this, arguments);
                }
            }
            renderFromRow() {
                if (!ExpiryHelper.isExpired || this.grid?.isScheduler) {
                    this._overridden.renderFromRow.apply(this, arguments);
                }
            }
        });
    }
    if (typeof SchedulerBase !== 'undefined') {
        applyBaseOverride(SchedulerBase);
        Override.apply(class {
            static get target() {
                return {
                    class : HorizontalRendering
                };
            }
            onRenderDone() {
                if (!ExpiryHelper.isExpired || this.scheduler?.isSchedulerPro) {
                    return this._overridden.onRenderDone.apply(this, arguments);
                }
            }
        });
        Override.apply(class {
            static get target() {
                return {
                    class : VerticalRendering
                };
            }
            onRenderDone() {
                if (!ExpiryHelper.isExpired || this.scheduler?.isSchedulerPro) {
                    return this._overridden.onRenderDone.apply(this, arguments);
                }
            }
        });
    }
    if (typeof SchedulerProBase !== 'undefined') {
        applyBaseOverride(SchedulerProBase);
        Override.apply(class {
            static get target() {
                return {
                    class : SchedulerEventRendering
                };
            }
            getEventsToRender() {
                if (ExpiryHelper.isExpired && this.isSchedulerPro) {
                    return [];
                }
                else {
                    return this._overridden.getEventsToRender.apply(this, arguments);
                }
            }
        });
    }
    if (typeof GanttBase !== 'undefined') {
        applyBaseOverride(GanttBase);
        Override.apply(class {
            static get target() {
                return {
                    class : NewTaskRendering
                };
            }
            onRenderDone() {
                if (!ExpiryHelper.isExpired) {
                    return this._overridden.onRenderDone.apply(this, arguments);
                }
            }
        });
    }
})();
