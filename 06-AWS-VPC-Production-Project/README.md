# AWS Production VPC Project

This folder documents a hands-on project where I built the kind of VPC setup that is actually used in production, with public and private subnets across two Availability Zones.

Until this point every topic was mostly individual pieces. This project connects VPC, subnets, NAT Gateway, Auto Scaling, Bastion host and Load Balancer into one working architecture.

---

# 1. Architecture

```
                        Internet
                           |
                    Internet Gateway
                           |
        +------------------+------------------+
        |            (public subnets)         |
        |   AZ-1                       AZ-2   |
        |   ALB node                ALB node  |
        |   NAT Gateway                       |
        |   Bastion host                      |
        +------------------+------------------+
                           |
        +------------------+------------------+
        |           (private subnets)         |
        |   AZ-1                       AZ-2   |
        |   EC2 (app)               EC2 (app) |
        |        <- Auto Scaling Group ->     |
        +-------------------------------------+
```

## Components and their jobs

| Component | Placed in | Job |
|-----------|-----------|-----|
| Internet Gateway | VPC | entry and exit point for the VPC |
| Application Load Balancer | public subnets, both AZs | the only thing exposed to users |
| NAT Gateway | public subnet | outbound internet for private instances |
| Bastion host | public subnet | the single controlled door for SSH |
| Auto Scaling Group | private subnets, both AZs | keeps the right number of app instances |
| EC2 app instances | private subnets | run the application, no public IPs |

---

# 2. Why this design

- The application servers are never exposed to the internet directly. Only the load balancer is public
- Two AZs: if one data center has a problem, the other keeps serving traffic
- Auto Scaling replaces failed instances automatically and scales with load
- NAT Gateway lets the private instances download updates while hiding their IPs
- The Bastion host means SSH access happens through one auditable point, not through public IPs on every server

This exact pattern (2-tier, multi AZ, private app layer) is also the answer to the most common AWS interview scenario question, covered in folder 07.

---

# 3. Traffic flows in this setup

## User request (inbound)

Internet -> IGW -> ALB (public subnet) -> target group -> EC2 in private subnet -> response back the same way

## Instance downloading packages (outbound)

EC2 (private) -> route table 0.0.0.0/0 -> NAT Gateway (public) -> IGW -> internet

## Admin SSH

My laptop -> Bastion public IP (port 22, ideally only from my IP) -> private IP of the EC2 instance

---

# 4. Security group chain

Instead of opening ports to IP ranges, each SG references the previous one:

- ALB SG: allow 80 from 0.0.0.0/0
- App SG: allow 8000 only from the ALB SG, allow 22 only from the Bastion SG
- Bastion SG: allow 22 only from my IP

So even if someone learns a private IP, there is no path that skips the chain.

---

# 5. Outcome

The Python web application running on a private instance was reachable through the load balancer URL from my browser. The instance itself has no public IP at all, which was the whole point of the exercise.

With the app on only one instance at first, the ALB health checks marked the other target unhealthy and routed traffic only to the working one. Seeing that happen live made health checks click for me.

---

# 6. Assignment I gave myself

Deploy the app on both instances with slightly different pages and refresh the load balancer URL to actually see load balancing switch between them.

---

# 7. Cost warning

Three things in this project bill even when idle:

- NAT Gateway (per hour plus per GB)
- ALB (per hour)
- EC2 instances if not Free Tier

I deleted the whole setup right after the practice: ASG first (so it stops recreating instances), then ALB, then NAT Gateway, then the VPC.

---

## Notes in this folder

- Implementation-steps.md (full step by step build, plus the problems I hit)
