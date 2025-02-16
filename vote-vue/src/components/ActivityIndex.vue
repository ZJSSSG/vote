<template>
  <div>
    <el-row>
      <el-col :xs="24" :sm="4">
        <el-dialog
          title="选手详情"
          :visible.sync="dialogFormVisible"
          :modal-append-to-body="false"
          @close="clear"
          :width="dialogWidth"
          style="text-align: center">
          <img :src="itemCoverLink" alt="" :onerror="errorImg01" style="width: 40%;"/>
          <p v-html="candidateDesc"></p>
        </el-dialog>
        <el-dialog
          title="请先登录"
          :visible.sync="dialogForLogin"
          :modal-append-to-body="false"
          @close="clear"
          :width="dialogWidth">
          <el-form label-position="right" label-width="100px">
            <el-form-item label="账号">
              <el-input v-model="user.userName" placeholder="用户名" class="login-input"></el-input>
            </el-form-item>
            <el-form-item label="密码">
              <el-input v-model="user.password" placeholder="请输入密码" type="password" class="login-input"></el-input>
            </el-form-item>
            <el-form-item label="验证码">
              <el-input v-model="verifyCode" placeholder="请输入右侧验证码" class="login-input"></el-input>
              <img :src="captchaPath" @click="updateVerifyCode" class="captcha-code">
            </el-form-item>
            <el-form-item>
              <el-button type="primary" class="login-button" @click="doLogin"> 登 录</el-button>
              <span class="forget-tips-text">
                  <a href="/login/forget">忘记密码？</a>
                </span>
            </el-form-item>
          </el-form>
        </el-dialog>

        <el-dialog
          title="投票验证码"
          :visible.sync="dialogForVote"
          :modal-append-to-body="false"
          @close="clear"
          :width="dialogWidth"
          style="text-align: center">
          <el-form>
            <el-form-item>
              <img :src="captchaPath" @click="updateVerifyCode" class="captcha-code">
            </el-form-item>
            <el-form-item>
              <el-input v-model="verifyCode" placeholder="输入上边验证码" class="verify-code-input"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="singleVote"> 提 交</el-button>
            </el-form-item>
          </el-form>
        </el-dialog>

      </el-col>
    </el-row>
    <el-row>
      <el-col :xs="{span:24,offset:0}" :sm="{span:16,offset:4}" :md="{span:16,offset:4}">
        <el-card class="activityDescDard">
          <h3>{{ curActivity.title }}</h3>
          <h5 style="color: #999">请仔细阅读活动详细规则</h5>
          <el-col :xl="4">&nbsp;</el-col>
          <el-col :sm="16">
            <div style="text-align: left;font: 14px;color: #999;">
              <div class="activeTime" style="margin: 10px;">
                活动开始：{{ curActivity.startTime  | fmtDate }} <br>
                活动截止：{{ curActivity.endTime  | fmtDate }} <br>
              </div>
              <div class="activerule" style="margin: 10px;">
                投票规则: <br>
                <div>
                  <span
                    v-if="activityType.voteType === 'single'">1. 每个用户可以投{{
                      activityType.totalVotes
                    }}票，可为同一选手投票{{ activityType.oneVotes }}票</span>
                  <span v-else>1. 最少选择{{ activityType.least }}人，最多投{{ activityType.most }}票</span>
                  <br>
                  <span v-if="activityType.cycleType === 'true'">2. 每天都可以投票</span>
                  <span v-else>2. 投票期间只能投一次</span>
                  <br>
                  <span v-if="curActivity.verifyCode">3. 投票时需要输入验证码</span>
                </div>
              </div>
              <div class="activerule" style="margin: 10px;">
                活动详情: <br>
                <p style="padding-left: 50px;" v-html="curActivity.content">

                </p>
              </div>
            </div>
          </el-col>
        </el-card>

      </el-col>
    </el-row>
    <el-row>
      <el-col :xs="{span:24,offset:0}" :sm="{span:16,offset:4}" :md="{span:16,offset:4}">

        <el-tabs v-model="activeName" @tab-click="handleTabClick">
          <el-tab-pane label="进行投票" name="first">
            <h2>参赛选手</h2>
            <h5 style="color: #999">请为喜欢的选手投票，点击选手头像查看详细信息</h5>
            <div v-if="activityType.voteType === 'single'">
              <el-row>
                <div v-for="(item,index) in voteItems" :key="index">
                  <el-col :xs="10" :sm="5" :offset="1">
                    <el-card style="background-color: #F7F7F7; margin-bottom: 10px">
<!--                      客户端投票选项-->
                      <div @click="showDetail(item)">
                        <img :src="item.coverUrl" alt="" :onerror="errorImg01"
                             style="width: 66px;height: 66px; border-radius: 50%;">
                        <div style="padding: 14px;color: #999; font-size: 14px;">
                          <span style="font-size: 16px;font-weight: bold; color: #2C3E50;">{{ item.title }}</span><br/>
                          <span>编号： {{ item.num }}</span><br>
                          <span>得票：<span style="color: red;">{{ item.voteCount }} </span>票</span><br>
                        </div>
                      </div>
                      <el-button type="primary" size="small" style="margin: 10px;" @click="handleVote(item)">投一票
                      </el-button>
                    </el-card>
                  </el-col>
                </div>
              </el-row>
              <br>
            </div>
            <div v-else>
              <el-row>
                <div v-for="(item,index) in voteItems" :key="index">
                  <el-col :xs="10" :sm="5" :offset="1">
                    <el-card style="background-color: #F7F7F7;margin-bottom: 10px">
                      <div @click="showDetail(item)">
<!--                        管理员端选项-->
                        <img :src="item.coverUrl" alt="" :onerror="errorImg01"
                             style="width: 66px;height: 66px; border-radius: 50%;">
                        <div style="padding: 14px;color: #999; font-size: 14px;">
                          <span style="font-size: 16px;font-weight: bold; color: #2C3E50;">{{ item.title }}</span><br/>
                          <span>编号： {{ item.num }}</span><br>
                          <span>得：<span style="
                          color: red;">{{ item.voteCount }} </span>票</span><br>
                        </div>
                      </div>
                      <el-button :type="btnMap.get(item.id)" size="small" style="margin: 10px"
                                 @click="changeSelected(item.id)" v-if="btnMap.get(item.id) != 'primary'">
                        投一票
                      </el-button>
                      <el-button :type="btnMap.get(item.id)" size="small" style="margin: 10px"
                                 @click="changeSelected(item.id)" v-else>
                        已&nbsp&nbsp选
                      </el-button>
                    </el-card>
                  </el-col>
                </div>
              </el-row>
              <br>
            </div>
            <div>
              <div v-if="activityType.voteType === 'multiple'" style="float: right;margin-right: 20px">
                <el-button type="primary" @click="multipleVote">
                  提交投票
                </el-button>
              </div>
              <div style="float: left;margin-left: 20px;margin-bottom: 10px">
                <el-pagination
                  @current-change="handleCurrentChange"
                  :current-page="currentPage"
                  :page-size="pageSize"
                  :total="totalSize">
                </el-pagination>
              </div>
            </div>
          </el-tab-pane>
          <el-tab-pane label="查看排行" name="second">
            <h2>排行榜</h2>
            <h5 style="color: #999">实时显示当前投票排名</h5>
            <div v-for="(item,index) in totalItems" :key="index">
              <el-row>
                <el-col :xs="{span:24,offset:0}" :sm="{span:16,offset:4}" :md="{span:16,offset:4}">
                  <el-card style="background-color: #F7F7F7; height: 65px;" :body-style="{ padding: '0px' }">
                    <el-col :sm="4" :xs="4" style="margin-top: 22px;color: #999;">第{{ index + 1 }}名</el-col>
                    <el-col :sm="4" :xs="4" style="margin-top: 22px;color: #999;">{{ item.title }}</el-col>
                    <el-col :sm="4" :xs="4" :offset="1">
<!--                      客户端排行-->
                      <img :src="item.coverUrl" alt="" :onerror="errorImg01"
                           style="width: 66px;height: 66px; border-radius: 50%;">
                    </el-col>
                    <el-col :sm="6" :xs="5" style="margin-top: 22px;color: #999;">
                      <el-progress :text-inside="true" :stroke-width="18"
                                   :percentage="parseInt((item.voteCount/sumVotes)*100) > 0 ? parseInt((item.voteCount/sumVotes)*100) : 0"></el-progress>
                    </el-col>
                    <el-col :sm="4" :xs="4" style="margin-top: 22px;color: #999;">{{ item.voteCount }}票</el-col>
                  </el-card>
                </el-col>
              </el-row>
              <br>
            </div>
          </el-tab-pane>

        </el-tabs>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "ActivityIndex",
  data() {
    return {
      dialogFormVisible: false,
      dialogForLogin: false,
      dialogForVote: false,
      dialogWidth: '500px',
      user: {
        userName: 'admin',
        password: '123456'
      },
      verifyCode: 'verifyCode',
      captchaPath: '',
      captcha_key: '',
      voteItems: [],
      totalItems: [],
      rankItems: [],
      multipleItem: [1, 2, 3, 4],
      curActivity: [],
      candidateDesc: [],
      itemCoverLink: '',
      activityType: [],
      errorImg01: 'this.src="' + require('../img/defaultImg.png') + '"',
      checks: [false, true, true, true],
      isActive: true,
      btns: [],
      btnMap: new Map(),
      selectedIds: [],
      curUser: [],
      activeName: 'first',
      sumVotes: 0,
      currentPage: 1,
      pageSize: 4,
      totalSize: 0,
      cur_date: new Date(),
      selectedItem: [],
      voteData: {}

    }
  },
  mounted() {
    window.onresize = () => {
      return (() => {
        this.setDialogWidth()
      })()
    }
    this.getCandidates()
    this.getTotal()
    this.getActivity()
    this.getCurUser()
    this.captcha_key = Date.parse(new Date())
    this.updateVerifyCode();
  },
  methods: {
    showDetail(item) {
      this.dialogFormVisible = true
      this.candidateDesc = item.itemDesc
      this.itemCoverLink = item.coverUrl
    },
    //获取所有所有选手（排好顺序）,初始化btnMap
    getTotal() {
      let _this = this
      this.$axios.get('/candidate/list/sequence/' + this.$route.params.id).then(resp => {
        if (resp && resp.data.code === 200) {
          _this.totalItems = resp.data.result
          _this.totalSize = resp.data.result.length
          _this.sumVotes = 0
          for (let i = 0; i < _this.totalItems.length; i++) {
            _this.btnMap.set(_this.totalItems[i].id, '')
            _this.sumVotes += this.totalItems[i].voteCount
          }
        }
      })
    },
    getCandidates() {
      let _this = this
      this.$axios.get('/candidate/list/' + this.$route.params.id
        + '?page=' + _this.currentPage + '&size=' + _this.pageSize).then(resp => {
        if (resp && resp.data.code === 200) {
          this.voteItems = resp.data.result // 当前页选手
          // this.rankItems = this.voteItems.sort(this.rankCompare)
        }
      })
    },
    getActivity() {
      this.$axios.get('/activity/' + this.$route.params.id)
        .then(resp => {
          if (resp && resp.data.code === 200) {
            this.curActivity = resp.data.result
            this.activityType = JSON.parse(this.curActivity.type)
          }
        })
    },
    changeSelected(id) {
      if (this.btnMap.get(id) != "primary") {
        if (this.selectedIds.length >= this.activityType.most) {
          let message = '最多选择' + this.activityType.most + '票！'
          this.$message.error(message);
          return;
        }
        this.btnMap.set(id, 'primary')
        this.selectedIds.push(id)
      } else {
        this.btnMap.set(id, '')
        for (let i = 0; i < this.selectedIds.length; i++) {
          if (this.selectedIds[i] === id) {
            this.selectedIds.splice(i, 1);
          }
        }
      }
      this.$forceUpdate();
    },
    handleVote(item) {
      let _this = this
      // 1. 判断活动状态
      if (this.curActivity.state === '0') {
        this.$message.error('该活动暂时禁止投票')
        return;
      }
      //2. 判断活动时间
      let curDate = new Date().getTime
      if (curDate < Date.parse(this.curActivity.startTime)) {
        this.$message.error("投票还未开始")
        return;
      }
      if (curDate > Date.parse(this.curActivity.endTime)) {
        this.$message.error("投票已经结束")
        return;
      }
      // 3. 判断是否登录
      if (this.curUser === "") {
        this.dialogForLogin = true
        return;
      }
      // 4.赋值选中的选项
      this.selectedItem = item

      // 5. 判断是否需要验证码
      if (this.curActivity.verifyCode === true) {
        this.updateVerifyCode()
        this.dialogForVote = true
        return;
      }
      this.singleVote(this.selectedItem)
    },
    singleVote() {
      let _this = this
      if (this.activityType.voteType === 'single') {
        this.$axios.post('/vote/single/' + _this.verifyCode + '/' + _this.captcha_key, {
          aid: _this.selectedItem.aid,
          cid: _this.selectedItem.id,
          uid: _this.curUser.id
        }).then(resp => {
          if (resp && resp.data.code === 200) {
            this.$message.success("投票成功")
            _this.dialogForVote = false
            _this.verifyCode = ''
            this.getCandidates()
          } else {
            let message = resp.data.message
            _this.dialogForVote = false
            _this.verifyCode = ''
            this.$message.error(message)
          }
        })
      } else {
        this.$axios.post('/vote/multiple/' + _this.verifyCode + '/' + _this.captcha_key, {
          voteData: {
            aid: _this.curActivity.id,
            uid: this.curUser.id,
            selectedIds: this.selectedIds
          }
        }).then(resp => {
          if (resp && resp.data.code === 200) {
            this.$message.success("投票成功")
            _this.dialogForVote = false
            _this.verifyCode = ''
            this.getCandidates()
            this.selectedIds = []
            this.getTotal()
          } else {
            let message = resp.data.message
            _this.dialogForVote = false
            _this.verifyCode = ''
            this.selectedIds = []
            this.getTotal()
            this.$message.error(message)
          }
        })
      }

    },

    multipleVote() {
      // 1. 判断活动状态
      if (this.curActivity.state === '0') {
        this.$message.error('该活动暂时禁止投票')
        return;
      }
      //2. 判断活动时间
      let curDate = new Date().getTime
      if (curDate < Date.parse(this.curActivity.startTime)) {
        this.$message.error("投票还未开始")
        return;
      }
      if (curDate > Date.parse(this.curActivity.endTime)) {
        this.$message.error("投票已经结束")
        return;
      }
      //3. 判断是否登录
      if (this.curUser === "") {
        this.dialogForLogin = true
        return;
      }
      //4.判断选中选项
      if (this.selectedIds.length < this.activityType.least) {
        let message = '最少选择' + this.activityType.least + '票！'
        this.$message.error(message)
        return;
      }
      //5.判断是否需要验证码
      if (this.curActivity.verifyCode === true) {
        this.updateVerifyCode()
        this.dialogForVote = true
        return;
      }
      //6.提交投票
      this.submitVote()
    },

    submitVote() {
      let _this = this
      this.$axios.post('/vote/multiple/' + _this.verifyCode + '/' + _this.captcha_key, {
        voteData: {
          aid: _this.curActivity.id,
          uid: this.curUser.id,
          selectedIds: this.selectedIds,
        }
      }).then(resp => {
        if (resp && resp.data.code === 200) {
          this.$message.success("投票成功")
          this.selectedIds = []
          this.getTotal()
          this.getCandidates()
        } else {
          let message = resp.data.message
          this.selectedIds = []
          this.getTotal()
          this.$message.error(message)
        }
      })
    },
    getCurUser() {
      let _this = this
      this.$axios.get('/user?userName=' + this.$store.state.user.userName).then(resp => {
        if (resp) {
          _this.curUser = resp.data
        }
      })
    },
    handleTabClick(tab, event) {
      this.getTotal()
      this.$forceUpdate()
    },
    clear() {
      this.dialogFormVisible = false
      this.dialogForLogin = false
      this.dialogForVote = false
      this.selectedIds = []
      this.verifyCode = ''
      this.getTotal()
    },
    handleCurrentChange: function (currentPage) {
      this.currentPage = currentPage
      this.getCandidates()
    },
    updateVerifyCode() {
      this.captchaPath = 'http://localhost:8443/api/user/captcha?captcha_key=' + this.captcha_key + '&random' + Date.parse(new Date());
    },
    doLogin() {
      let _this = this
      //判断数据
      if (this.user.userName === '') {
        this.$message.error("请输入用户名");
        return;
      }
      if (this.user.password === '') {
        this.$message.error("请输入密码");
        return;
      }
      if (this.verifyCode === '') {
        this.$message.error("请输入验证码");
        return;
      }
      this.$axios.post('/user/login/' + _this.verifyCode + '/' + _this.captcha_key, {
        userName: _this.user.userName,
        password: _this.user.password
      }).then(resp => {
        if (resp.data.code === 200) {
          this.$message.success("登录成功");
          _this.dialogForLogin = false
          _this.$store.commit('login', _this.user)
          _this.getCurUser()
        } else {
          _this.updateVerifyCode();
          this.$message.error(resp.data.message);
        }
      })
    },
    setDialogWidth() {
      let val = document.body.clientWidth
      const def = 500 // 默认宽度
      if (val < def) {
        this.dialogWidth = '100%'
      } else {
        this.dialogWidth = def + 'px'
      }
    },
  }
}
</script>

<style>
.activityDescDard {
  background-color: #F7F7F7;
}

.active {
  background: #36aaff;
  color: white;
}

.login-input {
  width: 55%;
  float: left;
}

/* .el-input{*/

/*}*/

.captcha-code {
  cursor: pointer;
  vertical-align: middle;
  margin-left: 10px;
  border: solid 1px #E6E6E6;
  width: 120px;
  padding-left: 10px;
  padding-right: 10px;
  height: 40px;
}

.verify-code-input {
  width: 60%;
}

.login-button {
  margin-bottom: 0;
  float: left;
}

.forget-tips-text {
  float: left;
  margin-left: 20px;
}

.forget-tips-text a {
  color: #999;
  text-decoration: none;
}

.forget-tips-text a:hover {
  color: #A612FF;

}

</style>
