##Terraform AWS 3-Tier Architecture Deployment

Overview:
This project deploys a 3-tier web application in AWS using Terraform, with separate state files for different components:

VPC (Networking)
RDS (PostgreSQL)
Compute (Auto Scaling + Load Balancer)
The infrastructure is automated using GitHub Actions, which deploys the resources whenever code is pushed to the main branch.
