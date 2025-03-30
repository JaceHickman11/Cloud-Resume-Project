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

# destory infra
cd terraform/aws
terraform destroy -auto-approve
# expect many errors because terraform is destroying the state file and lock
# create the s3 state and lock table
cd ../local/
terraform init
terraform apply -auto-approve
# apply the entire infra
cd ../aws/
terraform init --reconfigure
terraform import aws_s3_bucket.tf_state terraform-state-jacehickman
terraform import aws_dynamodb_table.tf_lock terraform-locks
terraform import aws_cloudfront_distribution.s3_distribution EWQUVWWCU52WU
terraform apply -auto-approve


