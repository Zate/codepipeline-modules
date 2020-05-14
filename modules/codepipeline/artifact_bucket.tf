# codepipeline artifact s3 bucket

resource "aws_s3_bucket" "artifacts" {
  bucket = var.artifact_bucket_name

  versioning {
    enabled = true
  }

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
      "Name" = "${var.artifact_bucket_name}-bucket"
    },
  )
}
