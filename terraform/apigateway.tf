resource "aws_api_gateway_deployment" "aagd_api" {
  depends_on = [
    "module.devices_list",
    "module.devices_info",
    "module.devices_update",
    "module.events_list",
    "module.events_info"
  ]
  rest_api_id = "${aws_api_gateway_rest_api.aagra_api.id}"
  stage_name  = "prod"
}

resource "aws_api_gateway_rest_api" "aagra_api" {
  name        = "${var.api}"
}

resource "aws_iam_role" "air_api" {
  name = "${var.api_role}"
  assume_role_policy = "${data.template_file.tf_api_assume_role_policy.rendered}"
}

resource "aws_iam_policy" "aip_api" {
  name = "${var.api_policy}"
  policy = "${data.template_file.tf_api_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "airpa_api" {
  role       = "${aws_iam_role.air_api.name}"
  policy_arn = "${aws_iam_policy.log_policy.arn}"
}

# User pool authorizer
resource "aws_cloudformation_stack" "user_pool_authorizer" {
  depends_on = ["aws_cognito_user_pool.acup_user_pool", "aws_api_gateway_rest_api.aagra_api"]
  name = "cognito-authorizer"
  template_body = <<STACK
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Resources": {
    "cognitoAuthorizer": {
      "Type": "AWS::ApiGateway::Authorizer",
      "Properties": {
        "IdentitySource": "method.request.header.Authorization",
        "Name": "cognitoAuthorizer",
        "ProviderARNs": ["arn:aws:cognito-idp:${var.aws_region}:${var.aws_account_id}:userpool/${aws_cognito_user_pool.acup_user_pool.id}"],
        "RestApiId": "${aws_api_gateway_rest_api.aagra_api.id}",
        "Type": "COGNITO_USER_POOLS"
      }
    }
  },
  "Outputs": {
    "AuthorizerId": { "Value": { "Ref": "cognitoAuthorizer" }}
  }
}
STACK
}

output "authorizer_id" {
  value = "${aws_cloudformation_stack.user_pool_authorizer.outputs}"
}
