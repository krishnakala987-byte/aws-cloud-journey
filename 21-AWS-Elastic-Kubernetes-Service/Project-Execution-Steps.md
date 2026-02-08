# Kubernetes End-to-End Project on AWS EKS
EKS Installation and Application Deployment with Ingress (ALB)

This file documents the exact steps I followed while building and validating an end-to-end Kubernetes project on Amazon EKS. The focus of this project was to gain hands-on experience with EKS cluster creation, application deployment, service exposure, Ingress configuration using AWS ALB, and complete cleanup after execution.

The content below reflects the real execution flow I followed during the project, including the commands used, validations performed, and logical order of operations.

---

Project Objective

The objective of this project was to deploy a containerized application on AWS EKS and expose it to the internet using Kubernetes Ingress backed by an AWS Application Load Balancer. This helped me understand how Kubernetes integrates with AWS-native networking and IAM components in a production-like setup.

---

Tools and Services Used

AWS EKS  
AWS IAM  
AWS Load Balancer Controller  
eksctl  
kubectl  
Kubernetes (Ingress, Service, Deployment, Namespace)  
Fargate profiles  

---

Step 1: Create EKS Cluster

The EKS cluster was created using eksctl with Fargate enabled.

Command used:

eksctl create cluster \
  --name demo-cluster \
  --region us-east-1 \
  --fargate

Verification:

eksctl get cluster
kubectl get nodes

---

Step 2: Create Application Namespace

A dedicated namespace was created to isolate the application resources.

Command used:

kubectl create namespace game-2048

Verification:

kubectl get namespaces

---

Step 3: Deploy Application Workload

The application (2048 game) was deployed inside the game-2048 namespace using Deployment and Service manifests.

Commands used:

kubectl apply -n game-2048 -f deployment.yaml
kubectl apply -n game-2048 -f service.yaml

Verification:

kubectl get pods -n game-2048
kubectl get svc -n game-2048

At this stage, the service was exposed internally using NodePort.

---

Step 4: Associate IAM OIDC Provider

OIDC provider association is required to allow Kubernetes service accounts to assume IAM roles.

Command used:

eksctl utils associate-iam-oidc-provider \
  --cluster demo-cluster \
  --region us-east-1 \
  --approve

---

Step 5: Create IAM Policy for AWS Load Balancer Controller

An IAM policy required by the AWS Load Balancer Controller was created using the official policy document.

Command used:

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json

---

Step 6: Create IAM Service Account (IRSA)

An IAM service account was created in the kube-system namespace and the ALB controller policy was attached to it.

Command used:

eksctl create iamserviceaccount \
  --cluster demo-cluster \
  --region us-east-1 \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --attach-policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve

Verification:

kubectl get sa -n kube-system | grep load-balancer

---

Step 7: Install AWS Load Balancer Controller

The AWS Load Balancer Controller was deployed into the cluster.

Command used:

kubectl apply -f aws-load-balancer-controller.yaml

Verification:

kubectl get pods -n kube-system | grep load-balancer

The controller pods moved to Running state after initialization.

---

Step 8: Create Ingress Resource

An Ingress resource was created to expose the application using an internet-facing Application Load Balancer.

Command used:

kubectl apply -n game-2048 -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-2048
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
spec:
  rules:
    - http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: service-2048
                port:
                  number: 80
EOF

Verification:

kubectl get ingress -n game-2048
kubectl describe ingress ingress-2048 -n game-2048

Once provisioned, the ALB DNS endpoint was generated and the application became accessible via browser.

---

Step 9: Application Validation

The application was successfully accessed through the ALB endpoint.

Checks performed:
- Pods were running
- Service endpoints were healthy
- Ingress rules were correctly applied
- AWS ALB was created and reachable

---

Step 10: Cleanup and Resource Deletion

All resources were deleted after completion to avoid unnecessary costs.

Commands used:

kubectl delete namespace game-2048

kubectl delete deployment aws-load-balancer-controller -n kube-system
kubectl delete svc aws-load-balancer-webhook-service -n kube-system

eksctl delete iamserviceaccount \
  --cluster demo-cluster \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --region us-east-1

eksctl delete cluster \
  --name demo-cluster \
  --region us-east-1

Final verification was performed from the AWS Console to ensure that no EKS, EC2, ALB, or networking resources were left running.

---

Project Summary

This project provided hands-on experience with:
- EKS cluster lifecycle management
- Kubernetes workloads on AWS
- IAM Roles for Service Accounts (IRSA)
- AWS Load Balancer Controller integration
- Kubernetes Ingress with ALB
- End-to-end debugging and validation
- Proper cleanup and cost control

This file reflects the exact execution flow followed during the project.
