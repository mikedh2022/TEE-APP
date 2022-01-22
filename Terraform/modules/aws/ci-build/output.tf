output "name" {
  value = "${aws_codebuild_project.build.name}"
}

output "role_arn" {
  value = "${module.role_codebuild.arn}"
}

output "role" {
  value = "${module.role_codebuild.name}"
}
