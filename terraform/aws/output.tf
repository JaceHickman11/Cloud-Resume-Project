output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.id
}

output "api_invoke_url" {
  description = "API Gateway URL"
  value       = aws_api_gateway_stage.api_stage.invoke_url
}

output "api_id" {
  description = "API Gateway id"
  value       = aws_api_gateway_rest_api.api.id
}

output "api_root_id" {
  description = "API Gateway id"
  value       = aws_api_gateway_rest_api.api.root_resource_id
}

output "api_arn" {
  description = "API Gateway id"
  value       = aws_api_gateway_rest_api.api.execution_arn
}

