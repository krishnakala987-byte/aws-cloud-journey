# AWS CodeCommit Authentication

## Incorrect Method (What I Tried First)
- Used IAM username
- Used IAM console password

This did not work for Git operations.

## Correct Method
AWS CodeCommit requires **HTTPS Git credentials**.

## Steps to Generate Credentials
1. AWS Console → IAM
2. Users → Security Credentials
3. Generate HTTPS Git credentials for AWS CodeCommit

## Important Learning
IAM console password is different from Git credentials.
