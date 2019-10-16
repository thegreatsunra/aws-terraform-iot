const generate = require('nanoid/generate')

const random = {
  createInteger (min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
  },
  // create a random location in the minneapolis area
  createLocation () {
    const coords = {
      lat: {
        max: 45.145,
        min: 44.836
      },
      lng: {
        min: -93.481,
        max: -92.997
      }
    }
    const output = {}
    const lat = ((Math.floor(Math.random() * ((coords.lat.max * 1000000) - (coords.lat.min * 1000000) + 1) + (coords.lat.min * 1000000))) / 1000000)
    const lng = ((Math.floor(Math.random() * ((coords.lng.max * 1000000) - (coords.lng.min * 1000000) + 1) + (coords.lng.min * 1000000))) / 1000000)
    output.lat = lat
    output.lng = lng
    return output
  },
  createString (length, characters = 'all') {
    const lowercase = 'abcdefghijklmnopqrstuvwxyz'
    const numbers = '0123456789'
    const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

    let possible = uppercase + lowercase + numbers

    if (characters === 'lowercase') {
      possible = lowercase
    } else if (characters === 'uppercase') {
      possible = uppercase
    } else if (characters === 'numbers') {
      possible = numbers
    } else if (characters === 'lowercasenumbers') {
      possible = lowercase + numbers
    }

    return generate(possible, length)
  }
}

module.exports = random
