resource "aws_iot_policy" "iot_policy" {
  name   = "${var.iot_policy}"
  policy = "${data.template_file.tf_iot_policy.rendered}"
}
