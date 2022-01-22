locals {
  prefix = "${var.prefix}"

  common_tags = "${merge(var.common_tags, map(
     "module", "ci-pipeline"
  ))}"

  iam_policy_name = "${local.prefix}-policy"
  iam_role_name   = "${local.prefix}-role"
}
