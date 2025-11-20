<template>
    <CustomNavBar/>
    <div class="container">
        <Title title="Lista de estados">
            <InputText v-model="filters.global.value" placeholder="Buscar..."/>
        </Title>
        <DataTable :value="page.states" paginator :rows="10" :loading :filters :globalFilterFields="['name']" @row-click="goToState">
            <Column field="name" header="Estado" sortable/>
        </DataTable>
    </div>
</template>
<script>
import { usePage } from '@inertiajs/vue3';
import CustomNavBar from '@/components/CustomNavBar.vue';
import Title from '@/components/Title.vue';
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import InputText from 'primevue/inputtext';

export default{
    data(){
        return{
            page:usePage().props,
            loading:false,
            filters:{
                global:{value:''}
            }
        }
    },
    methods:{
        goToState(event){
            console.log('evento escuchado')
            const name = event.data.name;
            this.$inertia.visit(`/state/${name}`);
        },
    },
    components:{
        CustomNavBar,
        Title,
        DataTable,
        Column,
        InputText
    }
}
</script>
<style scoped>
.main-class{
    padding:0;
}
</style>