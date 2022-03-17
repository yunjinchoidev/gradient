/**
 * The App file. It should stay as simple as possible
 */

// React libraries
import React, { Fragment } from 'react';

import { BryntumDemoHeader, BryntumThemeCombo } from '@bryntum/gantt-react'
import Gantt from './components/Gantt';

import './App.scss';

const App = props => {
    // Header configuration
    const headerConfig = {
        href: '../../../../../#example-frameworks-react-javascript-advanced'
    };

    return (
        <Fragment>
            <BryntumDemoHeader {...headerConfig} children={<BryntumThemeCombo />}/>
            <Gantt />
        </Fragment>
    );
};

export default App;
