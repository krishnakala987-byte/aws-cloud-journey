# AWS Load Balancer – Complete Detailed Guide

This document provides a complete understanding of AWS Load Balancers, networking basics, and production architecture concepts required for DevOps and Cloud interviews.

---

# 1. What is a Load Balancer?

A Load Balancer distributes incoming traffic across multiple servers (EC2 instances).

Purpose:
- Prevent server overload
- Increase availability
- Improve performance
- Ensure fault tolerance

If one server fails, traffic automatically shifts to healthy servers.

---

# 2. Types of AWS Load Balancers

## 2.1 Application Load Balancer (ALB)

- Works at OSI Layer 7 (Application Layer)
- Supports HTTP and HTTPS
- Supports path-based routing
- Supports host-based routing
- Can route to EC2, IP addresses, and Lambda

Best for:
- Web applications
- REST APIs
- Microservices

### Path-Based Routing

Routes traffic based on URL path.

Example:
- example.com/api → Server 1
- example.com/images → Server 2

ALB reads the path after the domain name and forwards traffic accordingly.

### Host-Based Routing

Routes traffic based on hostname (subdomain).

Example:
- api.example.com → Server 1
- blog.example.com → Server 2

ALB checks the hostname and routes traffic accordingly.

---

## 2.2 Network Load Balancer (NLB)

- Works at OSI Layer 4 (Transport Layer)
- Supports TCP and UDP
- Extremely high performance
- Low latency

Routes traffic based on:
- IP address
- Port number

Best for:
- Banking systems
- Gaming
- Real-time applications

---

## 2.3 Gateway Load Balancer (GWLB)

- Used for security appliances
- Integrates with firewalls
- Used for deep packet inspection
- Supports IDS and IPS systems

Best for:
- Network security
- Traffic inspection

---

# 3. Core Load Balancer Concepts

## Target Groups

Load Balancer forwards traffic to Target Groups.

Target Groups can contain:
- EC2 instances
- IP addresses
- Lambda functions (ALB only)

---

## Health Checks

Load Balancer continuously checks instance health.

If instance becomes unhealthy:
- Traffic stops going to that instance.

---

## Listener

Listener checks:
- Protocol (HTTP, HTTPS, TCP)
- Port number (80, 443, etc.)

Then forwards traffic to target group.

---

## Sticky Sessions

Sticky sessions ensure a user connects to the same server for multiple requests.

Useful for:
- Login systems
- Shopping carts

ALB supports sticky sessions using cookies.

---

# 4. OSI Model – 7 Layers

1. Physical  
2. Data Link  
3. Network  
4. Transport  
5. Session  
6. Presentation  
7. Application  

---

## Layer Explanation

Layer 1 – Physical  
Handles cables and signals.

Layer 2 – Data Link  
Uses MAC address.  
Switch works here.

Layer 3 – Network  
Uses IP address.  
Router works here.

Layer 4 – Transport  
Uses port numbers.  
TCP and UDP operate here.

Layer 5 – Session  
Manages sessions and connections.

Layer 6 – Presentation  
Handles encryption and formatting (SSL/TLS).

Layer 7 – Application  
HTTP, FTP, SMTP operate here.

---

# 5. MAC Address

MAC Address:
- Physical address of device
- Unique per device
- Used inside local network
- Works at Layer 2

Example format:
00:1A:2B:3C:4D:5E

---

# 6. Switch Working at Layer 2

Switch:
- Uses MAC address
- Maintains MAC address table
- Sends data only to intended device
- Works inside LAN

---

# 7. TCP vs UDP

## TCP
- Reliable
- Connection-oriented
- Uses 3-way handshake
- Used in HTTP and HTTPS

## UDP
- Fast
- Connectionless
- No confirmation
- Used in gaming and streaming

---

# 8. Important Port Numbers

HTTP  → 80  
HTTPS → 443  
FTP   → 21  
SMTP  → 25  

---

# 9. HTTP, FTP, SMTP

## HTTP
Used for loading websites.
Works on port 80.

## HTTPS
Secure version of HTTP.
Works on port 443.

## FTP
Used for file transfer.
Works on port 21.

## SMTP
Used for sending emails.
Works on port 25.

---

# 10. IDS and IPS

## IDS – Intrusion Detection System
- Detects suspicious activity
- Sends alert
- Does not block automatically

## IPS – Intrusion Prevention System
- Detects and blocks malicious traffic automatically

---

# 11. Layer 4 vs Layer 7 Load Balancing

Layer 4:
- Based on IP and Port
- Faster
- Used by NLB

Layer 7:
- Inspects HTTP request
- Can route based on URL path and hostname
- Used by ALB

---

# 12. Load Balancer + Auto Scaling

Traffic Flow:

User → Load Balancer → Target Group → EC2 Instances

If traffic increases:
- Auto Scaling launches new instances.
- Load Balancer distributes traffic automatically.

If traffic decreases:
- Instances are terminated automatically.

---

# 13. High Availability Architecture

Best Practice:
- Deploy across multiple Availability Zones.
- Use Auto Scaling.
- Maintain minimum two instances.
- Enable health checks.
- Use HTTPS.

---

# 14. Complete Production Flow Example

1. User enters domain.
2. DNS resolves to Load Balancer.
3. Listener checks port and protocol.
4. Routing rule is evaluated.
5. Traffic forwarded to target group.
6. Healthy EC2 instance processes request.
7. Response returned to user.

---

# Final Understanding

After going through this document , these concepts will be crystal clear :

- AWS Load Balancer types
- Routing concepts
- OSI Model fundamentals
- TCP vs UDP
- MAC address and switching
- HTTP, FTP, SMTP
- IDS and IPS
- Production architecture design
- Scaling and high availability
