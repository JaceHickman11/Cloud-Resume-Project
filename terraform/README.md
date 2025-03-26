# Terraform Deployment – Cloud Resume Infrastructure

This project uses a two-phase Terraform deployment pattern to ensure the backend (S3 + DynamoDB for state management) is bootstrapped before applying the full infrastructure.

---

## Bootstrap Phase (Local)

> Use this phase **only if your Terraform state backend doesn't exist**
> - First-time deployment
> - After destroying all infrastructure
> - When setting up a new environment (e.g., staging, dev)

### Structure
```bash
terraform/
├── aws/        # Full infrastructure (CloudFront, Lambda, S3, etc.)
├── local/      # Bootstrap phase – creates tfstate S3 bucket & DynamoDB lock table
└── README.md   # This file

```bash
cd terraform/local
terraform init
terraform plan
terraform apply
cd terraform/aws
terraform init -reconfigure
terraform plan
terraform apply
aws s3 sync ./web_files s3://jacehickman.com --delete
