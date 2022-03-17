/* global resourceUtilization */

const resourceUtilization = bryntum.query('ResourceUtilization');

resourceUtilization.project.commitAsync().then(() => {
    resourceUtilization.expand(resourceUtilization.store.first).then(() => {
        window.__thumb_ready = true;
    });
});
