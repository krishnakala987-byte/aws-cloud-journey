# AWS S3 – Deep Dive

## Focus of this topic
S3 stands for Simple Storage Service. It is the storage backbone of AWS and honestly one of the easiest services to start with, because the core idea is just buckets and objects.

## What makes S3 special
- Highly scalable. I can dump almost unlimited data into it.
- Highly available and secure by default.
- Cost effective, and the cost depends on how I choose to store the data.

## The 11 nines durability
S3 promises 99.999999999 percent durability. In practical terms, if I store millions of objects, statistically I might lose one in thousands of years. This is why companies trust it with critical data instead of maintaining their own storage servers.

## Buckets and regions
- A bucket is created in one specific region, mainly to keep latency low for the users near it.
- Bucket names are globally unique. If someone anywhere in the world took a name, I cannot use it.
- Objects inside are accessible over HTTP, so S3 works naturally with the web.

## Storage classes
The price changes a lot based on access pattern:

- S3 Standard: frequent access, default choice.
- Standard-IA: infrequent access, cheaper storage but retrieval costs.
- Glacier: archives, retrieval takes time.
- Glacier Deep Archive: cheapest, for data I probably never touch but must keep.

Picking the wrong class either wastes money or makes retrieval painful, so this decision actually matters.

## Versioning
With versioning on, S3 keeps every version of an object instead of overwriting it. If I upload a bad file or delete something by mistake, the old version is still there. I enabled it on my test bucket and confirmed old versions stay listed after re-upload.

## Bucket policies practical
This was the best part of the class. I tested a case where an IAM user had full S3 permissions but I attached a bucket policy denying access to that specific bucket. The user could still see other buckets but got access denied on this one. Explicit deny in a bucket policy wins over IAM allow, which is a very useful thing to know for protecting sensitive data.

## Static website hosting practical
1. Created a bucket and uploaded a simple index.html.
2. Enabled static website hosting in the bucket properties.
3. Unblocked public access and added a bucket policy allowing public read.
4. Opened the website endpoint and the page loaded straight from S3, no server needed.

## Mistakes to avoid
- Making a bucket public when it does not need to be. Public access should be a conscious decision, never a shortcut.
- Ignoring storage classes and paying Standard prices for archive data.
- Forgetting that versioning keeps old copies, which also means they keep billing.

## Key takeaway
S3 replaces the whole headache of buying, scaling and securing storage hardware. Understand buckets, policies and storage classes and most real world use cases are covered.
