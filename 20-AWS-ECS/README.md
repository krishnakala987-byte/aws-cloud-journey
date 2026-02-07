# AWS ECS – Overview & Learning Scope

This repository documents my learning and hands-on practice of **Amazon Elastic Container Service (ECS)** along with a conceptual and practical comparison of **ECS vs EKS vs Kubernetes**.

## What this repository covers

### 1. Container & Orchestration Basics

* What containers are
* Why container orchestration is required
* Problems orchestration solves (scaling, networking, failures)

### 2. Amazon ECS – Core Concepts

* What ECS is and where it fits in AWS
* ECS components (Cluster, Task Definition, Task, Service)
* Launch types (EC2 vs Fargate)
* ECS networking basics

### 3. Amazon ECR (Elastic Container Registry)

* Why ECR is needed
* Building Docker images locally
* Tagging images correctly
* Pushing images to ECR

### 4. ECS Demo (Hands-on)

* Building a Docker image from a Flask app
* Pushing image to ECR
* Creating an ECS cluster
* Running a task using Fargate
* Understanding VPC, subnets, and public IP assignment

### 5. Troubleshooting & Real Errors Faced

* Docker build and tag errors
* ECR authentication issues
* ECS task stuck in PENDING
* Networking and VPC misconfiguration

### 6. ECS vs EKS vs Kubernetes

* High-level comparison
* When to use ECS
* When to use EKS
* When Kubernetes is preferred

---

This README is intentionally concise and acts as a **table of contents**.
For detailed explanations, diagrams-in-text, demos, commands, and troubleshooting, refer to the **detailed notes file** in this repository.
