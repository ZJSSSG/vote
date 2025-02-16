<template>
  <div class="setItemsDiv">
    <CreateNav></CreateNav>
    <el-row>
      <el-col :sm="2" :xl="4">&nbsp;</el-col>
      <el-col  :sm="16"  :xs="24">
        <el-card>
          <el-form>
            <el-form-item>
                <div style="text-align: left;padding: 20px" >
                    <h3>投票规则</h3><hr>
                    <div style="width: 30%;float: left">
                      <h4>投票类型</h4>
                         <el-radio v-model="voteType" label="single" >单选</el-radio>
                         <el-radio v-model="voteType" label="multiple" >多选</el-radio>
                    </div>
                  <div  style="width: 30%;float: left">
                    <h4>投票时需要输入验证码</h4>
                    <el-radio v-model="verifyCode" label="1">是</el-radio>
                    <el-radio v-model="verifyCode" label="0">否</el-radio>
                  </div>
                  <div  style="width: 30%;float: left">
                    <h4>周期设置</h4>
                    <el-radio v-model="cycleType" label="false">投完不能再投</el-radio>
                    <el-radio v-model="cycleType" label="true">每天都可以投</el-radio>
                  </div>
                </div>
            </el-form-item>
            <el-form-item v-if="voteType === 'single' ">
                <div style="text-align: left;padding: 20px">
                  <h4>[单选]票次限制</h4><hr>
                  <el-input placeholder="输入用户可以投的总票数" v-model="totalVotes" @blur="BlurText($event)" style="width: 45%;float: left">
                    <template slot="prepend">每个用户可以投</template>
                    <template slot="append">票</template>
                  </el-input>
                  <el-input placeholder="输入可为同一选手投的票数" v-model="oneVotes"  @blur="BlurText($event)" style="width: 45%;float: right">
                    <template slot="prepend">可为同一选手投</template>
                    <template slot="append">票</template>
                  </el-input>
                </div>
            </el-form-item>
            <el-form-item v-else>
                <div style="text-align: left;padding: 20px">
                  <h4>[多选]选手设置</h4><hr>
                  <el-input placeholder="输入最少可以选择的选手" v-model="least" @blur="BlurText($event)" style="width: 45%;float: left">
                    <template slot="prepend">最少选择</template>
                    <template slot="append">个选手</template>
                  </el-input>
                  <el-input placeholder="输入最多可以选择的选手" v-model="most"  @blur="BlurText($event)" style="width: 45%;float: right">
                    <template slot="prepend">最多选择</template>
                    <template slot="append">个选手</template>
                  </el-input>
                </div>
            </el-form-item>
          </el-form>
          <div style="padding-top:50px;">
            <el-button @click="comeBack "> 返 回 </el-button>
            <el-button type="primary" @click="save()"> 发 布 </el-button>
          </div>
        </el-card>
      </el-col>

    </el-row>
  </div>
</template>

<script>
    import CreateNav from "./CreateNav";
    export default {
        name: "VoteEdit",
      components: {CreateNav},
      data(){
            return{
              voteType:'multiple',
              cycleType:'false',
              verifyCode:'0',
              input3:'',
              type:{},
              totalVotes:'',
              oneVotes:'',
              least:'',
              most:'',
              curId:'',
              curActivity:[],
              singleType:{
                  "voteType":'single',
                  "cycleType":'',
                  "totalVotes":'',
                  "oneVotes":''
               },
              multipleType:{
                  "voteType":'multiple',
                  "cycleType":'',
                  "least":'',
                  "most":''
              }
            }
        },
        mounted() {
          if (this.$route.query.id) {
            this.$store.state.curCreateActivity.id=this.$route.query.id
          }
          this.getCurActivity()
        },
        methods:{
          getCurActivity(){
              let curId = this.$store.state.curCreateActivity.id
              this.$axios.get('/activity/'+ curId).then(resp =>{
                if(resp && resp.data.code === 200){
                    this.curActivity = resp.data.result
                    let setType = JSON.parse(this.curActivity.type)
                    this.voteType = setType.voteType
                    this.cycleType = setType.cycleType
                    this.oneVotes = setType.oneVotes
                    this.totalVotes = setType.totalVotes
                    this.least = setType.least
                    this.most = setType.most
                    if(this.curActivity.verifyCode){
                      this.verifyCode = '1'
                    }
                }
              })
          },
          save(){
            if(this.voteType === 'single'){
              this.singleType.cycleType = this.cycleType
              this.singleType.totalVotes = this.totalVotes
              this.singleType.oneVotes = this.oneVotes
              this.type = this.singleType
              if(this.totalVotes === undefined){
                this.$message.error("请输入用户可以投的总票数")
                return;
              }
              if(this.oneVotes === undefined){
                this.$message.error("请输入可为同一选手投的票数")
                return;
              }
              if(this.oneVotes > this.totalVotes){
                this.$message.error("总票数不能大于为同一选手投的票数")
                return;
              }
            }else{
             this.multipleType.cycleType = this.cycleType
             this.multipleType.least = this.least
             this.multipleType.most = this.most
             this.type = this.multipleType
              if(this.least === '' || this.least === undefined){
                this.$message.error("请输入最少选择的选手")
                return;
              }
              if(this.most === '' || this.most === undefined){
                this.$message.error("请输入最多选择的选手")
                return;
              }
              if(this.least > this.most){
                this.$message.error("最多选择不能大于最少选择")
                return;
              }
            }
            let setVerifyCode = this.verifyCode === '1'? true : false
            console.log('verifyCode ===  1 == > ',this.verifyCode === '1')
            this.$axios.put('/admin/activity/'+this.curActivity.id,{
              title:this.curActivity.title,
              startTime:this.curActivity.startTime,
              endTime:this.curActivity.endTime,
              content:this.curActivity.content,
              type:JSON.stringify(this.type),
              verifyCode: setVerifyCode,
              author:this.$store.state.user.userName
            }).then(resp =>{
              if(resp && resp.data.code === 200){
                this.$store.state.curCreateActivity = []
                this.$message.success('发布成功')
                this.$router.replace('/admin/vote/list')
              }
            })
          },
          comeBack(){
            this.$router.replace('/admin/vote/add/item')
          },
          BlurText(e){
            let boolean = new RegExp("^[1-9][0-9]*$").test(e.target.value)
            if(!boolean){
              this.$message.warning("请输入一个正整数")
              e.target.value = ''
            }

          }
        }
    }
</script>

<style scoped>
  .setItemsDiv{
    margin: 0 auto;
    height: 100%;
    width: 100%;

  }
</style>
