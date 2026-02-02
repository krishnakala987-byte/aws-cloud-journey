# AWS End-to-End CI/CD Pipeline using CodePipeline, CodeBuild, and CodeDeploy

This repository contains an end-to-end CI/CD pipeline implementation on AWS for deploying a Python Flask application packaged as a Docker container to an Amazon EC2 instance.

The pipeline is fully automated. Any code change pushed to GitHub triggers the build, image creation, and deployment process without manual intervention.

## Technologies and Services Used
- GitHub – Source code management
- AWS CodePipeline – CI/CD orchestration
- AWS CodeBuild – Build and Docker image creation
- AWS CodeDeploy – Application deployment
- Amazon EC2 (Ubuntu) – Target compute instance
- Docker – Application containerization

## High-Level Workflow
1. Code changes are pushed to GitHub
2. CodePipeline detects the change
3. CodeBuild builds the Docker image and pushes it to Docker Hub
4. CodeDeploy deploys the updated application onto EC2 using lifecycle hooks

## Repository Contents
- appspec.yml – CodeDeploy configuration file
- start_container.sh – Script to start the Docker container
- stop_container.sh – Script to stop existing containers before deployment
- Dockerfile – Builds the Flask application image

## Outcome
- Fully automated CI/CD pipeline
- Dockerized Flask application running on EC2
- In-place deployments using CodeDeploy
- Successful deployments reflected by green pipeline stages

## Learning Reference
This project is based on learnings from the AWS DevOps Zero to Hero series by Abhishek Veeramalla sir. 
The implementation and troubleshooting were performed independently as part of hands-on practice.
