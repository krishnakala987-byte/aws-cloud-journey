# Amazon Elastic Container Registry (ECR) – Concepts & Reference

## What is Amazon ECR?

Amazon Elastic Container Registry (ECR) is a **fully managed container image registry service** provided by AWS. It is used to store, manage, and distribute Docker and OCI-compliant container images securely.

The term **Elastic** indicates that the service automatically scales to handle any number of images without requiring capacity planning.

---

## Why ECR is Used

* Secure storage of container images
* Centralized image management for teams
* Native integration with AWS services
* IAM-based authentication and authorization
* High availability and scalability

---

## Core Components of ECR

* **Repository**: Logical container for images
* **Image**: Built Docker/OCI image
* **Tag**: Human-readable identifier (e.g., latest, v1)
* **Digest**: Immutable SHA identifier
* **Registry**: Regional endpoint hosting repositories

---

## ECR vs Docker Hub

| Feature           | Amazon ECR | Docker Hub          |
| ----------------- | ---------- | ------------------- |
| Provider          | AWS        | Docker Inc.         |
| Default Access    | Private    | Public              |
| Authentication    | AWS IAM    | Username / Password |
| AWS Integration   | Native     | External            |
| Security Scanning | Built-in   | Limited             |
| Rate Limits       | No         | Yes                 |
| Production Ready  | Yes        | Limited             |

---

## Why Organizations Prefer ECR

* Uses existing AWS IAM users and roles
* No separate credentials for registry access
* Better security for private images
* Faster access from AWS compute services
* Reduced dependency on third-party services

---

## Authentication Model

ECR uses **temporary authentication tokens** generated via AWS CLI:

```bash
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
```

These tokens expire after a fixed duration and must be refreshed periodically.

---

## Security Features

* IAM policy-based access control
* Private repositories by default
* Optional image tag immutability
* Automated vulnerability scanning on push

---

## Important Notes

* ECR is a **storage service**, not a runtime
* Images must be executed using Docker, ECS, or Kubernetes
* Authentication is environment-specific (shell and user dependent)

---

## When to Use Docker Hub vs ECR

* **Docker Hub**: Learning, testing, public images
* **Amazon ECR**: Production workloads on AWS

---

This file is intended to be a **long-term reference** for understanding Amazon ECR in depth.
