# Deployment Steps

## Step 1: EKS Cluster Creation
- Cluster created using eksctl
- Region specified explicitly
- Fargate enabled for workloads

---

## Step 2: Kubernetes Configuration
- kubectl configured with cluster context
- Namespaces used for isolation

---

## Step 3: Application Deployment
- Kubernetes Deployment created
- Multiple replicas configured
- Pod health verified

---

## Step 4: Service Exposure
- NodePort service created
- Internal connectivity verified

---

## Step 5: AWS Load Balancer Controller
- IAM policy created
- IAM role associated using IRSA
- Controller deployed in kube-system namespace

---

## Step 6: Ingress Configuration
- Ingress resource created
- ALB annotations applied
- Internet-facing traffic enabled

---

## Step 7: Validation
- Pods running successfully
- Ingress routing verified
- Application accessible

---
