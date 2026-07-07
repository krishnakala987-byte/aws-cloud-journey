# AWS VPC – Complete Guide

This document covers everything I learned about Virtual Private Cloud, from the basic idea to the full traffic flow of a production setup. Networking scared me the most in AWS, so I wrote this in the simplest possible words for revision.

---

# 1. What is a VPC?

A VPC (Virtual Private Cloud) is my own private, isolated network inside AWS.

Whatever I launch (EC2, RDS, load balancers) lives inside this network, and nothing outside can touch it unless I explicitly allow it.

## The gated community analogy

- The community itself is the VPC. Nobody from outside can walk in directly.
- Individual houses are the EC2 instances.
- Streets inside the community are the subnets.
- The main gate is the Internet Gateway.
- The security guard at each house is the Security Group.

Once this picture was clear in my head, every component made sense.

---

# 2. Why VPC exists

Earlier, if everyone's servers sat in one shared network, a problem or attack on one user could affect others. No serious company would accept that.

So AWS gives every account isolated virtual networks:

- Complete isolation from other AWS customers
- Full control over IP ranges, subnets and routing
- The ability to keep some resources public and others fully private

---

# 3. CIDR and VPC size

The size of a VPC is decided by the CIDR block I assign to it.

- CIDR example: 10.0.0.0/16
- The /16 means the first 16 bits are fixed, the rest are available
- 10.0.0.0/16 gives around 65,536 IP addresses
- 10.0.0.0/24 gives 256 IP addresses

Smaller number after the slash = bigger network.

## Points to remember about CIDR

- VPC CIDR can be between /16 (largest) and /28 (smallest)
- AWS reserves 5 IP addresses in every subnet (first 4 and the last one), so a /24 subnet really gives 251 usable IPs
- Use private IP ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
- Plan the CIDR before creating anything. Changing it later is painful

As a DevOps engineer, the practical job is to take one big block and divide it into smaller subnets per project or team.

---

# 4. Subnets

A subnet is a smaller slice of the VPC CIDR that lives in exactly one Availability Zone.

## Public subnet

- Its route table has a route to the Internet Gateway
- Resources here can be reached from the internet (if their SG allows)
- Typically holds: load balancers, NAT Gateway, Bastion host

## Private subnet

- No direct route to the Internet Gateway
- Cannot be reached from the internet at all
- Typically holds: application servers, databases

Important: a subnet is not public or private by itself. The route table attached to it is what decides.

---

# 5. Internet Gateway (IGW)

- The entry and exit point between the VPC and the internet
- Attached to the VPC, one IGW per VPC
- Without it, nothing inside the VPC can talk to the outside world
- Highly available by default, I do not manage or scale it

---

# 6. Route Tables

Route tables decide where network traffic goes. Every subnet must be associated with exactly one route table.

Example of a public subnet route table:

| Destination | Target | Meaning |
|-------------|--------|---------|
| 10.0.0.0/16 | local | traffic inside the VPC stays inside |
| 0.0.0.0/0 | igw-xxxx | everything else goes to the internet |

Example of a private subnet route table:

| Destination | Target | Meaning |
|-------------|--------|---------|
| 10.0.0.0/16 | local | traffic inside the VPC stays inside |
| 0.0.0.0/0 | nat-xxxx | outbound internet goes through NAT |

The local route is created automatically and cannot be deleted. This is why any two instances in the same VPC can always talk over private IPs.

---

# 7. NAT Gateway

This one confused me at first, so in plain words:

Instances in a private subnet still need to download packages, patches and updates from the internet. But we do not want the internet to reach them.

A NAT Gateway solves exactly this:

- It sits in the public subnet
- Private instances send outbound traffic to it
- It performs Network Address Translation, replacing the private IP with its own Elastic IP
- Responses come back through it, but no one outside can start a connection inward

## Points to remember about NAT

- NAT Gateway allows outbound only, never inbound
- It is charged per hour plus per GB of data, so delete it after practice
- For high availability, production setups keep one NAT Gateway per AZ
- NAT instance (an EC2 doing the same job) is the old way, NAT Gateway is managed and preferred

---

# 8. Security layers inside a VPC

Two layers protect the resources. Full details are in folder 04, but the summary:

| | Security Group | NACL |
|---|---------------|------|
| Level | Instance | Subnet |
| State | Stateful | Stateless |
| Rules | Allow only | Allow and Deny |
| Evaluation | All rules checked | By rule number, lowest first |

Traffic entering a subnet hits the NACL first, then the Security Group of the instance.

---

# 9. VPC Endpoints

Normally, if a private instance wants to reach S3, traffic would need a NAT Gateway and would travel toward public endpoints.

A VPC Endpoint lets the instance reach AWS services privately, without internet:

- Gateway Endpoint: for S3 and DynamoDB, works through a route table entry, free
- Interface Endpoint: for most other services, creates a network interface in my subnet, billed hourly

This is both cheaper and more secure for heavy S3 traffic.

---

# 10. VPC Peering

Two VPCs can be connected so instances communicate over private IPs.

- Works across accounts and across regions
- CIDR ranges of the two VPCs must not overlap
- Peering is not transitive: if A is peered with B and B with C, A still cannot talk to C directly

---

# 11. VPC Flow Logs

Flow logs record metadata about the traffic moving in the VPC (source, destination, port, accept or reject).

- Can be enabled at VPC, subnet or network interface level
- Logs go to CloudWatch Logs or S3
- The tool I would reach for when something is unreachable and SG/NACL rules look correct

---

# 12. How a request actually flows

This is how I remember the full picture:

1. A user on the internet sends a request to my application
2. The request enters through the Internet Gateway
3. It lands on the Load Balancer in the public subnet
4. The route table forwards it to the application instance in the private subnet
5. The NACL of that subnet checks it first
6. The Security Group of the instance takes the final decision
7. The response goes back along the same path

For outbound traffic from private instances (like downloading updates), the path is instance to NAT Gateway to Internet Gateway to internet.

---

# 13. Default VPC vs Custom VPC

- Every region comes with a default VPC so beginners can launch instances immediately
- In the default VPC all subnets are public, which is fine for learning and wrong for production
- Real projects always use a custom VPC with proper public and private separation

---

# 14. Things to remember

- A subnet lives in exactly one AZ. Spreading subnets across AZs is how we get high availability
- Route tables make a subnet public or private, not the subnet itself
- 5 IPs are reserved by AWS in every subnet
- NAT Gateway = outbound only, IGW = both directions
- Peering is not transitive
- Local route in every route table means all instances in a VPC can already talk to each other
- Non overlapping CIDRs matter the moment two networks need to connect

---

# Mistakes to avoid

- Creating a subnet and forgetting to associate the right route table
- Putting application servers in a public subnet just because it is easier
- Assuming a private instance can download packages without a NAT Gateway
- Giving two VPCs the same CIDR and then needing peering later

---

# Key takeaway

VPC is not one service, it is a set of small pieces working together: CIDR, subnets, IGW, route tables, NAT, SG, NACL. Learn each piece alone first, then the full picture becomes easy.
