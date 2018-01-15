resource "aws_iam_policy" "log_policy" {
  name        = "${var.log_policy}"
  policy = "${data.template_file.tf_log_policy.rendered}"
}
