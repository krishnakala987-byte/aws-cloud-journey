# Debugging & Operational Learnings

This project included several real-world troubleshooting scenarios:

## 1. DNS Resolution Failures
Encountered intermittent DNS resolution issues while Terraform communicated with AWS APIs.

Lesson:
Infrastructure automation depends on stable network resolution.

---

## 2. Partial Resource Creation
Terraform may stop if one resource fails.

Lesson:
Understand Terraform state management and re-run apply carefully.

---

## 3. Account-Level Restrictions
Load balancer provisioning depends on AWS account permissions.

Lesson:
Cloud engineering includes understanding service limits and account configuration.

---

## 4. Safe Resource Teardown
Always perform:
terraform destroy

To prevent unwanted AWS charges.



# Security Considerations

## 1. Principle of Least Privilege
Security groups should allow only necessary ports.

## 2. Restrict SSH Access
Instead of 0.0.0.0/0, production should restrict SSH to specific IP addresses.

## 3. Protect Terraform State
State files should not be uploaded publicly.

## 4. Avoid Hardcoded Credentials
Use IAM roles instead of static access keys in production.


# Cost Management Strategy

Cloud resources generate cost if left running.

Best practices followed:

- Used terraform destroy after testing
- Verified no running EC2 instances
- Removed S3 buckets when unused
- Monitored billing dashboard

Infrastructure lifecycle awareness is essential in cloud engineering.

