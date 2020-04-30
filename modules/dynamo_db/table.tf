# Dynamodb table for state locks for items built with splunk-pipeline
resource "aws_dynamodb_table" "locks_table" {
  name         = var.locks_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = var.default_tags
}
