# ☁️ Enterprise-Grade AWS Infrastructure as Code (IaC)

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Security](https://img.shields.io/badge/Security-Hardened-green?style=for-the-badge)

## 🚀 Project Overview
This repository contains a fully automated, production-ready AWS infrastructure provisioned via **Terraform**. The project demonstrates advanced networking, multi-layered security protocols, and automated resource bootstrapping, managing a total of **34 distinct AWS resources**.

The core objective is to host a secure Nginx web service within a private subnet, adhering to the **Principle of Least Privilege (PoLP)**.

## 🏗 Architectural Design
The infrastructure is built on a custom VPC across multiple Availability Zones, featuring:

* **Network Isolation:** * **Public Subnets:** Hosting a **Bastion Host** (Jump Box) for secure administrative access.
    * **Private Subnets:** Isolated environment for the **Nginx EC2 instance**, ensuring no direct exposure to the public internet.
* **Layered Security (Defense in Depth):**
    * **Network ACLs (NACLs):** Stateless filtering at the subnet level with explicit rules (Allow/Deny).
    * **Security Groups:** Stateful firewalling (e.g., Nginx allows SSH only from the Bastion Host).
* **Automated Provisioning:**
    * **NAT Gateway:** Provides secure outbound internet access for private instances (for updates and S3 pulls).
    * **User Data Scripting:** Automated installation and configuration of Nginx and AWS CLI upon launch.
* **IAM Integration:** * EC2 uses an **IAM Instance Profile** with a scoped-down Read-Only policy to pull web content from an **S3 Bucket** (no static credentials used).

## 🛠 Tech Stack & Tools
* **IaC Engine:** Terraform `~> 1.14.0`
* **Cloud Provider:** AWS (Provider `~> 5.0`)
* **Operating System:** Ubuntu 22.04 LTS (Jammy)
* **Storage:** Amazon S3 (with Versioning & Force Destroy enabled)
* **Network:** VPC, NAT Gateway, Elastic IP, NACL, SG.



## 📁 Project Structure
* `providers.tf`: Terraform/Provider version pinning and Global Resource Tagging.
* `02-security.tf`: Comprehensive NACL and Security Group rules.
* `03-s3.tf`: S3 Bucket provisioning with Randomized naming and Versioning.
* `04-iam.tf`: IAM Roles, Trust Policies, and Instance Profiles.
* `05-servers.tf`: AMI Data Sources, Bastion Host, and Nginx EC2 (Private).
* `outputs.tf`: Exposure of critical infrastructure metadata (EIP, Bastion IP, Private IP).

## 🔧 Deployment Guide
To replicate this infrastructure, follow these steps:

1.  **Initialize:**
    ```bash
    terraform init
    ```
2.  **Validate & Plan:**
    ```bash
    terraform validate
    terraform plan -var-file="production.tfvars"
    ```
3.  **Execute:**
    ```bash
    terraform apply -auto-approve
    ```

## 📊 Infrastructure Visualization
To ensure logical consistency and audit resource dependencies, I generated a visual representation of the stack using `terraform graph`.

**Key Insights from the Graph:**
* **Cyclic Dependency Check:** Verified that all 34 resources follow a clean, directed acyclic graph (DAG).
* **Network-to-Compute Flow:** Clearly shows the VPC and Subnets provisioning before EC2 instances.
* **Security & IAM Mapping:** Illustrates how IAM profiles and S3 bucket policies are coupled with the private Nginx nodes.
* **VPC Endpoints:** Displays the private routing path for S3 access, bypassing the public internet for enhanced security.

---
## 🗺️ Roadmap & Future Enhancements
- [ ] **Load Balancing:** Implementing an Application Load Balancer (ALB) for high availability.
- [ ] **Auto-Scaling:** Configuring ASG to handle traffic spikes.
- [ ] **State Management:** Migrating the local `terraform.tfstate` to a remote S3 backend with DynamoDB locking.
- [ ] **Monitoring:** Integrating CloudWatch alarms for EC2 health checks.

---
**Author:** R-Kx
**Status:** Managed by Terraform. Production-ready IaC.
