process.env.NODE_ENV = 'testing'
const server = require('../../../build/dev-server.js')
const spawn = require('cross-spawn')
const opts = process.argv.slice(2)

server.ready.then(() => {
  const runner = spawn('./node_modules/.bin/testcafe', opts, { stdio: 'inherit' })
  runner.on('exit', (code) => {
    server.close()
    process.exit(code)
  })

  runner.on('error', (err) => {
    server.close()
    throw err
  })
})
