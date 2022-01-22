module "exec_policy" {
  source = "../../aws/iam/policy"
  policy = "${data.aws_iam_policy_document.exec_policy.json}"
  name   = "${local.prefix}-ecs-exec-policy"
}

data "aws_iam_policy_document" "exec_policy" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "kms:*",
    ]

    resources = [
      "${var.kms_arn}",
    ]
  }
}

module "exec_role" {
  source             = "../../aws/iam/role"
  name               = "${local.prefix}-ecs-exec-role"
  description        = "${local.prefix} ECS Execution role"
  policy_to_attach   = "${module.exec_policy.arn}"
  assume_role_policy = "${data.aws_iam_policy_document.exec_assume_policy.json}"
}

data "aws_iam_policy_document" "exec_assume_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "ecs-tasks.amazonaws.com",
      ]
    }
  }
}

############

module "service_policy" {
  source = "../../aws/iam/policy"
  policy = "${data.aws_iam_policy_document.service_policy.json}"
  name   = "${local.prefix}-ecs-service-policy"
}

data "aws_iam_policy_document" "service_policy" {
  statement {
    actions = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "ec2:Describe*",
      "ec2:AuthorizeSecurityGroupIngress",
    ]

    resources = [
      "*",
    ]
  }
}

module "service_role" {
  source             = "../../aws/iam/role"
  name               = "${local.prefix}-ecs-service-role"
  description        = "${local.prefix} ECS Service role"
  policy_to_attach   = "${module.service_policy.arn}"
  assume_role_policy = "${data.aws_iam_policy_document.service_assume_policy.json}"
}

data "aws_iam_policy_document" "service_assume_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "ecs-tasks.amazonaws.com",
      ]
    }
  }
}
