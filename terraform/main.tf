# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/
# terraform init - initalizes, must be ran from where main.tf exists
# terraform apply - apply the configurations, only changes what's required
# terraform show - show details of a created resource
# terraform destroy - destroys the configuration

# Variables:
    # Inputs:
        # variables.tf 
    # Outputs:
        # outputs.tf 
        # Query resources and return values back
        # terraform output - query outputs.tf


# 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.69.0"
    }
  }
}

provider "aws" {
    region = "us-east-2"
}

# data blocks only access the resource
data "aws_s3_bucket" "my_bucket" {
    bucket = "jacehickman.com"
}

data "aws_cloudfront_distribution" "my_distribution" {
    id = "E3EERE5S6HGZEH"
}

data "aws_route53_zone" "dns" {
    name = "jacehickman.com"
}

data "aws_dynamodb_table" "visitor_table" {
    name = "VisitorTable"
}

data "aws_api_gateway_rest_api" "api" {
    name = "CloudResumeAPI"
}

data "aws_lambda_function" "lambda_python" {
    function_name = "updateItem"
}