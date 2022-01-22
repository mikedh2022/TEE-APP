locals {
  prefix = "${var.prefix}"

  common_tags = "${merge(var.common_tags, map(
    "stack", "common-env"
  ))}"
}
