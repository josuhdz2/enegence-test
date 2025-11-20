<template>
    <div class="text-center m-4">
        <div class="row">
            <div class="col-6">
                <h3>{{ title }}</h3>
            </div>
            <div class="col-6">
                <slot/>
            </div>
        </div>
    </div>
</template>
<script>
export default{
    props:{
        title:{type:String, required:true}
    }
}
</script>
<style scoped>
.main-class{
    padding:0;
}
</style>