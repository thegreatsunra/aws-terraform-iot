provider "aws" {
  version    = "~> 2.15"
  profile    = "${var.aws_profile}"
  region     = "${var.aws_region}"
}

provider "archive" {
  version    = "~> 1.2"
}

provider "template" {
  version    = "~> 2.1"
}
