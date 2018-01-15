import Vue from 'vue'
import Vuex from 'vuex'
// import VuexPersistedState from 'vuex-persistedstate'

import modules from './modules'

Vue.use(Vuex)

export default new Vuex.Store({
  modules,
  // plugins: [VuexPersistedState()],
  strict: process.env.NODE_ENV !== 'production'
})
