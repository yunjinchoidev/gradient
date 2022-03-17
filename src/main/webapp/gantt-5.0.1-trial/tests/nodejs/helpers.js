const
    paramValueRegExp = /^(\w+)=(.*)$/,
    parseParams      = paramString => {
        const
            result = {},
            params = paramString ? paramString.split('&') : [];

        // loop through each 'filter={"field":"name","operator":"=","value":"Sweden","caseSensitive":true}' string
        // So we cannot use .split('='). Using forEach instead of for...of for IE
        params.forEach(nameValuePair => {
            const
                [match, name, value] = paramValueRegExp.exec(nameValuePair),
                decodedName          = decodeURIComponent(name),
                decodedValue         = decodeURIComponent(value);

            if (match) {
                let paramValue = result[decodedName];

                if (paramValue) {
                    if (!Array.isArray(paramValue)) {
                        paramValue = result[decodedName] = [paramValue];
                    }
                    paramValue.push(decodedValue);
                }
                else {
                    result[decodedName] = decodedValue;
                }
            }
        });

        return result;
    },
    mockAjaxMap      = {};

export function mockUrl(t, url, response) {
    const
        me         = t,
        AjaxHelper = me.global.AjaxHelper;

    if (!AjaxHelper) {
        throw new Error('AjaxHelper must be injected into the global namespace');
    }

    mockAjaxMap[url] = response;

    // Inject the override into the AjaxHelper instance
    if (!AjaxHelper.originalFetch) {
        AjaxHelper.originalFetch = AjaxHelper.fetch;
    }

    AjaxHelper.fetch = mockAjaxFetch.bind(me);
}

export function mockAjaxFetch(url, options) {
    const
        urlAndParams = url.split('?'),
        win          = this.global;

    let result     = mockAjaxMap[urlAndParams[0]],
        parsedJson = null;

    if (result) {
        if (typeof result === 'function') {
            result = result(urlAndParams[0], parseParams(urlAndParams[1]), options);
        }
        try {
            parsedJson = options.parseJson && JSON.parse(result.responseText);
        }
        catch (error) {
            parsedJson = null;
            result.error = error;
        }

        result = win.Object.assign({
            status     : 200,
            ok         : true,
            statusText : 'OK',
            url        : url,
            parsedJson : parsedJson,
            text       : () => new Promise((resolve) => {
                resolve(result.responseText);
            }),
            json : () => new Promise((resolve) => {
                resolve(parsedJson);
            })
        }, result);

        return new win.Promise((resolve, reject) => {
            if (result.synchronous) {
                result.rejectPromise ? reject('Promise rejected!') : resolve(result);
            }
            else {
                win.setTimeout(() => {
                    result.rejectPromise ? reject('Promise rejected!') : resolve(result);
                }, ('delay' in result ? result.delay : 100));
            }
        });
    }
    else {
        return win.AjaxHelper.originalFetch(url, options);
    }
}
