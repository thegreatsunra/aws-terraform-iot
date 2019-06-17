provider "aws" {
  version    = "~> 2.15"
  profile    = "${var.aws_profile}"
  region     = "${var.aws_region}"
}
