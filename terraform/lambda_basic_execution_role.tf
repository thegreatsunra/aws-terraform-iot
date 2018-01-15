resource "aws_iam_role" "lambda_basic_execution_role" {
  name = "${var.lambda_basic_execution_role}"
  path = "${var.service_role_path}"
  assume_role_policy = "${data.template_file.tf_lambda_assume_role_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_log_attachment" {
  role       = "${aws_iam_role.lambda_basic_execution_role.name}"
  policy_arn = "${aws_iam_policy.log_policy.arn}"
}
