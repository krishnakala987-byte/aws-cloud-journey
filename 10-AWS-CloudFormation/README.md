# AWS CloudFormation – Complete Guide

This is where Infrastructure as Code starts in my journey. Instead of clicking in the console or firing single CLI commands, I describe the whole infrastructure in a template file and CloudFormation creates it for me. These notes cover the IaC idea, template anatomy, stacks, drift detection, and the practical I did.

---

# 1. What IaC actually means

IaC (Infrastructure as Code) sits between me and the cloud provider:

1. I write what I want in a declarative template (the end state, not the steps)
2. The template lives in version control like any other code
3. The tool converts the template into API calls and makes reality match the template

The template becomes the single source of truth. Anyone in the team can read it and know exactly what exists, review changes in pull requests, and recreate the whole environment anywhere.

## Declarative vs imperative

- CLI is imperative: do this, then this, then this
- CFT is declarative: this is what should exist. CloudFormation figures out the order, the dependencies and the API calls

---

# 2. CLI vs CFT

My rule after this class:

- Quick short task, one or two resources, checks: AWS CLI
- Full infrastructure, repeatable, reviewable, shared with a team: CloudFormation

---

# 3. Why YAML over JSON

CFT supports both, but YAML won for me easily:

- YAML allows comments, JSON does not. In a template used by a team, comments matter
- YAML is shorter and easier to read
- Less bracket matching pain

Indentation mistakes are the price to pay, which is why the editor plugins below help a lot.

---

# 4. Template anatomy

A template can have these sections:

| Section | Purpose | Mandatory? |
|---------|---------|-----------|
| AWSTemplateFormatVersion | template version, always 2010-09-09 | no |
| Description | what this template does | no |
| Parameters | inputs asked at stack creation (env name, instance type) | no |
| Mappings | fixed lookup tables (region to AMI id) | no |
| Conditions | create resources only if a condition is true | no |
| Resources | the actual AWS resources | YES |
| Outputs | values exported after creation (URLs, IDs) | no |

Resources is the only mandatory section. Everything else is support around it.

## Intrinsic functions

Small helpers used inside templates. The ones I actually needed:

- !Ref : reference a parameter or another resource
- !GetAtt : get an attribute of a resource, like its ARN or DNS name
- !Sub : substitute variables into a string
- !Join : join strings together

---

# 5. Stacks

When I submit a template, CloudFormation creates a stack, and all the resources in the template live and die with that stack.

- Update the template and update the stack: CloudFormation changes only what differs
- Delete the stack: every resource it created gets cleaned up, which is great for practice
- If creation fails midway, CloudFormation rolls back and deletes what it partially created, so no half built infrastructure is left behind

## Change sets

Before updating a live stack, a change set shows exactly what would be modified, added or deleted, without applying anything. This is the review step before touching production, the same idea as terraform plan.

---

# 6. Drift detection

If someone changes a resource manually outside the template (console or CLI), the stack has drifted. Drift detection compares reality with the template and reports the differences per resource and per property.

I tested this myself in the practical below. This feature is the answer to "how do you know if someone changed infra manually".

---

# 7. Other features that stood out

- Designer: a visual editor where beginners can drag resources and see the template generated. Good for learning the syntax, not something I would build production templates with
- Nested stacks: split a big template into smaller reusable ones (network stack, app stack) and call them from a parent stack
- StackSets: deploy the same stack across multiple accounts and regions in one go

---

# 8. Practical I did

1. Wrote a template that creates an S3 bucket with versioning enabled (s3-bucket-versioning.yaml in this folder)
2. Created a stack from it in the console and verified the bucket appeared with versioning on
3. Then I manually suspended versioning on the bucket from the S3 console
4. Ran drift detection on the stack. It reported the bucket as MODIFIED and showed exactly which property drifted (VersioningConfiguration expected Enabled, actual Suspended)
5. Deleted the stack at the end and confirmed the bucket went with it

This small loop (create, drift, detect, delete) taught me more than the theory part did.

---

# 9. Tips that saved me time

- Install the YAML plugin by Red Hat and the AWS Toolkit in Visual Studio Code. They give autocomplete for template syntax, so I did not have to keep the documentation open all the time
- Validate before creating the stack:

```bash
aws cloudformation validate-template --template-body file://template.yaml
```

- Start from the documentation examples for each resource type and trim, instead of writing from a blank file

---

# 10. CFT vs Terraform (common interview question)

| | CloudFormation | Terraform |
|---|---------------|-----------|
| Cloud support | AWS only | multi cloud |
| Language | YAML or JSON | HCL |
| State | managed by AWS inside the stack | state file managed by me/team |
| Preview changes | change sets | terraform plan |
| Cost | free (resources billed normally) | free (open source) |

CloudFormation is native to AWS and deeply integrated. Terraform wins in multi cloud or hybrid environments because one tool and one language covers everything. I will be learning Terraform later in this journey (folder 23) for exactly this reason.

---

# 11. Things to remember

- Resources is the only mandatory template section
- Deleting a stack deletes its resources, know this before deleting anything shared
- Failed stack creation rolls back automatically
- Change sets before updating anything important
- Drift detection catches manual changes, it does not fix them by itself
- YAML for humans, JSON if a machine generates the template

---

# Key takeaway

Templates turn infrastructure into code that can be reviewed, versioned and repeated. After this topic, clicking resources manually in the console started feeling like the wrong way.

## Files in this folder

- s3-bucket-versioning.yaml (the template from the practical)
