<template>
  <div>
    <div class="header-left-box">
      <div class="header-logo" @click="toHome">小龙的投票系统</div>
      <div class="header-right"   v-if="userName">
        <el-dropdown style="float: right" class="dropdown-link">
        <span class="el-dropdown-link" >
                        <img :src="avatar || '../../img/defaultImg.png'"
                             class="user-avatar">
        <span>{{userName}}</span>
        </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native="userInfo">账户信息</el-dropdown-item>
            <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
      <div v-else>
        <a href="Login"> <el-button>登录</el-button></a>
        <a href="Register"> <el-button>注册</el-button></a>
      </div>
    </div>
  </div>
</template>

<script>
    export default {
      name: "TopHeader",
      data(){
        return{
          avatar:this.$store.state.user.avatar,

          userName:this.$store.state.user.userName,
        }
      },
      mounted() {
        console.log("是"+this.avatar)
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
        userInfo(){
          this.$router.push('/admin/account/info')
        },
        toHome(){
          this.$router.push('/home')
        }
      }
    }
</script>

<style scoped>
  .header-logo{
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
  .user-avatar{
    float: left;
    margin-left: 30px;
    width: 50px;
    height: 50px;
    border-radius: 50px;
  }
</style>
