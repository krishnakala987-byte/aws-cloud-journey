# Project Troubleshooting Log – AWS CI/CD Pipeline

This document records the real issues encountered while building the AWS CI pipeline and the steps taken to resolve them.  
The troubleshooting process involved manual debugging, AWS documentation, and assistance from both ChatGPT and Google Gemini.

---

## 1. IAM Permission Error (SSM Access)

### Error
```
AccessDeniedException: is not authorized to perform: ssm:GetParameters
```

### Root Cause
The IAM role used by CodeBuild / CodePipeline did not have permission to access AWS Systems Manager (SSM) Parameter Store.

### Resolution
- Identified the exact IAM role mentioned in the error message
- Added permission to allow `ssm:GetParameters` using an inline policy or managed policy

### Learning
Permissions must always be added to the IAM role explicitly shown in the error logs.

---

## 2. Missing Parameter Error (SSM)

### Error
```
Decrypted Variables Error Message: parameter does not exist
```

### Root Cause
Two issues were identified:
1. The `buildspec.yml` referenced short variable names instead of full SSM parameter paths
2. Some required parameters did not exist in Parameter Store

### Resolution
- Updated `buildspec.yml` to reference full parameter paths:
```
/myapp/docker-credentials/username
/myapp/docker-credentials/password
```
- Created the missing parameters in the `us-east-2` region

### Learning
SSM parameters are:
- Region-specific
- Case-sensitive
- Path-sensitive

---

## 3. Directory Mismatch Error

### Error
```
No such file or directory: day-13/simple-python-app/requirements.txt
```

### Root Cause
The repository directory was renamed from `day-13` to `day-14`, but the buildspec file still referenced the old path.

### Resolution
- Updated all directory references in `buildspec.yml` from `day-13` to `day-14`

### Learning
Any repository structure change must be reflected in CI configuration files.

---

## 4. Docker Build Context Error

### Error
```
docker build ... exit status 1
```

### Root Cause
After changing into the application directory using `cd`, the Docker build command still referenced a nested path, resulting in an invalid context.

### Resolution
- Simplified the Docker build command to use the current directory:
```
docker build -t $imagename .
```

### Learning
Once inside the correct directory, Docker build context should be `.`

---

## Final Resolution (Gemini Contribution)

After applying the fixes above, additional validation and corrections were performed using **Google Gemini**, particularly around:
- SSM parameter naming
- Correct buildspec path usage
- Directory and Docker context alignment

After these corrections, the pipeline executed successfully end-to-end.

---

## Final Outcome

- GitHub commit successfully triggered CodePipeline
- CodeBuild completed without errors
- Docker image was built and pushed to the registry
- Pipeline achieved a fully successful execution status

---

## Summary

This troubleshooting process reinforced that most CI/CD issues arise from configuration and permissions rather than application code.  
The project provided practical experience in debugging IAM, Docker, and AWS CI services in a real-world setup.
