<!--
 * Vue Application Component
 -->
<template>
    <div id="container">
        <bryntum-demo-header
            link="../../../../../#example-frameworks-vue-javascript-pdf-export"
        />
        <div class="demo-toolbar align-right">
            <bryntum-button
                cls="b-deep-orange b-raised"
                text="Export to PDF/PNG"
                @click="exportHandler"
            />
        </div>
        <bryntum-gantt
            ref="gantt"
            v-bind="ganttConfig"
        ></bryntum-gantt>
    </div>
</template>

<script>
import {
    BryntumGantt,
    BryntumDemoHeader,
    BryntumButton
} from '@bryntum/gantt-vue';
import { ganttConfig } from '@/AppConfig.js';

export default {
    name: 'app',

    // local components
    components: {
        BryntumDemoHeader,
        BryntumGantt,
        BryntumButton
    },

    data() {
        return {
            ganttConfig
        };
    },

    methods: {
        exportHandler() {
            this.$refs.gantt.instance.features.pdfExport.showExportDialog();
        }
    }
};
</script>

<style lang="scss">
@import './App.scss';
</style>
