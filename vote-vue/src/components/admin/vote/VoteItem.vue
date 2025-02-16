<template>
  <div class="setItemsDiv">

    <EditDesc  @onSubmit="listItem" ref="editDescDialog"></EditDesc>

    <el-dialog
      title="图片地址"
      :visible.sync="dialogFormVisible"
      :modal-append-to-body="false"
      @close="clear"
      width="30%">
      <el-input v-model="imageLink"></el-input>
      <div style="margin-top: 20px">
        <el-button type="primary" size="small" @click="submitImgLink">确定</el-button>
        <el-button size="small" @click="clear">取消</el-button>
      </div>
    </el-dialog>


    <CreateNav></CreateNav>
    <el-row>
      <el-col :sm="2"  :xl="4">&nbsp;</el-col>
      <el-col :sm="16"  :xs="24">
        <el-card>
          <div style="text-align: left">
            <el-button type="primary" @click="saveCandidate">添加选手</el-button>
            <el-button @click="toggleSelection()">取消选择</el-button>
            <el-button  @click="multipleRemove()">批量删除</el-button>
            <el-table
              v-loading="loading"
              :data="voteItems"
              stripe
              :default-sort = "{prop: 'id', order: 'ascending'}"
              style="width: 100%"
              ref="multipleTable"
              @selection-change="handleSelectionChange"
            >
              <el-table-column
                type="selection"
                width="55">
              </el-table-column>
              <el-table-column
                prop="coverUrl"
                label="封面"
                fit>
                <template slot-scope="scope">
                  <img  :src="scope.row.coverUrl" alt=""  :onerror="errorImg01" style="width: 60px;height: 60px">
                </template>
              </el-table-column>
              <el-table-column
                prop="num"
                label="编号"
                sortable
                fit>
                <template slot-scope="scope">
                  <el-input  v-model="scope.row.num" placeholder="编号" style="width: 80%" @change="updateCandidate(scope.row)"></el-input>
                </template>
              </el-table-column>
              <el-table-column
                label="标题"
                fit>
                <template slot-scope="scope">
                  <el-input  v-model="scope.row.title" placeholder="标题" @change="updateCandidate(scope.row)"></el-input>
                </template>
              </el-table-column>
              <el-table-column
                label="操作"
                width="380px">
                <template slot-scope="scope">
                  <el-button
                    plain
                    size="small"
                    @click="editItemDesc(scope.row)">
                    修改描述<i class="el-icon-edit  el-icon--right"></i>
                  </el-button>
                  <el-dropdown trigger="click" >
                    <span class="el-dropdown-link">
                      <el-button
                        plain
                        size="small">
                         修改封面<i class="el-icon-picture  el-icon-right"></i>
                      </el-button>
                    </span>
                    <el-dropdown-menu slot="dropdown">
                      <el-dropdown-item @click.native="inputImgLink(scope.row)">
                          图片链接
                      </el-dropdown-item>
                     <el-dropdown-item  @click.native="setCurCandidate(scope.row)">
                         <el-upload
                           ref="upload"
                           action="http://localhost:8443/api/admin/candidate/covers"
                           with-credentials
                           :show-file-list="false"
                           :on-success="handleSuccess"
                            >
                           <span>点击上传</span>
                         </el-upload>
                      </el-dropdown-item>
                    </el-dropdown-menu>
                  </el-dropdown>
<!--                  <el-dropdown >-->
<!--                    <span class="el-dropdown-link">-->
<!--                      <el-button-->
<!--                        plain-->
<!--                        size="small">-->
<!--                         上传视频<i class="el-icon-upload  el-icon-right"></i>-->
<!--                      </el-button>-->
<!--                    </span>-->
<!--                    <el-dropdown-menu slot="dropdown">-->
<!--                      <el-dropdown-item @click.native="inputImgLink">-->
<!--                        视频链接-->
<!--                      </el-dropdown-item>-->
<!--                      <el-dropdown-item>-->
<!--                          <img-upload @onUpload="uploadImg" ref="imgUpload"></img-upload>-->
<!--                      </el-dropdown-item>-->
<!--                    </el-dropdown-menu>-->
<!--                  </el-dropdown>-->
                    <el-button
                      type="danger" plain
                      size="small" @click="deleteItem(scope.row)" >
                      删除选项<i class="el-icon-delete el-icon--right"></i>
                    </el-button>
                </template>
              </el-table-column>
              <el-table-column
                label="状态"
                fit>
                <template slot-scope="scope">
                  <el-switch
                    v-model="scope.row.state"
                    active-color="#13ce66"
                    inactive-color="#ff4949"
                    @change="(value) => commitStatusChange(value, scope.row)">
                  </el-switch>
                </template>
              </el-table-column>
            </el-table>
          </div>
          <div style="float: left;padding: 20px">
            <el-pagination
              @current-change="handleCurrentChange"
              :current-page="currentPage"
              :page-size="pageSize"
              :total="totalSize">
            </el-pagination>
          </div>
          <div style="padding-top:  20px">
            <el-button  @click="comeBack"> 返  回 </el-button>
            <el-button type="primary" @click="nextStep">下一步</el-button>
          </div>
        </el-card>
      </el-col>

    </el-row>
  </div>
</template>

<script>
  import Qeditor from "../../common/Qeditor";
  import CreateNav from "./CreateNav";
  import EditDesc from "./EditDesc";
  // import ImgUpload from "./ImgUpload"; ImgUpload,
  export default {
    name: "VoteItem",
    components: {EditDesc, CreateNav, Qeditor},
    data(){
      return{
        loading:false,
        dialogFormVisible:false,
        currentPage:1,
        pageSize:5,
        totalSize:0,
        value1: '',
        value2: '',
        voteItems:[],
        num:0,
        testLink:'',
        imageLink:'',
        curItemId:0,
        curCandidate:{
          id:0,
          num:0,
          title:'新增的标题',
          subTitle:'',
          itemDesc:'',
          coverUrl:'',
          videoUrl:'',
          getVote:0,
          state:''
        },
        errorImg01: 'this.src="' + require('../../../img/defaultImg.png') + '"',
        multipleSelection:[],
        selectedCandidateIds:[],
        dialogWidth:'100%',
      }
    },
    mounted(){
      if (this.$route.query.id) {
        this.$store.state.curCreateActivity.id=this.$route.query.id
      }
      this.listItem()
    },
    methods:{
      handleSelectionChange(val){
         this.multipleSelection = val;
      },
      toggleSelection(rows) {
          if (rows) {
            rows.forEach(row => {
              this.$refs.multipleTable.toggleRowSelection(row);
            });
          } else {
            this.$refs.multipleTable.clearSelection();
          }
      },
      editItemDesc(item){
        this.$refs.editDescDialog.dialogFormVisible = true
        setTimeout(()=>{
          this.$refs.editDescDialog.content = item.itemDesc
          this.$refs.editDescDialog.voteItemId = item.id
          this.$refs.editDescDialog.num = item.num
          this.$refs.editDescDialog.coverUrl = item.coverUrl
          this.$refs.editDescDialog.videoUrl = item.videoUrl
          this.$refs.editDescDialog.title = item.title
          this.$refs.editDescDialog.state = item.state
          this.$refs.editDescDialog.handleBindContent()
        },10)
      },
      inputImgLink(item){
        this.dialogFormVisible = true
        this.curCandidate.id = item.id
        this.curCandidate.title = item.title
        this.curCandidate.num = item.num
        this.curCandidate.subTitle = item.subTitle
        this.curCandidate.itemDesc = item.itemDesc
        this.curCandidate.coverUrl = item.coverUrl
        this.curCandidate.videoUrl= item.videoUrl
        this.curCandidate.aid = item.aid
        this.curCandidate.state = item.state
        this.imageLink = item.coverUrl
      },
      setCurCandidate(item){
        this.curCandidate.id = item.id
        this.curCandidate.title = item.title
        this.curCandidate.num = item.num
        this.curCandidate.subTitle = item.subTitle
        this.curCandidate.itemDesc = item.itemDesc
        this.curCandidate.coverUrl = item.coverUrl
        this.curCandidate.videoUrl= item.videoUrl
        this.curCandidate.aid = item.aid
      },
      clear(){
        this.dialogFormVisible = false
        this.imageLink = ''
      },
      submitImgLink(){
        this.$axios.put('/admin/candidate/'+this.curCandidate.id,{
          title:this.curCandidate.title,
          num:this.curCandidate.num,
          subTitle:this.curCandidate.subTitle,
          itemDesc:this.curCandidate.itemDesc,
          coverUrl:this.imageLink,
          videoUrl:this.curCandidate.videoUrl,
          state:this.curCandidate.state,
          aid:this.curCandidate.aid
        }).then(resp =>{
          this.dialogFormVisible = false
          this.listItem()
        })
      },
      listItem(){
        let _this = this
        this.loading = true
        this.$axios.get('/admin/candidate/list/'+this.$store.state.curCreateActivity.id
          +'?page='+_this.currentPage+'&size='+_this.pageSize).then(resp =>{
          if(resp && resp.data.code === 200){
            this.totalSize = resp.data.result.totalElements
            this.voteItems = resp.data.result.content
            this.loading =  false
          }
        })
      },
      saveCandidate(){
        this.num = ++this.voteItems.length
        this.$axios.post('/admin/candidate',{
          num:this.num,
          coverUrl:'',
          title:'新增的标题',
          aid:this.$store.state.curCreateActivity.id
        }).then(resp =>{
            this.listItem()
        })
      },
      updateCandidate(item){
        this.$axios.put('/admin/candidate/'+item.id,{
          title: item.title,
          num:item.num,
          subTitle:item.subTitle,
          itemDesc:item.itemDesc,
          coverUrl:item.coverUrl,
          videoUrl:item.videoUrl,
          getVote:item.getVote,
          state:item.state,
          aid:item.aid
        }).then(resp =>{
          this.listItem()
        })
      },
      deleteItem(item){
        this.$confirm('确认删除选项?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
            this.$axios
              .delete('/admin/candidate/'+item.id).then(resp => {
              if (resp && resp.data.code === 200) {
                this.listItem()
                this.$message({
                  type: 'info',
                  message: '删除成功'
                })
              }
            })
          }
        ).catch(() => {
        })
      },
      commitStatusChange(value, item) {
          this.$axios.put('/admin/candidate/state/'+item.id+'?state='+value).then(resp => {
            if (resp && resp.data.code === 200) {
              if (value) {
                this.$message('候选人 [' + item.title + '] 已启用')
              } else {
                this.$message('候选人 [' + item.title + '] 已禁用')
              }
            }
          })
      },
      uploadImg(){
             this.testLink = this.$refs.imgUpload.url
             this.$refs.imgUpload.clear()
      },
      comeBack(){
        this.$router.replace('/admin/vote/add/index')
      },
      nextStep(){
        this.$router.replace('/admin/vote/add/setting')
      },

      handleSuccess (response) {
        this.imageLink = response
        this.submitImgLink()
        this.$message.warning('上传成功')
      },
      multipleRemove(){
        if(this.multipleSelection.length < 1){
          this.$message.error("请选择所要删除的选项")
          return
        }
        this.$confirm('确认删除选项?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'}).then(() =>{
            for(let i = 0; i<this.multipleSelection.length; i++){
              this.selectedCandidateIds += this.multipleSelection[i].id + ' '
            }
            this.$axios.delete('/admin/candidate/batch?selectedCandidateIds='+ this.selectedCandidateIds,{
            }).then(resp =>{
              if(resp.data.code === 200){
                this.$alert("删除成功")
                this.selectedCandidateIds=''
                this.listItem()
              }
            })
          })
      },
      handleCurrentChange(currentPage) {
        this.currentPage = currentPage
        this.listItem()
      },
    }
  }
</script>

<style scoped>
  .setItemsDiv{
    margin: 0px auto;
    height: 100%;
    width: 100%;

  }
</style>
