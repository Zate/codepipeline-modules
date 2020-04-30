variable default_tags {}

variable account_name {}

variable account_id {}

variable aws_region {}

variable "project_name" {}

variable "project_env" {}

variable "s3_logging_bucket_id" {}

variable "codebuild_iam_role_name" {
    type = string
    default = "splunk-pipeline-codebuild"
}

variable "codebuild_iam_role_policy_name" {
    type = string
    default = "splunk-pipeline-codebuild"
}

variable "codepipeline_artifact_bucket_arn" {}

variable "terraform_codecommit_repo_arn" {}

variable "terraform_locks_arn" {}



