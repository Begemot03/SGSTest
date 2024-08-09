<script setup lang="ts">
import { ref, computed } from 'vue';
import SelectInput from './SelectInput.vue';

type DepenceRow = {
    name: string;
    dependences: Array<string>;
};

type DepenceTable = Array<DepenceRow>;
type JoinedTable = Array<Array<string>>;

const cityWorkshop: DepenceTable = [
    {
        name: "Город1",
        dependences: [ "Цех1-1", "Цех1-2", ], 
    },
    {
        name: "Город2",
        dependences: [ "Цех2-1", "Цех2-2", ], 
    },
];

const workshopEmployee: DepenceTable = [
    {
        name: "Цех1-1",
        dependences: [ "Сотрудник1-1-1", "Сотрудник1-1-2", ],
    },
    {
        name: "Цех1-2",
        dependences: [ "Сотрудник1-2-1", "Сотрудник1-2-2", ],
    },
    {
        name: "Цех2-1",
        dependences: [ "Сотрудник2-1-1", "Сотрудник2-1-2", ],
    },
    {
        name: "Цех2-2",
        dependences: [ "Сотрудник2-2-1", "Сотрудник2-2-2", ],
    },
];

const brigades = ["Бригада1", "Бригада2", "Бригада3"];
const workshifts = ["Смена1", "Смена2", "Смена3"];

function isEqualOrEmpty(str: string, value: string): boolean {
    return str === value || value === "";
}

function crossJoin(cities: DepenceTable, workshops: DepenceTable): JoinedTable
{
    const res = [];

    for(let i = 0; i < cities.length; i++) {
        const t = [cities[i].name];

        for(let j = 0; j < cities[i].dependences.length; j++) {
            t.push(cities[i].dependences[j]);

            const curw = workshops.filter(workshop => workshop.name === cities[i].dependences[j])[0];

            if(curw){
                for(let k = 0; k < curw.dependences.length; k++) {
                    t.push(curw.dependences[k]);
                    res.push([...t]);
                    t.pop();
                }
            }

            t.pop();
        }

        t.pop();
    }

    return res;
}

function postForm(e: SubmitEvent): void {
    e.preventDefault();

    const jsonData = {
        city: city.value,
        workshop: workshop.value,
        employee: employee.value,
        brigade: brigade.value,
        workshift: workshift.value,
    };

    console.log(jsonData);

    document.cookie = "formJsonResult=" + JSON.stringify(jsonData) + ";SameSite=None;Secure=false";
}


const joinedTable = crossJoin(cityWorkshop, workshopEmployee);

const city = ref("");
const workshop = ref("");
const employee = ref("");
const brigade = ref("");
const workshift = ref("");

const optionsList: Array<Array<string>> = computed((): Array<Array<string>> => {
    let r: Array<Set<string>> = [new Set(), new Set(), new Set()];

    for(let i = 0; i < joinedTable.length; i++) {
        if( isEqualOrEmpty(joinedTable[i][0], city.value) && 
            isEqualOrEmpty(joinedTable[i][1], workshop.value) && 
            isEqualOrEmpty(joinedTable[i][2], employee.value)) 
        {
            r[0].add(joinedTable[i][0]);
            r[1].add(joinedTable[i][1]);
            r[2].add(joinedTable[i][2]);
        }
    }

    return [[...Array.from(r[0])], [...Array.from(r[1])], [...Array.from(r[2])]];
});


</script>

<template>
<form 
    method="post"
    @submit.prevent="postForm"
>
    <SelectInput 
        v-model="city"
        selectName="city"
        defaultValue="Выберите город"
        :optionList="optionsList[0]"
    />
    <SelectInput 
        v-model="workshop"
        selectName="workshop"
        defaultValue="Выберите цех"
        :optionList="optionsList[1]"
    />
    <SelectInput 
        v-model="employee"
        selectName="employee"
        defaultValue="Выберите сотрудника"
        :optionList="optionsList[2]"
    />
    <SelectInput 
        v-model="brigade"
        selectName="brigade"
        defaultValue="Выберите бригаду"
        :optionList="brigades"
    />
    <SelectInput 
        v-model="workshift"
        selectName="workshift"
        defaultValue="Выберите смену"
        :optionList="workshifts"
    />
    <button 
        type="submit"
    >Отправить</button>
</form>
</template>

<style scoped>

</style>
