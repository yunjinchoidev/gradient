<!--
* Vue Application Component
-->
<template>
    <div id="container">
        <bryntum-demo-header
            link="../../../../../#example-frameworks-vue-javascript-advanced"
        />
        <bryntum-gantt v-bind="ganttConfig" />
    </div>
</template>

<script>
import { BryntumDemoHeader, BryntumGantt } from "@bryntum/gantt-vue";
import { ganttConfig } from "@/AppConfig";

export default {
    name: "app",

    components: {
        BryntumDemoHeader,
        BryntumGantt
    },
    data() {
        return {
            ganttConfig
        };
    }
};
</script>

<style lang="scss">
@import "./App.scss";
</style>
