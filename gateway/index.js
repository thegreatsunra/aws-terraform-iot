// node_modules
const awsIotDeviceSdk = require('aws-iot-device-sdk').device
const config = require('./config')
const eventer = require('./eventer')
const fake = require('./fake')

let awsIotDevice

const initAWSIoT = async () => {
  try {
    awsIotDevice = awsIotDeviceSdk({
      keyPath: config.aws.iot.keyPath,
      certPath: config.aws.iot.certPath,
      caPath: config.aws.iot.caPath,
      host: config.aws.iot.host
    })

    // Log AWS IoT events
    awsIotDevice.on('connect', () => {
      eventer.send({
        type: 'awsiot_connected',
        text: 'Connected to AWS IoT integration'
      })
    })
    awsIotDevice.on('close', () => {
      eventer.send({
        type: 'awsiot_closed',
        text: 'Disconnected from AWS IoT integration'
      })
    })
    awsIotDevice.on('reconnect', () => {
      eventer.send({
        type: 'awsiot_reconnected',
        text: 'Reconnected to AWS IoT integration'
      })
    })
    awsIotDevice.on('offline', () => {
      eventer.send({
        type: 'awsiot_offline',
        text: 'AWS IoT integration is offline'
      })
    })
    awsIotDevice.on('error', (err) => {
      eventer.send({
        type: 'awsiot_error',
        text: 'Error received from AWS IoT integration',
        payload: {
          error: err
        }
      })
    })
  } catch (err) {
    console.log(err)
  }
}

const initEventer = () => {
  eventer.on('event', (event) => {
    console.log(JSON.stringify(event, null, '  '))
    if (event.type === 'data') {
      const parsedEvent = {
        at: event.at,
        id: event.id,
        ...event.payload.data
      }
      awsIotDevice.publish(config.aws.iot.topic, JSON.stringify(parsedEvent))
    }
  })
}

const emitFakeEvent = () => {
  eventer.send({
    type: 'data',
    text: 'Generated test data',
    payload: {
      data: fake.createData()
    }
  })
}

initAWSIoT()
initEventer()
setInterval(() => {
  emitFakeEvent()
}, 2000)
