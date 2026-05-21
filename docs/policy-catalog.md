# Policy Catalog

This repository groups service control policies into three practical buckets:

## Hard Deny Policies

Use these to block actions that should almost never be possible in member accounts.

| Policy | Purpose |
| --- | --- |
| `deny-root-user.json` | Blocks use of the member account root principal. |
| `deny-leaving-org.json` | Prevents accounts from leaving the AWS Organization. |
| `deny-disable-cloudtrail.json` | Prevents trail tampering and logging shutdown. |
| `deny-public-s3.json` | Blocks public ACLs and deletion of Public Access Block settings. |
| `deny-unencrypted-ebs.json` | Requires encrypted EBS volumes at launch and creation time. |
| `deny-region-restriction.json` | Restricts actions to approved regions with global-service exceptions. |
| `deny-iam-user-creation.json` | Forces role-based access by denying IAM user creation flows. |
| `deny-security-group-open.json` | Blocks internet-open security group ingress rules. |
| `deny-wildcard-iam-policies.json` | Restricts broad IAM policy attachment and customer-managed policy version changes to designated platform roles. |
| `restrict-admin-role-creation.json` | Limits creation and escalation of administrative roles to approved identity and security roles. |

## Guardrail Policies

Use these to steer platform behavior without turning every control into a blanket deny.

| Policy | Purpose |
| --- | --- |
| `mandatory-tagging.json` | Requires `Environment`, `Owner`, and `CostCenter` tags on selected creates. |
| `enforce-mfa.json` | Denies sensitive IAM and STS actions when MFA is not present. |
| `enforce-encryption.json` | Requires encryption for RDS storage and selected EC2 storage operations. |
| `restrict-instance-types.json` | Allows only approved EC2 families for standard workloads. |
| `restrict-expensive-resources.json` | Denies GPU and other expensive EC2 families, large RDS classes, and manual snapshots. |
| `restrict-expensive-regions.json` | Blocks high-cost regions for compute and data-plane service creation except for approved platform roles. |

## Recommended Enterprise Additions

These are common next-step SCPs for larger organizations:

- Deny internet-facing load balancers outside approved VPCs.
- Deny unsupported database engines and oversized analytics clusters.
- Block disabling AWS Config and Security Hub in governed OUs.

## Rollout Guidance

1. Start with sandbox and developer accounts.
2. Attach regional and cost policies before stricter identity guardrails.
3. Record business exceptions in OU-specific examples under `examples/`.
4. Promote policies to production only after validating service-specific condition keys.
