<template>
  <div>
    <router-view/>
  </div>
</template>

<script>
    import Create from "./Create";
    export default {
      name: "AddActivity",
      components: {Create},
      data(){
        return{
          addIndex:true,
          curPath:''
        }
      },
      computed: {
        // setter
        set: function () {
          this.curPath = this.$route.path
        }
      },
      methods:{

      }
    }
</script>

<style scoped>

</style>
