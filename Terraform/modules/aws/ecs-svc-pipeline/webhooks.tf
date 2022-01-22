resource "aws_codepipeline_webhook" "gh_webhook" {
  name            = "${local.prefix}"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = "${aws_codepipeline.cd.name}"

  authentication_configuration {
    secret_token = "${var.pipe_webhook["secret"]}"
  }

  filter {
    json_path    = "${var.pipe_webhook["json_path"]}"
    match_equals = "${var.pipe_webhook["match_equals"]}"
  }
}

# Wire the CodePipeline webhook into a GitHub repository.
resource "github_repository_webhook" "gh_webhook" {
  repository = "${var.gh_repo}"

  name = "web"

  configuration {
    url          = "${aws_codepipeline_webhook.gh_webhook.url}"
    content_type = "json"
    insecure_ssl = true
    secret       = "${var.pipe_webhook["secret"]}"
  }
  lifecycle {
    ignore_changes = ["configuration.secret"]
  }
  events = ["${var.common_tags["env"] == "prod" ? "release" : "push"}"]
}
