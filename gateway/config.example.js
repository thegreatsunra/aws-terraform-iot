const path = require('path')

const config = {
  aws: {
    iot: {
      keyPath: path.join(__dirname, './cert/private.pem.key'),
      certPath: path.join(__dirname, './cert/certificate.pem.crt'),
      caPath: path.join(__dirname, './cert/root-CA.pem'),
      host: 'xxxxxxxxxxxxx.iot.xx-xxxx-x.amazonaws.com',
      topic: 'events'
    }
  }
}

module.exports = config
