// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from  './store'
import './filter'// 加载过滤器
// 设置反向代理，前端请求默认发送到 http://localhost:8443/api
var axios = require('axios')
axios.defaults.baseURL = 'http://localhost:8443/api'
// 全局注册，之后可在其他组件中通过 this.$axios 发送数据
Vue.prototype.$axios = axios
Vue.config.productionTip = false
axios.defaults.withCredentials = true

import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
Vue.use(ElementUI)

import VueQuillEditor from 'vue-quill-editor'
// require styles
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'

import QRCode from 'qrcodejs2'
Vue.use(VueQuillEditor)


router.beforeEach((to, from, next) => {
    if (store.state.user.userName && to.path.startsWith('/admin')) {
      initAdminMenu(router, store)
    }
    // if(store.state.user.userName && this.$route.path === '/admin'){
    //   this.router.redirect('/admin/vote/list')
    // }
    // 已登录状态下访问 login 页面直接跳转到后台首页
    if (store.state.userName && to.path.startsWith('/login')) {
      next({
        path: 'admin/vote'
      })
    }
    if (to.meta.requireAuth) {
      if (store.state.user) {
        axios.get('/authentication').then(resp => {
          if (resp) next()
        })
      } else {
        next({
          path: 'login',
          query: {redirect: to.fullPath}
        })
      }
    } else {
      next()
    }
  }
)

const initAdminMenu = (router, store) => {
  if (store.state.adminMenus.length > 0) {
    return;
  }
  axios.get('/menu').then(resp => {
    if (resp && resp.status === 200) {
      var fmtRoutes = formatRoutes(resp.data.result)
      router.addRoutes(fmtRoutes)
      store.commit('initAdminMenu', fmtRoutes)
    }
  })
}

const formatRoutes = (routes) => {
  let fmtRoutes = []
  routes.forEach(route => {
    if (route.children) {
      route.children = formatRoutes(route.children)
    }

    let fmtRoute = {
      path: route.path,
      component: resolve => {
        require(['./components/admin/' + route.component + '.vue'], resolve)
      },
      name: route.name,
      nameZh: route.nameZh,
      iconCls: route.iconCls,
      meta: {
        requireAuth: true
      },
      children: route.children
    }
    fmtRoutes.push(fmtRoute)
  })
  return fmtRoutes
}

Vue.prototype.setDialogWidth = function () {
    let val = document.body.clientWidth
    console.log('val===>',val)
    const def = 800 // 默认宽度
    if (val < def) {
      this.dialogWidth = '100%'
    } else {
      this.dialogWidth = '30%'
    }
}


/* eslint-disable no-new */
new Vue({
  el: '#app',
  render: h => h(App),
  router,
  store,
  components: { App },
  template: '<App/>'
})
