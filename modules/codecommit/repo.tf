#CodeCommit git repo
resource "aws_codecommit_repository" "repo" {
  repository_name = var.repo_name
  description     = "CodeCommit Terraform repo for ${var.project_name} ${var.project_env} ${var.repo_project}"
  tags = merge(
    var.default_tags,
    {
      "Name" = "${var.project_env}-${var.repo_project}-${var.repo_name}"
    },
  )
}
