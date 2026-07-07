# AWS Route 53 – DNS on AWS

## Focus of this topic
Route 53 is the DNS service of AWS. This was a shorter, theory heavy class, but the concept is important because almost every project after this uses a domain name somewhere.

## What is DNS?
DNS maps human friendly domain names to machine friendly IP addresses. I can remember amazon.com, I cannot remember 205.251.242.103. Without DNS, users would need to know the IP of every server, and every time an IP changed the whole world would break.

## Why Route 53?
Managing DNS on my own means running and patching DNS servers. Route 53 does it as a managed service and it plugs directly into AWS resources like load balancers, so mapping a domain to my infrastructure is a few clicks.

## Core components
- Domain registration: I can buy a domain directly in AWS, or bring a domain purchased somewhere else like GoDaddy.
- Hosted zones: the container where the actual DNS records live. This is where the domain name to IP mapping is defined.
- Records: entries inside the hosted zone, like an A record pointing my domain to a load balancer.

## Health checks
This is the feature I liked most. Route 53 can keep checking whether my application is responding. If one instance goes down, it detects the failure and can route traffic to the healthy resources instead. So DNS itself becomes part of high availability, not just name resolution.

## Where this fits in a real setup
User types the domain, Route 53 resolves it to the load balancer, the load balancer forwards to instances in private subnets. The next topic in this repo is exactly that full architecture built hands-on.

## Key takeaway
Route 53 is the phonebook of my AWS setup. Users remember names, Route 53 handles the numbers.
