# IAM Security Best Practices

## Why I wrote this
IAM mistakes can compromise the entire AWS account.

## Core idea in 5 lines
- Root is for emergencies only
- MFA is mandatory
- Roles are safer than keys
- Rotate credentials
- Remove unused permissions

## How AWS actually works here
- IAM Access Analyzer helps detect issues
- CloudTrail logs IAM activity
- Least privilege reduces blast radius

## When I should use this
- Setting up new AWS accounts
- Auditing permissions
- Improving account security

## Common mistakes I must avoid
- No MFA
- Long-lived keys
- Over-permissioned roles


