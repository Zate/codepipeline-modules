# S3 logging bucket
output "dynamodb_table_arn" {
  value = aws_dynamodb_table.locks_table.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.locks_table.name
}
