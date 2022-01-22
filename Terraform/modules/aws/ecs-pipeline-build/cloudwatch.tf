resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/codebuild/${local.prefix}"
  retention_in_days = "${var.retention_in_days}"

  tags = "${local.common_tags}"
}
