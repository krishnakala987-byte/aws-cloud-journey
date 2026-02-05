# Errors and Problems Faced During CloudFront Demo

This document records the issues and errors I faced while setting up and cleaning up the Amazon CloudFront demo project.  
These problems helped me understand AWS behavior more deeply, especially around billing, dependencies, and service limitations.

---

## Issue 1: Unable to Delete CloudFront Distribution

### Problem
After completing the demo, I tried to delete the CloudFront distribution.  
Even after disabling it, AWS did not allow deletion and showed an error message related to a pricing plan or billing cycle.

### Cause
CloudFront distributions cannot be deleted immediately if they are associated with:
- A pricing plan or trial
- A billing-cycle lock

Even if the pricing plan was free or part of a demo, AWS enforces a monthly billing cycle before allowing deletion.

### Solution
- Disabled the CloudFront distribution
- Confirmed that no traffic was being served
- Learned that deletion is only possible after the billing cycle ends

### Learning
Disabling a CloudFront distribution is enough to stop charges, even if deletion is temporarily blocked.

---

## Issue 2: Savings Bundle / Pricing Plan Not Visible

### Problem
AWS error messages indicated that the distribution was linked to a pricing plan, but the Savings Bundle inventory showed no active plans.

### Cause
Some demo or trial-based pricing features do not appear in the Savings Bundle inventory after expiration, but the billing lock still applies internally.

### Solution
- Verified Savings Bundle inventory
- Confirmed no active plans existed
- Understood that the lock was internal and time-based

### Learning
Not all pricing-related restrictions are visible in the AWS console UI.

---

## Issue 3: Charges Showing Even When Service Usage Was Zero

### Problem
The billing dashboard showed an outstanding INR amount even though all individual AWS services showed zero usage.

### Cause
- Promotional credits had expired
- GST (tax) was applied separately
- Taxes were not covered by credits
- Charges appeared at the invoice level, not service level

### Solution
- Checked Billing → Bills → Previous month
- Identified tax-related charges
- Confirmed no ongoing usage

### Learning
AWS billing views can be misleading if taxes and credits are not fully understood.

---

## Issue 4: Fear of Resources Reactivating Automatically

### Problem
While attempting to delete resources earlier, some services appeared to re-enable or fail deletion, causing concern about ongoing charges.

### Cause
AWS resources have dependencies.  
Deleting child resources before parent resources can cause:
- Deletion failures
- Confusing states

### Solution
- Followed a correct deletion order
- Disabled services first
- Verified billing dashboard after cleanup

### Learning
AWS resource deletion must always respect dependency order.

---

## Issue 5: Concern About Charges After Disabling Services

### Problem
There was uncertainty about whether disabled services, especially CloudFront, would still generate charges.

### Cause
AWS documentation and UI are not always explicit about billing behavior after disabling services.

### Solution
- Confirmed that a disabled CloudFront distribution does not serve traffic
- Verified that no usage-based charges occur when disabled

### Learning
Understanding the difference between "disabled" and "deleted" is critical in AWS.

---

## Role of ChatGPT in Troubleshooting

During this process, ChatGPT was used to:
- Interpret AWS error messages
- Understand billing behavior
- Identify safe cleanup steps
- Learn correct deletion order
- Gain confidence before making changes

This helped avoid further mistakes and unnecessary charges.

---

## Final Reflection

These issues were not just problems, but valuable learning points.  
They improved understanding of AWS CloudFront, billing cycles, cost management, and real-world cloud behavior.

Documenting errors and fixes is as important as documenting success.
