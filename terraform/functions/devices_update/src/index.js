console.log('Loading function')
const AWS = require('aws-sdk')
const dynamo = new AWS.DynamoDB.DocumentClient({
  convertEmptyValues: true
})
const table = 'devices'

exports.handler = (data, context) => {
  const params = {
    TableName: table,
    Key : {
      id : data.id
    },
    UpdateExpression: "set #name = :name",
    ExpressionAttributeNames: {
      "#name": "name"
    },
    ExpressionAttributeValues: {
      ':name' : data.name
    },
    ReturnValues: 'UPDATED_NEW'
  }

  dynamo.update(params, (err, data) => {
     if (err) console.log(err)
     else console.log(data)
  })
}
