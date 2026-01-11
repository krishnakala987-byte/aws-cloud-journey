# AWS CodeCommit – Issues Faced & Troubleshooting Guide

This document captures all the real issues I faced while working with AWS CodeCommit and the exact steps taken to resolve them.  
It serves as both a **learning reference** and a **future troubleshooting guide**.

---

## Issue 1: CodeCommit Repository Not Visible

### Problem
After creating a repository in AWS CodeCommit, it was not visible in the AWS Console.

### Root Cause
AWS CodeCommit repositories are **region-specific**.  
I was checking a different AWS region than the one in which the repository was created.

### Resolution
- Verified the region used during repository creation
- Switched AWS Console to the correct region (e.g., `us-east-1`)
- Repository appeared immediately

### Key Learning
Always verify the AWS region when working with AWS services.

---

## Issue 2: Unable to Authenticate from Terminal

### Problem
While cloning and pushing to CodeCommit from the terminal, authentication failed repeatedly.

### What I Did Initially (Incorrect)
- Used IAM username
- Used IAM console password

### Root Cause
AWS CodeCommit over HTTPS does **not** accept IAM console credentials.

### Correct Approach
AWS CodeCommit requires **HTTPS Git credentials**, which are different from console credentials.

### Resolution Steps
1. Logged into AWS Console
2. Navigated to: IAM → Users → Security Credentials
3. Generated **HTTPS Git credentials for AWS CodeCommit**
4. Used the generated **Git username and password** in terminal

### Key Learning
IAM console credentials ≠ CodeCommit Git credentials.

---

## Issue 3: Git Commit Failed – Author Identity Unknown

### Problem
While running the commit command, Git returned the following error:

Author identity unknown


### Root Cause
Git requires user identity (name and email) to associate commits with an author.  
These details were not configured.

### Resolution
Configured Git user details globally:

```
git config --global user.name "Krishna Kala"
git config --global user.email "krishna@example.com"
```

After this configuration, git commit executed successfully.

### Key Learning

Git must know who the author is before creating commits.

### Issue 3: Git Push Failed (DNS Error)

Error: Could not resolve host

Cause: DNS tools missing

## Fix:

```
sudo yum install bind-utils -y
```
## Result: DNS resolution successful and git push worked.

### STEP 9: Git Commands (FINAL WORKFLOW)
```
git status
git add .
git commit -m "docs: add AWS CodeCommit learning notes and practice"
git push origin main
```






