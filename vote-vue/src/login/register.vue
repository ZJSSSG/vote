<template>
    <div class="admin-login-center-box">
      <div class="center login-center-box">
        <el-row :gutter="20">
          <el-col :span="10">
            <el-form label-position="right" label-width="100px">
              <el-form-item label="用户名" required>
                <el-input v-model="user.userName" placeholder="用户名" @blur="checkUserName"></el-input>
                <span class="el-icon-error" v-if="isUserNameOkay === '1'">用户名已被注册</span>
                <span class="el-icon-success" v-if="isUserNameOkay === '0'">用户名可用</span>
              </el-form-item>
              <el-form-item label="密码" required>
                <el-input v-model="user.password" placeholder="请输入密码" type="password"></el-input>
              </el-form-item>
              <el-form-item label="邮箱地址" required>
                <el-input v-model="user.email" placeholder="请输入邮箱"></el-input>
                <!-- <el-button v-if="!isCountDowning" type="primary" class="login-button" style="margin-left: 20px"  @click="getVerifyCode">
                  获取验证码
                </el-button>
                <el-button v-else type="primary" class="login-button" style="margin-left: 20px" @click.prevent="getVerifyCode" disabled>
                  {{countDownText}}
                </el-button> -->
              </el-form-item>
              <!-- <el-form-item label="邮箱验证码" required>
                <el-input v-model="emailCode" placeholder="请输入邮箱验证码"></el-input>
              </el-form-item> -->
              <el-form-item label="验证码" required>
                <el-input v-model="verifyCode" placeholder="请输入右侧验证码"></el-input>
                <img :src="captchaPath" @click="updateVerifyCode" class="captcha-code">
              </el-form-item>
              <el-form-item>
                <el-button type="primary" class="login-button" @click="doRegister" > 注 册 </el-button>
              </el-form-item>
            </el-form>
          </el-col>
        </el-row>
      </div>
    </div>
</template>

<script>
  export default {
    name: "register.vue",
    data(){
      return{
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
        emailCode:''
      }
    },
    methods:{
      doLogin(){
      },
      updateVerifyCode(){
        this.captchaPath = 'http://localhost:8443/api/user/captcha?captcha_key='+this.captcha_key + '&random'+Date.parse(new Date());
      },
      // getVerifyCode(){
      //     let _this = this
      //     if(this.user.email === ''){
      //       this.$message.error("请输入邮箱地址");
      //       return;
      //     }
      //     let reg = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/
      //     if (!reg.test(this.user.email)) {
      //       this.$message.error("邮箱格式不正确");
      //       return;
      //     }
      //    this.$axios
      //     .get('/user/verify_code?email='+_this.user.email+'&type=register').then(resp =>{
      //      if (resp.data.code === 200) {
      //        _this.startCountDown();
      //      }else {
      //        this.$message.error(resp.data.message);
      //      }
      //    })
      // },
      startCountDown(){
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
      checkUserName(){
        if(this.user.userName == ''){
          this.isUserNameOkay = '';
          return;
        }
        let _this = this
        this.$axios
          .get('/user/user_name?userName='+this.user.userName).then(resp =>{
          if (resp.data.code === 200) {
            //已存在
            _this.isUserNameOkay = '1';
          }else {
            //不存在，可以用
            _this.isUserNameOkay = '0';
          }
        })
      },
      doRegister(){
        let _this = this;
        if(this.user.userName === ''){
          this.$message.error("请输入用户名");
          return;
        }
        if(this.user.password === ''){
          this.$message.error("请输入密码");
          return;
        }
        if(this.user.email === ''){
          this.$message.error("请输入邮箱");
          return;
        }
        // if(this.emailCode === ''){
        //   this.$message.error("请输入邮箱验证码") ;
        //   return;
        // }
        if(this.verifyCode === ''){
          this.$message.error("请输入验证码");
          return;
        }
        this.$axios.post('/user/join_in?'+'captcha_code='+_this.verifyCode+ '&captcha_key='+_this.captcha_key+'&email_code='+_this.emailCode,{
          userName:_this.user.userName,
          password:_this.user.password,
          email: _this.user.email
        }).then(resp =>{
          if(resp.data.code === 200){
            this.$message.success("注册成功");
            this.$emit('onSubmit')
            location.href="/login"
          }else {
            _this.updateVerifyCode();
            this.$message.error(resp.data.message);
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

  .forget-tips-text a{
    color: #999;
    text-decoration:none;
  }
  .forget-tips-text a:hover{
    color: #A612FF;
  }

  .el-icon-success{
    color: #67C23A;
  }

  .el-icon-error{
    color: #F56C6C;
  }

</style>
