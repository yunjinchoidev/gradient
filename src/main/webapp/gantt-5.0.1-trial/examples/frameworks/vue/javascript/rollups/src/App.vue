<!-- Application -->
<template>
    <div id="container">
        <bryntum-demo-header
            link="../../../../../#example-frameworks-vue-javascript-rollups"
        />
        <div class="demo-toolbar align-right">
            <bryntum-checkbox
                :checked="true"
                text="Show Rollups"
                @change="onShowRollups"
            />
        </div>
        <bryntum-gantt ref="gantt" v-bind="ganttConfig" />
    </div>
</template>

<script>
import {
    BryntumDemoHeader,
    BryntumGantt,
    BryntumCheckbox,
} from "@bryntum/gantt-vue";
import { ganttConfig } from "@/AppConfig";

export default {
    name: "App",

    components: {
        BryntumDemoHeader,
        BryntumCheckbox,
        BryntumGantt,
    },

    methods: {
        onShowRollups({ checked }) {
            this.$refs.gantt.instance.features.rollups.disabled = !checked;
        },
    },

    data() {
        return { ganttConfig };
    },
};
</script>

<style lang="scss">
@import "./App.scss";
</style>
