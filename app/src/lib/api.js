import cognitoAuth from '../cognito'
import config from '../config'
import Vue from 'vue'

const api = {
  hit: async (options) => {
    return new Promise(async (resolve, reject) => {
      await cognitoAuth.getIdToken(async (err, token) => {
        if (err || !token || !navigator.onLine || !options.route) {
          console.log('error', err)
          reject(err)
        } else {
          const requestOptions = {
            headers: {
              'Authorization': token
            }
          }
          if (!options.params) options.params = ''
          if (!options.route) options.route = ''
          if (!options.method) options.method = 'GET'
          const endpoint = `${config.aws.apiGateway.endpoint}/${options.route}${options.params}`
          if (options.method === 'GET') {
            console.log('getting from API')
            try {
              const response = await Vue.http.get(endpoint, requestOptions)
              console.log('successfully getted from API')
              resolve(response)
            } catch (err) {
              console.log('error getting from API', err)
              reject(err)
            }
          } else if (options.method === 'POST' && options.payload) {
            console.log('posting to API')
            try {
              await Vue.http.post(endpoint, options.payload, requestOptions)
              console.log('successfully posted to API')
              resolve()
            } catch (err) {
              console.log('error pushing to API', err)
              reject(err)
            }
          } else {
            console.log('error hitting API')
            reject(err)
          }
        }
      })
    })
  }
}

export { api as default }
