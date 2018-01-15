import Router from 'vue-router'
import Vue from 'vue'

import Home from '@/components/views/Home'
Vue.use(Router)
export default new Router({
  routes: [
    {
      path: '/home',
      component: Home,
    },
    {
      path: '*',
      redirect: '/home'
    }
  ]
