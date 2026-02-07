# Introduction to Amazon EKS

## What is Amazon EKS

Amazon Elastic Kubernetes Service (EKS) is a fully managed Kubernetes service provided by AWS. It allows users to run Kubernetes clusters without managing the Kubernetes control plane. AWS takes care of running, scaling, securing, and maintaining critical components such as the API server, etcd, scheduler, and controller manager.

This enables engineers to focus more on application deployment and infrastructure design rather than cluster maintenance.

---

## Why Kubernetes is Used

Kubernetes is used to manage containerized applications at scale. It provides:

- Automated application deployment and rollback
- Self-healing capabilities
- Horizontal scaling
- Service discovery and load balancing
- Configuration and secret management

These features make Kubernetes the standard orchestration platform in modern cloud environments.

---

## Why Amazon EKS

Amazon EKS is preferred in production environments because:

- The control plane is fully managed by AWS
- High availability is built-in across multiple availability zones
- Native integration with AWS IAM and VPC
- Secure and scalable by default
- Compatible with standard Kubernetes tools

---

## EKS Core Components

### Control Plane
Managed entirely by AWS and includes:
- Kubernetes API Server
- etcd datastore
- Scheduler and controllers

### Worker Nodes
EKS supports:
- EC2-based worker nodes
- AWS Fargate (serverless pods)

In this project, AWS Fargate was used to reduce node management complexity.

---

## Networking in EKS

- EKS runs inside an AWS VPC
- Pods receive IPs from the VPC CIDR
- Services handle internal traffic
- Ingress integrates with AWS Load Balancers for external access

---

## IAM and Security in EKS

EKS integrates deeply with AWS IAM:
- IAM controls authentication to the cluster
- Kubernetes RBAC controls in-cluster permissions
- IRSA allows pods to securely access AWS services with least privilege

---

## EKS vs Self-Managed Kubernetes

| Aspect | Self-Managed | Amazon EKS |
|------|--------------|------------|
| Control Plane | User-managed | AWS-managed |
| Availability | Manual | Built-in |
| Security Patching | Manual | AWS-managed |
| IAM Integration | External | Native |
| Operational Overhead | High | Low |

---

## Why EKS is Important

EKS combines Kubernetes flexibility with AWS reliability. Understanding EKS is essential for modern DevOps and cloud engineering roles.

---
