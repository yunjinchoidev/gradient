/**
 * Application
 */
import React, { Fragment } from 'react';

import { BryntumDemoHeader, BryntumThemeCombo, BryntumGantt } from '@bryntum/gantt-react';
import { ganttConfig } from './AppConfig';
import './App.scss';

const App = () => {
    // edit button click handler
    const handleEditClick = ({ record, grid: gantt }) => {
        gantt.editTask(record);
    };

    return (
        <Fragment>
            <BryntumDemoHeader
                href="../../../../../#example-frameworks-react-javascript-basic"
                children={<BryntumThemeCombo />}
            />
            <BryntumGantt {...ganttConfig} extraData={{ handleEditClick }} />
        </Fragment>
    );
};

export default App;
