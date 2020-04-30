# Dynamodb table for state locks for items built with splunk-pipeline

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.state_locks_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = merge(
    var.default_tags,
    {
      "Name" = "state-lock-table-${var.state_locks_table}"
    },
  )
}
