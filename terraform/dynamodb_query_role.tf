resource "aws_iam_role" "db_query_role" {
  name = "${var.db_query_role}"
  path = "${var.service_role_path}"
  assume_role_policy = "${data.template_file.tf_api_assume_role_policy.rendered}"
}

resource "aws_iam_policy" "db_query_policy" {
  name        = "${var.db_query_policy}"
  policy = "${data.template_file.tf_db_query_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "db_query_attachment" {
  role       = "${aws_iam_role.db_query_role.name}"
  policy_arn = "${aws_iam_policy.db_query_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "db_query_log_attachment" {
  role       = "${aws_iam_role.db_query_role.name}"
  policy_arn = "${aws_iam_policy.log_policy.arn}"
}
