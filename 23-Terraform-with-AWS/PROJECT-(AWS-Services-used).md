# AWS Services Used in This Project

## 1. VPC (Virtual Private Cloud)
A logically isolated virtual network inside AWS.

Used to:
- Define private IP ranges
- Control traffic routing
- Segment infrastructure

---

## 2. Subnets
Subdivisions inside the VPC.

Used to:
- Distribute resources
- Enable high availability
- Separate public and private zones

---

## 3. Internet Gateway
Allows communication between the VPC and the internet.

---

## 4. Route Tables
Controls traffic routing inside the VPC.

---

## 5. Security Groups
Acts as a virtual firewall.

Used to:
- Allow HTTP traffic (port 80)
- Allow SSH traffic (port 22)
- Restrict access to required sources

---

## 6. EC2 Instances
Virtual machines in AWS.

Used to:
- Host web server
- Deploy application via user data script

---

## 7. Application Load Balancer (ALB)
Distributes traffic across multiple EC2 instances.

Benefits:
- High availability
- Fault tolerance
- Traffic distribution

---

## 8. Target Groups
Defines where the load balancer forwards traffic.

Includes:
- Health checks
- Port configuration
