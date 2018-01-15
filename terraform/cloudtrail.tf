resource "aws_cloudtrail" "cloudtrail" {
  name                          = "${var.cloudtrail}"
  s3_bucket_name                = "${aws_s3_bucket.s3_cloudtrail.id}"
  s3_key_prefix                 = "prefix"
  include_global_service_events = true
}

resource "aws_s3_bucket" "s3_cloudtrail" {
  bucket        = "${var.s3_cloudtrail}"
  force_destroy = true
  policy = "${data.template_file.tf_s3_cloudtrail_policy.rendered}"
}
