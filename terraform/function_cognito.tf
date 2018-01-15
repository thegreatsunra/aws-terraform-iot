module "cognito" {
  source = "./lambda"
  lambda_permission_id = "${var.functions["cognito"]}",
  lambda_name = "${var.functions["cognito"]}",
  lambda_path = "functions/cognito"
  lambda_role = "${aws_iam_role.lambda_basic_execution_role.arn}"
}
