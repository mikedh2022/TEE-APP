#========================#
#     s3 loggings:       #
#       Used by ALB      #
#                        #
#========================#

module "s3_logging" {
  source      = "../../aws/s3/logging"
  name        = "${local.prefix}-logs"
  common_tags = "${merge(local.common_tags, map("visibility", "internal"))}"
}

#====================================#
#     CodeBuild Artifacts:           #
#       Used by CodeBuild &          #
#       CodePipeline                 #
#====================================#

data "aws_iam_policy_document" "s3_artifacts" {
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
      "arn:aws:s3:::${local.prefix}-artifacts/*",
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

resource "aws_s3_bucket" "artifacts" {
  bucket        = "${local.prefix}-artifacts"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags = "${merge(local.common_tags, map(
      "usage", "code-source",
      "visibility", "internal"
  ))}"

  lifecycle_rule {
    id      = "codesource"
    enabled = true

    prefix = "/"
    tags   = "${local.common_tags}"

    expiration {
      #TODO: Define expiry dates of builds
      days = "30"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  policy = "${data.aws_iam_policy_document.s3_artifacts.json}"
}

#====================================#
#     CodeBuild Cache Bucket:        #
#       Used by CodeBuild            #
#       to cache builds              #
#====================================#

data "aws_iam_policy_document" "s3_cache_policy" {
  statement {
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
      "arn:aws:s3:::${local.prefix}-build-cache/*",
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

resource "aws_s3_bucket" "codebuild_cache" {
  bucket        = "${local.prefix}-build-cache"
  acl           = "private"
  force_destroy = true

  tags = "${merge(local.common_tags, map(
      "usage", "codebuild-cache",
      "visibility", "internal"
  ))}"

  lifecycle_rule {
    id      = "codebuildcache"
    enabled = true

    prefix = "/"
    tags   = "${local.common_tags}"

    expiration {
      #TODO: Define expiry dates of builds
      days = "30"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  policy = "${data.aws_iam_policy_document.s3_cache_policy.json}"
}
