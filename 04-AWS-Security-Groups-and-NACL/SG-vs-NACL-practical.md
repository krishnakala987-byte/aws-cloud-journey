# Practical – Testing Security Groups vs NACL

## What I built
1. Created a custom VPC with a public subnet.
2. Launched an EC2 instance inside that public subnet.
3. Started a simple Python HTTP server on the instance to have something to test against:

```bash
python3 -m http.server 8000
```

## Test 1 – Security Group closed
By default the Security Group did not allow port 8000, so the browser kept loading and nothing came back. This is expected behaviour, not an error.

## Test 2 – Security Group open
Added an inbound rule for port 8000 in the Security Group. Refreshed the browser with the public IP and port 8000 and the page loaded immediately.

## Test 3 – NACL deny overrides Security Group
This was the interesting part. I kept the Security Group rule open and added a deny rule for port 8000 in the NACL of the subnet. The page stopped loading again.

So the NACL sits in front of the Security Group. A deny at the subnet level wins even when the instance level allows the traffic.

## Test 4 – Rule numbers matter
NACL rules run in order of rule number. When I had an allow rule at number 100 and a deny rule at a higher number, the allow won because it was evaluated first. Changing the deny to a lower number blocked the traffic again.

## What I learned from this
- Always check both layers when an application is unreachable.
- NACL rule order is easy to get wrong and easy to forget.
- Testing with a tiny Python server is a cheap way to understand traffic flow before deploying a real app.
