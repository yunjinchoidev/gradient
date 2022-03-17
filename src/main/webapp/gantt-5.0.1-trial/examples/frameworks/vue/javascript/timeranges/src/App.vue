<!-- Application -->
<template>
    <div id="container">
        <bryntum-demo-header
            link="../../../../../#example-frameworks-vue-javascript-timeranges"
        />
        <div id="content">
            <bryntum-gantt ref="gantt" v-bind="ganttConfig" />
            <bryntum-splitter />
            <bryntum-panel ref="panel" v-bind="panelConfig" />
        </div>
    </div>
</template>

<script>
import {
    BryntumGantt,
    BryntumDemoHeader,
    BryntumSplitter,
    BryntumPanel
} from "@bryntum/gantt-vue";
import { ganttConfig, panelConfig } from "@/AppConfig";

export default {
    name: "App",

    components: {
        BryntumDemoHeader,
        BryntumGantt,
        BryntumSplitter,
        BryntumPanel
    },

    data() {
        return {
            ganttConfig,
            panelConfig
        };
    },

    mounted() {
        const gantt = this.$refs.gantt.instance;
        const grid = this.$refs.panel.instance.widgetMap.grid;
        grid.store = gantt.features.timeRanges.store;
    }
};
</script>

<style lang="scss">
@import "./App.scss";
</style>
