# codepipeline artifact s3 bucket

resource "aws_s3_bucket" "codepipeline_artifact" {
  bucket = var.codepipeline_artifact_name

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
      "Name" = "${var.codepipeline_artifact_name}-bucket"
    },
  )
}
