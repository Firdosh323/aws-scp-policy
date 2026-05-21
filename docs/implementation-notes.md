# Implementation Notes

## Design Principles

- Keep SCPs focused on organization-level boundaries, not application-level authorization.
- Prefer explicit, small policies over one large combined SCP so exceptions stay manageable.
- Treat region restriction and cost controls as OU-specific, not universal.

## Testing Approach

1. Validate JSON syntax and policy intent in a non-production OU.
2. Use AWS Organizations delegated admin or management account credentials for attachment.
3. Test expected denies with representative IAM roles, not only administrators.
4. Capture approved exceptions as separate policies or separate target mappings.

## Terraform Usage

The Terraform in `terraform/` publishes one AWS Organizations policy resource per repository JSON file that appears in `policy_targets`.

Each map entry needs:

- a repository-relative policy path such as `deny-policies/deny-root-user.json`
- one or more target IDs for OUs, roots, or accounts
- optional display `name` and `description`

## Operational Notes

- `deny-region-restriction.json` includes global-service exceptions but still needs review for your service footprint.
- `restrict-expensive-resources.json` intentionally blocks manual snapshots; many teams will want an exception process.
- `mandatory-tagging.json` is intentionally limited to a few create APIs and should expand with your platform standards.
- `deny-wildcard-iam-policies.json` and `restrict-admin-role-creation.json` use placeholder exempt role names and permissions boundaries; adapt them to your identity platform before deployment.
- `restrict-expensive-regions.json` focuses on create APIs for major cost drivers and should be tuned to your approved disaster recovery regions.
