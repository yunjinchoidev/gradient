'use strict';

const build = require('@microsoft/sp-build-web');

build.addSuppression(/Warning - \[sass] The local CSS class '.*' is not camelCase and will not be type-safe\./);

build.configureWebpack.mergeConfig({
    additionalConfiguration : (generatedConfiguration) => {
        generatedConfiguration.module.rules.push(
            {
                test    : /gantt.stockholm\.css$/,
                loader  : 'string-replace-loader',
                options : {
                    search  : 'woff2',
                    replace : 'woff'
                }
            }
        );

        return generatedConfiguration;
    }
});

const getTasks = build.rig.getTasks;
build.rig.getTasks = () => {
    const result = getTasks.call(build.rig);
    result.set('serve', result.get('serve-deprecated'));
    return result;
};

build.initialize(require('gulp'));
