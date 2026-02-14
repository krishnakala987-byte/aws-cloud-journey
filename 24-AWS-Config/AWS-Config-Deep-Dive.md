# AWS Config – Deep Dive Notes

## What is AWS Config?

AWS Config is a service that continuously monitors and records AWS resource configurations.  
It helps in tracking changes and checking whether resources follow defined compliance rules.

It answers three main questions:

1. What does my resource look like?
2. Who changed it?
3. Is it compliant with my rule?

---

## Core Components of AWS Config

### 1. Configuration Recorder
Records configuration details of supported AWS resources.

### 2. Delivery Channel
Stores configuration snapshots in:
- S3 bucket
- SNS topic (optional)

### 3. Config Rules
Used to evaluate compliance.
Two types:
- AWS Managed Rules
- Custom Rules (Lambda-based)

---

## Evaluation Modes

### Detective
Evaluates resources after configuration changes.

### Proactive
Evaluates before resource deployment.

---

## Trigger Types

1. Configuration changes
2. Periodic evaluation

---

## Scope of Changes

- All changes → Every resource
- Resources → Specific resource type
- Tags → Trigger only on tag changes

In our project we used:
Scope = Resources  
Resource Type = EC2 Instance / S3 Bucket

---

## How AWS Config Works with Lambda

1. Resource changes
2. Config detects change
3. Config invokes Lambda
4. Lambda checks compliance logic
5. Lambda returns:
   - COMPLIANT
   - NON_COMPLIANT
6. Config updates dashboard

---

## IAM Role Concepts

### Lambda Execution Role
Allows Lambda to:
- Call EC2 API
- Call S3 API
- Write logs to CloudWatch

Example permissions used:
- AWSLambdaBasicExecutionRole
- AmazonEC2ReadOnlyAccess
- AmazonS3FullAccess (for testing)

---

### Resource-Based Policy (Very Important)

Execution Role → What Lambda can access  
Resource Policy → Who can invoke Lambda

For AWS Config:
Principal = config.amazonaws.com  
Action = lambda:InvokeFunction  
Source ARN = Usually left empty for testing

---

## CloudWatch Logging

Every Lambda execution creates a log group:

/aws/lambda/<function-name>

Logs help in debugging:
- Syntax errors
- Permission issues
- Event structure problems

---

## Key Learning from Implementation

- Config evaluation is not always instant
- Manual re-evaluation may be required
- IAM permission mistakes cause most failures
- CloudWatch is the first place to check for errors
- Always verify event structure before writing logic

---

## Architecture Flow (Simple Version)

EC2 / S3 Change
        ↓
AWS Config
        ↓
Lambda Function
        ↓
Compliance Result
        ↓
Config Dashboard
