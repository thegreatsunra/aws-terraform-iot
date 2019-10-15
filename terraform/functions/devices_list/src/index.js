console.log('Loading function')
const AWS = require('aws-sdk')
const dynamo = new AWS.DynamoDB.DocumentClient()
const table = 'devices'

exports.handler = (data, context) => {
  const params = {
    TableName: table
  }

  dynamo.scan(params, (err, data) => {
    if (err) console.log(err)
    else {
      console.log(data.Items)
      context.succeed(data.Items)
    }
  })
}
