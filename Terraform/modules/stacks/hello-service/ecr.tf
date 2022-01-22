resource "aws_ecr_repository" "default" {
  name = "${local.prefix}"
}
