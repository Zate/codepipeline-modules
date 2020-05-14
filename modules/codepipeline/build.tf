

# Create CodeBuild Project for Terraform Plan
resource "aws_codebuild_project" "plan" {
  name          = "${var.project_env}-${var.repo_name}-${var.repo_stage}-plan"
  description   = "${var.project_env} ${var.repo_name} ${var.repo_stage} codebuild plan"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
    artifact_identifier = "${var.project_env}-${var.repo_name}-${var.repo_stage}-plan"
  }

  cache {
    type     = "S3"
    location = var.logging_bucket_id
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = "0.12.24"
    }

    environment_variable {
      name  = "TERRAGRUNT_VERSION"
      value = "0.23.4"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${var.logging_bucket_id}/${var.project_env}/${var.repo_name}/${var.repo_stage}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_plan.yml"
  }

  tags = merge(
    var.default_tags,
    {
      "Name" = "${var.project_env}-${var.repo_name}-${var.repo_stage}-build"
    },
  )
}

# Output TF Plan CodeBuild name to main.tf
output "codebuild_terraform_plan_name" {
  value = var.terraform_plan_name
}


# Create CodeBuild Project for Terraform Apply
resource "aws_codebuild_project" "codebuild_project_terraform_apply" {
  name          = var.codebuild_project_terraform_apply_name
  description   = "Terraform codebuild project"
  build_timeout = "5"
  service_role  = var.codebuild_iam_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = var.s3_logging_bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = "0.12.16"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${var.s3_logging_bucket_id}/${var.codebuild_project_terraform_apply_name}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_terraform_apply.yml"
  }

  tags = {
    Terraform = "true"
  }
}


