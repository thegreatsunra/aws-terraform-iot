module "events" {
  source = "./lambda"
  lambda_permission_id = "${var.functions["events"]}"
  lambda_name = "${var.functions["events"]}"
  lambda_path = "functions/events"
  lambda_role = "${aws_iam_role.db_update_role.arn}"
}
