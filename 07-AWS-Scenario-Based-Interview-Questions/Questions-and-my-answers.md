# Questions and My Answers

Ten scenario questions on EC2, IAM and VPC. For each one I wrote the answer I would actually give, plus the reasoning, because interviewers almost always follow up with "why".

---

## 1. Design a highly available and scalable 2-tier application

Put the load balancer in public subnets and the application servers in private subnets, spread across at least two Availability Zones. Use an Auto Scaling Group so instances are added or removed with traffic.

Why each piece:
- Private subnets: app servers should never be directly reachable from the internet
- Two AZs: survives a data center failure
- ASG: handles both scaling and self healing (replaces failed instances)
- ALB: the single public entry point, also does health checks

This is exactly the production VPC project in folder 06, so I can describe it from my own build.

## 2. Restrict outbound internet access for one subnet only

Change the route table of that subnet. Remove the route that points 0.0.0.0/0 to the Internet Gateway or NAT Gateway.

Key point to say in the interview: route tables are per subnet, so other subnets are not affected. This is also why route tables, not subnets themselves, decide what is public or private.

## 3. Private instances need to download software updates. How?

Place a NAT Gateway in a public subnet and add a 0.0.0.0/0 route from the private subnet to it.

The NAT Gateway performs address translation, so instances get outbound internet for downloads but nobody outside can start a connection inward. Worth adding: NAT is outbound only, and for production you keep one NAT Gateway per AZ so one AZ failure does not cut internet for the others.

## 4. How do two instances communicate inside a VPC? Across VPCs?

Inside the same VPC they simply use private IP addresses, because every route table has the automatic local route covering the whole VPC CIDR.

Across two VPCs, set up VPC Peering and update the route tables on both sides. Two gotchas worth mentioning: the CIDRs must not overlap, and peering is not transitive (A-B and B-C peering does not give A-C).

## 5. How do you add a subnet level security layer?

Use a Network ACL. It applies to the entire subnet, so every instance inside gets that protection automatically, including instances launched later. Unlike Security Groups it can explicitly deny traffic, so it is also the answer for blocking a specific bad IP.

## 6. A workload is sensitive and must be fully isolated

Put it in a subnet whose route table has no route to any gateway. No Internet Gateway, no NAT. The subnet can then only talk within the VPC.

If it still needs to reach AWS services like S3, that is what VPC Endpoints are for, no internet path required.

## 7. An instance needs to reach S3 without going over the internet

Use a VPC Endpoint. A Gateway Endpoint for S3 adds an entry in the route table so traffic to S3 stays inside the AWS network.

Extra points in an interview: Gateway Endpoints (S3, DynamoDB) are free, Interface Endpoints (most other services) are billed hourly. Endpoints also cut NAT Gateway data charges for S3 heavy workloads.

## 8. Difference between NACL and Security Group?

- NACL: subnet level, stateless, supports allow and deny, evaluates rules by number with first match winning
- Security Group: instance level, stateful, allow rules only, all rules evaluated together

Stateful means return traffic is automatically allowed. Stateless means I must open both directions myself, including the ephemeral port range for responses. That ephemeral ports detail usually separates people who have actually configured a NACL from people who memorised the table.

## 9. What are IAM Users, Groups, Policies and Roles?

- Users: identities for people, with long term credentials
- Groups: collections of users so permissions are managed once for a team
- Policies: the JSON documents that define the actual permissions (effect, action, resource)
- Roles: permissions for services or temporary identities. An EC2 instance that needs S3 access gets a role, not access keys

The line interviewers like: humans get users, services get roles, and nobody hardcodes access keys on an instance.

## 10. How do you SSH into instances that live in a private subnet?

Through a Bastion host, also called a jump server. It is a small instance in the public subnet. I SSH to the Bastion first and from there to the private instance over its private IP.

Hardening points worth adding: the Bastion SG allows port 22 only from my IP, the private instance SG allows 22 only from the Bastion SG, and the private instances never need public IPs at all. In my project (folder 06) I set up exactly this chain.

---

# How I use this file

Before an interview I cover the answer, read only the question, and say the answer out loud. If I cannot explain the why behind a design, I go back and rebuild that part hands-on.
