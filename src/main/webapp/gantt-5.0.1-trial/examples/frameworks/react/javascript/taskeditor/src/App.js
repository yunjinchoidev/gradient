/**
 * The App file. It should stay as simple as possible
 */

import React, { Fragment } from 'react';
import { BryntumDemoHeader, BryntumThemeCombo, BryntumGantt } from '@bryntum/gantt-react';
import { ganttConfig } from './AppConfig';
import './App.scss';

const App = () => {
    return (
        <Fragment>
            <BryntumDemoHeader
                href="../../../../../#example-frameworks-react-javascript-taskeditor"
                children={<BryntumThemeCombo />}
            />
            <BryntumGantt {...ganttConfig} />
        </Fragment>
    );
};

export default App;
