resource "aws_s3_bucket" "s3_web_app" {
  bucket = "${var.s3_web_app}"
  acl    = "private"
  force_destroy = true
  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}
