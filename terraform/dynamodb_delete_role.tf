resource "aws_iam_role" "db_delete_role" {
  name = "${var.db_delete_role}"
  path = "${var.service_role_path}"
  assume_role_policy = "${data.template_file.tf_api_assume_role_policy.rendered}"
}

resource "aws_iam_policy" "db_delete_policy" {
  name        = "${var.db_delete_policy}"
  policy = "${data.template_file.tf_db_delete_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "db_delete_attachment" {
  role       = "${aws_iam_role.db_delete_role.name}"
  policy_arn = "${aws_iam_policy.db_delete_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "db_delete_log_attachment" {
  role       = "${aws_iam_role.db_delete_role.name}"
  policy_arn = "${aws_iam_policy.log_policy.arn}"
}
