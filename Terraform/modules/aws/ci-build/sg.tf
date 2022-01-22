resource "aws_security_group" "codebuild" {
  name        = "${local.prefix}-sg"
  description = "${local.prefix} codebuild security group"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.common_tags, map("Name", "${local.prefix}-sg"))}"
}
