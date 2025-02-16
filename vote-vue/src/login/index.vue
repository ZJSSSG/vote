<template>
  <div>
    <div class="admin-login-box">
      <div class="admin-login-header-box">
        <div class="admin-login-header-center">
          <div class="admin-login-logo" @click="toHome">
            小龙的投票系统
          </div>
        </div>
    <!--中间内容-->
    <div class="login-tab-container">
      <el-tabs v-model="activeName" @tab-click="toLogin">
        <el-tab-pane  label="登录" name="first">
          <login ref="loginBox"></login>
        </el-tab-pane>
        <el-tab-pane label="注册" name="second" @tab-click="toRegister">
          <register @onSubmit="handleTab()" ref="registerBox"></register>
        </el-tab-pane>

      </el-tabs>
    </div>
     </div>
    </div>
  </div>
</template>
<script>
  import Login from "../login/login";
  import Register from "../login/register";
  export default {
    components: {Register, Login},
    data() {
      return {
        activeName: 'first'
      };
    },
    methods: {
      toLogin(){
        this.activeName = 'first';
        this.$refs.loginBox.updateVerifyCode();
      },
      toRegister(){
        this.activeName = 'second';
        this.$refs.registerBox.updateVerifyCode();
      },
      handleTab(){
        this.activeName = 'first';
        this.$refs.loginBox.updateVerifyCode();
      },
      toHome(){
        this.$router.push('/home')
      }
    },

  };
</script>

<style scoped>
  .admin-login-header-box{
    width: 100%;
    height: 46px;
    border-bottom: solid 1px #e6e6e6;
  }

  .admin-login-header-center{
    line-height: 46px;
    margin: 0 auto;
    width: 1140px;
  }

  .admin-login-logo{
    width: 200px;
    color: dodgerblue;
    font-size: 20px;
    font-weight: 600;
  }


  .login-tab-container{
    margin: 0 auto;
    margin-top: 30px;
    border-radius: 5px;
    padding: 20px;
    width: 1100px;
    height: 400px;
    background-color: #fff;
    box-shadow: 0 1px 10px 0 #afafaf;
  }
</style>

