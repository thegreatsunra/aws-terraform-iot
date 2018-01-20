data "template_file" "tf_iot_policy" {
  vars {
    aws_region = "${var.aws_region}"
    aws_account_id = "${var.aws_account_id}"
  }
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iot:Connect",
        "iot:Publish",
        "iot:Receive",
        "iot:Subscribe"
      ],
      "Resource": "arn:aws:iot:$${aws_region}:$${aws_account_id}:*"
    }
  ]
}
EOF
}

data "template_file" "tf_s3_cloudtrail_policy" {
  vars {
    s3_bucket = "${var.s3_cloudtrail}"
  }
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSCloudTrailAclCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::$${s3_bucket}"
    },
    {
      "Sid": "AWSCloudTrailWrite",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::$${s3_bucket}/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    }
  ]
}
EOF
}

data "template_file" "tf_auth_assume_role_policy" {
  vars {
    aws_region = "${var.aws_region}"
    identity_pool_id = "${aws_cognito_identity_pool.acip_identity_pool.id}"
  }
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "$${aws_region}:$${identity_pool_id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF
}

data "template_file" "tf_unauth_assume_role_policy" {
  vars {
    aws_region = "${var.aws_region}"
    identity_pool_id = "${aws_cognito_identity_pool.acip_identity_pool.id}"
  }
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "$${aws_region}:$${identity_pool_id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "unauthenticated"
        }
      }
    }
  ]
}
EOF
}

data "template_file" "tf_api_assume_role_policy" {
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "apigateway.amazonaws.com",
          "lambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "template_file" "tf_lambda_assume_role_policy" {
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "template_file" "tf_db_query_policy" {
  vars {
    aws_region = "${var.aws_region}"
    aws_account_id = "${var.aws_account_id}"
  }
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": [
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:GetItem"
    ],
    "Resource": "arn:aws:dynamodb:$${aws_region}:$${aws_account_id}:table/*"
  }
}
EOF
}

data "template_file" "tf_db_update_policy" {
  vars {
    aws_region = "${var.aws_region}"
    aws_account_id = "${var.aws_account_id}"
  }
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": [
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:BatchWriteItem"
    ],
    "Resource": "arn:aws:dynamodb:$${aws_region}:$${aws_account_id}:table/*"
  }
}
EOF
}

data "template_file" "tf_db_delete_policy" {
  vars {
    aws_region = "${var.aws_region}"
    aws_account_id = "${var.aws_account_id}"
  }
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": [
      "dynamodb:DeleteItem"
    ],
    "Resource": "arn:aws:dynamodb:$${aws_region}:$${aws_account_id}:table/*"
  }
}
EOF
}

data "template_file" "tf_log_policy" {
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents"
    ],
      "Resource": "arn:aws:logs:*:*:*"
  }
}
EOF
}

data "template_file" "tf_api_policy" {
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "execute-api:Invoke"
      ],
      "Resource": "arn:aws:execute-api:*:*:*"
    }
  ]
}
EOF
}

data "template_file" "tf_cognito_auth_policy" {
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "mobileanalytics:PutEvents",
        "cognito-sync:*",
        "cognito-identity:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

data "template_file" "tf_cognito_unauth_policy" {
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "mobileanalytics:PutEvents",
        "cognito-sync:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

data "template_file" "tf_events_list_request" {
  template = <<EOF
{
  "deviceId": "$input.params('deviceId')"
}
EOF
}

data "template_file" "tf_list_response" {
  template = <<EOF
#set($allParams = $input.params())
{
  "ok" : true,
  "items" : $input.json('$')
}

EOF
}

data "template_file" "tf_info_request" {
  template = <<EOF
{
  "id": "$input.params('id')"
}
EOF
}

data "template_file" "tf_info_response" {
  template = <<EOF
#set($allParams = $input.params())
{
  "ok" : true,
  "item" : $input.json('$')
}

EOF
}
