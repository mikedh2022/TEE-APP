data "aws_elb_service_account" "current" {}

locals {
  common_tags = "${merge(var.common_tags, map("acl", "log-delivery-write"))}"
}
