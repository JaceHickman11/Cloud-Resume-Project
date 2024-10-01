# Cloud-Resume-Project
I'm taking on the Cloud Resume Challenge detailed here: https://cloudresumechallenge.dev/docs/the-challenge/aws/

This repository is the front-end code for my website: https://jacehickman.com

This website is hosted using Amazon Web Services. 
I am using this project to showcase my cloud administration skills. 

AWS Services utilized so far:
S3 - Hosts the web files HTML, CSS, and Javascript
Route 53 - DNS, route any http request to the https site. Purchase the domain with this service as well. 
CloudFront - Content delivery, it ensures web content is given to the user at the closest AWS edge location to them. 
AWS Certificate Manager - Certificate issuer so my website supports https
API Gateway - API creation to access AWS resources
DyanmoDB - The website has a "Page Views" in the top left. The current count is stored in a simple table using this service
Lambda - Serverless computing platform. I host the lambda_function.py here. When the site is loaded, Javascript sends a POST request to the API which triggers the Lambda function. The function accesses my table in DynamoDB, increments the "Page Views:" count, and reports the updated value to the website.

I'm currently focused on making this IaC using Terraform (Step 12). 

