module "policy_codebuild" {
  source = "../../../aws/iam/policy"
  policy = "${data.aws_iam_policy_document.policy_codebuild.json}"
  name   = "${local.iam_policy_name}"
}

data "aws_iam_policy_document" "policy_codebuild" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ec2:*",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    #TODO:Restrict access to encrypt & decrypt
    actions = [
      "kms:*",
    ]

    resources = [
      "${var.kms_arn}",
    ]
  }

  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetAuthorizationToken",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]

    resources = ["*"]
  }
}

module "role_codebuild" {
  source             = "../../../aws/iam/role"
  name               = "${local.iam_role_name}"
  description        = "${local.prefix} codebuild Role"
  policy_to_attach   = "${module.policy_codebuild.arn}"
  assume_role_policy = "${data.aws_iam_policy_document.role_assume_policy_codebuild.json}"
}

data "aws_iam_policy_document" "role_assume_policy_codebuild" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "codebuild.amazonaws.com",
      ]
    }
  }
}
