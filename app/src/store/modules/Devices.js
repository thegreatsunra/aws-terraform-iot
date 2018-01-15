import cognitoAuth from '../../cognito'
import config from '@/config'
import { merge } from 'lodash'
import Vue from 'vue'

const state = []

const mutations = {
  ADD_DEVICE (state, payload) {
    state.push({
      at: payload.at,
      eventId: payload.eventId,
      id: payload.id,
      lat: payload.lat,
      lng: payload.lng,
      name: payload.name
    })
  },
  UPDATE_DEVICE (state, payload) {
    merge(state.find(({ id }) => id === payload.id), {
      at: payload.at,
      eventId: payload.eventId,
      id: payload.id,
      lat: payload.lat,
      lng: payload.lng,
      name: payload.name
    })
  },
  DESTROY_DEVICES (state) {
    // We use splice because vue cannot react to .length = 0 and array = [] changes
    state.splice(0)
  }
}

const actions = {
  destroyDevices: async ({ commit }) => {
    console.log('destroying devices')
    try {
      await commit('DESTROY_DEVICES')
    } catch (err) {
      console.log('error destroying devices', err)
    }
  },
  pullDevice: async ({ commit, dispatch }, id) => {
    cognitoAuth.getIdToken(async (err, token) => {
      if (err || !token || !navigator.onLine) {
        console.log(err)
        return false
      } else {
        try {
          const options = {
            headers: {
              'Authorization': token
            }
          }
          const response = await Vue.http.get(`${config.aws.apiGateway.endpoint}/devices.info?id=${id}`, options)
          console.log('pullDevice response:', response)
          if (response.data.item) dispatch('handlePulledDevice', response.data.item)
        } catch (err) {
          console.log('error getting device from API', err)
        }
      }
    })
  },
  pullDevices: async ({ commit, dispatch }) => {
    cognitoAuth.getIdToken(async (err, token) => {
      if (err || !token || !navigator.onLine) {
        console.log(err)
        return false
      } else {
        try {
          const options = {
            headers: {
              'Authorization': token
            }
          }
          const response = await Vue.http.get(`${config.aws.apiGateway.endpoint}/devices.list`, options)
          console.log('response', response)
          response.data.items.forEach((item) => {
            dispatch('handlePulledDevice', item)
          })
        } catch (err) {
          console.log('error getting devices from API', err)
        }
      }
    })
  },
  updateDevice: async ({ commit, dispatch }, payload) => {
    try {
      console.log('updating existing device')
      await commit('UPDATE_DEVICE', payload)
      dispatch('pushDevice', payload)
    } catch (err) {
      console.log('error updating device', err)
    }
  },
  addDevice: async ({ commit, dispatch }, payload) => {
    try {
      console.log('adding new device')
      await commit('ADD_DEVICE', payload)
      dispatch('pushDevice', payload)
    } catch (err) {
      console.log('error adding device', err)
    }
  },
  pushDevice: async ({ commit }, payload) => {
    cognitoAuth.getIdToken(async (err, token) => {
      if (err || !token || !navigator.onLine) {
        console.log(err)
        return false
      } else {
        try {
          console.log('pushing device update to db')
          const options = {
            headers: {
              'Authorization': token
            }
          }
          await Vue.http.post(`${config.aws.apiGateway.endpoint}/devices.update`, payload, options)
        } catch (err) {
          console.log('error pushing device update to db', err)
        }
      }
    })
  },
  handlePulledDevice: async ({ state, commit }, payload) => {
    try {
      if (payload.id && state.find(({ id }) => id === payload.id)) {
        await commit('UPDATE_DEVICE', payload)
      } else {
        await commit('ADD_DEVICE', payload)
      }
    } catch (err) {
      console.log('error updating device', err)
    }
  }
}

const getters = {
}

export default {
  actions,
  getters,
  mutations,
  state
}
