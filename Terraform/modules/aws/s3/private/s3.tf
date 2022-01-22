resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}"
  acl    = "${var.acl}"

  logging {
    target_bucket = "${var.logging_bucket}"
    target_prefix = "${var.name}/"
  }

  tags = "${var.common_tags}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
