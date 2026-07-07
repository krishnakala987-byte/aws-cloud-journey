# AWS CLI – Complete Guide

Until now I did everything from the AWS console UI. The UI is good for learning, but nobody creates 50 resources by clicking around. This topic is about the first automation friendly way of talking to AWS, the command line interface. These notes cover why the CLI exists, how authentication works, the command structure, and the commands I practised.

---

# 1. Why CLI over UI?

If my team asks for 10 S3 buckets and 5 EC2 instances:

- Console: repeat the same clicks 15 times, slow and error prone
- CLI: a few commands, and those commands can go inside a script and run again any time

The UI is for learning and exploring. The CLI is for doing things repeatedly and reliably.

---

# 2. Where APIs fit in

Every AWS service exposes APIs. Everything, including the console itself, ultimately calls these APIs.

Instead of me writing code to call the APIs directly, the CLI acts as a layer in between. I type a simple command, the CLI converts it into the right API call, sends it, and prints the response.

That is really all the CLI is: a friendly wrapper over AWS APIs.

---

# 3. CLI vs Terraform vs CloudFormation

| Tool | Best for |
|------|----------|
| AWS CLI | quick day to day tasks, checks, one-off resources, shell scripts |
| CloudFormation | full AWS infrastructure as versioned templates |
| Terraform | infrastructure as code across multiple clouds |

So the CLI does not replace IaC tools, they solve different sized problems. Quick short task: CLI. Whole environment: IaC (next topic, folder 10).

---

# 4. Installation and setup

1. Installed the AWS CLI v2 following the official documentation for my OS
2. Verified:

```bash
aws --version
```

3. Created an access key for my IAM user (IAM -> Users -> Security credentials -> Create access key)
4. Configured the CLI:

```bash
aws configure
```

It asks for four things: Access Key ID, Secret Access Key, default region, default output format (json is the usual choice).

## What configure actually does

It writes two plain text files in the home directory:

- ~/.aws/credentials (the keys)
- ~/.aws/config (region and output settings)

Knowing this helps when debugging auth issues: the CLI is just reading these files.

## Named profiles

For more than one account or user, profiles keep credentials separate:

```bash
aws configure --profile dev
aws s3 ls --profile dev
```

---

# 5. Command structure

Every command follows the same shape:

```
aws <service> <operation> [parameters]
```

Examples: aws s3 ls, aws ec2 describe-instances, aws iam list-users. Once this pattern clicks, unfamiliar services stop being scary, the pattern is always the same.

---

# 6. Commands I practised

List all my S3 buckets:

```bash
aws s3 ls
```

Copy a file to a bucket:

```bash
aws s3 cp file.txt s3://my-bucket/
```

Launch an EC2 instance:

```bash
aws ec2 run-instances --image-id ami-xxxxxxxx --instance-type t2.micro --key-name my-key
```

List instances (the raw output is huge, so filtering matters):

```bash
aws ec2 describe-instances --query "Reservations[].Instances[].[InstanceId,State.Name]" --output table
```

The --query flag filters the JSON response and --output table makes it readable. These two flags turned the CLI from noisy to actually useful for me.

---

# 7. Learning to read errors

I intentionally ran the run-instances command with missing parameters to see what happens. The CLI clearly tells which required parameter is missing.

Reading the error instead of panicking is a habit worth building early, the message usually contains the fix. The common ones I met:

- missing required parameter: add the flag it names
- UnauthorizedOperation: my IAM user lacks that permission
- could not connect to the endpoint: wrong region name in the command or config

For any command, help is built in:

```bash
aws ec2 run-instances help
```

---

# 8. Security rules I follow with the CLI

- Never share or commit the Access Key and Secret Access Key anywhere. Treat them like passwords, because they are
- Never create access keys for the root user
- Give the IAM user behind the CLI only the permissions it needs
- Rotate keys periodically, delete keys that are not used
- On EC2, use IAM roles instead of storing keys on the instance

---

# 9. Things to remember

- The CLI reads credentials from ~/.aws/credentials, config from ~/.aws/config
- Region matters: without it set, commands fail or hit the wrong region and resources "disappear"
- --query and --output table make responses readable
- --dry-run on EC2 commands tests permissions without creating anything
- Everything the console does, the CLI can do, because both call the same APIs
- Resources created from the terminal are easy to forget. Terminate practice resources immediately

---

# Key takeaway

The CLI is where AWS stops being a website and starts being programmable. Everything I automate later builds on this idea.
