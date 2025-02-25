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
        <router-link :to="'/activityIndex/'+activityId">{{activityLink}}</router-link>
<!--        <a :href="activityLink" >{{activityLink}}</a>-->
      </div>
    </el-dialog>
    <el-row>
      <el-col :sm="1"  :xl="2">&nbsp;</el-col>
      <el-col :sm="20"  :xs="24">
        <el-card style="margin-top: 20px">
          <div style="float: left;margin-bottom: 20px">
            最新公告
          </div>
          <div style="text-align: left;">
            <el-table
              v-loading="noticeLoading"
              :data="notices"
              stripe
              :default-sort = "{prop: 'id', order: 'ascending'}"
              style="width: 100%"
              ref="multipleTable"
              show-overflow-tooltip>
              <el-table-column
                label="标题"
                fit>
                <template slot-scope="scope">
                  <router-link :to="'/notice/detail/'+scope.row.id" class="notice-link">{{scope.row.title}}</router-link>
                </template>
              </el-table-column>
              <el-table-column
                label="发布时间"
                fit>
                <template slot-scope="scope">
                  <div style="color: #999;">{{scope.row.createTime | fmtDate}}</div>
                </template>
              </el-table-column>
            </el-table>
            <div style="float: left;padding: 15px">
              <el-pagination
                @current-change="handleNoticeCurrentChange"
                :current-page="noticeCurrentPage"
                :page-size="noticePageSize"
                :total="noticeTotalSize">
              </el-pagination>
            </div>
          </div>
        </el-card>

      </el-col>

    </el-row>
    <el-row>
      <el-col :sm="1"  :xl="2">&nbsp;</el-col>
      <el-col :sm="20"  :xs="24">
        <el-card>
          <div>
            <div style="float: left">
              我创建的投票
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
              ref="multipleTable">
              <el-table-column
                prop="title"
                label="标题"
                width="200">
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
                width="200">
                <template slot-scope="scope">
                  <div style="color: #999;">{{scope.row.startTime | fmtDate}}</div>
                  <div style="color: #999;">{{scope.row.endTime | fmtDate}}</div>
                  <div style="color: #999;"></div>
                </template>
              </el-table-column>
              <el-table-column
                label="操作"
                width="500px">
                <template slot-scope="scope">
                  <el-button size="mini" type="primary"  @click="editActivity(scope.row)">编辑</el-button>
                  <el-button size="mini" type="primary"  @click="editCandidate(scope.row)">选手管理</el-button>
                  <el-button size="mini" type="success"  @click="toVoteResult(scope.row)">统计</el-button>
                  <el-button size="mini"  type="warning" @click="showQrCode(scope.row)">分享</el-button>
                  <el-button size="mini"  type="warning" @click="toVote(scope.row)">投票</el-button>
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
    <el-row>
      <el-col :sm="1"  :xl="2">&nbsp;</el-col>
      <el-col :sm="20"  :xs="24">
        <el-card>
          <div>
            <div style="float: left">
              我参与的投票
            </div>
          </div>
          <div style="text-align: left">
            <el-table
              v-loading="loading"
              :data="canVoteActivities"
              stripe
              :default-sort = "{prop: 'id', order: 'ascending'}"
              style="width: 100%"
              ref="multipleTable">
              <el-table-column
                prop="title"
                label="标题"
                width="200">
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
                width="200">
                <template slot-scope="scope">
                  <div style="color: #999;">{{scope.row.startTime | fmtDate}}</div>
                  <div style="color: #999;">{{scope.row.endTime | fmtDate}}</div>
                  <div style="color: #999;"></div>
                </template>
              </el-table-column>
              <el-table-column
                label="操作"
                width="500px">
                <template slot-scope="scope">
                  <el-button size="mini" type="success"  @click="toVoteResult(scope.row)">统计</el-button>
                  <el-button size="mini"  type="warning" @click="showQrCode(scope.row)">分享</el-button>
                  <el-button size="mini"  type="warning" @click="toVote(scope.row)">投票</el-button>
                </template>
              </el-table-column>
            </el-table>
            <div style="float: left;padding: 15px">
              <el-pagination
                @current-change="handleCurrentChange"
                :current-page="currentPage"
                :page-size="pageSize"
                :total="canVotetotalSize">
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
    name: 'ListActivity',
    data(){
      return{
        noticeLoading:false,
        loading: false,
        dialogWidth:'500px',
        currentPage:1,
        pageSize:6,
        totalSize:0,
        canVotetotalSize:0,
        noticeCurrentPage:1,
        noticePageSize:4,
        noticeTotalSize:0,
        notices:[],
        activities:[],
        canVoteActivities:[],
        voteItems:[],
        date: new Date(),
        date_1:'',
        dialogFormVisible:false,
        activityLink:'',
        activityId:'',
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
      this.canVoteListActivity()
      this.listNotice()

    },
    methods:{
      listActivity(){
        let _this = this
        this.loading = true
        this.$axios.get('/admin/activity/list/self?page='+_this.currentPage
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
      canVoteListActivity(){
        let _this = this
        this.loading = true
        this.$axios.get('/admin/activity/list/canVote?page='+_this.currentPage
          +'&size='+_this.pageSize
          +'&userName='+ _this.$store.state.user.userName)
          .then(resp =>{
            if(resp && resp.data.code === 200){
              _this.canVoteActivities = resp.data.result.content
              _this.canVotetotalSize = resp.data.result.totalElements
              _this.loading = false
            }
          })
      },
      toCreate(){
        this.$store.state.curCreateActivity = []
        this.$router.replace('/admin/vote/add/index')
      },
      editActivity(activity){
        this.$store.commit('createActive', activity)
        const id = this.$store.state.curCreateActivity.id;
        window.open(`/admin/vote/add/index?id=${id}`, '_blank'); // 打开新页面

      },
      editCandidate(activity){
        this.$store.commit('createActive', activity)
        const id = this.$store.state.curCreateActivity.id;
        window.open(`/admin/vote/add/item?id=${id}`, '_blank'); // 打开新页面
      },
      toVoteResult(activity){
        this.$store.commit('createActive', activity)
        const id = this.$store.state.curCreateActivity.id;
        window.open(`/admin/vote/list/result?id=${id}`, '_blank');
        // this.$router.replace('/admin/vote/list/result')
      },
      toVote(activity){
        this.$store.commit('createActive', activity);
        window.open(`/ActivityIndex/${activity.id}`, '_blank'); // 打开新页面
      },
      showQrCode(activity){
        this.dialogFormVisible = true
        this.activityId = activity.id
        this.activityLink = 'http://localhost/activityIndex/'+activity.id
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
      handleNoticeCurrentChange(noticeCurrentPage){
        this.currentPage = noticeCurrentPage
        this.listNotice()
      },
      listNotice(){
        let _this = this
        this.noticeLoading = true
        this.$axios.get('/notice/list?page='+_this.noticeCurrentPage
          +'&size='+_this.noticePageSize)
          .then(resp =>{
            if(resp && resp.data.code === 200){
              _this.notices = resp.data.result.content
              _this.totalSize = resp.data.result.totalElements
              _this.noticeLoading = false
            }
          })
      },
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
</script>

<style>

  .notice-link{
    color: #999;
    text-decoration:none;
  }
</style>
