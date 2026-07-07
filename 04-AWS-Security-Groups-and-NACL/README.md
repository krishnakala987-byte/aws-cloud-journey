# AWS Security Groups and NACL – Complete Guide

This is the security part of VPC. After learning how traffic enters a VPC, the next question is who actually decides whether a packet reaches my application. The answer is these two layers, Security Groups and NACLs. This document covers both in depth, plus how they interact.

---

# 1. Where these two sit in the architecture

Traffic coming from the internet passes through layers in this order:

1. Internet Gateway (entry to the VPC)
2. Route table (decides the path to the subnet)
3. NACL (guard at the subnet boundary)
4. Security Group (guard at the instance)
5. The application itself

So NACL is checked first, Security Group second. Both must allow the traffic for it to reach the app.

---

# 2. Security Groups

A Security Group is a virtual firewall at the instance level.

## Core properties

- Attached to the network interface of an instance (EC2, RDS, ALB, etc.)
- Controls both inbound and outbound traffic
- Stateful: if I allow a request in, the response is automatically allowed out. I never write rules for return traffic
- Allow rules only. There is no deny in a Security Group
- All rules are evaluated together. If any rule allows the traffic, it passes

## Default behaviour

- Inbound: everything blocked by default
- Outbound: everything allowed by default

This default is sensible: my app cannot be reached until I open a port, but my instance can immediately download updates.

## Rules

A rule has: protocol, port range, and source (for inbound) or destination (for outbound).

The source can be:
- A CIDR like 203.0.113.5/32 (one IP) or 0.0.0.0/0 (whole internet)
- Another Security Group. This is very powerful: "allow port 8000 only from the load balancer's SG" means only the ALB can reach my app, no matter what IPs are involved

## Points to remember

- One instance can have multiple Security Groups, rules get combined
- One Security Group can be attached to many instances
- Changes apply immediately, no restart needed
- Port 25 (SMTP) outbound is blocked by AWS by default to prevent spam

---

# 3. NACL (Network Access Control List)

A NACL is a firewall at the subnet level. It protects every instance inside that subnet at once.

## Core properties

- Stateless: inbound and outbound are checked separately. If I allow a request in, I must also allow the response out, otherwise it dies on the way back
- Supports both allow and deny rules. This is the only place I can explicitly block a specific IP
- Rules are numbered and evaluated from the lowest number up. The first match wins and evaluation stops
- Every rule list ends with an invisible * rule that denies everything not matched above

## Default NACL vs custom NACL

- The default NACL that comes with a VPC allows all inbound and all outbound. That is why beginners never notice NACLs exist
- A custom NACL I create starts with deny everything, and I add rules on top

## The ephemeral ports trap

This is the classic NACL mistake, and it comes from statelessness.

When a client connects to my server on port 80, the response goes back to a random high port on the client side (1024 to 65535, called ephemeral ports). Since NACL does not track connections, my outbound rules must allow that ephemeral range, otherwise responses never leave the subnet even though the inbound rule was fine.

## Points to remember

- One NACL per subnet, but one NACL can cover many subnets
- Leave gaps in rule numbers (100, 200, 300) so rules can be inserted later
- A deny rule with a lower number beats an allow rule with a higher number

---

# 4. Security Group vs NACL comparison

| | Security Group | NACL |
|---|---------------|------|
| Operates at | Instance level | Subnet level |
| State | Stateful | Stateless |
| Rule types | Allow only | Allow and Deny |
| Rule evaluation | All rules together | By number, first match wins |
| Return traffic | Automatic | Must be explicitly allowed |
| Default (AWS created) | Inbound blocked, outbound open | Everything allowed |
| Typical use | Day to day app security | Subnet wide guardrails, blocking bad IPs |

This table is asked in interviews constantly, especially stateful vs stateless.

---

# 5. Shared responsibility

One thing I noted from this class: AWS gives the infrastructure and the default configurations, but configuring the rules correctly is my job. If I open port 22 to the whole world and something goes wrong, that is on me, not on AWS.

In real companies, NACLs are often controlled by a central security or network team as an organisation wide guardrail, while application teams manage their own Security Groups.

---

# 6. When to use which

- Allow my application traffic: Security Group
- Block one abusive IP address: NACL (SGs cannot deny)
- Protect a whole subnet regardless of what instances get launched in it: NACL
- Allow traffic only from the load balancer: Security Group referencing the ALB's SG

They are not alternatives. Production uses both together.

---

# 7. Mistakes to avoid

- Confusing stateful with stateless. This is also a very common interview question
- Adding an allow rule in the Security Group and forgetting that the NACL might still be blocking it
- Forgetting ephemeral ports in custom NACL outbound rules
- Leaving 0.0.0.0/0 open on ports that do not need it
- Opening SSH (22) to the world instead of to my own IP

---

# Key takeaway

Security Group is the guard at the house, NACL is the guard at the street. Both must agree before traffic reaches the application, and the NACL always gets asked first.

## Notes in this folder

- SG-vs-NACL-practical.md (hands-on test proving NACL deny overrides SG allow)
