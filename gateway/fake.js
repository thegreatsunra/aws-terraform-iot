const random = require('./random')

const fake = {
  devices: [
    'ptuudlga',
    'ouaurksl',
    'ttzccikk',
    'didebjal',
    'wydjgfqr',
    'zpfjecet',
    'lndbbrwb',
    'gxcyuaau'
  ],
  createData () {
    const deviceId = fake.devices[random.createInteger(0, 7)]
    const location = random.createLocation()
    const data = {
      deviceId,
      lat: location.lat,
      lng: location.lng
    }
    return data
  }
}

module.exports = fake
