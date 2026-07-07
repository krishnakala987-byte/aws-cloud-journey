# Implementation Steps

The exact order I built it in. Doing it in this order avoids most dependency errors.

---

## 1. VPC and subnets

- Created a custom VPC using the "VPC and more" option, which builds subnets, route tables and gateways together in one screen
- CIDR: 10.0.0.0/16
- Two public and two private subnets, spread over two Availability Zones
- One NAT Gateway placed in a public subnet, with an Elastic IP allocated automatically
- Checked the generated route tables before moving on: public subnets pointing 0.0.0.0/0 to the IGW, private subnets pointing 0.0.0.0/0 to the NAT Gateway

The visual preview in "VPC and more" is honestly the best way to sanity check the design before creating it.

## 2. Launch template and Auto Scaling Group

- Created a launch template with the AMI (Ubuntu), instance type (t2.micro), key pair and the app security group
- A launch template is just the recipe. The ASG is what actually launches instances from it
- Created an Auto Scaling Group from the template: desired 2, min 1, max 4
- Selected only the private subnets for the ASG, so instances launch without public IPs
- Verified two instances came up, one in each AZ, both with private IPs only

## 3. Bastion host

- Launched a separate small EC2 instance in the public subnet with a public IP enabled
- Copied my private key to the Bastion host (scp), then SSH from the Bastion to the private instance using its private IP
- This is the only way in, because private instances cannot be reached from the internet

```bash
# from my laptop
scp -i my-key.pem my-key.pem ubuntu@<bastion-public-ip>:/home/ubuntu/

ssh -i my-key.pem ubuntu@<bastion-public-ip>

# from inside the bastion
ssh -i my-key.pem ubuntu@<private-instance-ip>
```

## 4. Application

- Installed Python on the private instance through the Bastion session
- Wrote a small HTML page and served it:

```bash
python3 -m http.server 8000
```

- Deployed it deliberately on only one of the two instances, to see what the load balancer does with an unhealthy target

## 5. Application Load Balancer

- Created an internet facing ALB in the public subnets of both AZs
- Created a target group on port 8000 with HTTP health checks and registered the private instances
- Listener on port 80 forwarding to the target group
- Updated the ALB security group to allow HTTP traffic on port 80 from anywhere
- Updated the app security group to allow port 8000 from the ALB security group (not from the internet)

## 6. Testing

- Opened the ALB DNS name in the browser and the page loaded
- Target group showed one healthy and one unhealthy target, exactly as expected since the app ran on one instance only
- All traffic went to the healthy instance, which is the health check mechanism doing its job

---

# Problems I hit

- SSH to the private instance kept timing out until I realised I was trying from my laptop instead of from the Bastion host
- Forgot to allow port 8000 from the ALB security group to the instance security group, so the target stayed unhealthy for a while. Fixing the SG made it healthy within seconds
- Started the Python server in the foreground, closed the SSH session, and the app died with it. Restarted it with nohup so it survives the session
- NAT Gateway costs money per hour. I deleted it along with the whole setup right after finishing the practice

---

# Cleanup order that worked

1. Auto Scaling Group (otherwise it keeps recreating the instances I terminate)
2. Load balancer and target group
3. Bastion host
4. NAT Gateway, then release the Elastic IP
5. The VPC itself
