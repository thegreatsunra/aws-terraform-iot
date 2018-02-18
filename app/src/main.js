// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import App from './App'
import axios from 'axios'
import cognitoAuth from './cognito'
import Vue from 'vue'

import router from './router'
import store from './store'

Vue.http = Vue.prototype.$http = axios
Vue.config.productionTip = false

router.beforeEach((to, from, next) => {
  window.scrollTo(0, 0)
  next()
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  components: { App },
  cognitoAuth,
  router,
  store,
  template: '<App/>'
})
