# Amazon ECR – Hands-On Demo & Troubleshooting

## Objective of This Demo

The goal of this hands-on demo was to:

* Build a Docker image locally
* Authenticate Docker with Amazon ECR
* Push the image to a private ECR repository
* Understand and fix real-world errors encountered during the process

---

## Environment Used

* OS: Ubuntu (WSL2 on Windows)
* Docker: Docker Engine with Docker Desktop integration
* AWS CLI: Version 2
* AWS Region: ap-south-1

---

## Step-by-Step Demo

### 1. AWS CLI Configuration

```bash
aws configure
```

Configured Access Key, Secret Key, region, and output format.

---

### 2. Authenticate Docker to ECR

```bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-south-1.amazonaws.com
```

This step is mandatory before pushing images.

---

### 3. Dockerfile Used

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY . .
CMD ["python", "--version"]
```

---

### 4. Build Docker Image

```bash
docker build -t demo-app-repo .
```

---

### 5. Tag Image for ECR

```bash
docker tag demo-app-repo:latest <account-id>.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo:latest
```

---

### 6. Push Image to ECR

```bash
docker push <account-id>.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo:latest
```

---

## Errors Faced and How They Were Fixed

### Error 1: `Get-ECRLoginCommand` Not Working

**Cause:** Deprecated PowerShell command used in Linux bash.

**Fix:** Used AWS CLI v2 `get-login-password` command.

---

### Error 2: `docker: command not found`

**Cause:** Docker not installed in Ubuntu (WSL).

**Fix:** Installed Docker and enabled Docker Desktop WSL integration.

---

### Error 3: Permission Denied to Docker Daemon

**Cause:** User not part of docker group.

**Fix:**

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
```

---

### Error 4: Dockerfile Cannot Be Empty

**Cause:** Dockerfile existed without instructions.

**Fix:** Added valid Dockerfile instructions.

---

### Error 5: `no basic auth credentials`

**Cause:** Docker not logged in to ECR or token expired.

**Fix:** Re-authenticated Docker to ECR before pushing.

---

## Verification

Image was verified by pulling and running locally:

```bash
docker run --rm demo-app-repo
```

---

## Key Takeaways

* ECR authentication is temporary and environment-specific
* Docker permissions are a common Linux issue
* Most real DevOps work involves debugging, not just commands

---

This document captures the **practical learning and troubleshooting experience** of working with Amazon ECR.
