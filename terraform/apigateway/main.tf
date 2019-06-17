variable "api_id" {}
variable "parent_id" {}
variable "path_part" {}
variable "http_method" {
  default = "GET"
}
variable "authorization" {
  default = "NONE"
}
variable "authorizer_id" {
  type = "string"
  default = ""
}
variable "lambda_permission_id" {}
variable "lambda_name" {}
variable "lambda_path" {}
variable "lambda_role" {}
variable "aws_region" {}
variable "request_parameters" {
  type = "map"
  default = {}
}
variable "request_templates" {
  type="map"
  default = {}
}
variable "response_templates" {
  type = "map"
  default = {
    "application/json" = <<EOF
{
  "ok" : true
}

EOF
  }
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = "${var.api_id}"
  parent_id   = "${var.parent_id}"
  path_part   = "${var.path_part}"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id = "${var.api_id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method   = "${var.http_method}"
  authorization = "${var.authorization}"
  authorizer_id = "${var.authorizer_id}"

  ## "false" means not required, "true" means required
  ## we're setting it to "not required" for now because we haven't set up
  ## request validation yet

  request_parameters = "${var.request_parameters}"
}

resource "aws_api_gateway_integration" "integration" {
  depends_on  = ["aws_lambda_function.lambda_function"]
  rest_api_id = "${var.api_id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.method.http_method}"
  integration_http_method = "POST"
  passthrough_behavior = "WHEN_NO_TEMPLATES"
  type        = "AWS"
  uri         = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_function.arn}/invocations"
  request_templates = "${var.request_templates}"
}

resource "aws_api_gateway_method_response" "response" {
  rest_api_id = "${var.api_id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.method.http_method}"
  status_code = "200"
  response_models = {"application/json" = "Empty"}
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "true"
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  depends_on  = ["aws_lambda_function.lambda_function"]
  statement_id  = "${var.lambda_permission_id}"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_name}"
  principal     = "apigateway.amazonaws.com"
}

data "archive_file" "lambda_archive" {
  type = "zip"
  source_file = "${var.lambda_path}/src/index.js"
  output_path = "${var.lambda_path}/src/index.js.zip"
}

resource "aws_lambda_function" "lambda_function" {
  filename         = "${data.archive_file.lambda_archive.output_path}"
  publish          = true
  function_name    = "${var.lambda_name}"
  role             = "${var.lambda_role}"
  handler          = "index.handler"
  source_code_hash = "${base64sha256(file("${data.archive_file.lambda_archive.output_path}"))}"
  runtime          = "nodejs6.10"
  memory_size      = 256
  timeout          = 60
}

resource "aws_api_gateway_integration_response" "integration_response" {
  depends_on  = ["aws_api_gateway_method_response.response", "aws_api_gateway_integration.integration"]
  rest_api_id = "${var.api_id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.method.http_method}"
  # status_code = "${aws_api_gateway_method_response.reponse.status_code}"
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  response_templates = "${var.response_templates}"
}

resource "aws_api_gateway_method" "options_method" {
  rest_api_id = "${var.api_id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "options_response" {
  depends_on  = ["aws_api_gateway_method.options_method"]
  rest_api_id = "${var.api_id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.options_method.http_method}"
  status_code = "200"
  response_models = {"application/json" = "Empty"}
  response_parameters = {
    "method.response.header.Access-Control-Allow-Methods" = "true"
    "method.response.header.Access-Control-Allow-Headers" = "true"
    "method.response.header.Access-Control-Allow-Origin" = "true"
  }
}

resource "aws_api_gateway_integration" "options_integration" {
  depends_on  = ["aws_api_gateway_method_response.options_response"]
  rest_api_id = "${var.api_id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.options_method.http_method}"
  type        = "MOCK"

  request_templates = {
    "application/json" = <<EOF
{
  "statusCode": 200
}
EOF
  }
}

resource "aws_api_gateway_integration_response" "options_integration_response" {
  depends_on  = ["aws_api_gateway_integration.options_integration"]
  rest_api_id = "${var.api_id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.options_method.http_method}"
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  response_templates = {
    "application/json" = ""
  }
}
