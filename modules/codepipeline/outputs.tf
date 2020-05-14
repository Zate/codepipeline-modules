# Codepieline artifact bucket
output "codepipeline_artifact_bucket_arn" {
    value = aws_s3_bucket.artifacts.arn
}

# Output TF Plan CodeBuild name to main.tf
output "codebuild_terraform_apply_name" {
  value = var.codebuild_project_terraform_apply_name
}
