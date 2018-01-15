resource "aws_iam_role" "cognito_auth_role" {
  name = "${var.cognito_auth_role}"
  assume_role_policy = "${data.template_file.tf_auth_assume_role_policy.rendered}"
}

resource "aws_iam_policy" "cognito_auth_policy" {
  name        = "${var.cognito_auth_policy}"
  policy = "${data.template_file.tf_cognito_auth_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "cognito_auth_attachment" {
  role       = "${aws_iam_role.cognito_auth_role.name}"
  policy_arn = "${aws_iam_policy.cognito_auth_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "cognito_auth_log_attachment" {
  role       = "${aws_iam_role.cognito_auth_role.name}"
  policy_arn = "${aws_iam_policy.log_policy.arn}"
}

resource "aws_iam_role" "cognito_unauth_role" {
  name = "${var.cognito_unauth_role}"
  assume_role_policy = "${data.template_file.tf_unauth_assume_role_policy.rendered}"
}

resource "aws_iam_policy" "cognito_unauth_policy" {
  name        = "${var.cognito_unauth_policy}"
  policy = "${data.template_file.tf_cognito_unauth_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "cognito_unauth_attachment" {
  role       = "${aws_iam_role.cognito_unauth_role.name}"
  policy_arn = "${aws_iam_policy.cognito_unauth_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "cognito_unauth_log_attachment" {
  role       = "${aws_iam_role.cognito_unauth_role.name}"
  policy_arn = "${aws_iam_policy.log_policy.arn}"
}
