<template>
  <el-row :gutter="22">
    <el-col :sm="2" :xl="4">&nbsp;</el-col>
    <el-col :sm="4" :xs="22" >
      <div class="createItem" v-bind:class="{ active: isCreate }" >
        <!--        <router-link 　:to="{ path: '/voteItem' }">跳转</router-link>-->
        <h4>1.基本信息</h4>
        <div class="createItemDesc" @click="voteCreatePath">
          <span>标题、时间、描述</span>
        </div>
      </div>
    </el-col>
    <el-col  :sm="4" :xs="22" :offset="2">
      <div class="createItem"  @click="voteItemPath"  v-bind:class="{ active: isVoteItem }" >
        <h4>2.选手管理</h4>
        <div class="createItemDesc">
          <span>管理投票选手</span>
        </div>
      </div>
    </el-col>
    <el-col  :sm="4" :xs="22" :offset="2">
      <div class="createItem" @click="voteEditPath"  v-bind:class="{ active: isVoteEdit}" >
        <h4>3.自定义配置</h4>
        <div class="createItemDesc">
          <span>投票类型设置</span>
        </div>
      </div>
    </el-col>
  </el-row>
</template>

<script>
  export default {
    name: "CreateNav",
    data(){
      return{
        curPath:'',
        isCreate:false,
        isVoteItem:false,
        isVoteEdit:false,
      }
    },
    mounted(){
      this.handleBackground()
    },
    computed: {
      // setter
      set: function () {
        this.curPath = this.$route.path
      }
    },
    methods:{

      voteCreatePath(){
        if(this.$store.state.curCreateActivity.id) {
          this.$router.push({path:'/admin/vote/add/index'})
        }
        this.$router.push({path:'/admin/vote/add/index'})
      },
      voteItemPath(){
        if(this.$store.state.curCreateActivity.id) {
          this.$router.push({path: '/admin/vote/add/item'})
        }
      },
      voteEditPath(){
        if(this.$store.state.curCreateActivity.id) {
          this.$router.push({path:'/admin/vote/add/setting'})
        }
      },
      handleBackground(){
        if(this.$route.path === '/admin/vote/add' || this.$route.path === '/admin/vote/add/index' ){
          this.isCreate = true
        }else {
          this.isCreate = false
        }
        if(this.$route.path === '/admin/vote/add/item' ){
          this.isVoteItem = true
        }else {
          this.isVoteItem = false
        }
        if(this.$route.path === '/admin/vote/add/setting' ){
          this.isVoteEdit = true
        }else {
          this.isVoteEdit = false
        }
      }
    }
  }
</script>

<style scoped>
  .createItem{
    margin: 0px auto 40px auto;
    text-align: center;
    border: 1px solid #eaeaea;
    border-radius: 8px;
    box-shadow: 0 0 25px #cac6c6;
  }
  .createItem:hover{
    background-color: #36aaff;
    color: white;
  }
  .createItemDesc{
    padding: 0px 0px 10px 0px;
  }

  .active{
    background-color: #36aaff;color: white
  }

</style>
