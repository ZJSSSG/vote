<template>
  <div>
    <el-row :gutter="20">
      <el-col :xs="20" :sm="18">
        <div class="grid-content bg-purple" style="margin-left: 20%" v-if="userName">
          <el-menu
            :default-active="'/index'"
            router
            mode="horizontal"
            background-color="white"
            style="min-width: 1300px">
            <el-menu-item v-for="(item,i) in navList" :key="i" :index="item.name">
              {{ item.navItem }}
            </el-menu-item>
          </el-menu>
        </div>
      </el-col>
      <el-col :xs="4" :sm="6">
        <div class="grid-content bg-purple" style="float: left"  v-if="userName">
          <el-dropdown style="float: right" class="dropdown-link">
        <span class="el-dropdown-link" >
       <img src="../../img/defaultImg.png" style="border-radius: 100%;width: 45px">
        <span>{{userName}}</span>
        </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item>账户信息</el-dropdown-item>
              <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
        <div v-else>
          <a href="Login"> <el-button>登录</el-button></a>
          <a href="Register"> <el-button>注册</el-button></a>
        </div>
      </el-col>
    </el-row>
    <el-row  v-if="username">
      <el-col :xl="4">&nbsp;</el-col>
      <el-col :sm="16"  :xs="24">

      </el-col>
    </el-row>
  </div>


</template>

<script>
  export default {
    name: "TopNav",
    data(){
      return{
        userName:this.$store.state.user.userName,
        activeIndex: 'listActivity',
        navList: [
          {name: '/index', navItem: '首页'},
          {name: '/listActivity', navItem: '投票管理'},
          {name: '/userProfile', navItem: '账户信息'},
        ],
      }
    },
    methods:{
      logout () {
        let _this = this
        this.$axios.get('/logout').then(resp => {
          if (resp.data.code === 200) {
            _this.$store.commit('logout')
            _this.$router.replace('/login')
        }
        })
      },
      handleSelect(key, keyPath) {
        console.log(key, keyPath);
      }

    }
  }
</script>

<style scoped>
  .dropdown-link{
    margin-right: 100px;
    margin-top: 10px;
  }
</style>
