<template>
<div>
  <div class="header-box">
    <div class="header-left-box" >
      <div class="header-logo">小龙的投票系统</div>
      <div class="header-right"   v-if="curUser.userName"  style="float: right">
        <el-button type="primary"  style="margin-top: 10px;margin-right: 50px" @click="userCenter">个人中心</el-button>
        <el-dropdown style="float: right" class="dropdown-link">
        <span class="el-dropdown-link" >
       <img src="../img/defaultImg.png" style="border-radius: 100%;width: 45px">
        <span>{{curUser.userName}}</span>
        </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native="userInfo">账户信息</el-dropdown-item>
            <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
      <div class="header-right" v-else >
        <a href="/login"> <el-button>登录 | 注册</el-button></a>
      </div>
    </div>
  </div>
  <el-row>
    <el-col :xs="{span:24,offset:0}" :sm="{span:18,offset:2}" :lg="{span:18,offset:3}">
    <div class="test-back-img">
      <div class="button-box">
        <el-button type="warning" round class="create-vote-button" @click="createVote" style="margin-left: 50px">创建投票</el-button>
      </div>
    </div>
    </el-col>
  </el-row>
  <div class="vote-case-box">
    <h3>投票案例</h3>
    <h5 style="color: #999">点击跳转投票页面</h5>
    <el-row>
      <el-col :xs="{span:24,offset:0}" :sm="{span:16,offset:4}" :lg="{span:16,offset:4}">
        <div id="case-item-box">
          <a :href="activityLink">
            <div v-for="(item,index) in activities" :key="index" @mouseenter="enter(index,item.id)" @mouseleave="leave(index,item.id)">
              <el-col :xs="11" :sm="5" :offset="1" >
                <el-card style="background-color: #F7F7F7;margin: 10px" >
                  <div class="qrcode"  ref="qrCodeUrl"  :style="{'margin-left':(codeWidth==100?'10px':'32px')}" v-show="showMap.get(item.id) === 'show'"></div>
                  <div v-show="showMap.get(item.id) === ''">
                    <img src="../img/case.jpg" class="image" style="width: 100%">
                  </div>
                  <div style="padding: 14px;color: #999; font-size: 12px;">
                    <span>{{item.title}}</span><br>
                  </div>
                </el-card>
              </el-col>
            </div>
          </a>

        </div>
      </el-col>
    </el-row>
  </div>
  <div>
    <el-time-select
      placeholder="起始时间"
      v-model="startTime"
      :picker-options="{
      start: '08:30',
      step: '00:15',
      end: '18:30'
    }">
    </el-time-select>
  </div>
  <div>
    <el-button @click="drawer = true" type="primary" style="margin-left: 16px;">
      点我打开
    </el-button>

    <el-drawer
      title="我是标题"
      :visible.sync="drawer"
      :with-header="false"
      :modal="false"
      size="50%">
      <span>我来啦!</span>
    </el-drawer>
  </div>
</div>
</template>

<script>
    import QRCode from "qrcodejs2";

    export default {
      name: "Home",
      data(){
        return{
          drawer:false,
          startTime:'',
          currentPage:1,
          pageSize:4,
          totalSize:0,
          codeWidth:100,
          showIndex: null,
          activities:[],
          userName:this.$store.state.user.userName,
          activityLink:'',
          showMap:new Map(),
          curUser:[],
        }
      },
      mounted() {
        this.setDialogWidth()
        window.onresize = () => {
          return (() => {
            this.setDialogWidth()
          })()
        }
        this.listActivityCase()
        this.getCurUser()
      },
      methods:{
        logout () {
          let _this = this
          this.$axios.get('/user/logout').then(resp => {
            if (resp.data.code === 200) {
              _this.$store.commit('logout')
              _this.$router.replace('/login')
            }
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
        userInfo(){
          this.$router.push('/admin/account/info')
        },
        listActivityCase(){
          let _this = this
          this.$axios.get('/activity/list/case?page='+_this.currentPage+'&size='+_this.pageSize).then(resp =>{
            if(resp && resp.data.code === 200){
              _this.activities = resp.data.result
              _this.totalSize = resp.data.result.length
              for(let i=0; i<_this.activities.length; i++){
                _this.showMap.set(_this.activities[i].id,'')
              }
            }
          })
        },
        leave(index,id){
          this.$refs.qrCodeUrl[index] = ''
          this.showIndex = null
          this.showMap.set(id,'')
          this.$forceUpdate();
        },
        enter(index,id){
          let _this = this
          this.showMap.set(id,'show')
          this.$forceUpdate();
          var  qrBox;
          this.$nextTick(function () {
            qrBox = this.$refs.qrCodeUrl[index]
          })
          this.activityLink = 'http://localhost/activityIndex/'+id
          this.$nextTick(function () {
            let qrcode = new QRCode(qrBox, {
              text: this.activityLink, // 需要转换为二维码的内容
              width: _this.codeWidth,
              height: _this.codeWidth,
              colorDark: '#000000',
              colorLight: '#ffffff',
              correctLevel: QRCode.CorrectLevel.H
            })
          })
        },
        createVote(){
          if(this.curUser.userName){
            this.$router.push('/admin/vote/add/index')
          }else {
            this.$router.push('/login')
          }
        },
        userCenter(){
          this.$router.push('/admin/vote/list')
        },
        setDialogWidth() {
          let val = document.body.clientWidth
          const def = 1570 // 默认宽度
          if (val <  def) {
            this.codeWidth = 100
          } else {
            this.codeWidth = 120
          }
        },
      }
    }
</script>

<style scoped>
.test-back-img{

  max-width: 1100px;
  height: 480px;
  margin: 0 auto;
  margin-top: 20px;
  background-image: url("../img/vote.jpg");
}
  .button-box{
    padding-top: 420px;
    margin-right: 60px;
  }

.header-box{
  padding-bottom: 50px;
}
.header-logo{
  width: 10%;
  float: left;
  margin-left: 100px;
  color: #36aaff;
  font-size: 20px;
  font-weight: 600;
}
.header-right{
  float: right;
  margin-right: 150px;
}

</style>
