console.log('Loading function')

exports.handler = (event, context) => {
  // As an example Cognito trigger, arbitrarily limit
  // account creation to email addresses at @gmail.com
  const domain = '@gmail.com'
  console.log(JSON.stringify(event, null, 2))
  if (!event.request.userAttributes.email.endsWith(domain)) {
    const error = new Error('Email address validation failed')
    context.done(error, event)
  }
  context.done(null, event)
}
