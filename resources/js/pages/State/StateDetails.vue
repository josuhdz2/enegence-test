<template>
    <CustomNavBar/>
    <div class="container">
        <Title title="Lista de municipios."/>
        <table class="table table-primary">
            <thead>
                <tr>
                    <th>Nombre del Municipio</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="item in page.cities">
                    <td>{{ item }}</td>
                </tr>
            </tbody>
        </table>
    </div>
</template>
<script>
import CustomNavBar from '@/components/CustomNavBar.vue';
import Title from '@/components/Title.vue';
import { usePage } from '@inertiajs/vue3';

export default{
    data(){
        return{
            page:usePage().props
        }
    },
    components:{
        CustomNavBar,
        Title
    }
}
</script>
<style scoped>
.main-class{
    padding:0;
}
</style>