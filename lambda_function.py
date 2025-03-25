# This is the function placed into Lambda
# It's in /terraform/lambda.zip
# main.tf takes this and places the function into Lambda
    # See resource "aws_lambda_function" "updateItem_py" in main.tf

import json
import boto3

def lambda_handler(event, context):

    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('VisitorTable')
# Get the table item
    response = table.get_item(
        Key={
            'visitor_id': 0
        }
    )
    item = response.get('Item')
    
    if item:
# Increment visitor_count
        new_value = int(item['visitor_count']) + 1
        table.update_item(
            Key={
                'visitor_id': 0
            },
            UpdateExpression='SET visitor_count = :val',
            ExpressionAttributeValues={
# Set :val to new_value
                ':val': new_value
            }
        )
# Return the updated value
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
            },
            'body': json.dumps({'Updated visitor_count': new_value})
        }
# Return an error if item isn't found
    else:
        return {
            'statusCode': 404,
            'body': 'Item not found'
        }


