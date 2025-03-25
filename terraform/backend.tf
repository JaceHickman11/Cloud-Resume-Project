terraform {
  backend "s3" {
    bucket         = "terraform-state-jacehickman"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
