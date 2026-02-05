# Architecture and Request Flow

## Architecture Overview

This project uses a standard AWS architecture for hosting a secure static website.

Components involved:
- Client (web browser)
- CloudFront distribution
- CloudFront edge locations
- Origin Access Identity
- Amazon S3 private bucket

---

## Request Flow

1. A user requests the website using the CloudFront domain.
2. CloudFront routes the request to the nearest edge location.
3. If the requested object is cached, it is served immediately.
4. If not cached, CloudFront retrieves the object from the S3 bucket.
5. The response is cached at the edge and delivered to the user over HTTPS.

---

## Security Design

- Public access to S3 is blocked
- Only CloudFront can access the S3 bucket
- HTTPS is enforced at the CloudFront level
- The origin remains hidden from end users

This architecture is widely used for secure and scalable static website hosting.

