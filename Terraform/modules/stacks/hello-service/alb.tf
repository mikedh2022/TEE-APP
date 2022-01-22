resource "aws_alb" "default" {
  name            = "${local.prefix}-alb"
  subnets         = ["${var.public_subnet_ids}"]
  security_groups = ["${aws_security_group.default_alb.id}"]
  internal        = false

  access_logs {
    bucket  = "${var.s3_logging["id"]}"
    prefix  = "${local.prefix}"
    enabled = true
  }

  tags = "${merge(local.common_tags, map("Name", "${local.prefix}-alb"))}"
}

resource "aws_alb_listener" "default" {
  load_balancer_arn = "${aws_alb.default.id}"

  port            = 80
  protocol        = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.default.id}"
    type             = "forward"
  }
}


resource "aws_alb_target_group" "default" {
  name        = "${local.prefix}-tg"
  port        = "${var.port}"
  protocol    = "HTTP"
  vpc_id      = "${var.vpc_id}"
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    path     = "/health/live"
    protocol = "HTTP"
    port     = "${var.port}"
    matcher  = "200"
  }

  tags = "${merge(local.common_tags, map("Name", "${local.prefix}-tg"))}"
}
