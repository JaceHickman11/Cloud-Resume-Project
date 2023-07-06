# this prints the items in a table named VisitorCounter
# Placing for reference when coding updateitem.py

import json
import boto3

def lambda_handler(event, context):

    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('VisitorCounter')
    
    response = table.get_item(
        Key={
            'test_key': '1'
        }
    )
    item = response['Item']
    print(item)
