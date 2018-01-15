import Router from 'vue-router'
import Vue from 'vue'

import cognitoAuth from '@/cognito'

import Home from '@/components/views/Home'

import ChangePassword from '@/components/views/Auth/ChangePassword'
import ConfirmPasswordReset from '@/components/views/Auth/ConfirmPasswordReset'
import CreateAccount from '@/components/views/Auth/CreateAccount'
import Login from '@/components/views/Auth/Login'
import RequestPasswordReset from '@/components/views/Auth/RequestPasswordReset'
import VerifyEmailAddress from '@/components/views/Auth/VerifyEmailAddress'

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
      path: '/account/change-password',
      component: ChangePassword,
      beforeEnter: requireAuth
    },
    {
      path: '/account/confirm-password-reset',
      component: ConfirmPasswordReset
    },
    {
      path: '/account/create-account',
      component: CreateAccount
    },
    {
      path: '/account/request-password-reset',
      component: RequestPasswordReset
    },
    {
      path: '/account/verify-email-address',
      component: VerifyEmailAddress
    },
    {
      path: '/home',
      component: Home,
      beforeEnter: requireAuth
    },
    {
      path: '/login',
      component: Login
    },
    {
      path: '/logout',
      beforeEnter (to, from, next) {
        cognitoAuth.signout()
        next('/login')
      }
    },
    {
      path: '*',
      redirect: '/home'
    }
  ]
})
