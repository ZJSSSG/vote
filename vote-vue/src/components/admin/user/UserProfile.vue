<template>
  <div>
    <!--修改用户信息对话框-->
    <el-dialog
      title="修改用户信息"
      :visible.sync="dialogFormVisible">
      <el-form v-model="selectedUser" label-position="right"  label-width="120px" style="text-align: left" ref="dataForm">
        <el-form-item label="用户名" prop="userName">
          <label >{{selectedUser.userName}}</label>
        </el-form-item>
        <el-form-item label="邮箱"  prop="email">
          <el-input v-model="selectedUser.email" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="角色分配"  prop="roles

">
          <el-checkbox-group v-model="selectedRolesIds">
            <el-checkbox v-for="(role,i) in roles" :key="i" :label="role.id">{{role.nameZh}}</el-checkbox>
          </el-checkbox-group>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit(selectedUser)">确 定</el-button>
      </div>
    </el-dialog>


    <!--面包屑导航-->
    <el-row style="margin: 18px 0px 0px 18px ">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item>用户管理</el-breadcrumb-item>
        <el-breadcrumb-item>用户信息</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>

    <!-- 用户列表表格-->
    <el-card style="margin: 18px 2%;width: 95%">
      <el-table
        v-loading="loading"
        :data="users"
        stripe
        :default-sort = "{prop: 'id', order: 'ascending'}"
        style="width: 100%"
        :max-height="tableHeight">
        <el-table-column
          prop="id"
          label="id"
          sortable
          width="55">
        </el-table-column>
        <el-table-column
          prop="userName"
          label="用户名"
          width="200">
        </el-table-column>
        <el-table-column
          label="头像"
          fit>
          <template slot-scope="scope">
            <el-avatar size="medium" :src="scope.row.avatar"></el-avatar>
          </template>
        </el-table-column>
        <el-table-column
          prop="email"
          label="邮箱"
          width="180">
        </el-table-column>
        <el-table-column
          label="状态"
          width="100">
          <template slot-scope="scope">
            <el-switch
              v-model="scope.row.state"
              active-color="#13ce66"
              inactive-color="#ff4949"
              @change="(value) => commitStatusChange(value, scope.row)">
            </el-switch>
          </template>
        </el-table-column>

        <el-table-column
          label="操作"
          width="200">
          <template slot-scope="scope">
            <el-button type="primary" size="small" @click="editUser(scope.row)">编辑</el-button>
            <el-button type="warning" size="small" @click="resetPassword(scope.row.id)">重置密码</el-button>
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
    </el-card>
  </div>
</template>

<script>
  export default {
    name: 'UserFile',
    data () {
      return {
        loading: false,
        currentPage:1,
        pageSize:6,
        totalSize:0,
        users: [],
        roles: [],
        dialogFormVisible: false,
        selectedUser: [],
        selectedRolesIds: []
      }
    },
    mounted () {
      this.listRoles()
      this.listUsers()
    },
    computed: {
      tableHeight () {
        return window.innerHeight - 320
      }
    },
    methods: {
      listUsers () {
        let _this = this;
        _this.loading = true;
        this.$axios.get('/admin/user/list?page='+_this.currentPage+'&size='+_this.pageSize).then(resp => {
          if (resp && resp.data.code === 200) {
            _this.users = resp.data.result.content
            _this.totalSize = resp.data.result.totalElements
            _this.loading = false
          }
        })
      },
      listRoles () {
        console.log('list roles ... ')
        let _this = this
        this.$axios.get('/admin/role').then(resp => {
          if (resp && resp.data.code === 200) {
            _this.roles = resp.data.result
            console.log('roles === > ',_this.roles)
          }
        })
      },
      commitStatusChange (value, user) {
        if (user.userName !== 'admin') {
          this.$axios.put('/admin/user/state/'+user.id+'?state='+value).then(resp => {
            if (resp && resp.data.code === 200) {
              if (value) {
                this.$message('用户 [' + user.userName + '] 已启用')
              } else {
                this.$message('用户 [' + user.userName + '] 已禁用')
              }
            }
          })
        } else {
          user.state = true
          this.$alert('不能禁用管理员账户')
        }
      },
      onSubmit (user) {
        let _this = this
        if(user.userName === 'admin'){
          this.$message.error("不可修改系统管理员的信息");
          return;
        }
        //判断信息
        if(user.email === ''){
          this.$message.error("邮箱不能为空");
          return;
        }
        let reg = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/
        if (!reg.test(user.email)) {
          this.$message.error("邮箱格式不正确");
          return;
        }
        // 根据视图绑定的角色 id 向后端传送角色信息
        let roles = []
        for (let i = 0; i < _this.selectedRolesIds.length; i++) {
          for (let j = 0; j < _this.roles.length; j++) {
            if (_this.selectedRolesIds[i] === _this.roles[j].id) {
              roles.push(_this.roles[j])
            }
          }
        }
        this.$axios.put('/admin/user/'+user.id, {
          id:user.id,
          userName: user.userName,
          email: user.email,
          roles: roles
        }).then(resp => {
          if (resp && resp.data.code === 200) {
            this.$message.success("用户信息修改成功");
            this.dialogFormVisible = false
            // 修改角色后重新请求用户信息，实现视图更新
            this.listUsers()
          }
        })
      },
      editUser (user) {
        this.dialogFormVisible = true
        this.selectedUser = user
        let roleIds = []
        for (let i = 0; i < user.roles.length; i++) {
          roleIds.push(user.roles[i].id)
        }
        this.selectedRolesIds = roleIds
      },
      resetPassword (id) {
        this.$axios.put('/admin/user/repassword/'+id).then(resp => {
          if (resp && resp.data.code === 200) {
            this.$alert('密码已重置为 123')
          }
        })
      },
      handleCurrentChange(currentPage) {
        this.currentPage = currentPage
        this.listUsers()
      },
    }
  }
</script>

<style scoped>

</style>
