<!-- Button -->
<template>
    <button class="b-button b-grey" @click="click($event)">
        <span>Done: {{ record.percentDone | round }}%</span>
    </button>
</template>

<script>
import { Toast } from '@bryntum/gantt';

export default {
    name    : 'GreyButton',
    props   : ['record'],
    methods : {
        click() {
            Toast.show(`<b>${Math.round(this.record.percentDone)}%</b> done of task <b>${this.record.name}</b>`);
        }
    },
    filters : {
        round(value) {
            return Math.round(value);
        }
    }
};
</script>
