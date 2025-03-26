output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.id
}

output "api_invoke_url" {
  description = "API Gateway URL"
  value       = aws_api_gateway_stage.api_stage.invoke_url
}
