# Cloud Resume Project

This project was completed as part of the [Cloud Resume Challenge](https://cloudresumechallenge.dev/docs/the-challenge/aws/), which aims to showcase a well-rounded skillset in cloud infrastructure, automation, and web development.

You can view the live site here: [https://jacehickman.com](https://jacehickman.com)

---

## Project Overview

This repository contains both the **frontend** and **backend** code for my personal website. 
The goal of the project was to leverage AWS services to build a serverless, scalable, and automated resume website
entirely managed through code and CI/CD pipelines.

---

## AWS Services Used

- **S3**  
  Hosts static website files (HTML, CSS, JS)
  (see `web_files/*`)

- **Route 53**  
  DNS service to route requests to the hosted domain, the domain was also purchased with this

- **CloudFront**  
  Content delivery, it ensures web content is provided from AWS edge locations close to the user
  I don't have to deploy my site in many places

- **AWS Certificate Manager (ACM)**  
  Issues SSL/TLS certificates to support HTTPS

- **API Gateway**  
  REST API for frontend-to-backend communication
  I send a POST request here to trigger a function in Lambda

- **Lambda**  
  Serverless function triggered by API Gateway
  Accesses a table in DynamoDB, increments the count, and reports the new value back
  (see `aws_files/lambda_function.py`)

- **DynamoDB**  
  Stores the Page Views: count displayed on the site
  The Lambda function updates this table on each visit

---

## 🛠️ Infrastructure as Code (IaC)

The backend infrastructure (The AWS services described above) is managed using **Terraform**.  
Check out [`terraform/main.tf`](./terraform/main.tf) for the full deployment configuration.

---

## ⚙️ CI/CD with GitHub Actions

Deployment is fully automated using GitHub Actions:

- **Frontend** is deployed to S3 and invalidates CloudFront caches
- **Backend** is deployed using Terraform

Workflows are triggered automatically when changes are made to:

- `.github/workflows/`
- `/terraform`
- `/web_files`

---

## 📝 Learn More

Want to learn more about how this all came together?  
Check out the live [site](https://jacehickman.com) or read my [blog post](https://jacehickman.com) about the project!  
Thanks for visiting!

