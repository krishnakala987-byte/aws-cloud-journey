# Questions and My Answers

## 1. Design a highly available and scalable 2-tier application
Put the load balancer in public subnets and the application servers in private subnets, spread across at least two Availability Zones. Use an Auto Scaling Group so instances are added or removed with traffic. This is exactly the production VPC project in folder 06.

## 2. Restrict outbound internet access for one subnet only
Change the route table of that subnet. Remove the route that points 0.0.0.0/0 to the Internet Gateway or NAT Gateway. Since route tables are per subnet, other subnets are not affected.

## 3. Private instances need to download software updates. How?
Place a NAT Gateway in a public subnet and add a route from the private subnet to it. The NAT Gateway performs the address translation, so instances get internet access for downloads but nobody outside can reach them.

## 4. How do two instances communicate inside a VPC? Across VPCs?
Inside the same VPC, they simply use private IP addresses. Across two VPCs, set up VPC Peering and update the route tables on both sides so traffic knows the path.

## 5. How do you add a subnet level security layer?
Use a Network ACL. It applies to the entire subnet, so every instance inside gets that protection, and unlike Security Groups it can explicitly deny traffic.

## 6. A workload is sensitive and must be fully isolated
Put it in a subnet whose route table has no route to any gateway. No Internet Gateway, no NAT. The subnet can then only talk within the VPC.

## 7. An instance needs to reach S3 without going over the internet
Use a VPC Endpoint. A Gateway Endpoint for S3 adds an entry in the route table so traffic to S3 stays inside the AWS network.

## 8. Difference between NACL and Security Group?
NACL is subnet level, stateless, supports allow and deny, and evaluates rules by number. Security Group is instance level, stateful, allow rules only. Stateful means return traffic is automatically allowed, stateless means I must open both directions myself.

## 9. What are IAM Users, Groups, Policies and Roles?
Users are identities for people. Groups collect users so permissions are managed once for a team. Policies are the JSON documents that define the actual permissions. Roles give permissions to services or temporary identities, for example an EC2 instance that needs to read from S3 gets a role, not access keys.

## 10. How do you SSH into instances that live in a private subnet?
Through a Bastion host, also called a jump server. It is a small instance in the public subnet. I SSH to the Bastion first and from there to the private instance. The private instances never need public IPs.
