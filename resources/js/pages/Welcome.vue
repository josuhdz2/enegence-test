<template>
    <div class="row mt-5">
        <div class="col"></div>
        <div class="col-4">
            <div class="card text-center">
                <div class="card-header">
                    <h1>Estados</h1>
                </div>
                <div class="card-body">
                    <p>
                        <Link href="/state" class="btn btn-success">Ver estados</Link>
                    </p>
                </div>
                <div class="card-footer">
                    <a href="https://herdev.com.mx">Sitio del desarrollador</a>
                </div>
            </div>
        </div>
        <div class="col"></div>
    </div>
</template>
<script>
import { usePage, Link } from '@inertiajs/vue3';

export default{
    data(){
        return{
            page:usePage()
        }
    },
    components:{
        Link
    }
}
</script>
<style scoped>
.main-class{
    padding:0;
}
</style>