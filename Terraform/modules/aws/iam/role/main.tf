resource "aws_iam_role" "role" {
  name               = "${var.name}"
  assume_role_policy = "${var.assume_role_policy}"
  description        = "${var.description}"
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  policy_arn = "${var.policy_to_attach}"
  role       = "${aws_iam_role.role.name}"
}
