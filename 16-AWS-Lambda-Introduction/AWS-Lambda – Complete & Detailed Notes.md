#  AWS Lambda – Complete & Detailed Notes (DevOps Focus)

This document contains **in-depth yet easy-to-understand notes on AWS Lambda**, written specifically for **DevOps engineers and beginners**.  
It explains AWS Lambda concepts from scratch and gradually covers **real-world usage, automation, cost optimization, and security use cases**.

---

## 1️ What is AWS Lambda?

AWS Lambda is a **serverless compute service** that allows you to run code **without creating or managing servers**.

In simple terms:
- You write the code
- AWS runs the code when needed
- You pay only for the time your code runs

You do not manage:
- Servers
- Operating systems
- Scaling
- Infrastructure

---

## 2️ What Does “Serverless” Mean?

Serverless does NOT mean there are no servers.

It means:
- Servers exist, but AWS manages them
- You do not provision or maintain servers
- You do not handle scaling or availability
- You focus only on writing business logic

Serverless reduces operational overhead and simplifies automation.

---

## 3️ Event-Driven Architecture

AWS Lambda works on an **event-driven model**.

This means:
- Lambda does not run continuously
- It runs only when an event occurs

Examples of events:
- File upload to S3
- Scheduled cron job using CloudWatch/EventBridge
- API request
- Security or compliance trigger

Once execution finishes, Lambda automatically stops.

---

##  AWS Lambda vs Amazon EC2

| Feature | Amazon EC2 | AWS Lambda |
|------|-----------|------------|
| Type | Virtual Machine | Serverless Function |
| Server Management | User manages OS & patches | AWS manages infrastructure |
| Execution | Always running | Runs only on events |
| Scaling | Manual / Auto Scaling | Automatic |
| Pricing | Pay while instance runs | Pay per execution |
| Use Case | Long-running applications | Automation & short tasks |

Key idea:
EC2 is mainly used for applications.  
Lambda is mainly used for automation.

---

## 5️ Why DevOps Engineers Use AWS Lambda

DevOps engineers use AWS Lambda to automate repetitive and operational tasks.

Common use cases include:
- Cost optimization
- Security enforcement
- Compliance checks
- Cloud resource cleanup
- Scheduled monitoring tasks

Lambda helps reduce manual work and human error.

---

## 6️ AWS Lambda Runtime

A runtime defines the programming language environment for your Lambda function.

Common runtimes:
- Python (most commonly used in DevOps)
- Node.js
- Java
- Go

Shell scripts are not natively supported as a runtime.

---

## 7️ Lambda Handler (Entry Point)

The handler is the function that AWS Lambda calls when execution starts.

Example in Python:

def lambda_handler(event, context):
    pass

- event: contains trigger-related data
- context: contains runtime and execution information

The handler works like the main() function of a program.

---

## 8️ IAM Role in AWS Lambda (Very Important)

AWS Lambda cannot access other AWS services by default.

Each Lambda function must have an **IAM execution role**.

The IAM role allows Lambda to:
- Access EC2 information
- Read EBS volumes and snapshots
- Delete snapshots
- Write logs to CloudWatch

Without the correct IAM permissions, Lambda execution will fail.

Best practice:
- Follow the principle of least privilege
- Grant only required permissions

---

## 9️ boto3 – AWS SDK for Python

boto3 is the official Python library used to interact with AWS services.

In simple words:
boto3 allows Python code to communicate with AWS APIs.

Using boto3, Lambda can:
- Describe EC2 instances
- Describe EBS volumes
- List and delete snapshots
- Automate AWS operations

boto3 is heavily used in DevOps automation.

---

##  Amazon EBS Volumes

An EBS volume is a **virtual hard disk** attached to an EC2 instance.

It stores:
- Operating system
- Application files
- Logs
- Databases (small scale)

EC2 instances cannot function without storage volumes.

---

## 1️1️ EBS Snapshots

An EBS snapshot is a **backup of an EBS volume**.

Important points:
- Snapshots are stored separately from EC2
- They survive EC2 or volume deletion
- Used for backup and recovery
- Incremental after the first snapshot

Snapshots incur cost if not managed properly.

---

## 1️2️ Why Snapshot Cleanup Is Important

Over time:
- Volumes get deleted
- Snapshots remain
- Unused snapshots increase AWS bill

Manual cleanup is time-consuming and error-prone.

Automating snapshot cleanup helps with:
- Cost optimization
- Account hygiene
- Operational efficiency

---

## 1️3️ Snapshot Cleanup Automation Logic

A typical cleanup automation follows these steps:

1. Fetch all EBS snapshots owned by the account
2. Fetch all running EC2 instances
3. For each snapshot:
   - Check if it is linked to a volume
   - Check if the volume still exists
   - Check if the volume is attached to a running EC2
4. Delete snapshots that are unused or orphaned

This logic ensures safe cleanup.

---

## 1️4️ Error Handling in Lambda Automation

AWS API calls may fail due to:
- Deleted volumes
- Missing resources
- Invalid references

Proper error handling:
- Prevents Lambda crashes
- Ensures safe execution
- Makes automation reliable in production

---

## 1️5️ Logging with CloudWatch

AWS Lambda automatically sends:
- Logs
- Errors
- Print outputs

To CloudWatch Logs.

Logs help in:
- Debugging issues
- Monitoring execution
- Auditing automation behavior

---

## 1️6️ When NOT to Use AWS Lambda

Avoid AWS Lambda for:
- Long-running tasks (more than 15 minutes)
- Heavy CPU or memory workloads
- Stateful applications
- Legacy monolithic systems

For such use cases, EC2, ECS, or EKS are better options.

---

## 1️7️ Key Benefits of AWS Lambda for DevOps

- No server management
- Automatic scaling
- Pay only for execution time
- Ideal for automation tasks
- Strong security and IAM integration

---

##  Final Summary

AWS Lambda is a powerful serverless service that enables DevOps engineers to automate cloud operations efficiently while reducing cost and operational overhead.

---

## 🧠 Final Learning

AWS Lambda is not designed to replace EC2.

It is designed to:
Automate cloud tasks using a serverless and event-driven approach.
