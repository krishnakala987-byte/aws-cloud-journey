# CloudFront and CDN Study Notes

## What is a Content Delivery Network (CDN)?

A Content Delivery Network is a globally distributed network of servers designed to deliver content efficiently to users based on their geographic location.

Without a CDN, requests must travel long distances to a central server, increasing latency and load times. A CDN solves this by caching content at edge locations closer to users.

---

## Amazon CloudFront

Amazon CloudFront is AWS’s managed CDN service. It integrates with services such as Amazon S3, EC2, and Elastic Load Balancing to deliver content with low latency and high transfer speeds.

CloudFront sits between the end user and the origin server, handling caching, security, and request routing.

---

## Benefits of CloudFront

- Reduced latency through edge caching
- Improved security by hiding the origin
- Scalability without infrastructure management
- Cost efficiency for repeated content delivery

---

## Static Website Hosting with S3 and CloudFront

S3 stores the static website files, while CloudFront serves them globally.  
The S3 bucket remains private and is accessed only by CloudFront using an Origin Access Identity.

This design ensures both performance and security.

---

## Caching Behavior

CloudFront caches objects at edge locations. When content is updated in S3, CloudFront may continue serving cached versions until the cache expires or is invalidated.

Understanding cache behavior is important during development and updates.

