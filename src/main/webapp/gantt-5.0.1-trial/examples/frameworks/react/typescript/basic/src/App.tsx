/**
 * Main Application script
 */
import React, { Fragment, FunctionComponent } from 'react';

import { BryntumDemoHeader, BryntumThemeCombo, BryntumGantt } from '@bryntum/gantt-react';
import { ganttConfig } from './AppConfig';
import './App.scss';

const App: FunctionComponent = () => {
    return (
        <Fragment>
            <BryntumDemoHeader
                href="../../../../../#example-frameworks-react-typescript-basic"
                children={<BryntumThemeCombo />}
            />
            <BryntumGantt {...ganttConfig} />
        </Fragment>
    );
};

export default App;
