# Terraform AWS Infrastructure Project

This repository contains an end-to-end Infrastructure as Code (IaC) implementation using Terraform to provision AWS resources.

The goal of this project was to design and implement a production-style cloud architecture including networking, compute, and load balancing components using Terraform.

This is not a basic tutorial project. It includes real-world debugging scenarios, infrastructure lifecycle management, and best practices for cloud cost control.

---

## Project Roadmap

The project was built following this structured roadmap:

### Phase 1 – Core Infrastructure
- Configure AWS provider
- Create custom VPC
- Create public subnets
- Configure Internet Gateway
- Setup route tables

### Phase 2 – Compute Layer
- Launch EC2 instances
- Configure Security Groups
- Deploy web server using user data
- Validate public accessibility

### Phase 3 – Load Balancing Layer
- Create Application Load Balancer (ALB)
- Create Target Groups
- Attach EC2 instances
- Configure Listener
- Output Load Balancer DNS

### Phase 4 – Infrastructure Lifecycle
- Apply Terraform
- Debug DNS and provider issues
- Manage partial state scenarios
- Perform safe resource destruction

### Phase 5 – Documentation & Optimization
- Repository structuring
- Security review
- Cost management validation
- Project publishing

---

This project demonstrates practical cloud engineering skills including infrastructure design, debugging, cost awareness, and clean teardown practices.
