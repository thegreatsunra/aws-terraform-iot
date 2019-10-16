console.log('Loading AWS IoT Lambda function')
const AWS = require('aws-sdk')
const dynamo = new AWS.DynamoDB.DocumentClient({
  convertEmptyValues: true
})
const eventsTable = 'events'
const devicesTable = 'devices'

function createExpressions (event) {
  const expressions = {
    item: {},
    update: [],
    values: {},
    names: {}
  }

  Object.keys(event).forEach((key) => {
    if (event[key] === undefined || event[key] === null) {
      delete event[key]
    }
  })
  Object.keys(event).forEach((key) => {
    expressions.item[key] = event[key]
    if (key === 'id') {
      // if the key is the event id, assign it to eventId
      expressions.values[':eventId'] = event[key]
      expressions.names['#eventId'] = 'eventId'
      expressions.update.push('#eventId = :eventId')
    } else if (key !== 'deviceId') {
      // handle all keys, except id and deviceId, normally
      expressions.values[`:${key}`] = event[key]
      expressions.names[`#${key}`] = key
      expressions.update.push(`#${key} = :${key}`)
    }
  })
  expressions.update = `set ${expressions.update.join(', ')}`
  console.log('EXPRESSION:', expressions)
  return expressions
}

exports.handler = (event, context) => {
  console.log('Received event from AWS IoT:\n', JSON.stringify(event, null, 2))
  const expressions = createExpressions(event)
  const eventParams = {
    TableName: eventsTable,
    Item: expressions.item
  }
  console.log('Putting AWS IoT Event into DynamoDB:\n', eventParams)
  dynamo.put(eventParams, (err, data) => {
    if (err) {
      console.error('ERROR. Unable to put event in table:\n', JSON.stringify(err, null, 2))
      context.fail()
    } else {
      console.log('SUCCESS. Put event in table:\n', JSON.stringify(data, null, 2))
      context.succeed()
    }
  })

  if (expressions.item.deviceId) {
    const deviceParams = {
      TableName: devicesTable,
      Key: {
        id: expressions.item.deviceId
      },
      UpdateExpression: expressions.update,
      ExpressionAttributeValues: expressions.values,
      ExpressionAttributeNames: expressions.names,
      ReturnValues: 'UPDATED_NEW'
    }
    console.log('Adding or updating device in DynamoDB:\n', deviceParams)
    dynamo.update(deviceParams, (err, data) => {
      if (err) {
        console.error('ERROR. Unable to add/update device:\n', JSON.stringify(err, null, 2))
        context.fail()
      } else {
        console.log('SUCCESS. Added/updated device:\n', JSON.stringify(data, null, 2))
        context.succeed()
      }
    })
  }
}
