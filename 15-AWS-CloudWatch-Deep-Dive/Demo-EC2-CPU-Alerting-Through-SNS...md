# AWS CloudWatch – Deep Dive, Implementation, and Observations

This document contains a complete explanation of AWS CloudWatch concepts along with a hands-on implementation of real-time monitoring and alerting using an EC2 instance. It also documents practical observations and common issues encountered during setup.

---

OVERVIEW

AWS CloudWatch is a monitoring and observability service used to collect metrics, logs, and events from AWS resources and applications. It acts as a centralized service to monitor system health, performance, and operational behavior.

CloudWatch is often referred to as the “watchman” or “gatekeeper” of AWS because it continuously monitors resources and helps detect issues before they impact applications.

This deep dive focuses on understanding CloudWatch fundamentals and implementing an EC2 CPU utilization alarm with email notifications.

---

CORE FUNCTIONS OF CLOUDWATCH

CloudWatch provides the following primary capabilities:

- Monitoring: Tracks performance and health of AWS resources
- Alerting: Triggers actions when thresholds are crossed
- Logging: Stores and organizes logs from AWS services
- Reporting: Helps analyze historical data for optimization

---

KEY CLOUDWATCH CONCEPTS

METRICS

Metrics are numerical data points that represent the performance of AWS services. Examples include CPU utilization, network traffic, disk operations, and request counts.

AWS CloudWatch automatically tracks over a thousand metrics for supported services. For EC2, CPU utilization is monitored by default.

Metrics are collected at fixed intervals and stored for analysis and alerting.

---

ALARMS

CloudWatch alarms monitor metrics and take actions when conditions are met. An alarm evaluates a metric against a defined threshold over a specific time period.

Example:
If CPU utilization is greater than or equal to 50% for one minute, trigger an alert.

Alarms can:
- Send notifications
- Trigger auto scaling
- Stop or terminate instances

---

LOG GROUPS

CloudWatch Logs are organized into log groups. A log group represents logs from a specific service or application.

Even if the underlying resource (such as an EC2 instance or CodeBuild project) is deleted, logs remain available in CloudWatch for troubleshooting.

---

CUSTOM METRICS

AWS provides many default metrics, but not all system-level metrics are tracked automatically.

For example:
- CPU utilization is available by default
- Memory (RAM) utilization is NOT available by default

To monitor memory usage, custom metrics must be configured and pushed to CloudWatch manually.

---

HANDS-ON DEMO: EC2 CPU UTILIZATION ALERT

The practical demo involved setting up a real-time CPU alert for an EC2 instance.

---

STEP 1: EC2 INSTANCE SETUP

An Ubuntu EC2 (t2.micro) instance was launched.

Detailed Monitoring was enabled on the instance. This reduced the metric reporting interval from the default 5 minutes to 1 minute, allowing faster alarm evaluation and alerting.

---

STEP 2: CPU SPIKE SIMULATION

To simulate high CPU usage, a Python script was used.

The script continuously consumes CPU resources to increase utilization to approximately 80–100%, mimicking a high-load scenario.

The script was executed on the EC2 instance using:
python3 CPU_spike.py

Once running, CPU usage increased immediately.

---

STEP 3: CLOUDWATCH ALARM CONFIGURATION

A CloudWatch alarm was created using the following configuration:

Metric:
- EC2 > Per-Instance Metrics > CPUUtilization
- Selected using the specific instance ID

Condition:
- Threshold type: Static
- Condition: Greater than or equal to 50%
- Period: 1 minute (to match detailed monitoring)
- Statistic: Maximum (used for faster demo results)

In production environments, Average is generally preferred to avoid alerts caused by short spikes.

---

STEP 4: SNS NOTIFICATION SETUP

An Amazon SNS topic was created to send email notifications.

Steps:
- Created a new SNS topic
- Added an email subscription
- Confirmed the subscription by clicking the confirmation link received in email

This confirmation step is mandatory. Without confirmation, alerts will not be delivered.

---

STEP 5: TESTING AND VERIFICATION

Once the CPU usage crossed the defined threshold:
- The CloudWatch alarm state changed from OK to In Alarm
- An email notification was received with alarm details

The email was sometimes delivered to the Promotions or Spam folder, which was verified during testing.

---

IMPORTANT OBSERVATIONS AND BEST PRACTICES

- Detailed monitoring enables faster alerting but increases cost slightly
- Average metrics are recommended for production use
- Maximum metrics are useful for demonstrations and immediate alerts
- SNS subscriptions must always be confirmed
- CloudWatch helps identify underutilized resources, supporting cost optimization
- CloudWatch logs remain available even after resource deletion

---

FINAL OUTCOME

- CloudWatch successfully monitored EC2 CPU utilization
- Alarm triggered correctly during high CPU usage
- Email notification was received through SNS
- End-to-end monitoring and alerting workflow was validated

---
