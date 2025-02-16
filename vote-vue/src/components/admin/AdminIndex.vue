<template>

  <el-container>
    <el-header id="header-box">
      <top-header></top-header>
    </el-header>
    <el-container>
      <el-aside id="left-menu-list-box" width="200px">
        <admin-menu></admin-menu>
      </el-aside>
      <el-main>
        <router-view/>
      </el-main>
    </el-container>
  </el-container>

</template>

<script>
  import AdminMenu from './AdminMenu'
  import TopHeader from "./TopHeader";

  export default {
    name: 'AdminIndex',
    components: {TopHeader, AdminMenu},
    data () {
      return {
        dialogVisible: false
      }
    },
    //动态设置侧边栏高度
    mounted() {
      let leftMenuBox = document.getElementById('left-menu-list-box');
      let headerBox = document.getElementById('header-box');
      let dy = window.innerHeight - headerBox.offsetHeight;
      if( leftMenuBox && headerBox){
        leftMenuBox.style.height = dy + 'px';
      }
    }
  }
</script>

<style scoped>

  #left-menu-list-box .el-menu{
    border-right: none;
  }

  .el-header{
    line-height: 46px;
    height: 46px !important;
    border-bottom: 1px solid #e6e6e6;
  }
  .el-aside{
    border-right: solid 1px #e6e6e6;
    line-height: 200px;
  }
</style>
