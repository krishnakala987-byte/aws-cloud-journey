# AWS CloudFront and Content Delivery Network (CDN)

This repository documents my learning and hands-on practice with **Amazon CloudFront** and **Content Delivery Networks (CDNs)**.  
It combines conceptual understanding with a practical implementation of hosting a **secure static website** using **Amazon S3 and CloudFront**.

The goal of this project was not only to understand how CloudFront works, but also to learn how performance, security, and cost considerations apply in real-world AWS usage.

---

## Project Objectives

- Understand why CDNs are required
- Learn how Amazon CloudFront works internally
- Implement a secure static website using S3 as an origin
- Configure CloudFront with proper access control
- Observe caching behavior and performance improvements
- Understand common billing pitfalls while learning AWS

---

## What Was Implemented

- Created a private S3 bucket for static website hosting
- Uploaded static website files (HTML, CSS, assets)
- Created a CloudFront distribution with the S3 bucket as origin
- Configured Origin Access Identity (OAI) to restrict S3 access
- Enforced HTTPS using CloudFront viewer protocol policy
- Verified that content is accessible only through CloudFront
- Disabled the distribution after testing to prevent charges

---

## Key Learnings

- CDNs reduce latency by serving content from nearby edge locations
- CloudFront acts as both a performance and security layer
- Keeping the S3 bucket private is a critical best practice
- Cache behavior affects how quickly content updates are visible
- Billing awareness is essential even when using free-tier resources

---

## Repository Contents

| File Name | Description |
|---------|-------------|
| `cloudfront-study-notes.md` | Detailed explanation of CDN concepts and CloudFront |
| `architecture-and-flow.md` | Architecture overview and request flow |
| `billing-lessons-learned.md` | Real billing insights and mistakes to avoid |

---

## Important Notes on Cost

- CloudFront and S3 are not completely free
- Data transfer, requests, and security features may incur charges
- Promotional credits can expire
- Taxes (GST) may not be covered by credits
- Resources should always be disabled or deleted after practice

---

## Conclusion

This project helped strengthen my understanding of content delivery, AWS security best practices, and real-world cloud cost management.  
The documentation here is intended to be a reference for future learning and a practical example of CloudFront usage.

