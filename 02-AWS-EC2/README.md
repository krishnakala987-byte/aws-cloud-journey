# AWS EC2 – Deep Dive

## Why I wrote this
Most of my real AWS practice started with EC2. Almost every project needs a server somewhere, so getting comfortable with EC2 early made the later topics much easier.

## What is EC2?
EC2 stands for Elastic Cloud Compute. In simple words, I ask AWS for a virtual server (a mix of CPU, RAM and disk) and it gives me one in a few minutes. The word elastic means I can scale the resources up or down based on demand.

## Why use EC2?
- Less management work for me. AWS handles the hardware, security patching and virtualization.
- Pay as you go. I only pay while the server is running, so I can shut it down when I am not using it and save money.

## Instance types
AWS groups instances by the kind of work they are good at:
- General purpose
- Compute optimized
- Memory optimized
- Storage optimized
- Accelerated computing

For this practice I used a general purpose instance, which is enough for learning and small deployments.

## Regions and Availability Zones
- A Region is a physical location in the world. I pick one close to my users to reduce latency and to meet data rules.
- Availability Zones are separate data centers inside a region. Spreading across AZs is how AWS gives high availability and fault tolerance.

## Practical: deploying Jenkins on EC2
This was the hands-on part of the topic.

1. Launched an EC2 instance and made sure to pick a Free Tier eligible type (t2.micro) so I do not get charged.
2. Created a key pair and kept it safe for secure SSH access.
3. Connected to the instance from my terminal.
4. Updated the system packages and installed Java, since Jenkins needs it.
5. Installed and started the Jenkins service.
6. Opened port 8080 in the Security Group inbound rules so I could reach Jenkins from my browser.
7. Accessed Jenkins using the public IP and port 8080.

## Mistakes to avoid
- Launching a bigger instance than needed and forgetting the Free Tier limit.
- Leaving the instance running after the practice is done.
- Forgetting to open the right port in the Security Group and then wondering why the app will not load.

## Key takeaway
EC2 stops feeling like magic once I think of it as a rented computer that I can start, stop and resize whenever I want.
