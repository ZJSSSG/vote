<template>
  <div class="setItemsDiv">
    <CreateNav ref="createBase"></CreateNav>
    <el-row>
      <el-col  :sm="2" :xl="4">&nbsp;</el-col>
      <el-col  :sm="16"  :xs="24">
        <el-card>
          <div style="text-align: left">
            <el-form>
              <el-form-item>
                <span style="font-size: 16px;font-weight: bold">投票标题</span>
                <el-input v-model="title"></el-input>
              </el-form-item>
              <el-form-item>
                <div style="width: 50%;float: left">
                  <span class="demonstration">投票开始时间</span>
                  <el-date-picker
                    v-model="startTime"
                    type="datetime"
                    placeholder="选择开始时间">
                  </el-date-picker>
                </div>
                <div style="width: 50%;float: right">
                  <span class="demonstration">投票结束时间</span>
                  <el-date-picker
                    v-model="endTime"
                    type="datetime"
                    placeholder="选择结束时间">
                  </el-date-picker>
                </div>
              </el-form-item>
              <el-form-item>
                <Qeditor ref="qeditor"></Qeditor>
              </el-form-item>
            </el-form>
          </div>

          <div style="padding-top: 50px;margin-top: 20px">
            <el-button @click="comeBcak" >返回</el-button>
            <el-button type="primary" @click="saveActivity">下一步</el-button>
          </div>
        </el-card>
      </el-col>

    </el-row>
  </div>

</template>

<script>
  import Qeditor from "../../common/Qeditor";
  import CreateNav from "./CreateNav";
  export default {
    name: "Create",
    components: {CreateNav, Qeditor},
    data(){
      return{
        startTime: '',
        endTime: '',
        title:'',
        content:'',
        type:{},
      }
    },
    mounted(){
      this.getCurActivity()
    },
    methods:{
      testContent(){
        this.content = this.$refs.qeditor.content
      },
      saveActivity() {
        if(this.title === ''){
          this.$message.error("活动标题不能为空");
          return;
        }
        if(this.startTime === ''){
          this.$message.error("开始时间不能为空");
          return;
        }
        if(this.endTime === ''){
          this.$message.error("结束时间不能为空");
          return;
        }
        if(this.startTime > this.endTime){
          this.$message.error("开始时间不能再结束时间后");
          return;
        }
        if(this.$refs.qeditor.content === ''){
          this.$message.error("活动描述不能为空");
          return;
        }
        //如果state里面有id，证明是已存在的活动
        //点击下一步是对已有的活动进行更新
        if(this.$store.state.curCreateActivity.id){
          let activityId = this.$store.state.curCreateActivity.id;
          this.$axios.put('/admin/activity/'+activityId,{
            title: this.title,
            startTime:this.startTime,
            endTime: this.endTime,
            content:this.$refs.qeditor.content,
            type:this.type
          }).then(resp =>{
            if(resp.data.code === 200){
              this.$message.success("活动更新成功")
              this.$router.replace('/admin/vote/add/item');
            }
          })
        }else{
          this.$axios.post('/admin/activity', {
            title: this.title,
            startTime:this.startTime,
            endTime: this.endTime,
            content:this.$refs.qeditor.content,
            author:this.$store.state.user.userName,
            type:JSON.stringify(this.type)
          }).then(resp => {
            if (resp && resp.data.code === 200) {
              this.$message.success("活动创建成功")
              let data = resp.data.result
              this.$store.commit('createActive', data)
              this.$router.replace('/admin/vote/add/item')
            }
          }).catch(() => {
            this.$message({
              type: 'info',
              message: '已取消创建'
            })
          })
        }
      },
      comeBcak(){

      },
      getCurActivity(){
        if(this.$store.state.curCreateActivity.id){
          let curId = this.$store.state.curCreateActivity.id
          this.$axios.get('/activity/'+ curId).then(resp =>{
            if(resp && resp.data.code === 200){
              let curActivity = resp.data.result
              this.startTime = curActivity.startTime
              this.endTime = curActivity.endTime
              this.title =  curActivity.title
              this.$refs.qeditor.content = curActivity.content
              this.type = curActivity.type
            }
          })
        }
      }
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
