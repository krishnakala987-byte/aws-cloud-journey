# Amazon ECR

## About This Module

This module is part of my **AWS Zero to Hero** learning journey and focuses specifically on **Amazon Elastic Container Registry (ECR)**.

The purpose of this section is to document:

* What Amazon ECR is
* Why it is used in real-world systems
* How it compares with Docker Hub
* How container images are built and pushed to ECR

This README is intentionally concise and topic-focused. Detailed theory, comparisons, and hands-on troubleshooting are documented in separate files.

---

## Topics Covered

* Introduction to Amazon Elastic Container Registry (ECR)
* Core concepts of container registries
* ECR vs Docker Hub
* IAM-based authentication with ECR
* AWS CLI usage for ECR
* Docker image build, tag, and push workflow

---

## Repository Structure

```
Amazon-ECR/
│
├── README.md                  # Topic overview (this file)
├── ECR_CONCEPTS.md            # Deep dive: ECR concepts & comparison
├── ECR_HANDS_ON_DEMO.md       # Practical demo, errors & fixes
└── Dockerfile                 # Sample Dockerfile used in demo
```

---

## Learning Objective

The objective of this module is not only to understand Amazon ECR conceptually, but also to gain **practical experience** by performing real operations and resolving real errors that occur in production-like environments.

---

## Status

* Amazon ECR repository created
* Docker image built locally
* Image pushed successfully to ECR
* Image verified locally

---

This module serves as a solid foundation for future topics such as **Amazon ECS, EKS, Fargate, and CI/CD pipelines**.
