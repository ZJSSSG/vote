<template>
  <div>
    <div class="center login-center-box">
      <el-dialog
        title="修改邮箱"
        :visible.sync="dialogForEmail"
        :modal-append-to-body="false"
        @close="clear"
        :width="dialogWidth">
        <el-row :gutter="20">
          <el-form label-position="right" label-width="100px">
            <el-form-item label="邮箱地址" required>
              <el-input v-model="email" placeholder="请输入邮箱"></el-input>
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
              <el-button type="primary" class="login-button" @click="updateEmail" > 修改邮箱 </el-button>
            </el-form-item>
          </el-form>
        </el-row>
      </el-dialog>

      <el-row :gutter="20">
        <el-col :span="10">
          <el-form label-position="right" label-width="100px">
            <el-form-item>
              <img :src="curUser.avatar || '../../img/defaultImg.png'" v-loading="avatarLoading"
                   class="user-avatar">
            </el-form-item>
            <el-form-item label="用户名" >
              <label class="info-label">{{curUser.userName}}</label>
            </el-form-item>
            <el-form-item label="邮箱" >
              <label class="info-label">{{curUser.email}}</label>
            </el-form-item>
            <el-form-item label="操作">
              <el-button type="primary" class="login-button" @click="updatePassword"> 修改密码</el-button>
              <el-button type="success" class="login-button" @click="toUpdateEmail"> 修改邮箱</el-button>
              <span class="login-button">
                      <el-button @click.native="setCurCandidate()"
                                 type="primary"
                      >
                         更换头像
                      </el-button>
                    </span>
              <el-upload
                ref="upload"
                action="http://localhost:8443/api/admin/candidate/covers"
                with-credentials
                :show-file-list="false"
                :on-success="handleSuccess"
              >
              </el-upload>
            </el-form-item>
          </el-form>
        </el-col>
      </el-row>
    </div>
    <div class="user-info-dialog">
<!--      <avatar-upload field="img"-->
<!--                 @crop-success="cropSuccess"-->
<!--                 @crop-upload-success="cropUploadSuccess"-->
<!--                 @crop-upload-fail="cropUploadFail"-->
<!--                 v-model="show"-->
<!--                 :width="300"-->
<!--                 :height="300"-->
<!--                 url="/upload"-->
<!--                 :params="params"-->
<!--                 :headers="headers"-->
<!--                 img-format="png"></avatar-upload>-->
    </div>
  </div>

</template>

<script>
    export default {
      name: "UserInfo",
      data() {
        return {
          avatarLoading: true,
          dialogForEmail: false,
          dialogWidth: '500px',
          email: '',
          emailCode: '',
          isUserNameOkay: '',
          isCountDowning: false,
          countDownText: '重新发送(60)',
          user: {
            userName: '',
            password: ''
          },
          verifyCode: '',
          captchaPath: '',
          captcha_key: '',
          curUser: [],
          curCandidate: {},
          imageLink: null,

        }
      },
      mounted() {
        this.getCurUser()
      },
      methods:{
        getCurUser(){
          this.avatarLoading = true
          let _this = this
          this.$axios.get('/user?userName='+this.$store.state.user.userName).then(resp =>{
            if(resp){
              _this.curUser = resp.data
              this.avatarLoading = false
            }
          })
        },
        getVerifyCode(){
          let _this = this
          if(this.email === ''){
            this.$message.error("请输入邮箱地址");
            return;
          }
          let reg = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/
          if (!reg.test(this.email)) {
            this.$message.error("邮箱格式不正确");
            return;
          }
          this.$axios
            .get('/user/verify_code?email='+_this.email+'&type=update').then(resp =>{
            if (resp.data.code === 200) {
              _this.startCountDown();
            }else {
              this.$message.error(resp.data.message);
            }
          })
        },
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
        clear(){
          this.dialogForEmail = false
        },
        updatePassword(){
          this.$router.replace('/login/forget')
        },
        updateEmail(){
          let _this = this
          this.$axios.put('/user/email?email='+_this.email+'&verify_code='+_this.emailCode,{
            id:_this.curUser.id,
            userName: _this.curUser.userName
          }).then(resp =>{
            if (resp && resp.data.code === 200) {
              this.$message.success("修改成功")
              this.dialogForEmail = false
              this.email = ''
              this.emailCode = ''

              this.getCurUser()
            } else {
              let message = resp.data.message
              this.$message.error(message)
            }
          })
        },
        toUpdateEmail() {
          this.dialogForEmail = true
        },
        setCurCandidate() {
          this.$refs.upload.$el.querySelector('input[type="file"]').click();
        },
        handleSuccess(response) {
          this.imageLink = response
          this.submitImgLink()
          this.$message.warning('上传成功')
        },
        submitImgLink() {
          this.$axios.put('/user/avatar', {
            avatar: this.imageLink,
            userName: this.$store.state.user.userName
          }).then(resp => {
            this.getCurUser()
          })
        },
      }
    }
</script>

<style scoped>
.user-avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  cursor: pointer;
}

.login-center-box .el-input {
  width: 40%;
  float: left;
}

  .login-button{
    margin-left: 20px;
    margin-bottom: 0;
    float: left;
  }
  .info-label{
    margin-left: 20px;
    margin-bottom: 0;
    float: left;
  }
.user-avatar{
  float: left;
  margin-left: 30px;
  width: 80px;
  height: 80px;
  border-radius: 50px;
}
</style>
