import Vue from 'vue'
import Router from 'vue-router'
import ActivityIndex from "../components/ActivityIndex";
import Home from "../components/Home";
import loginTab from "../login/index";
import forget from "../login/forget";
import AdminIndex from "../components/admin/AdminIndex";
import NoticeIndex from "../components/NoticeIndex";
import test from "../components/test";

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    // {
    //   path: '/admin',
    //   redirect: '/admin/vote/list'
    // },
    {
      path: '/home',
      name:'home',
      component: Home
    },
    {
      path: '/notice/detail/:id',
      name: 'noticeDetail',
      component: NoticeIndex
    },
    {
      path: '/',
      name: 'Home',
      component: Home,
      redirect: '/home'
    },
    {
      path:'/activityIndex/:id',
      name:'ActivityIndex',
      component:ActivityIndex
    },

    {
      path:'/login/forget',
      component:forget
    },
    {
      path:'/login',
      component:loginTab
    },
    {
      path: '/admin',
      component: AdminIndex
    },
    {
      path:'/test',
      component: test
    }

  ]
})
