# IAM Troubleshooting

## Why I wrote this
Most AWS errors are permission-related.

## Core idea in 5 lines
- AccessDenied means policy issue
- Check explicit deny
- Verify attached policies
- Check trust policy for roles
- SCPs can override IAM

## How AWS actually works here
- Permission and trust policies are different
- SCPs apply at organization level

## When I should use this
- Debugging failed AWS actions
- EC2/Lambda access issues

## Common mistakes I must avoid
- Forgetting to attach roles
- Assuming instant propagation
- Ignoring SCPs

## Quick check
AccessDenied = check policies + trust

