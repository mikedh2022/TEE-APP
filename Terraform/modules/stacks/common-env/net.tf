module "network" {
  source         = "../../aws/net/vpc"
  prefix         = "${local.prefix}"
  common_tags    = "${local.common_tags}"
  cidr_block     = "${var.net_cidr}"
  public_ranges  = "${var.net_ranges["public_cidr_ranges"]}"
  private_ranges = "${var.net_ranges["private_cidr_ranges"]}"
}
