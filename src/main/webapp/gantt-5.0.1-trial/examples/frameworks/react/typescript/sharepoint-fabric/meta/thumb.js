// Adding default config to sessionStorage to view Gantt on page

window.sessionStorage.setItem('sp_webpart_workbench_state',
    JSON.stringify(
        [
            {
                controlType : 3,
                id          : '46d08269-5e14-449f-b8b2-76506108c27a',
                position    : {
                    zoneIndex    : 1,
                    sectionIndex : 1,
                    controlIndex : 1,
                    layoutIndex  : 1
                },
                webPartId   : '61b23e18-26fb-42bb-ad9f-29bfcbcebab4',
                webPartData : {
                    id                     : '61b23e18-26fb-42bb-ad9f-29bfcbcebab4',
                    instanceId             : '46d08269-5e14-449f-b8b2-76506108c27a',
                    title                  : 'BryntumGantt',
                    description            : 'BryntumGantt description',
                    serverProcessedContent : {
                        htmlStrings          : {},
                        searchablePlainTexts : {},
                        imageSources         : {},
                        links                : {}
                    },
                    dataVersion : '1.0',
                    properties  : {
                        showHeader  : true,
                        description : 'BryntumGantt',
                        range       : 3,
                        demoData    : 'single',
                        listId      : 'Mock'
                    }
                },
                emphasis       : {},
                reservedHeight : 2007,
                reservedWidth  : 743
            }
        ])
);

document.location.reload();

window.__thumb_ready = true;
