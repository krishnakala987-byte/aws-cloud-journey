# Project Architecture

## Architecture Overview

This project follows a standard Kubernetes architecture deployed on AWS EKS.

---

## Traffic Flow

1. User sends an HTTP request
2. Request reaches AWS Application Load Balancer
3. ALB forwards traffic to Kubernetes Ingress
4. Ingress routes traffic to a Service
5. Service forwards traffic to application Pods

---

## Key Components

### Amazon EKS
Provides a managed Kubernetes control plane.

### AWS Fargate
Runs Kubernetes pods without managing EC2 worker nodes.

### AWS Load Balancer Controller
- Watches Ingress resources
- Automatically provisions Application Load Balancers
- Manages listeners and target groups

### Kubernetes Service
Acts as an internal load balancer for Pods.

### Pods
Run the application containers.

---

## Networking Design

- VPC-based networking
- Public subnets for ALB
- Private networking for pods
- Secure traffic routing using Kubernetes primitives

---
