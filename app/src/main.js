import axios from 'axios'
import Vue from 'vue'

import App from './App'
import cognitoAuth from './cognito'
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
  components: { App },
  cognitoAuth,
  router,
  store,
  template: '<App/>'
}).$mount('#app')
