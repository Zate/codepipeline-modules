# S3 logging bucket
output "s3_logging_bucket_id" {
  value = aws_s3_bucket.s3_logging_bucket.id
}
output "s3_logging_bucket_arn" {
  value = aws_s3_bucket.s3_logging_bucket.arn
}

# State bucket
output "s3_terraform_state_bucket_id" {
  value = aws_s3_bucket.terraform_state.id
}

output "s3_terraform_state_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}

# State DB Table
output "dynamodb_teraform_lock_table_id" {
  value = aws_dynamodb_table.terraform_locks.id
}

output "dynamodb_teraform_lock_table_arn" {
  value = aws_dynamodb_table.terraform_locks.arn
}

# Codepieline artifact bucket
output "codepipeline_artifact_bucket_arn" {
    value = aws_s3_bucket.codepipeline_artifact.arn
}


