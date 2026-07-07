# AWS CloudFormation – Infrastructure as Code

## Focus of this topic
This is where Infrastructure as Code starts in my journey. Instead of clicking in the console or firing single CLI commands, I describe the whole infrastructure in a template file and CloudFormation creates it for me.

## What IaC actually means
IaC sits between me and the cloud provider. I write what I want in a declarative template, keep it in version control, and the tool converts it into API calls. The template is the single source of truth. Anyone in the team can read it and know exactly what exists.

## CLI vs CFT
My rule after this class:

- Quick short task, one or two resources: AWS CLI.
- Full infrastructure, repeatable and reviewable: CloudFormation template.

## Why YAML over JSON
CFT supports both, but YAML won for me easily:

- YAML allows comments, JSON does not. In a template used by a team, comments matter.
- YAML is shorter and easier to read.

Indentation mistakes are the price to pay, which is why the editor plugins below help a lot.

## Template anatomy
A template has sections like Parameters, Mappings, Conditions, Outputs and Resources. The only mandatory section is Resources. Everything else is optional support around it.

## Features that stood out
- Stack: when I submit a template, CloudFormation creates a stack, and all resources live and die with that stack. Deleting the stack cleans up everything, which is great for practice.
- Drift detection: if someone changes a resource manually outside the template, drift detection catches the difference. I tested this myself below.
- Designer: a visual editor where beginners can drag resources and see the template generated.

## Practical I did
1. Wrote a template that creates an S3 bucket with versioning enabled (the template is in this folder).
2. Created a stack from it and verified the bucket appeared with versioning on.
3. Then I manually suspended versioning on the bucket from the console.
4. Ran drift detection on the stack. It reported the bucket as modified and showed exactly which property drifted. This proved the point that manual changes never stay hidden from CloudFormation.

## Tips that saved me time
- Install the YAML plugin by Red Hat and the AWS Toolkit in VS Code. They give autocomplete for template syntax, so I did not have to keep the documentation open all the time.

## CFT vs Terraform (common interview question)
CloudFormation is native to AWS and only works with AWS. Terraform works across cloud providers. So teams that are fully on AWS may use CFT, while companies with multi cloud or hybrid setups usually choose Terraform. I will be learning Terraform later in this journey for exactly this reason.

## Key takeaway
Templates turn infrastructure into code that can be reviewed, versioned and repeated. After this topic, clicking resources manually in the console started feeling like the wrong way.

## Files in this folder
- s3-bucket-versioning.yaml
