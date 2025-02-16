<template>
  <div class="admin-login-box">
    <div class="admin-login-header-box">
      <div class="admin-login-header-center">
        <div class="admin-login-logo">
          小龙的投票系统
        </div>
      </div>
    </div>
    <!--中间内容-->
    <div class="admin-login-center-box">
      <div class="center login-center-box">
        <el-row :gutter="20">
          <el-col :span="10">
            <div class="forget-title-tips">
              <span class="forget-title">找回密码</span>
            </div>
            <div class="verify-code-container" v-if="showType === 'verifyCode'">
              <el-form label-position="right" label-width="100px">
                <el-form-item label="邮箱地址" required>
                  <el-input v-model="user.email" placeholder="请输入邮箱"></el-input>
                  <el-button v-if="!isCountDowning" type="primary" class="login-button" style="margin-left: 20px"  @click="getVerifyCode">
                    获取验证码
                  </el-button>
                  <el-button v-else type="primary" class="login-button" style="margin-left: 20px" @click.prevent="getVerifyCode" disabled>
                    {{countDownText}}
                  </el-button>
                </el-form-item>
                <el-form-item label="邮箱验证码" required>
                  <el-input v-model="emailCode" placeholder="请输入邮箱验证码"></el-input>
                </el-form-item>
                <el-form-item>
                  <el-button type="primary"  @click="resetPassword" style="float:left;"> 找回密码  </el-button>
                </el-form-item>
              </el-form>
            </div>
            <div class="forget-reset-password-container" v-if="showType === 'resetPassword'">
              <el-form label-position="right" label-width="100px">
                <el-form-item label="新密码" required>
                  <el-input v-model="user.password" placeholder="请输入密码" type="password"></el-input>
                </el-form-item>
                <el-form-item label="确认密码" required>
                  <el-input v-model="repassword" placeholder="请再次输入密码" type="password"></el-input>
                </el-form-item>
                <el-form-item>
                  <el-button type="primary"  @click="setPassword" style="float:left;"> 设置密码  </el-button>
                </el-form-item>
              </el-form>
            </div>
          </el-col>
        </el-row>
      </div>
    </div>

  </div>
</template>

<script>
  export default {
    name: "forget.vue",
    data(){
      return{
        showType:'verifyCode',
        isUserNameOkay:'',
        isCountDowning:false,
        countDownText:'重新发送(60)',
        user:{
          userName:'',
          password:'',
          email:'',
        },
        captchaPath:'',
        verifyCode:'',
        captcha_key:'',
        emailCode:'',
        repassword:'',

      }
    },

    methods:{
      updateVerifyCode(){
        this.captchaPath = 'http://oahouhs:8443/api/user/captcha?captcha_key='+this.captcha_key + '&random'+Date.parse(new Date());
        console.log(this.captchaPath)
      },
      getVerifyCode(){
        let _this = this
        if(this.user.email === ''){
          this.$message.error("请输入邮箱地址");
          return;
        }
        let reg = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/
        if (!reg.test(this.user.email)) {
          this.$message.error("邮箱格式不正确");
          return;
        }
        this.$axios
          .get('/user/verify_code?email='+_this.user.email+'&type=forget').then(resp =>{
          if (resp.data.code === 200) {
            _this.startCountDown();
          }else {
            this.$message.error(resp.data.message);
          }
        })
      },
      startCountDown(){
        console.log('执行倒计时。。。')
        let _this = this;
        let time = 60;
        this.isCountDowning = true;
        let interval = setInterval(function () {
          //执行倒计时
          time--;
          if(time <= 0){
            _this.isCountDowning = false;
            clearInterval(interval);
          }
          _this.countDownText = '重新发送('+ time + ')';
        },1000)
      },
      resetPassword(){
        let _this = this;
        if(this.user.email === ''){
          this.$message.error("请输入邮箱");
          return;
        }
        if(this.emailCode === ''){
          this.$message.error("请输入邮箱验证码");
          return;
        }
        this.$axios.get('/user/check_email_code?email='+_this.user.email+'&emailCode='+this.emailCode).then(resp =>{
            if(resp.data.code === 200){
              _this.showType = 'resetPassword';
            }else {
              this.$message.error(resp.data.message);
            }
        })
      },
      setPassword(){
        let _this = this;
        if(this.user.password === ''){
          this.$message.error("请输入新的密码");
          return;
        }
        if(this.user.password != this.repassword){
          this.$message.error("两次密码输入不一致");
          return;
        }
        //更新密码
        this.$axios.put('/user/password',{
          email:_this.user.email,
          password:_this.user.password
        }).then(resp =>{
          if(resp.data.code === 200){
            if(resp.data.code === 200){
              this.$message.success("更新成功");
              location.href="/login"
            }else {
              this.$message.error(resp.data.message);
            }
          }
        })
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

  .login-center-box{
    margin: 0 auto;
    margin-top: 30px;
    border-radius: 5px;
    padding: 20px;
    width: 1100px;
    height: 400px;
    background-color: #fff;
    box-shadow: 0 1px 10px 0 #afafaf;
  }

  .login-center-box .el-input{
    width: 55%;
    float: left;
  }

  .login-button{
    margin-bottom: 0;
    float: left;
  }

  .forget-tips-text a{
    color: #999;
    text-decoration:none;
  }
  .forget-tips-text a:hover{
    color: #A612FF;
  }
  .forget-title-tips{
    width: 80%;
    font-size: 20px;
    font-weight: 600;
    padding: 20px;
    margin-bottom: 20px;
    text-align: left;
    color: #505458;
  }

</style>
