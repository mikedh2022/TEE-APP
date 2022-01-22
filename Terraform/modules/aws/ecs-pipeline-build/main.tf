locals {
  prefix      = "${var.prefix}"
  common_tags = "${var.common_tags}"

  iam_role_name   = "${local.prefix}-codebuild-role"
  iam_policy_name   = "${local.prefix}-codebuild-policy"
}
