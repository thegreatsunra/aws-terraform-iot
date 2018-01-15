module "devices_info" {
  source = "./apigateway"
  api_id = "${aws_api_gateway_rest_api.aagra_api.id}"
  parent_id = "${aws_api_gateway_rest_api.aagra_api.root_resource_id}"
  path_part = "devices.info"
  authorization = "${var.authorization}"
  authorizer_id = "${var.authorizer_id}"
  lambda_permission_id = "${var.routes["devices_info"]}"
  lambda_name = "${var.routes["devices_info"]}"
  lambda_path = "functions/devices_info"
  lambda_role = "${aws_iam_role.db_query_role.arn}"
  aws_region = "${var.aws_region}"
  request_parameters = {
    "method.request.querystring.id" = false
  }
  request_templates = {
    "application/json" = "${data.template_file.tf_info_request.rendered}"
  }
  response_templates = {
    "application/json" = "${data.template_file.tf_info_response.rendered}"
  }
}

module "devices_list" {
  source = "./apigateway"
  api_id = "${aws_api_gateway_rest_api.aagra_api.id}"
  parent_id = "${aws_api_gateway_rest_api.aagra_api.root_resource_id}"
  path_part = "devices.list"
  authorization = "${var.authorization}"
  authorizer_id = "${var.authorizer_id}"
  lambda_permission_id = "${var.routes["devices_list"]}"
  lambda_name = "${var.routes["devices_list"]}"
  lambda_path = "functions/devices_list"
  lambda_role = "${aws_iam_role.db_query_role.arn}"
  aws_region = "${var.aws_region}"
  response_templates = {
    "application/json" = "${data.template_file.tf_list_response.rendered}"
  }
}

module "devices_update" {
  source = "./apigateway"
  api_id = "${aws_api_gateway_rest_api.aagra_api.id}"
  parent_id = "${aws_api_gateway_rest_api.aagra_api.root_resource_id}"
  path_part = "devices.update"
  authorization = "${var.authorization}"
  authorizer_id = "${var.authorizer_id}"
  lambda_permission_id = "${var.routes["devices_update"]}"
  lambda_name = "${var.routes["devices_update"]}"
  lambda_path = "functions/devices_update"
  lambda_role = "${aws_iam_role.db_update_role.arn}"
  aws_region = "${var.aws_region}"
  http_method = "POST"
}

module "events_info" {
  source = "./apigateway"
  api_id = "${aws_api_gateway_rest_api.aagra_api.id}"
  parent_id = "${aws_api_gateway_rest_api.aagra_api.root_resource_id}"
  path_part = "events.info"
  authorization = "${var.authorization}"
  authorizer_id = "${var.authorizer_id}"
  lambda_permission_id = "${var.routes["events_info"]}"
  lambda_name = "${var.routes["events_info"]}"
  lambda_path = "functions/events_info"
  lambda_role = "${aws_iam_role.db_query_role.arn}"
  aws_region = "${var.aws_region}"
  request_parameters = {
    "method.request.querystring.id" = false
  }
  request_templates = {
    "application/json" = "${data.template_file.tf_info_request.rendered}"
  }
  response_templates = {
    "application/json" = "${data.template_file.tf_info_response.rendered}"
  }
}

module "events_list" {
  source = "./apigateway"
  api_id = "${aws_api_gateway_rest_api.aagra_api.id}"
  parent_id = "${aws_api_gateway_rest_api.aagra_api.root_resource_id}"
  path_part = "events.list"
  authorization = "${var.authorization}"
  authorizer_id = "${var.authorizer_id}"
  lambda_permission_id = "${var.routes["events_list"]}"
  lambda_name = "${var.routes["events_list"]}"
  lambda_path = "functions/events_list"
  lambda_role = "${aws_iam_role.db_query_role.arn}"
  aws_region = "${var.aws_region}"
  request_parameters = {
    "method.request.querystring.deviceId" = false
  }
  request_templates = {
    "application/json" = "${data.template_file.tf_events_list_request.rendered}"
  }
  response_templates = {
    "application/json" = "${data.template_file.tf_list_response.rendered}"
  }
}
