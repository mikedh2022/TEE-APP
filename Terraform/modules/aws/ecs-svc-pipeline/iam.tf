resource "aws_iam_role" "codepipeline" {
  name               = "${local.iam_role_name}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "codepipeline.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "${local.iam_policy_name}"
  role   = "${aws_iam_role.codepipeline.id}"
  policy = "${data.aws_iam_policy_document.policy.json}"
}

data "aws_iam_policy_document" "policy" {
  "statement" {
    actions = [
      "elasticbeanstalk:*",
      "ec2:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "s3:*",
      "sns:*",
      "cloudformation:*",
      "rds:*",
      "sqs:*",
      "ecs:*",
      "codebuild:*",
      "iam:PassRole",
    ]

    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObject",
    ]

    resources = [
      "${var.s3_artifacts["arn"]}",
      "${var.s3_artifacts["arn"]}/*",
      "arn:aws:s3:::elasticbeanstalk*",
    ]

    effect = "Allow"
  }

  statement {
    actions = [
      "logs:*",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    effect = "Allow"

    actions = [
      #TODO:Restrict access to encrypt & decrypt
      "kms:*",
    ]

    resources = [
      "${var.kms_arn}",
    ]
  }
}
