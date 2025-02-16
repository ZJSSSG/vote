<template>
  <div>
    <el-row>
      <el-col :xs="{span:24,offset:0}" :sm="{span:16,offset:4}" :lg="{span:16,offset:4}">
        <el-card>
          <div style="text-align: center">
            <h3>{{curNotice.title}}</h3>
            <div style="color: #999" >
              {{curNotice.createTime | fmtDate}}
            </div>
            <div style="text-align: left"> <p v-html="curNotice.content"></p></div>
          </div>

        </el-card>
      </el-col>

    </el-row>
  </div>

</template>

<script>
    export default {
      name: "NoticeIndex",
      data(){
        return{
          curNotice:[]
        }
      },
      mounted() {
        this.getCurNotice()
      },
      methods:{
        getCurNotice(){
          let _this = this
          this.$axios.get('/notice/'+this.$route.params.id).then(resp =>{
            if(resp && resp.data.code === 200){
              _this.curNotice = resp.data.result
            }
          })
        },
      }
    }
</script>

<style scoped>

</style>
