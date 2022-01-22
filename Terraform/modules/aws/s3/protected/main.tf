locals {
  common_tags = "${merge(var.common_tags, map("acl", "private"))}"
}

data "aws_iam_policy_document" "policy_statement" {
  policy_id = "${var.policy_id}"

  statement {
    sid    = "DenyUnEncryptedObjectUploads"
    effect = "Deny"

    actions = [
      "s3:PutObject",
    ]

    principals {
      type = "*"

      identifiers = [
        "*",
      ]
    }

    resources = [
      "arn:aws:s3:::${var.name}/*",
    ]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"

      values = [
        "aws:kms",
        "AES256",
      ]
    }
  }
}
