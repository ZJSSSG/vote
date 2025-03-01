<template>
    <!--中间内容-->
    <div class="admin-login-center-box">
      <div class="center login-center-box">
        <el-row :gutter="20">
          <el-col :span="10">
            <el-form label-position="right" label-width="100px">
              <el-form-item label="账号" required>
                <el-input v-model="user.userName" placeholder="用户名"></el-input>
              </el-form-item>
              <el-form-item label="密码" required>
                <el-input v-model="user.password" placeholder="请输入密码" type="password"></el-input>
              </el-form-item>
              <el-form-item label="验证码" required>
                <el-input v-model="verifyCode" placeholder="请输入右侧验证码"></el-input>
                <img :src="captchaPath" @click="updateVerifyCode" class="captcha-code">
              </el-form-item>
              <el-form-item>
                <el-button type="primary"  class="login-button" @click="doLogin"> 登 录 </el-button>
                <span class="forget-tips-text">
                  <a href="/login/forget">忘记密码？</a>
                </span>
              </el-form-item>
            </el-form>
          </el-col>
        </el-row>
      </div>
    </div>
</template>

<script>
  export default {
    name: "index.vue",
    data(){
      return{
        user:{
          userName:'',
          password:''
        },
        verifyCode:'',
        captchaPath:'',
        captcha_key:'',
        curUser:{},
      }
    },

    methods:{
      doLogin(){
        let _this = this
        //判断数据
        if(this.user.userName === ''){
          this.$message.error("请输入用户名");
          return;
        }
        if(this.user.password === ''){
          this.$message.error("请输入密码");
          return;
        }
        if(this.verifyCode === ''){
          this.$message.error("请输入验证码");
          return;
        }
        this.$axios.post('/user/login/'+_this.verifyCode+'/'+_this.captcha_key, {
           userName:_this.user.userName,
           password:_this.user.password
        }).then(resp => {
          if(resp.data.code === 200){
            this.$message.success("登录成功");
            _this.$store.commit('login', _this.user)
            this.getCurUser()
          }else {
            _this.updateVerifyCode();
            this.$message.error(resp.data.message);
          }
        })

      },
      getCurUser(){
        let _this = this
        this.$axios.get('/user?userName='+this.$store.state.user.userName).then(resp =>{
          if(resp){
            _this.curUser = resp.data
            _this.$store.commit('login', _this.curUser)
            var path = this.$route.query.redirect
            this.$router.push({path: path === '/' || path === undefined ? '/admin' : path})
          }
        })
      },
      updateVerifyCode(){
        this.captchaPath = 'http://localhost:8443/api/user/captcha?captcha_key='+this.captcha_key + '&random'+Date.parse(new Date());
      }
    },
    mounted() {
      this.captcha_key = Date.parse(new Date())
      this.updateVerifyCode();
    },
  }
</script>

<style scoped>

  .admin-login-header-box{
    width: 100%;
    height: 46px;
    background-color: dodgerblue;
  }

  .admin-login-header-center{
    line-height: 46px;
    margin: 0 auto;
    width: 1140px;
  }

  .admin-login-logo{
    width: 200px;
    color: #fff;
    font-size: 20px;
    font-weight: 600;
  }

  /*.login-center-box{*/
  /*  margin: 0 auto;*/
  /*  margin-top: 30px;*/
  /*  border-radius: 5px;*/
  /*  padding: 20px;*/
  /*  width: 1100px;*/
  /*  height: 400px;*/
  /*  background-color: #fff;*/
  /*  box-shadow: 0 1px 10px 0 #afafaf;*/
  /*}*/

  .login-center-box .el-input{
    width: 55%;
    float: left;
  }

  .captcha-code{
    cursor: pointer;
    vertical-align: middle;
    margin-left: 10px;
    border:solid 1px #E6E6E6;
    width: 120px;
    padding-left: 10px;
    padding-right: 10px;
    height: 40px;
  }


  .login-button{
    margin-bottom: 0;
    float: left;
  }

  .forget-tips-text{
    float: left;
    margin-left: 20px;
  }
  .forget-tips-text a{
    color: #999;
    text-decoration:none;
  }
  .forget-tips-text a:hover{
    color: #A612FF;

  }

  /*.login-center-box .el-input{*/
  /*  width: 200px;*/
  /*}*/

  /*.el-form-item .login-center-box{*/
  /*  border-radius: 4px;*/
  /*  width: 1100px;*/
  /*  padding: 20px;*/
  /*  background-color: #fff;*/
  /*}*/

  /*.el-form-item .el-input__inner{*/
  /*  border:solid 1px #E6E6E6;*/
  /*  height: 42px;*/
  /*  border-radius: 0;*/
  /*}*/

  /*.el-form-item__label{*/
  /*  background-color: aliceblue;*/
  /*  border-left: solid 1px #e6e6e6;*/
  /*  border-top: solid 1px #e6e6e6;*/
  /*  border-bottom: solid 1px #e6e6e6;*/
  /*  text-align: center;*/
  /*}*/


</style>
