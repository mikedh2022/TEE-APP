data "aws_region" "current" {}

locals {
  prefix      = "${var.prefix}"
  common_tags = "${merge(local.common_tags, map("stack", "ci-build"))}"
}
