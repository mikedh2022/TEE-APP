resource "aws_kms_key" "a" {
  description             = "For use on ${local.prefix}-kms"
  deletion_window_in_days = "${var.deletion_window_in_days}"
}

resource "aws_kms_alias" "a" {
  name          = "alias/${local.prefix}-kms"
  target_key_id = "${aws_kms_key.a.key_id}"
}
