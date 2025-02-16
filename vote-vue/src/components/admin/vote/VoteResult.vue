<template>
  <div>
    <el-row>
      <el-col :sm="1"  :xl="2">&nbsp;</el-col>
      <el-col :sm="20"  :xs="24">
        <div style="margin: 20px">
          <el-breadcrumb separator="/">
            <el-breadcrumb-item :to="{ path: '/admin/vote/list' }">投票管理</el-breadcrumb-item>
            <el-breadcrumb-item >结果统计</el-breadcrumb-item>
          </el-breadcrumb>
        </div>
        <el-card>
          <div style="text-align: left">
            投票结果
           <a :href="'http://localhost:8443/api/download-result/'+this.$store.state.curCreateActivity.id">
             <el-button type="primary" size="mini" style="float: right;margin-bottom: 20px">导出为Excel</el-button>
           </a>
            <hr style= "border:1px dashed #999" />
            <el-table
              :data="voteItems"
              stripe
              :default-sort = "{prop: 'id', order: 'ascending'}"
              style="width: 100%"
              ref="multipleTable"
              >
              <el-table-column
                label="排名"
                fit
                type="index"
                :index="countIndex"
                width="100">
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
                prop="title"
                label="标题"
                fit>
              </el-table-column>
              <el-table-column
                label="占比"
                width="200">
                <template slot-scope="scope">
                  <el-progress :text-inside="true" :stroke-width="18" :percentage="parseInt((scope.row.voteCount/sumVotes)*100) > 0 ? parseInt((scope.row.voteCount/sumVotes)*100) : 0"></el-progress>
                </template>
              </el-table-column>
              <el-table-column
                prop="voteCount"
                label="得票"
                fit>
              </el-table-column>

            </el-table>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
  export default {
    name: "VoteResult",
    data(){
      return{
        sumVotes:0,
        voteItems:[],
        errorImg01: 'this.src="' + require('../../../img/defaultImg.png') + '"',
      }
    },
    mounted() {
      if (this.$route.query.id) {
        this.$store.state.curCreateActivity.id=this.$route.query.id
      }
      this.getTotal()
    },
    methods:{
      getTotal(){
        let _this = this
        this.$axios.get('/candidate/list/sequence/'+this.$store.state.curCreateActivity.id).then(resp =>{
          if(resp && resp.data.code === 200){
            _this.voteItems = resp.data.result
            _this.totalSize = resp.data.result.length
            _this.sumVotes = 0
            for(let i=0; i<_this.voteItems.length; i++){
              _this.sumVotes+=this.voteItems[i].voteCount
            }
          }
        })
      },
      countIndex(index){
        return index+1
      }
    },
  }
</script>

<style scoped>

</style>
