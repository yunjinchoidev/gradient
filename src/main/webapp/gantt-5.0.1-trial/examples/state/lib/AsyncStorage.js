import AsyncHelper from '../../../lib/Core/helper/AsyncHelper.js';
import StateStorage from '../../../lib/Core/state/StateStorage.js';

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
export default class AsyncStorage extends StateStorage {
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
