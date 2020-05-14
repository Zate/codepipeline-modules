terraform {

  required_version = "~> 0.12.17"

  required_providers {
    aws = "~> 2.59.0"
  }
}

data "aws_kms_alias" "s3kmskey" {
  name = "alias/tfKMSkey"
}

data "aws_dynamodb_table" "tableName" {
  name = var.locks_table
}

data "aws_s3_bucket" "logging" {
    name =  var.logging_bucket_name
}

data "aws_s3_bucket" "state" {
    name = var.bucket_name
}
