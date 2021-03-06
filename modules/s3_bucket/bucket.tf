# s3 bucket for logging items built with splunk-pipeline
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = merge(
    var.default_tags,
    {
      "Name" = var.bucket_name
    },
  )
}
