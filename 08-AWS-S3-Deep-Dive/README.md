# AWS S3 – Complete Guide

S3 stands for Simple Storage Service. It is the storage backbone of AWS and honestly one of the easiest services to start with, because the core idea is just buckets and objects. These notes cover the concepts, the security model, storage classes, and the two practicals I did (bucket policies and static website hosting).

---

# 1. What is S3?

An object storage service. I create a bucket, I put objects (files plus their metadata) into it, and S3 handles everything else: scaling, durability, availability, security.

Object storage means there is no file system to mount and no disk to resize. Every object is addressed by its key (the full name/path) over HTTP.

## What makes S3 special

- Highly scalable: no practical limit on data, objects can be up to 5 TB each
- Highly available and durable by default
- Secure: private by default, multiple permission layers
- Cost effective: cost depends on how I choose to store the data

---

# 2. The 11 nines durability

S3 promises 99.999999999 percent durability. In practical terms, if I store millions of objects, statistically I might lose one in thousands of years.

How: every object is automatically stored across multiple Availability Zones (for standard classes). This is why companies trust it with critical data instead of maintaining their own storage servers.

Durability (not losing data) and availability (being able to reach it right now) are different numbers. Durability is 11 nines across almost all classes, availability varies per class.

---

# 3. Buckets and regions

- A bucket is created in one specific region, mainly to keep latency low for the users near it and to meet data residency rules
- Bucket names are globally unique across all AWS accounts. If someone anywhere took a name, I cannot use it
- Objects are accessible over HTTP(S), so S3 works naturally with the web:

```
https://bucket-name.s3.region.amazonaws.com/object-key
```

## Naming rules that bit me

- Lowercase letters, numbers and hyphens only
- No underscores, no uppercase
- Must be 3 to 63 characters

---

# 4. Storage classes

The price changes a lot based on access pattern:

| Class | For | Trade off |
|-------|-----|-----------|
| S3 Standard | frequent access | default, most expensive storage |
| Standard-IA | infrequent access | cheaper storage, retrieval fee, 30 day minimum |
| One Zone-IA | infrequent, re-creatable data | one AZ only, cheaper, less resilient |
| Intelligent-Tiering | unknown/changing patterns | moves objects between tiers automatically |
| Glacier Instant Retrieval | archives needed instantly | cheaper, higher retrieval cost |
| Glacier Flexible Retrieval | archives, minutes to hours | very cheap |
| Glacier Deep Archive | compliance, almost never touched | cheapest, retrieval takes hours, 180 day minimum |

Picking the wrong class either wastes money or makes retrieval painful, so this decision actually matters.

## Lifecycle policies

Instead of moving objects by hand, lifecycle rules do it on a schedule. A typical rule: keep in Standard for 30 days, move to IA, move to Glacier after 90 days, delete after one year. Logs and backups almost always deserve a lifecycle rule.

---

# 5. Versioning

With versioning on, S3 keeps every version of an object instead of overwriting it.

- Upload a bad file: the old version is still there
- Delete an object: S3 just adds a delete marker, the data is recoverable
- I enabled it on my test bucket and confirmed old versions stay listed after re-upload

Things to remember:
- Versioning is off by default, and once enabled it can only be suspended, never fully turned off
- Old versions keep occupying storage and keep billing. Pair versioning with a lifecycle rule that expires old versions

---

# 6. Security model

S3 is private by default. Access is decided by several layers working together:

- IAM policies: what a user or role is allowed to do, attached to the identity
- Bucket policies: rules attached to the bucket itself, JSON, can allow or deny
- Block Public Access: an account/bucket level master switch that overrides everything else
- ACLs: the legacy mechanism, AWS recommends leaving them disabled

The rule that ties it all together: an explicit deny anywhere wins over any allow.

## Bucket policy practical I did

This was the best part of the class. I tested a case where an IAM user had full S3 permissions but I attached a bucket policy denying access to that specific bucket.

Result: the user could still see every other bucket but got access denied on this one. Explicit deny in the bucket policy beat the full allow from IAM. This is exactly how you protect a sensitive bucket even from over-permissioned users inside your own account.

## Encryption

- SSE-S3: AWS managed keys, on by default for new objects
- SSE-KMS: keys in KMS, gives audit trail and control over who can decrypt
- In transit, everything goes over HTTPS

---

# 7. Static website hosting practical

S3 can serve a static website directly, no server needed:

1. Created a bucket and uploaded a simple index.html
2. Enabled static website hosting in the bucket properties and set index.html as the index document
3. Turned off Block Public Access for the bucket (conscious decision, this is a public website)
4. Added a bucket policy allowing public read of objects:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-bucket-name/*"
    }
  ]
}
```

5. Opened the website endpoint and the page loaded straight from S3

In production this pairs with CloudFront for HTTPS and caching (covered later in folder 18).

---

# 8. Common real world uses

- Application file storage (images, uploads, media)
- Backups and disaster recovery
- Log storage from every service
- Data lakes for analytics
- Static website hosting
- Storing artifacts in CI/CD pipelines

---

# 9. Things to remember

- Bucket names are global, buckets themselves are regional
- 11 nines is durability, availability is a separate (lower) number
- Explicit deny always wins, whether from IAM or bucket policy
- Block Public Access overrides even a public bucket policy
- Versioning cannot be disabled once enabled, only suspended
- Old versions bill until a lifecycle rule cleans them up
- Max object size 5 TB, uploads above 5 GB need multipart upload

---

# Mistakes to avoid

- Making a bucket public when it does not need to be. Public access should be a conscious decision, never a shortcut
- Ignoring storage classes and paying Standard prices for archive data
- Enabling versioning without a lifecycle rule and wondering why the bill grows
- Hardcoding bucket names in code without checking the region

---

# Key takeaway

S3 replaces the whole headache of buying, scaling and securing storage hardware. Understand buckets, the security layers and storage classes, and most real world use cases are covered.
