<template>
    <h1>Hola, este es un proyecto de laravel con vuejs</h1>
    <h3>Este es el mensaje {{ page.props.message }}</h3>
</template>
<script>
import { usePage } from '@inertiajs/vue3';

export default{
    data(){
        return{
            page:usePage()
        }
    }
}
</script>
<style scoped>
.main-class{
    padding:0;
}
</style>