resource "aws_default_network_acl" "acl" {
  default_network_acl_id = "${aws_vpc.vpc.default_network_acl_id}"

  subnet_ids = [
    "${concat(aws_subnet.public.*.id, aws_subnet.private.*.id)}",
  ]

  # Network ACL
  # allow all ports communications internally
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "${local.name}-acl"
    )
  )}"
}
