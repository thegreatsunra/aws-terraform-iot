import cognitoAuth from '../../cognito'
import config from '@/config'
import { merge } from 'lodash'
import Vue from 'vue'

const state = []

const mutations = {
  ADD_EVENT (state, payload) {
    state.push({
      at: payload.at,
      deviceId: payload.deviceId,
      id: payload.id,
      lat: payload.lat,
      lng: payload.lng
    })
  },
  UPDATE_EVENT (state, payload) {
    merge(state.find(({ id }) => id === payload.id), {
      at: payload.at,
      deviceId: payload.deviceId,
      id: payload.id,
      lat: payload.lat,
      lng: payload.lng
    })
  },
  DESTROY_EVENTS (state) {
    // We use splice because vue cannot react to .length = 0 and array = [] changes
    state.splice(0)
  }
}

const actions = {
  destroyEvents: async ({ commit }) => {
    console.log('destroying events')
    try {
      await commit('DESTROY_EVENTS')
    } catch (err) {
      console.log('error destroying events', err)
    }
  },
  pullEvent: async ({ commit, dispatch }, id) => {
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
          const response = await Vue.http.get(`${config.aws.apiGateway.endpoint}/events.info?id=${id}`, options)
          console.log('pullEvent response:', response)
          if (response.data.item) dispatch('handlePulledEvent', response.data.item)
        } catch (err) {
          console.log('error getting event from API', err)
        }
      }
    })
  },
  pullEvents: async ({ commit, dispatch }) => {
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
          const response = await Vue.http.get(`${config.aws.apiGateway.endpoint}/events.list`, options)
          console.log('response', response)
          response.data.items.forEach((item) => {
            dispatch('handlePulledEvent', item)
          })
        } catch (err) {
          console.log('error getting events from API', err)
        }
      }
    })
  },
  updateEvent: async ({ commit, dispatch }, payload) => {
    try {
      console.log('updating existing event')
      await commit('UPDATE_EVENT', payload)
      dispatch('pushEvent', payload)
    } catch (err) {
      console.log('error updating event', err)
    }
  },
  addEvent: async ({ commit, dispatch }, payload) => {
    try {
      console.log('adding new event')
      await commit('ADD_EVENT', payload)
      dispatch('pushEvent', payload)
    } catch (err) {
      console.log('error adding event', err)
    }
  },
  handlePulledEvent: async ({ state, commit }, payload) => {
    try {
      if (payload.id && state.find(({ id }) => id === payload.id)) {
        await commit('UPDATE_EVENT', payload)
      } else {
        await commit('ADD_EVENT', payload)
      }
    } catch (err) {
      console.log('error updating event', err)
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
