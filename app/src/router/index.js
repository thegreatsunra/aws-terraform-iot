import Router from 'vue-router'
import Vue from 'vue'

import cognitoAuth from '@/cognito'

import Home from '@/components/views/Home'
Vue.use(Router)

function requireAuth (to, from, next) {
  cognitoAuth.isAuthenticated((err, loggedIn) => {
    if (err) return next()
    if (!loggedIn) {
      next({
        path: '/login',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
  })
}

export default new Router({
  routes: [
    {
      path: '/home',
      component: Home,
      beforeEnter: requireAuth
    },
    },
    {
      path: '*',
      redirect: '/home'
    }
  ]
})
