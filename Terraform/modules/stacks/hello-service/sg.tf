resource "aws_security_group" "default" {
  name        = "${local.prefix}-sg"
  description = "${local.prefix} default ECS service"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = "${var.port}"
    protocol        = "TCP"
    to_port         = "${var.port}"
    security_groups = ["${aws_security_group.default_alb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.common_tags, map("Name", "${local.prefix}-sg"))}"
}

resource "aws_security_group" "default_alb" {
  name        = "${local.prefix}-alb-sg"
  description = "${local.prefix} Load balancer security group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port = 80
    protocol  = "TCP"
    to_port   = 80

    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.common_tags, map("Name", "${local.prefix}-alb-sg"))}"
}
