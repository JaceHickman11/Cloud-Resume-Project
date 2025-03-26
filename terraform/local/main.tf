provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "terraform-state-jacehickman"
  force_destroy = true
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
