# Billing Lessons Learned

## Free Tier Limitations

AWS free tier resources have usage limits. Exceeding these limits, even temporarily, can generate charges.

Free tier should be treated as a learning aid, not a guarantee of zero cost.

---

## Credits and Expiry

Promotional credits are time-bound. Once expired, any usage is billed normally.

In many cases, taxes are not covered by credits and appear as payable amounts.

---

## India-Specific Tax Behavior

AWS applies GST in India. Tax charges may not appear under individual services but are reflected at the invoice level.

This can make it seem like charges appeared unexpectedly.

---

## Services That Can Charge Quickly

Some resources start charging immediately upon creation:
- NAT Gateways
- Elastic IPs (if not attached)
- AWS WAF
- CloudFront security features

These should be deleted as soon as they are no longer required.

---

## Disable vs Delete

Disabling a service like CloudFront stops usage and billing, even if deletion is temporarily blocked due to billing cycles.

Deletion order matters due to service dependencies.

---

## Final Takeaway

Learning AWS also means learning cost control.  
Monitoring billing and cleaning up resources is as important as building the solution itself.

