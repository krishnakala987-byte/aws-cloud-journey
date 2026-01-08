# IAM Policies

## Why I wrote this
Most IAM issues happen because of incorrect policies.

## Core idea in 5 lines
- Policies define permissions
- Written in JSON
- Allow or deny actions
- Applied to identities or resources
- Evaluated on every request

## How AWS actually works here
- DENY > ALLOW
- No ALLOW = implicit deny
- Multiple policies are combined during evaluation

## When I should use this
- Restrict access to S3, EC2, etc.
- Follow least privilege
- Control actions precisely

## Common mistakes I must avoid
- Using wildcards everywhere
- Not understanding implicit deny
- Mixing permissions blindly


## Main points
- DENY always wins
- Policies are evaluated at runtime
