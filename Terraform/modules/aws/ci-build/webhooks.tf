resource "aws_codebuild_webhook" "this" {
  project_name  = "${aws_codebuild_project.build.name}"
  branch_filter = "^(?!master).*$"
}

resource "github_repository_webhook" "this" {
  active     = true
  events     = ["push"]
  name       = "web"
  repository = "${var.gh_repo}"

  configuration {
    url          = "${aws_codebuild_webhook.this.payload_url}"
    secret       = "${aws_codebuild_webhook.this.secret}"
    content_type = "json"
    insecure_ssl = false
  }
}

output "codebuild_secret" {
  value = "${aws_codebuild_webhook.this.secret}"
}

output "codebuild_url" {
  value = "${aws_codebuild_webhook.this.payload_url}"
}
