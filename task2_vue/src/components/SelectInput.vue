<script setup lang="ts">

const props = defineProps({
    selectName: {
        type: String,
        required: true,
    },
    defaultValue: {
        type: String,
        required: true,
    },
    optionList: {
        type: Array,
        required: false,
    },
    modelValue: {
        type: String,
        required: true
    }
});

const emits = defineEmits(["update:modelValue"]);
</script>

<template>
    <select
        :value="modelValue"
        :name="props.selectName"
        :id="props.selectName"
        @change="e => emits('update:modelValue', e.target.value)"
    >
        <option value="" selected>{{ props.defaultValue }}</option>

        <option 
            v-for="item in props.optionList"
            :value="item"
            :key="item"
        >{{ item }}</option>
    </select>
</template>

<style scoped>

</style>
