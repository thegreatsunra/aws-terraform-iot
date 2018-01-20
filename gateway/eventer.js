const EventEmitter = require('events')

const utils = require('./utils')
const random = require('./random')

class Eventer extends EventEmitter {}

const eventer = new Eventer()

eventer.send = (event) => {
  const id = random.createString(16)
  const at = utils.createTimestamp()
  const output = {
    id,
    at,
    ...event
  }
  eventer.emit('event', output)
}

module.exports = eventer
