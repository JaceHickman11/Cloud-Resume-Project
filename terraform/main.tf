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

resource "aws_s3_bucket" "primary_bucket" {
    bucket = "jacehickman.com"
}

resource "aws_s3_bucket" "www_bucket" {
    bucket = "www.jacehickman.com"
}

# Needs way more stuff
resource "aws_cloudfront_distribution" "s3_distribution" {
    provider = aws
    default_cache_behavior {
      
    }
    enabled = true
    origin {
      
    }
    restrictions {
      
    }
    viewer_certificate {
    
    }

}

resource "aws_route53_zone" "my_dns" {
  name = "jacehickman.com"
}

resource "aws_dynamodb_table" "visitor_table" {
  name = "VisitorTable"
}

resource "aws_api_gateway_rest_api" "api" {
  name = "CloudResumeAPI"
}

resource "aws_lambda_function" "updateItem_py" {
  function_name = "updateItem"
}

# Commands to import my resources
# terraform import aws_s3_bucket.primary_bucket jacehickman.com
# terraform import aws_s3_bucket.www_bucket www.jacehickman.com
# terraform import aws_cloudfront_distribution.s3_distribution E3EERE5S6HGZEH
# terraform import aws_route53_zone.my_dns Z07797793UO05BKPV64D2
# terraform import aws_dynamodb_table.visitor_table VisitorTable
# terraform import aws_api_gateway_rest_api.api z3v2iubne2
# terraform import aws_lambda_function.updateItem_py updateItem

# data blocks only access the resource
# data "aws_resource type" "resource_reference"
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

data "aws_lambda_function" "updateItem_py" {
    function_name = "updateItem"
}
