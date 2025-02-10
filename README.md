# **Terraform AWS 3-Tier Architecture Deployment**

## **Overview**

This project deploys a **3-tier web application** in **AWS using Terraform**, with **separate state files** for different components:
- **VPC** (Networking)
- **RDS (PostgreSQL)**
- **Compute (Auto Scaling + Load Balancer)**

The infrastructure is automated using **GitHub Actions**, which deploys the resources whenever code is pushed to the `main` branch.

## **Arch Diagram**


![Threetireapplication](https://github.com/user-attachments/assets/935b3c77-5525-4a14-a728-2822fd92e0d1)

---

## **📂 Project Structure**
```bash
terraform-project/
├── .github/
│   ├── workflows/
│   │   ├── deploy.yml   # GitHub Actions for automatic deployment
│   │   ├── destroy.yml  # GitHub Actions for destroying infrastructure
├── vpc/                 # VPC and networking resources
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
├── rds/                 # PostgreSQL RDS instance
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
├── compute/             # EC2 instances, ALB, Auto Scaling Group
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
├── README.md            # Project documentation
```

---

## ** Folder Descriptions**
### **1 `.github/workflows/`**
Contains **GitHub Actions CI/CD workflows**:
- **`deploy.yml`**: Runs Terraform to deploy infrastructure on AWS
- **`destroy.yml`**: Destroys infrastructure manually when triggered

### **2 `vpc/` (Networking)**
Handles AWS **VPC, subnets, and networking components**.
- `main.tf`: Creates VPC, public/private subnets, internet gateway, and route tables
- `variables.tf`: Defines required variables
- `outputs.tf`: Outputs VPC details (e.g., `vpc_id`, `subnet_ids`)

### **3 `rds/` (PostgreSQL Database)**
Deploys an **AWS RDS PostgreSQL instance** in private subnets.
- `main.tf`: Creates the RDS instance
- `variables.tf`: Defines required variables
- `outputs.tf`: Outputs RDS endpoint
- `terraform.tfvars`: Stores database settings

### **4 `compute/` (Application Tier)**
Manages **EC2 instances, Load Balancer, and Auto Scaling**.
- `main.tf`: Creates Auto Scaling Group (ASG), ALB, and security groups
- `variables.tf`: Defines required variables
- `outputs.tf`: Outputs ALB DNS
- `terraform.tfvars`: Stores instance configuration

