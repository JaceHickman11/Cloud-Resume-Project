# Output blocks gets the resource out output contents to output.terraform 
# The intent here was to see what all my data is set as
output "s3_bucket_all" {
    value = jsonencode(data.aws_s3_bucket.my_bucket)
}

output "aws_cloudfront_all" {
    value = jsonencode(data.aws_cloudfront_distribution.my_distribution)
}

output "aws_route53_all" {
    value = jsonencode(data.aws_route53_zone.dns)
}

output "aws_dynamodb_table_all" {
    value = jsonencode(data.aws_dynamodb_table.visitor_table)
}

output "aws_api_gateway_rest_api_all" {
    value = jsonencode(data.aws_api_gateway_rest_api.api)
}

output "aws_lambda_function_all" {
    value = jsonencode(data.aws_lambda_function.updateItem_py)
}
