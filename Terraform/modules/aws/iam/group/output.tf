output "devops_group_name" {
  description = "DevOps IAM group name"
  value       = "${aws_iam_group.devops.name}"
}

output "developers_group_name" {
  description = "Developers IAM group name"
  value       = "${aws_iam_group.developers.name}"
}

output "back_office_group_name" {
  description = "Back-office IAM group name"
  value       = "${aws_iam_group.back_office.name}"
}

output "administrators_group_name" {
  description = "administrators IAM group name"
  value       = "${aws_iam_group.administrator.name}"
}
