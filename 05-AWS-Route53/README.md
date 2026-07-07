# AWS Route 53 – Complete Guide

Route 53 is the DNS service of AWS. The class itself was theory heavy, but the concept matters because almost every project after this uses a domain name somewhere. These notes cover DNS basics, every Route 53 component, record types and routing policies.

---

# 1. What is DNS?

DNS (Domain Name System) maps human friendly domain names to machine friendly IP addresses.

I can remember amazon.com. I cannot remember 205.251.242.103.

Without DNS:
- Users would need the IP of every server
- Every time an IP changed (which happens constantly in the cloud), everything would break
- Infrastructure could never be moved or scaled freely

DNS is basically the phonebook of the internet.

---

# 2. How a DNS lookup works (simplified)

1. I type example.com in the browser
2. The browser asks a DNS resolver (usually from the ISP)
3. The resolver walks down the chain: root servers, then .com servers, then the name servers of example.com
4. The name server returns the IP from its records
5. The browser connects to that IP

The answer gets cached along the way based on TTL, so repeat lookups are fast.

---

# 3. Why Route 53?

Managing DNS myself means running, patching and securing DNS servers. Route 53 is AWS's managed DNS:

- Highly available (the only AWS service with a 100 percent availability SLA)
- Scales automatically
- Integrates directly with AWS resources like load balancers and CloudFront
- The name comes from port 53, the port DNS runs on

---

# 4. Core components

## Domain registration

I can buy a domain directly in Route 53, or bring a domain purchased elsewhere (GoDaddy, Namecheap) by pointing its name servers to Route 53.

## Hosted zones

A hosted zone is the container where the DNS records of a domain live.

- Public hosted zone: answers queries from the internet, used for public websites
- Private hosted zone: attached to a VPC, resolves names only inside that VPC. Useful for internal service names like db.internal.company

## Records

The actual entries inside a hosted zone that do the mapping.

---

# 5. Record types I should know

| Type | Maps to | Notes |
|------|---------|-------|
| A | IPv4 address | the most common record |
| AAAA | IPv6 address | same as A but for IPv6 |
| CNAME | another domain name | cannot be used on the root domain |
| Alias | AWS resources (ALB, CloudFront, S3) | Route 53 special, works on root domain, free queries |
| MX | mail servers | for receiving email |
| TXT | text | domain verification, SPF |
| NS | name servers | who answers for this domain |

## Alias vs CNAME (interview favourite)

Both point a name at another name, but:
- CNAME is standard DNS, not allowed on the root domain (example.com), only on subdomains
- Alias is a Route 53 feature made for AWS targets, works on the root domain, and queries to it are free

Load balancer IPs change, so I never use A records with hardcoded IPs for an ALB. Always Alias.

---

# 6. TTL

Every record has a TTL (time to live) in seconds. Resolvers cache the answer that long.

- High TTL: fewer queries, cheaper, but changes take longer to spread
- Low TTL: changes propagate fast, more queries

Before a planned migration, the trick is to lower the TTL in advance so the switch is quick.

---

# 7. Routing policies

Route 53 is not just name to IP. It can decide which answer to give based on policy:

- Simple: one record, one answer. Default
- Weighted: split traffic by percentage, for example 90/10 for canary testing a new version
- Latency: send the user to the region with lowest latency for them
- Failover: primary and secondary. If the health check on primary fails, traffic moves to secondary
- Geolocation: answer based on where the user is (India users to Mumbai servers)
- Multivalue: return several healthy IPs, a poor man's load balancing

---

# 8. Health checks

The feature I liked most. Route 53 can keep checking whether my application endpoint responds.

- Checks run from multiple AWS locations around the world
- Can watch an endpoint, another health check, or a CloudWatch alarm
- Combined with failover routing, this turns DNS itself into part of high availability, not just name resolution

If one instance or region goes down, users automatically get routed to the healthy one.

---

# 9. Where this fits in a real setup

User types the domain, Route 53 resolves it to the load balancer (Alias record), the load balancer forwards to instances in private subnets. The next topic in this repo (folder 06) is exactly that full architecture built hands-on.

---

# 10. Things to remember

- Hosted zone = container, records = the actual mappings
- Use Alias records for AWS resources, especially on the root domain
- Private hosted zones give clean internal names inside a VPC
- Health checks + failover routing = DNS level high availability
- Lower TTL before planned changes
- Route 53 charges per hosted zone and per million queries, Alias queries to AWS resources are free

---

# Key takeaway

Route 53 is the phonebook of my AWS setup, but a smart one. It does not just translate names to IPs, it can pick the best answer based on health, latency, weight or location.
