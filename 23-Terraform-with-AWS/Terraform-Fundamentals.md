# Terraform Fundamentals

## What is Terraform?

Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp. It allows engineers to define and provision infrastructure using declarative configuration files.

Instead of manually creating resources in the AWS console, Terraform enables infrastructure to be written as code.

---

## Why Terraform?

Terraform is used because:

- Infrastructure becomes version-controlled
- Environments are reproducible
- Manual errors are reduced
- Infrastructure changes are trackable
- It supports multi-cloud environments

---

## How Terraform Works

Terraform follows a lifecycle model:

### 1. Initialization
`terraform init`
- Downloads required providers
- Sets up backend
- Prepares working directory

### 2. Planning
`terraform plan`
- Compares desired state with current state
- Shows execution plan

### 3. Apply
`terraform apply`
- Creates or updates resources
- Stores state file

### 4. Destroy
`terraform destroy`
- Safely removes infrastructure
- Prevents unnecessary cost

---

## Terraform State

Terraform uses a state file (`terraform.tfstate`) to track resources it manages.

This file:
- Maps real AWS resources to Terraform configuration
- Enables change detection
- Must not be publicly exposed

---

## Terraform in AWS

Terraform interacts with AWS through the AWS Provider.

It communicates with AWS APIs to:
- Create VPCs
- Launch EC2 instances
- Configure Load Balancers
- Manage Security Groups
- Provision S3 resources

All actions are API-driven and automated.
