resource "aws_codebuild_project" "codebuild" {
  name          = "${var.project_name}-codebuild"
  service_role  = aws_iam_role.codepipeline_role.arn

  source_version = "main"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  source {
    type            = "CODECOMMIT"
    location        = aws_codecommit_repository.codecommit.clone_url_http
    git_clone_depth = 1
    buildspec = "buildspec.yml"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:7.0"
    type         = "LINUX_CONTAINER"
    environment_variable {
      name  = "S3_BUCKET"
      value = var.s3_bucket.bucket
    }
  }

  tags = var.project_tags
}