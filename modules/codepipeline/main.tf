terraform {
  required_version = "~> 0.12.0"

  required_providers {
    aws = "~> 2.25"
  }
}

data "aws_kms_alias" "s3kmskey" {
  name = "alias/myKmsKey"
}
