variable default_tags {}

variable account_name {}

variable account_id {}

variable aws_region {}

variable "state_bucket_name" {
  type    = string
  default = "splunk-tf-state"
}

variable "state_locks_table" {
  type    = string
  default = "splunk-tf-locks"
}

variable "s3_logging_bucket_name" {
  type    = string
  default = "splunk-pipeline-logs"
}

variable "codepipeline_artifact_name" {
    type = string
    default = "splunk-codepipeline-artifacts"
}

