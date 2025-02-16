<template>

  <div class="setItemsDiv">
    <el-row>
      <el-col :sm="1"  :xl="2">&nbsp;</el-col>
      <el-col :sm="20"  :xs="24">
        <el-card>
          <div>
            <div style="float: left">
              公告管理
            </div>
            <div style="float: right">
              <el-button type="primary" @click="toCreate">创建公告</el-button>
            </div>
          </div>
          <div style="text-align: left">
            <el-table
              v-loading="loading"
              :data="notices"
              stripe
              :default-sort = "{prop: 'id', order: 'ascending'}"
              style="width: 100%"
              ref="multipleTable"
              show-overflow-tooltip>
              <el-table-column
                prop="title"
                label="标题"
                fit>
              </el-table-column>
              <el-table-column
                label="创建时间"
                fit>
                <template slot-scope="scope">
                  <div style="color: #999;">{{scope.row.createTime | fmtDate}}</div>
                </template>
              </el-table-column>
              <el-table-column
                label="操作"
                width="200">
                <template slot-scope="scope">
                  <el-button size="mini" type="primary"  @click="showNotice(scope.row.id)">查看</el-button>
                  <el-button size="mini" type="danger"  @click="deleteNotice(scope.row)">删除</el-button>
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
    name: 'NoticeManagement',
    data(){
      return{
        loading: false,
        dialogWidth:'500px',
        currentPage:1,
        pageSize:6,
        totalSize:0,
        notices:[],
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
      this.listNotice()

    },
    methods:{
      listNotice(){
        let _this = this
        this.loading = true
        this.$axios.get('/notice/list?page='+_this.currentPage
          +'&size='+_this.pageSize
          +'&userName='+ _this.$store.state.user.userName)
          .then(resp =>{
            if(resp && resp.data.code === 200){
              _this.notices = resp.data.result.content
              _this.totalSize = resp.data.result.totalElements
              _this.loading = false
            }
          })
      },
      toCreate(){
        this.$store.state.curCreateActivity = []
        this.$router.replace('/admin/content/add/notice')
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
      showNotice(id){
        this.$router.push('/notice/detail/'+id)
      },
      deleteNotice(notice){
        this.$confirm('确定删除此公告?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$axios.delete('/admin/notice/'+notice.id).then(resp =>{
            if(resp && resp.data.code === 200){
              this.$message.success("删除成功")
              this.listNotice()
            }else {
              let message = resp.data.message
              this.$message.error("删除成功")
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
