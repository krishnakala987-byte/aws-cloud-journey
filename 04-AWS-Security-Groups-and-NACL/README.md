# AWS Security Groups and NACL

## Focus of this topic
This is the security part of VPC. After learning how traffic enters a VPC, the next question is who actually decides whether a packet reaches my application. The answer is these two layers, Security Groups and NACLs.

## Security Groups
- Work at the instance level (for example one EC2 instance).
- Act as a virtual firewall controlling inbound and outbound traffic.
- Stateful. If I allow a request in, the response is automatically allowed out.
- Can only have allow rules. There is no deny rule in a Security Group.

## NACL (Network Access Control List)
- Works at the subnet level, so it protects every instance inside that subnet at once.
- Stateless. Inbound and outbound rules are checked separately.
- Supports both allow and deny rules, so I can explicitly block an IP or a port.
- Rules are evaluated by rule number, lowest first.

## Shared responsibility
One thing I noted from this class: AWS gives the infrastructure and the default settings, but configuring the rules correctly is my job. If I open port 22 to the whole world and something goes wrong, that is on me, not on AWS.

## Order of evaluation
Traffic entering a subnet meets the NACL first, then the Security Group of the instance. So even if my Security Group allows a port, a deny rule in the NACL will still block it. I verified this myself in the practical below.

## Mistakes to avoid
- Confusing stateful with stateless. This is also a very common interview question.
- Adding an allow rule in the Security Group and forgetting that the NACL might still be blocking it.
- Leaving 0.0.0.0/0 open on ports that do not need it.

## Key takeaway
Security Group is the guard at the house, NACL is the guard at the street. Both must agree before traffic reaches the application.

## Notes in this folder
- SG-vs-NACL-practical.md
