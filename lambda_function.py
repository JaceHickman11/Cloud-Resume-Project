# AWS Lambda function to track website visitor counter
# Handles CORS
# Reads current count from DynamoDB
# Increments counts
# Returns updated count as JSON
import json  # Handles JSON formatting
import boto3  # AWS SDK to talk to DynamoDB

def lambda_handler(event, context):
 
    try:
        # Print the entire event for debugging for CloudWatch logs
        print("Received event:", json.dumps(event, indent=2))

        # Handle CORS Preflight Requests
        if event.get('httpMethod') == 'OPTIONS':
            print("Handling CORS preflight request") 
            return {
                'statusCode': 200,
                'headers': {
                    'Access-Control-Allow-Origin': 'https://jacehickman.com',  
                    'Access-Control-Allow-Methods': 'OPTIONS,POST',  
                    'Access-Control-Allow-Headers': 'Content-Type'  
                },
                'body': json.dumps({'message': 'CORS preflight response'})  # Dummy response
            }

        # Connect to DynamoDB
        dynamodb = boto3.resource('dynamodb')  
        table = dynamodb.Table('VisitorTable')

        # Get the current visitor count from the table
        print("Fetching visitor count from DynamoDB...")
        response = table.get_item(Key={'visitor_id': 0})  
        item = response.get('Item')  
        print("DynamoDB response:", item)  

        # If visitor count exists, increment it
        if item:
            new_value = int(item['visitor_count']) + 1 
            table.update_item(
                Key={'visitor_id': 0},  
                UpdateExpression='SET visitor_count = :val',  
                ExpressionAttributeValues={':val': new_value}  
            )

        # If visitor count doesn't exist, create it with a value of 1
        else:
            print("No existing record found. Creating new visitor count...")
            new_value = 1
            table.put_item(Item={'visitor_id': 0, 'visitor_count': new_value})

        # Return the updated visitor count
        print("Returning updated count:", new_value)  
        return {
            'statusCode': 200,  
            'headers': {
                'Access-Control-Allow-Origin': 'https://jacehickman.com'  
            },
            'body': json.dumps({'Updated visitor_count': new_value}) 
        }

    except Exception as e:
        # Handle any unexpected errors
        print("Error:", str(e))  # Log the error
        return {
            'statusCode': 500,  
            'headers': {
                'Access-Control-Allow-Origin': 'https://jacehickman.com' 
            },
            'body': json.dumps({'Error': str(e)})  # Return error message
        }
