resource "aws_codepipeline" "cd" {
  name     = "${local.prefix}"
  role_arn = "${aws_iam_role.codepipeline.arn}"

  artifact_store {
    location = "${var.s3_artifacts["bucket"]}"
    type     = "S3"

    encryption_key {
      id   = "${var.kms_arn}"
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["code"]

      configuration {
        Owner                = "${var.gh_org}"
        Repo                 = "${var.gh_repo}"
        Branch               = "${var.common_tags["env"] == "stg" ? "stable" : "master"}"
        OAuthToken           = "${var.gh_token}"
        PollForSourceChanges = "false"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["code"]
      output_artifacts = ["package"]
      version          = "1"

      configuration {
        ProjectName = "${module.codebuild.name}"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["package"]
      version         = "1"

      configuration {
        ClusterName = "${var.ecs_cluster_name}"
        ServiceName = "${var.ecs_service_name}"
      }
    }
  }
  lifecycle {
    ignore_changes = ["stage.0.action.0.configuration.OAuthToken", "stage.0.action.0.configuration.%"]
  }
}
