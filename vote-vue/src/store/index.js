import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: {
      userName: window.localStorage.getItem('user' || '[]') == null ? '' : JSON.parse(window.localStorage.getItem('user' || '[]')).userName,
      password: window.localStorage.getItem('user' || '[]') == null ? '' : JSON.parse(window.localStorage.getItem('user' || '[]')).password,
      avatar: window.localStorage.getItem('user' || '[]') == null ? '' : JSON.parse(window.localStorage.getItem('user' || '[]')).avatar,
    },
    curCreateActivity:{
    },
    adminMenus: [],
    dialogWidth:'100%'
  },
  mutations: {
    login (state, user) {
      state.user = user
      console.log(JSON.stringify(user))
      window.localStorage.setItem('user', JSON.stringify(user))
    },
    logout(state){
      state.user = []
      window.localStorage.removeItem('user')
    },
    createActive(state,data){
       state.curCreateActivity = data
       window.localStorage.setItem('curCreateActivity', JSON.stringify(data))
    },
    initAdminMenu (state, menus) {
      state.adminMenus = menus
    }
  }
})
