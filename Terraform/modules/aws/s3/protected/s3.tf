resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}"
  acl    = "${var.acl}"

  request_payer = "BucketOwner"

  versioning {
    enabled = true
  }

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

  policy = "${data.aws_iam_policy_document.policy_statement.json}"
}
