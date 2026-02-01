# AWS End-to-End CI Pipeline – Real-Time Hands-On Project

## Project Overview

This project documents a **real-time End-to-End Continuous Integration (CI) pipeline** built using **AWS managed services**.

The source code for this project was **forked from the repository _aws-devops-zero-to-hero_ by Abhishek Veeramalla** as part of a structured learning journey.  
After forking the repository, the CI pipeline was **independently implemented, configured, debugged, and executed** by me to gain hands-on experience with AWS CI/CD services.

The primary objective of this project was to automate the following workflow:
- Pull application code from GitHub
- Build the application as a Docker image
- Securely authenticate using AWS services
- Push the image to a container registry

During implementation, several real-world CI/CD issues were encountered related to **IAM permissions, Docker build context, directory structure, AWS CodeBuild configuration, AWS CodePipeline orchestration, and AWS Systems Manager (SSM)**.  
Each issue was debugged and resolved step by step, making this a practical DevOps learning exercise rather than a simple tutorial execution.

---

## Architecture

```
GitHub (Forked Repository)
        |
        v
AWS CodePipeline (CI Orchestration)
        |
        v
AWS CodeBuild (Build & Image Creation)
        |
        v
Docker Registry (Docker Hub / Amazon ECR)
```

---

## Services and Tools Used

| Service / Tool | Purpose |
|----------------|---------|
| GitHub | Source code management (forked repository) |
| AWS CodePipeline | CI orchestration |
| AWS CodeBuild | Build automation and Docker image creation |
| AWS IAM | Role-based access control |
| AWS Systems Manager (Parameter Store) | Secure credential storage |
| Docker | Application containerization |
| AWS CloudShell | AWS CLI usage and testing |

---

## Repository Structure

```
aws-devops-zero-to-hero/
└── day-14/
    └── simple-python-app/
        ├── app.py
        ├── Dockerfile
        ├── requirements.txt
        ├── buildspec.yml
        ├── appspec.yml
        ├── start_container.sh
        └── stop_container.sh
```

---

## CI Pipeline Workflow

1. Code is pushed to the forked GitHub repository
2. AWS CodePipeline detects the change
3. CodePipeline triggers AWS CodeBuild
4. CodeBuild performs the following:
   - Retrieves credentials from AWS Systems Manager Parameter Store
   - Authenticates to the container registry
   - Builds the Docker image
   - Tags and pushes the image
5. The pipeline execution completes successfully

---

## Secure Credential Management

To avoid hardcoding sensitive information:
- Docker credentials are stored in **AWS Systems Manager Parameter Store**
- CodeBuild securely retrieves these values during runtime

### Parameters Used

```
/myapp/docker-credentials/username
/myapp/docker-credentials/password
```

---

## Final Working buildspec.yml

```
version: 0.2

phases:
  pre_build:
    commands:
      - echo Logging in to the container registry
      - aws ecr get-login-password --region us-east-2 |
        docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.us-east-2.amazonaws.com

  build:
    commands:
      - docker build -t simple-python-app \
        -f day-14/simple-python-app/Dockerfile \
        day-14/simple-python-app

  post_build:
    commands:
      - docker tag simple-python-app:latest <ACCOUNT_ID>.dkr.ecr.us-east-2.amazonaws.com/simple-python-app:latest
      - docker push <ACCOUNT_ID>.dkr.ecr.us-east-2.amazonaws.com/simple-python-app:latest
```

---

## Final Result

- Any commit to GitHub automatically triggers the CI pipeline
- Docker image is built successfully
- Image is pushed to the container registry
- The pipeline completes with a successful execution status

---

## Key Learnings

- IAM misconfiguration is one of the most common CI/CD failure points
- Permissions must be applied to the exact IAM role referenced in error logs
- Docker build context and directory paths are critical in CI pipelines
- AWS SSM parameters are region-specific and case-sensitive
- Debugging and log analysis are essential DevOps skills

---

## Why This Project Is Valuable

- Built using AWS-managed CI services
- Includes real-world IAM and configuration troubleshooting
- Demonstrates secure credential handling
- Reflects how CI pipelines operate in real production environments

This project represents hands-on experience in building and debugging an AWS-based CI pipeline.
