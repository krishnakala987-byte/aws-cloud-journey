# AWS Production VPC Project

This folder documents a hands-on project where I built the kind of VPC setup that is actually used in production, with public and private subnets across two Availability Zones.

Until this point every topic was mostly individual pieces. This project connects VPC, subnets, NAT Gateway, Auto Scaling, Bastion host and Load Balancer into one working architecture.

## Architecture in short
- One custom VPC
- Two Availability Zones for high availability
- Public subnets: hold the Application Load Balancer and the NAT Gateway
- Private subnets: hold the application EC2 instances, no direct internet access
- Auto Scaling Group launching instances across both AZs
- Bastion host in the public subnet for SSH access to private instances

## Why this design
- The application servers are never exposed to the internet directly. Only the load balancer is public.
- If one AZ has a problem, the other AZ keeps serving traffic.
- NAT Gateway lets the private instances download updates while hiding their IPs.
- The Bastion host is the single controlled door for administration.

## Outcome
The Python web application running on a private instance was reachable through the load balancer URL from my browser. The instance itself has no public IP at all, which was the whole point of the exercise.

## Assignment I gave myself
Deploy the app on both instances with slightly different pages and refresh the load balancer URL to actually see load balancing switch between them.

## Notes in this folder
- Implementation-steps.md
