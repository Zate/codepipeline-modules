# CodeBuild IAM role
output "codebuild_iam_role_arn" {
  value = aws_iam_role.codebuild_iam_role.arn
}
# Output TF Plan CodeBuild name to main.tf
output "codebuild_terraform_plan_name" {
  value = var.codebuild_project_terraform_plan_name
}
