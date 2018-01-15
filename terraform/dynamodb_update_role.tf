resource "aws_iam_role" "db_update_role" {
  name = "${var.db_update_role}"
  path = "${var.service_role_path}"
  assume_role_policy = "${data.template_file.tf_api_assume_role_policy.rendered}"
}

resource "aws_iam_policy" "db_update_policy" {
  name        = "${var.db_update_policy}"
  policy = "${data.template_file.tf_db_update_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "db_update_attachment" {
  role       = "${aws_iam_role.db_update_role.name}"
  policy_arn = "${aws_iam_policy.db_update_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "db_update_log_attachment" {
  role       = "${aws_iam_role.db_update_role.name}"
  policy_arn = "${aws_iam_policy.log_policy.arn}"
}
