# AWS Config – Troubleshooting Guide

This file documents common issues faced during implementation and how they were resolved.

---

## Issue 1: No Logs in CloudWatch

Cause:
Lambda execution role missing logging permission.

Fix:
Attach policy:
AWSLambdaBasicExecutionRole

---

## Issue 2: NameError: s3_client not defined

Cause:
Client not initialized.

Fix:
s3_client = boto3.client('s3')

---

## Issue 3: NoneType object is not subscriptable

Cause:
Incorrect event structure parsing.

Fix:
Properly parse:
json.loads(event['invokingEvent'])

---

## Issue 4: Rule stuck at old evaluation time

Cause:
Lambda failed silently.

Fix:
Check CloudWatch logs immediately.

---

## Issue 5: S3 showing Non-Compliant even after enabling block

Cause:
Lambda logic error or incomplete public access configuration.

Fix:
Verify all four public access settings are TRUE.

---

## Debugging Checklist

1. Check CloudWatch logs
2. Verify Lambda execution role
3. Confirm resource-based policy
4. Re-evaluate rule manually
5. Confirm correct region
6. Verify Config recorder is ON

---

## Important Reminders

- Never use FullAccess in production
- Always follow least privilege principle
- Config evaluation is not real-time always
- Logging is essential for debugging
- Execution role and resource policy are different

---

## Final Learning

Most AWS Config issues are not service problems.
They are:
- IAM issues
- Event parsing mistakes
- Missing permissions
- Incorrect logic in Lambda
