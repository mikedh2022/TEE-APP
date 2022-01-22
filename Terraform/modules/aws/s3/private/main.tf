locals {
  common_tags = "${merge(var.common_tags, map("acl", "private"))}"
}
