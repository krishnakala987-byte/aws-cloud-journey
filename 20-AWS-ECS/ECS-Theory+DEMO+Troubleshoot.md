# AWS ECS – Complete Notes 

These notes are based on **| AWS ECS | ECS vs EKS vs Kubernetes**  along with hands-on practice and real troubleshooting performed during the demo.

---

## 1. Why Container Orchestration Exists

### From Docker to Orchestration

* Docker solves **container packaging and lifecycle**.
* Docker alone does **not** provide:

  * Auto-healing
  * Auto-scaling
  * High availability
* In real-world production, applications must:

  * Survive failures
  * Scale during traffic spikes

This gap led to **Container Orchestration Engines (COE)** such as:

* Kubernetes
* AWS ECS

---

## 2. ECS vs EKS vs Kubernetes

### ECS (Elastic Container Service)

* AWS-managed container orchestration service
* Deep AWS integration
* Task Definitions are AWS-specific
* Simple setup and operations
* Best for teams fully on AWS

### Kubernetes (Generic)

* Open-source orchestration platform
* Cloud-agnostic (AWS, Azure, GCP, on‑prem)
* Large ecosystem and community
* Advanced features like CRDs, operators, service mesh

### EKS (Elastic Kubernetes Service)

* AWS-managed Kubernetes
* Combines Kubernetes flexibility with AWS infrastructure
* More operational complexity than ECS

### Key Comparison

| Feature             | ECS     | EKS     | Kubernetes |
| ------------------- | ------- | ------- | ---------- |
| Managed by AWS      | Yes     | Yes     | No         |
| Cloud portability   | No      | Partial | Yes        |
| Complexity          | Low     | Medium  | High       |
| Community ecosystem | Limited | Large   | Very large |
| CRDs / Service Mesh | No      | Yes     | Yes        |

---

## 3. ECS Compute Options

### EC2 Launch Type

* You manage EC2 instances
* Responsible for:

  * Patching
  * Scaling
  * Capacity planning

### AWS Fargate (Used in Demo)

* Serverless containers
* No EC2 management
* Pay only for CPU & memory used
* Ideal for learning and production

---

## 4. ECS Core Architecture

### Cluster

* Logical grouping of tasks and services

### Task Definition

* Blueprint describing:

  * Container image
  * CPU & memory
  * Port mappings
  * Environment variables

### Task

* Running instance of a task definition

### Service

* Maintains desired number of tasks
* Integrates with load balancers

---

## 5. Hands‑On Demo Flow

### Application

* Python Flask application
* Source: **AWS DevOps Zero to Hero – Day 21** repository

### Dockerfile

* Base image: python:3.9
* Exposes port 3000
* Runs Flask app

---

## 6. Amazon ECR (Elastic Container Registry)

### Steps Performed

1. Create private ECR repository
2. Authenticate Docker to ECR
3. Build Docker image
4. Tag image correctly
5. Push image to ECR

### Common Mistakes Faced

* Missing region in login command
* Wrong image tag format
* Image built locally but not tagged for ECR

### Correct Flow

* Build image with full ECR URI
* Verify using `docker images`
* Push exact tagged image

---

## 7. ECS Cluster & Task Setup

### Cluster Creation

* Launch type: **Fargate**
* Region: us-east-1

### Task Definition

* Container image: ECR image URL
* Memory & CPU configured
* Port mapping: 3000

### Running the Task

* Task launched in ECS cluster
* Logs checked via CloudWatch

---

## 8. Real Errors Faced & Fixes

### 1. Docker not found in WSL

**Cause:** Docker Desktop WSL integration disabled or docker-desktop service stopped

**Fix:**

* Enable WSL integration in Docker Desktop
* Restart Docker Desktop

---

### 2. Docker build failed – invalid tag

**Cause:** Extra slash before `:latest`

**Fix:**

* Correct image tag format

---

### 3. ECR push failed – tag does not exist

**Cause:** Image not tagged with ECR URI

**Fix:**

* Retag existing image
* Push again

---

### 4. ECS Task stuck in PENDING

**Error Message:**

* Unable to pull image from ECR
* i/o timeout

**Root Cause:**

* Task running in private subnet
* No internet access
* Missing NAT Gateway or public IP

**Fix:**

* Use public subnet with auto‑assign public IP
* Or configure NAT Gateway

---

## 9. Networking Concepts Learned

### VPC CIDR for Practice

* Safe default: `10.0.0.0/16`
* Subnets: /24

### For Learning

* Use default VPC or public subnets
* Simplifies networking and avoids NAT costs

---

## 10. Key Takeaways

* ECS is ideal for AWS‑centric workloads
* Fargate removes infrastructure overhead
* Correct image tagging is critical
* Networking misconfiguration is the #1 ECS beginner issue
* Logs and error messages are the best debugging tools

---

## 11. When to Choose What

* **ECS:** Simple AWS workloads, faster delivery
* **EKS:** Kubernetes features + AWS ecosystem
* **Kubernetes:** Multi‑cloud, advanced control

---

