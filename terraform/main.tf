# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/
# terraform init - initalizes, must be ran from where main.tf exists
# terraform plan - show changes to be made by apply
# terraform apply - apply the configurations, only changes what's required
# terraform show - show details of a created resource
# terraform destroy - destroys the configuration
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

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "jacehickman.com.s3-website.us-east-2.amazonaws.com"
    origin_id = "jacehickman.com.s3-website.us-east-2.amazonaws.com"
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1.2"]
      origin_read_timeout = 30
      origin_keepalive_timeout = 5
    }
  }

  aliases = ["jacehickman.com", "www.jacehickman.com"]
  enabled         = true
  is_ipv6_enabled = true
  default_root_object = "resume.html"

  default_cache_behavior {
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    allowed_methods  = ["GET", "HEAD"]  
    cached_methods   = ["GET", "HEAD"]  
    target_origin_id = "jacehickman.com.s3-website.us-east-2.amazonaws.com"
    viewer_protocol_policy = "redirect-to-https" 
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400  
    compress = true
    forwarded_values {
      query_string = false 
      cookies {
        forward = "none" 
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
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


# IAM Role for Lambda Execution
resource "aws_iam_role" "table_role" {
  name = "VisitorCounter_Role"
  description = "Managed by Terraform. Allows Lambda functions to call AWS services on your behalf."
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_lambda_function" "updateItem_py" {
 function_name = "updateItem"  
  role = aws_iam_role.table_role.arn
  handler = "lambda_function.lambda_handler"
  runtime = "python3.10"
  filename         = "lambda.zip"  
  source_code_hash = filebase64sha256("lambda.zip") 

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.visitor_table.name  
    }
  }
}

# Commands to import my resources
# terraform import aws_s3_bucket.primary_bucket jacehickman.com
# terraform import aws_s3_bucket.www_bucket www.jacehickman.com
# terraform import aws_cloudfront_distribution.s3_distribution E3EERE5S6HGZEH
# terraform import aws_route53_zone.my_dns Z07797793UO05BKPV64D2
# terraform import aws_dynamodb_table.visitor_table VisitorTable
# terraform import aws_api_gateway_rest_api.api z3v2iubne2
# terraform import aws_lambda_function.updateItem_py updateItem
# terraform import aws_iam_role.table_role VisitorCounter_Role

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

data "aws_iam_role" "visitor_counter_role" {
  name = "VisitorCounter_Role" 
}