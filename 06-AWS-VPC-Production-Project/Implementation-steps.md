# Implementation Steps

## 1. VPC and subnets
- Created a custom VPC using the VPC and more option, which builds subnets, route tables and gateways together.
- Two public and two private subnets, spread over two Availability Zones.
- One NAT Gateway placed in the public subnet.

## 2. Launch template and Auto Scaling Group
- Created a launch template with the AMI, instance type and security group.
- Created an Auto Scaling Group from the template with desired capacity 2.
- Selected only the private subnets for the ASG, so instances launch without public IPs.
- Verified two instances came up, one in each AZ.

## 3. Bastion host
- Launched a separate small EC2 instance in the public subnet with a public IP.
- Copied my key to the Bastion host and then did SSH from the Bastion to the private instance using its private IP.
- This is the only way in, because private instances cannot be reached from the internet.

## 4. Application
- Installed Python on the private instance through the Bastion session.
- Wrote a small HTML page and served it:

```bash
python3 -m http.server 8000
```

## 5. Application Load Balancer
- Created an internet facing ALB in the public subnets.
- Created a target group on port 8000 and registered the private instances.
- Updated the security group to allow HTTP traffic on port 80 to the ALB.

## 6. Testing
- Opened the ALB DNS name in the browser and the page loaded.
- One target showed unhealthy at first because the app was deployed on only one instance, which also proved the health checks were doing their job.

## Problems I hit
- SSH to the private instance kept timing out until I realised I was trying from my laptop instead of from the Bastion host.
- Forgot to allow port 8000 from the ALB security group to the instance security group, so the target stayed unhealthy for a while.
- NAT Gateway costs money per hour. I deleted it along with the whole setup right after finishing the practice.
