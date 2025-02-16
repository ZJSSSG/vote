<template>
  <div class="setItemsDiv">
    <el-row>
      <el-col  :sm="2" :xl="4">&nbsp;</el-col>
      <el-col  :sm="16"  :xs="24">
        <el-card>
          <div style="text-align: left">
            <el-form>
              <el-form-item>
                <span style="font-size: 16px;font-weight: bold">公告标题</span>
                <el-input v-model="title"></el-input>
              </el-form-item>
              <el-form-item>
                <span style="font-size: 16px;font-weight: bold">公告内容</span>
                <Qeditor ref="qeditor"></Qeditor>
              </el-form-item>
            </el-form>
          </div>

          <div style="padding-top: 50px;margin-top: 20px">
            <el-button type="primary" @click="saveActivity"> 发 布 </el-button>
          </div>
        </el-card>
      </el-col>

    </el-row>
  </div>

</template>

<script>
  import Qeditor from "../../common/Qeditor";
  export default {
    name: "CaseManagement",
    components: {Qeditor},
    data(){
      return{
        title:'',
        content:'',
        curUser:[]
      }
    },
    mounted() {
      this.getCurUser()
    },
    methods:{
      saveActivity() {
        if(this.title === ''){
          this.$message.error("标题不能为空");
          return;
        }
        if(this.$refs.qeditor.content === ''){
          this.$message.error("公告内容不能为空");
          return;
        }
        this.$axios.post('/admin/notice', {
          title: this.title,
          content:this.$refs.qeditor.content,
          uid:this.curUser.id,
        }).then(resp => {
          if (resp && resp.data.code === 200) {
            this.$message.success("公告添加成功")
            this.$router.replace('/admin/content/notice')
          }
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消创建'
          })
        })
      },
      getCurUser(){
        let _this = this
        this.$axios.get('/user?userName='+this.$store.state.user.userName).then(resp =>{
          if(resp){
            _this.curUser = resp.data
          }
        })
      },
      }
  }
</script>

<style scoped>
  .setItemsDiv{
    margin: 0px auto;
    height: 100%;
    width: 100%;

  }



</style>
