console.log('Loading function')
const AWS = require('aws-sdk')
const dynamo = new AWS.DynamoDB.DocumentClient()
const table = 'devices'

exports.handler = (data, context) => {
  const params = {
    TableName: table,
    IndexName: 'id-index',
    KeyConditionExpression: 'id = :id',
    ExpressionAttributeValues: {
      ':id': data.id
    }
  }

  dynamo.query(params, (err, data) => {
     if (err) {
       console.log(err)
       context.fail()
     } else {
       console.log(data)
       context.succeed(data.Items[0])
      }
  })
}
