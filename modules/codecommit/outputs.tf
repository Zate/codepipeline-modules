# Output the repo info back to main.tf
output "terraform_codecommit_repo_arn" {
  value = aws_codecommit_repository.repo.arn
}
output "terraform_codecommit_repo_name" {
  value = aws_codecommit_repository.repo.repository_name
}
