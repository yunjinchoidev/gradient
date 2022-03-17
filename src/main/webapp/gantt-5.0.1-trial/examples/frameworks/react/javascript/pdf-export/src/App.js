/**
 * The App file. It should stay as simple as possible
 */

import React, { Fragment, useRef } from 'react';

import {
    BryntumDemoHeader,
    BryntumThemeCombo,
    BryntumGantt,
    BryntumButton
} from '@bryntum/gantt-react';
import { ganttConfig } from './AppConfig';
import './App.scss';

const App = () => {
    const ganttRef = useRef(null);

    const onExportClick = () => {
        ganttRef.current.instance.features.pdfExport.showExportDialog();
    };

    return (
        <Fragment>
            <BryntumDemoHeader
                href="../../../../../#example-frameworks-react-javascript-pdf-export"
                children={<BryntumThemeCombo />}
            />
            <div className="demo-toolbar align-right">
                <BryntumButton
                    text="Export to PDF/PNG"
                    cls="b-deep-orange b-raised"
                    onClick={onExportClick}
                />
            </div>
            <BryntumGantt ref={ganttRef} {...ganttConfig} />
        </Fragment>
    );
};

export default App;
