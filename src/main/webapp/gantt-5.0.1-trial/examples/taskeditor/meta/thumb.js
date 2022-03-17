/* global shared, gantt */
gantt.editTask(gantt.taskStore.getById(13));
setTimeout(() => {
    // Show the ResourcesTab in the thumb
    shared.fireMouseEvent('click', document.querySelector('.b-tabpanel-tab[data-item-index="2"]'));

    setTimeout(() => {
        // Include the tooltip
        shared.fireMouseEvent('mouseover', document.querySelector('.b-list-item[data-index="4"] .b-icon-trash'));

        setTimeout(() => {
            // raise flag for thumb generator indicating page is ready for taking screenshot
            window.__thumb_ready = true;
        }, 300);
    }, 500);
}, 500);
