import BryntumGantt from '@bryntum/gantt-react/BryntumGantt.js';
import React from 'react';
import { IGanttProps } from './IGanttProps';
import styles from './App.module.scss';

// import css theme
import '../resources/gantt.stockholm.css';

/**
 * Gantt React component.
 *
 * This component renders the Bryntum Gantt widget.
 */
export default class Gantt extends React.Component<IGanttProps> {

    constructor(props) {
        super(props);
        // Add a reference to the gantt engine in the service
        props.service.ganttRef = React.createRef();
    }

    public render() {
        return <BryntumGantt
            cls={styles.gantt}
            autoHeight={true}
            ref={this.props.service.ganttRef}
            project={this.props.service.getTaskListModel()}
            columns={[
                { type : 'name', field : 'name', width : 250 }
            ]}
            features={
                {
                    rollups : {
                        disabled : false
                    }
                }
            }
            viewPreset="weekAndDayLetter"
            barMargin={10}
        />;
    }

    public shouldComponentUpdate(nextProps, nextState) {
    // This component should never update
        return false;
    }
}
