import { AsyncHelper, StateStorage, StateProvider, Toast, Gantt } from '../../build/gantt.module.js?457330';
import shared from '../_shared/shared.module.js?457330';

/**
 * This class represents a database-like entity. All actions are asynchronous to emulate asynchronous requests to a
 * remote database resource. Data is stored in the local storage to be retrievable between page refreshes.
 */
class BackendStorage {
    timeout = 200;
    key     = 'bryntum-state:backend-storage';

    constructor() {
        this.data = JSON.parse(localStorage.getItem(this.key)) || {};
    }

    async load() {
        await AsyncHelper.sleep(this.timeout);

        return Object.assign({}, this.data);
    }

    async getItem(key) {
        await AsyncHelper.sleep(this.timeout);

        return this.data[key];
    }

    async setItem(key, value) {
        await AsyncHelper.sleep(this.timeout);

        this.data[key] = value;

        localStorage.setItem(this.key, JSON.stringify(this.data));
    }

    async removeItem(key) {
        await AsyncHelper.sleep(this.timeout);

        delete this.data[key];

        localStorage.removeItem(this.key);
    }
}

/**
 * This storage class is meant to keep a local copy of the remote state and send changes to the backend. Synchronous
 * wrapper for backend storage is required do to synchronous nature of the State API.
 */
class AsyncStorage extends StateStorage {
    storage = new BackendStorage();

    data = {};

    /**
     * Init the storage to load data from remote resource
     * @return {Promise<void>}
     */
    async init() {
        this.data = await this.storage.load();
    }

    /**
     * Clears data object
     */
    clear() {
        this.data = {};
    }

    /**
     * Returns key value
     * @param {String} key
     * @return {String} JSON string
     */
    getItem(key) {
        // This method has to be synchronous, so we return local copy of the data
        return this.data[key];
    }

    /**
     * Sets key
     * @param {String} key
     * @param {String} value JSON string
     */
    setItem(key, value) {
        this.data[key] = value;

        // Notify underlying storage to persist change to remote resource
        this.storage.setItem(key, value).catch(err => {
            console.warn('Cannot persist state', err);
        });
    }

    /**
     * Removes key
     * @param {String} key
     */
    removeItem(key) {
        delete this.data[key];

        // Notify underlying storage to persist change to remote resource
        this.storage.removeItem(key).catch(err => {
            console.warn('Cannot remove state', err);
        });
    }
}

async function initAsyncStorage() {
    const asyncStorage = new AsyncStorage();

    await asyncStorage.init();

    return asyncStorage;
}

initAsyncStorage().then(storage => {
    const stateProvider = new StateProvider({ storage });

    const gantt = new Gantt({
        appendTo          : 'container',
        dependencyIdField : 'sequenceNumber',

        stateProvider,
        // stateId is required for state provider to persist state automatically
        stateId : 'b-gantt-state',

        // If start/end dates are not provided, they'd be inferred from the project and will override dates restored from
        // the state
        startDate : new Date(2019, 0, 13),
        endDate   : new Date(2019, 2, 24),

        features : {
            filter : true
        },

        project : {
            autoLoad  : true,
            transport : {
                load : {
                    url : '../_datasets/launch-saas.json'
                }
            }
        },

        tbar : [
            {
                type  : 'checkbox',
                ref   : 'autoSaveCheckbox',
                label : 'Auto save',
                value : true,
                onChange({ checked }) {
                    gantt.stateProvider = checked ? stateProvider : null;
                }
            },
            {
                type    : 'button',
                ref     : 'resetButton',
                color   : 'b-red',
                icon    : 'b-fa b-fa-times',
                text    : 'Reset to default',
                tooltip : 'Resets application to the default state',
                onAction() {
                    gantt.resetDefaultState();

                    Toast.show('Default state restored');
                }
            }
        ],

        columns : [
            // To persist column state it is better to explicitly specify an id
            { id : 'name', type : 'name', width : 250 },
            { id : 'startDate', type : 'startdate', width : 150 },
            { id : 'duration', type : 'duration', width : 150 },
            { id : 'predecessors', type : 'predecessor', width : 150 }
        ],

        // Custom task content, display task name on child tasks
        taskRenderer({ taskRecord }) {
            if (taskRecord.isLeaf && !taskRecord.isMilestone) {
                return taskRecord.name;
            }
        }
    });
});
