data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

locals {
  name = "${var.prefix}"

  common_tags = "${merge(map(
    "stack", "${var.prefix}"
  ), var.common_tags)}"
}
