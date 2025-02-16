<template>

  <div class="setItemsDiv">
    <el-dialog
      title="活动链接"
      :visible.sync="dialogFormVisible"
      :modal-append-to-body="false"
      @close="clear"
      :width="dialogWidth">
      <div class="qrcode" ref="qrCodeUrl" style="margin:50px auto;padding-left: 165px"></div>
      <div style="color: #36AAFF;">
        <a :href="activityLink" >{{activityLink}}</a>
      </div>
    </el-dialog>
    <el-row>
      <el-col :sm="1"  :xl="2">&nbsp;</el-col>
      <el-col :sm="20"  :xs="24">
        <el-card>
          <div>
            <div style="float: left">
              活动管理
            </div>
            <div style="float: right">
              <el-button type="primary" @click="toCreate">创建投票</el-button>
            </div>
          </div>
          <div style="text-align: left">
            <el-table
              v-loading="loading"
              :data="activities"
              stripe
              :default-sort = "{prop: 'id', order: 'ascending'}"
              style="width: 100%"
              ref="multipleTable"
              show-overflow-tooltip>
              <el-table-column
                prop="title"
                label="标题"
                width="150">
              </el-table-column>
              <el-table-column
                prop="author"
                label="用户"
                fit>
              </el-table-column>
              <el-table-column
                label="状态"
                fit>
                <template slot-scope="scope">
                  <el-tag type="info"  size="small" v-if="date.getTime() < Date.parse(scope.row.startTime)">未开始</el-tag>
                  <el-tag type="danger"  size="small" v-else-if="new Date().getTime() > Date.parse(scope.row.endTime)">已结束</el-tag>
                  <el-tag type="success" size="small" v-else>进行中</el-tag>
                </template>
              </el-table-column>
              <el-table-column
                label="活动时间"
                width="150">
                <template slot-scope="scope">
                  <div style="color: #999;">{{scope.row.startTime | fmtDate}}</div>
                  <div style="color: #999;">{{scope.row.endTime | fmtDate}}</div>
                  <div style="color: #999;"></div>
                </template>
              </el-table-column>
              <el-table-column
                label="属性"
                fit>
                <template slot-scope="scope">
                  <el-button type="primary"  size="small" v-if="scope.row.state === '1'">正常</el-button>
                  <el-button type="danger"  size="small" v-else-if="scope.row.state === '0'">禁止</el-button>
                  <el-button type="info" size="small" v-else>案例</el-button>
                </template>
              </el-table-column>
              <el-table-column
                label="修改属性"
                width="120">
                <template slot-scope="scope">
                  <el-dropdown trigger="click" >
                    <span class="el-dropdown-link">
                      <el-button
                        plain
                        size="small">
                         修改属性<i class=" el-icon-arrow-down"></i>
                      </el-button>
                    </span>
                    <el-dropdown-menu slot="dropdown">
                      <el-dropdown-item @click.native="updateState(scope.row,'1')" >
                         正 常
                      </el-dropdown-item>
                      <el-dropdown-item @click.native="updateState(scope.row,'0')">
                         禁 止
                      </el-dropdown-item>
                      <el-dropdown-item @click.native="updateState(scope.row,'2')">
                         案 例
                      </el-dropdown-item>
                    </el-dropdown-menu>
                  </el-dropdown>
                </template>
              </el-table-column>
              <el-table-column
                label="操作"
                width="200">
                <template slot-scope="scope">
                  <el-button size="mini" type="success"  @click="toVoteResult(scope.row)">统计</el-button>
                  <el-button size="mini"  type="warning" @click="showQrCode(scope.row)">二维码</el-button>
                </template>
              </el-table-column>
            </el-table>
            <div style="float: left;padding: 15px">
              <el-pagination
                @current-change="handleCurrentChange"
                :current-page="currentPage"
                :page-size="pageSize"
                :total="totalSize">
              </el-pagination>
            </div>
          </div>
        </el-card>

      </el-col>

    </el-row>
  </div>
</template>

<script>
  import QRCode from 'qrcodejs2';
  export default {
    name: 'ActivityManagement',
    data(){
      return{
        loading: false,
        dialogWidth:'500px',
        currentPage:1,
        pageSize:6,
        totalSize:0,
        activities:[],
        selectedActivity:[],
        voteItems:[],
        date: new Date(),
        date_1:'',
        dialogFormVisible:false,
        activityLink:'',
        cur_date : this.$options.filters.fmtDate(new Date())
      }
    },
    mounted() {
      window.onresize = () => {
        return (() => {
          this.setDialogWidth()
        })()
      }
      this.listActivity()

    },
    methods:{
      listActivity(){
        let _this = this
        this.loading = true
        this.$axios.get('/admin/activity/list?page='+_this.currentPage
          +'&size='+_this.pageSize
          +'&userName='+ _this.$store.state.user.userName)
          .then(resp =>{
            if(resp && resp.data.code === 200){
              _this.activities = resp.data.result.content
              _this.totalSize = resp.data.result.totalElements
              _this.loading = false
            }
          })
      },
      toCreate(){
        this.$store.state.curCreateActivity = []
        this.$router.replace('/admin/vote/add/index')
      },
      toVoteResult(activity){
        this.$store.commit('createActive', activity)
        this.$router.replace('/admin/vote/list/result')
      },
      showQrCode(activity){
        this.dialogFormVisible = true
        this.activityLink = 'http://localhost:8080/activityIndex?id='+activity.id
        this.$nextTick(function () {
          this.creatQrCode()
        })
      },
      creatQrCode() {
        let qrcode = new QRCode(this.$refs.qrCodeUrl, {
          text: this.activityLink, // 需要转换为二维码的内容
          width: 120,
          height: 120,
          colorDark: '#000000',
          colorLight: '#ffffff',
          correctLevel: QRCode.CorrectLevel.H
        })
      },
      clear(){
        this.dialogFormVisible = false
        this.$refs.qrCodeUrl = ''
      },

      handleCurrentChange(currentPage) {
        this.currentPage = currentPage
        this.listActivity()
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
      updateState(activity,state){
        this.$confirm('确定更改属性?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$axios.put('/admin/activity/'+activity.id,{
            author: activity.author,
            content: activity.content,
            createTime: activity.createTime,
            signIn: activity.signIn,
            startTime: activity.startTime,
            endTime:activity.endTime,
            state: state,
            title: activity.title,
            type: activity.type,
            verifyCode: activity.verifyCode,
          }).then(resp =>{
            if(resp && resp.data.code === 200){
              this.$message.success("更新属性成功")
              this.listActivity()
            }
          })
        }).catch(() => {
        })
      }
    }
  }
</script>

<style>
</style>
