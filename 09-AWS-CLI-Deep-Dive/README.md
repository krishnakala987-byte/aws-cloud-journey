# AWS CLI – Deep Dive

## Focus of this topic
Until now I did everything from the AWS console UI. The UI is good for learning, but nobody creates 50 resources by clicking around. This topic is about the first automation friendly way of talking to AWS, the command line interface.

## UI vs CLI
If my team asks for 10 S3 buckets and 5 EC2 instances, doing it in the UI is slow and error prone. With the CLI the same work is a few commands, and those commands can go inside a script and be repeated any time.

## Where APIs fit in
Every AWS service exposes APIs. Instead of me writing code to call those APIs directly, the CLI acts as a layer in between. I type a simple command, the CLI converts it into the right API call. That is really all the CLI is, a friendly wrapper over AWS APIs.

## CLI vs Terraform vs CloudFormation
- CLI: best for quick day to day tasks. List something, create one resource, check a status.
- CloudFormation and Terraform: best for creating whole infrastructure stacks in a repeatable way.

So the CLI does not replace IaC tools, they solve different sized problems.

## Setup I did
1. Installed the AWS CLI following the official documentation for my OS.
2. Verified with:

```bash
aws --version
```

3. Created an access key for my IAM user and configured the CLI:

```bash
aws configure
```

It asks for the Access Key, Secret Access Key, default region and output format.

## Commands I practised
List all my S3 buckets:

```bash
aws s3 ls
```

Launch an EC2 instance:

```bash
aws ec2 run-instances --image-id ami-xxxxxxxx --instance-type t2.micro --key-name my-key
```

## Learning to read errors
I intentionally ran the run-instances command with missing parameters to see what happens. The CLI clearly tells which required parameter is missing. Reading the error instead of panicking is a habit worth building early, the message usually contains the fix.

## Mistakes to avoid
- Never share or commit the Access Key and Secret Access Key anywhere. Treat them like passwords.
- Do not forget the region flag or config, otherwise resources appear in a region I was not looking at.
- Remember to terminate anything created from the CLI for practice. Resources made from the terminal are easy to forget.

## Key takeaway
The CLI is where AWS stops being a website and starts being programmable. Everything I automate later builds on this idea.
