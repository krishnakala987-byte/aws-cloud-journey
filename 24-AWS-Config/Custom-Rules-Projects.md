# AWS Config – Custom Rules Projects

This document contains the hands-on projects implemented using AWS Config and Lambda.

---

# Project 1: EC2 Detailed Monitoring Compliance

## Objective

Check whether EC2 instances have Detailed Monitoring enabled.

---

## Lambda Logic Used

1. Extract instance ID from event.
2. Describe instance.
3. Check:
   instance['Monitoring']['State']
4. If enabled → COMPLIANT
5. Else → NON_COMPLIANT

---

## Workflow

EC2 Change → Config → Lambda → Evaluation → Dashboard

---

## Important Observation

- Monitoring state must be "enabled"
- Sometimes evaluation delay occurs
- Re-evaluation may be required manually

---

# Project 2: S3 Public Access Block Compliance

## Objective

Ensure S3 bucket has Block Public Access enabled.

---

## Lambda Logic Used

1. Extract bucket name from event.
2. Call:
   get_public_access_block()
3. Check all 4 settings:
   - BlockPublicAcls
   - IgnorePublicAcls
   - BlockPublicPolicy
   - RestrictPublicBuckets

4. If all True → COMPLIANT
5. Else → NON_COMPLIANT

---

## Real Issue Faced

- Initially rule showed NON_COMPLIANT
- Reason: Lambda logic error
- Debugged using CloudWatch logs

---

## CloudWatch Errors Encountered

1. NameError (client not defined)
2. NoneType object is not subscriptable
3. Permission denied errors

Each was resolved by correcting:
- Variable definitions
- Event parsing
- IAM permissions

---

## Important Notes

- Always test Lambda manually
- Ensure execution role has proper permissions
- Check logs before assuming rule failure
- Config cache may delay status update

---

## What I Practiced

- Creating custom AWS Config rules
- Writing Lambda in Python using boto3
- Attaching IAM roles
- Debugging using CloudWatch
- Understanding compliance workflow
