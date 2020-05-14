#CodeCommit git repo
resource "aws_codecommit_repository" "repo" {
  repository_name = "${var.project_env}-${var.repo_name}-${var.repo_stage}"
  description     = "CodeCommit Terraform repo for ${var.project_env}-${var.repo_name}-${var.repo_stage}"
  tags = merge(
    var.default_tags,
    {
      "Name" = "${var.project_env}-${var.repo_name}-${var.repo_stage}-repo"
    },
  )
}
