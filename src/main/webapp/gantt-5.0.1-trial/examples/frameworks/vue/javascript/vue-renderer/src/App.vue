<!-- Application -->
<template>
    <div id="container">
        <bryntum-demo-header
            link="../../../../../#example-frameworks-vue-javascript-vue-renderer"
        ></bryntum-demo-header>
        <bryntum-gantt v-bind="ganttConfig" />
    </div>
</template>

<script>
import { BryntumDemoHeader, BryntumGantt } from '@bryntum/gantt-vue';
import { ganttConfig } from '@/AppConfig';

export default {
    name: 'App',

    components: {
        BryntumGantt,
        BryntumDemoHeader
    },

    data() {
        return { ganttConfig };
    }
};
</script>

<style lang="scss">
@import './App.scss';
</style>
