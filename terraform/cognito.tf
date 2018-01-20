resource "aws_cognito_user_pool" "acup_user_pool" {
  depends_on = ["module.cognito"]
  name = "${var.user_pool}"
  alias_attributes = ["email"]
  admin_create_user_config = {
    allow_admin_create_user_only = false
  }
  email_verification_subject = "Verification code for your ${var.company} app account"
  email_verification_message = "Hello from your friendly ${var.company} app! Your verification code is {####}"
  auto_verified_attributes = ["email"]

  password_policy = {
    minimum_length = "12"
    require_lowercase = true
    require_numbers = false
    require_symbols = false
    require_uppercase = false
  }
  schema = {
    developer_only_attribute = false
    mutable = false
    attribute_data_type = "String"
    name = "email"
    required = true
  }
  verification_message_template = {
    default_email_option = "CONFIRM_WITH_CODE"
  }
  lambda_config = {
    pre_sign_up = "${module.cognito.lambda_function_arn}"
  }
}

resource "aws_cognito_identity_pool" "acip_identity_pool" {
  identity_pool_name = "${var.identity_pool}"
  allow_unauthenticated_identities = false
  cognito_identity_providers {
    client_id = "${var.cognito_app_client_id}"
    provider_name = "cognito-idp.${var.aws_region}.amazonaws.com/${aws_cognito_user_pool.acup_user_pool.id}"
    server_side_token_check = false
  }
}

resource "aws_cognito_identity_pool_roles_attachment" "acipra_role_attachment" {
  identity_pool_id = "${aws_cognito_identity_pool.acip_identity_pool.id}"

  roles {
    "authenticated" = "${aws_iam_role.cognito_auth_role.arn}"
    "unauthenticated" = "${aws_iam_role.cognito_unauth_role.arn}"
  }
}
