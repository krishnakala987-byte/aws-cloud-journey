# AWS VPC – Virtual Private Cloud

## Why I wrote this
Networking was the topic I feared the most when I started AWS. VPC has a lot of moving parts, so I wrote these notes in the simplest words possible so that future me can revise quickly.

## The gated community analogy
The easiest way I understood VPC is to compare it with a secure gated community.

- The community itself is the VPC. Nobody from outside can walk in directly.
- Individual houses are the EC2 instances.
- Streets inside the community are the subnets.
- The main gate is the Internet Gateway.
- The security guard at each house is the Security Group.

Once this picture was clear in my head, every VPC component started making sense.

## Why VPC exists at all
Earlier, if everyone's servers sat in one shared network, a problem with one user could affect others. That is not acceptable for any serious company. So AWS gives each account its own isolated virtual network. Whatever I run inside my VPC stays inside my VPC unless I decide to expose it.

## How big is a VPC?
The size of a VPC is decided by the IP address range I give it, called a CIDR block. For example 10.0.0.0/16 gives me around 65,000 IP addresses. As a DevOps engineer the job is to take this big block and divide it into smaller subnets for different teams or projects.

## Core components
- Internet Gateway: the entry and exit point between my VPC and the internet. Without it, nothing inside the VPC can talk to the outside world.
- Public subnet: a subnet whose route table has a path to the Internet Gateway. Load balancers usually sit here.
- Private subnet: a subnet with no direct route to the internet. Application servers should live here.
- Route tables: they decide where the traffic goes. Every subnet is attached to one.
- Security Groups: virtual firewall at the instance level. I control traffic by port and IP.
- NACL (Network ACL): security layer at the subnet level. This one can explicitly deny traffic, which Security Groups cannot do.

## NAT Gateway
This one confused me at first. Instances in a private subnet still need to download packages and updates from the internet. A NAT Gateway sits in the public subnet and does this on their behalf. The private instance IP is masked, so the outside world never learns the actual IP of my servers.

## VPC Flow Logs
Flow logs record the traffic moving inside the VPC. When something is not reachable and I cannot figure out why, flow logs are the tool to debug the network.

## How a request actually flows
This is how I remember the whole picture. A user on the internet hits the Internet Gateway, the request lands on a load balancer in the public subnet, the route table forwards it to the application in the private subnet, and the Security Group on the instance takes the final decision to allow or block it.

## Mistakes to avoid
- Creating a subnet and forgetting to associate the right route table.
- Putting application servers in a public subnet just because it is easier.
- Assuming a private instance can download packages without a NAT Gateway.

## Key takeaway
VPC is not one service, it is a set of small pieces working together. Learn each piece alone first, then the full picture becomes easy.
