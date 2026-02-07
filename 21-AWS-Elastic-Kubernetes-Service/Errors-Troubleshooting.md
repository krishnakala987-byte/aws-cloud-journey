# Errors and Troubleshooting

This project involved real-world troubleshooting, which helped strengthen understanding of EKS and Kubernetes.

---

## Issue: Ingress Not Getting Address
Cause:
- Load Balancer Controller was not fully ready or had permission issues

Resolution:
- Verified controller logs
- Fixed IAM service account permissions
- Reapplied Ingress resource

---

## Issue: Controller Pods in Pending State
Cause:
- Namespace or Fargate profile mismatch

Resolution:
- Verified namespace configuration
- Restarted controller deployment

---

## Issue: Authorization Errors in Events
Cause:
- Missing EC2 and ELB permissions

Resolution:
- Updated IAM policies
- Recreated IAM service account

---

## Key Learnings
- Most EKS issues are IAM-related
- kubectl describe and events are critical
- Controllers must be ready before dependent resources

---
