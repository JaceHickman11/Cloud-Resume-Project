#if API is accessed run script

#access DynamoDB

#increment database +1

#report new value to API

#visitor counter is updated on site

import boto3

try:
  update_item(
  Key={"VisitorCount"}
  )
  
