console.log('Loading function')
const AWS = require('aws-sdk')
const dynamo = new AWS.DynamoDB.DocumentClient()
const table = 'events'
const index = 'deviceId-index'

exports.handler = (data, context) => {
  console.log('data:', data)
  // request contained a deviceId param, so return all events for that device
  if (data.deviceId) {
    const params = {
      TableName: table,
      IndexName: index,
      KeyConditionExpression: 'deviceId = :deviceId',
      ExpressionAttributeValues: {
        ':deviceId': data.deviceId
      }
    }
    dynamo.query(params, (err, results) => {
      if (err) console.log(err)
      else {
        results.Items.sort(sortByAt)
        context.succeed(results.Items)
      }
    })
  } else {
    const params = {
      TableName: table
    }
    dynamo.scan(params, (err, results) => {
      if (err) console.log(err)
      else {
        // sort items by at
        results.Items.sort(sortByAt)
        // return only the 200 most recent items
        results.Items = results.Items.slice(0, 200)
        context.succeed(results.Items)
      }
    })
  }
}

function sortByAt (a, b) {
  const atA = a.at.toUpperCase()
  const atB = b.at.toUpperCase()
  if (atA > atB) {
    return -1
  }
  if (atA < atB) {
    return 1
  }
  // ats must be equal
  return 0
}
