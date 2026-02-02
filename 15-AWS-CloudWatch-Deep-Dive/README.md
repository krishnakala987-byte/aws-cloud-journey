# AWS CloudWatch – Deep Dive and Hands-On Monitoring

This repository documents a deep dive into AWS CloudWatch, focusing on understanding its core concepts and implementing real-time monitoring and alerting using Amazon EC2.

The objective of this project is to gain hands-on experience with CloudWatch metrics, alarms, logs, and notifications by configuring a CPU utilization alert that sends an email notification when a defined threshold is breached.

## Services and Concepts Covered
- AWS CloudWatch
- CloudWatch Metrics
- CloudWatch Alarms
- CloudWatch Logs
- Custom Metrics
- Amazon EC2
- Amazon SNS (Simple Notification Service)

## What Was Implemented
- Enabled detailed monitoring on an EC2 instance
- Simulated high CPU usage using a Python script
- Created a CloudWatch alarm based on CPU utilization
- Configured SNS email notifications for alerts
- Verified alarm triggering and email delivery

## Outcome
- Real-time monitoring enabled for EC2
- Automated alert received via email when CPU threshold was exceeded
- Clear understanding of how CloudWatch is used for monitoring and alerting in production environments

## Learning Reference
This implementation was completed as part of hands-on learning using the AWS DevOps Zero to Hero YouTube series by Abhishek Veeramalla as a reference.  
All configuration, testing, and documentation were performed independently.
