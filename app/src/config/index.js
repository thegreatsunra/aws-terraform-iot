export default {
  aws: {
    apiGateway: {
      endpoint: `${process.env.API_GATEWAY_URI}/${process.env.API_GATEWAY_STAGE}`,
      stage: process.env.API_GATEWAY_STAGE,
      uri: process.env.API_GATEWAY_URI
    }
  },
  clientId: process.env.COGNITO_CLIENT_ID,
  identityPoolId: process.env.COGNITO_IDENTITY_POOL_ID,
  region: process.env.AWS_REGION,
  userPoolId: process.env.COGNITO_USER_POOL_ID
}
