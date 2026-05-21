# Production OU Baseline

Recommended attachment set for production workloads:

- `deny-root-user.json`
- `deny-leaving-org.json`
- `deny-disable-cloudtrail.json`
- `deny-public-s3.json`
- `deny-unencrypted-ebs.json`
- `deny-security-group-open.json`
- `deny-region-restriction.json`
- `deny-wildcard-iam-policies.json`
- `restrict-admin-role-creation.json`
- `enforce-encryption.json`
- `mandatory-tagging.json`
- `restrict-instance-types.json`
- `restrict-expensive-regions.json`

Use production OUs for the strictest baseline and keep exceptions narrow and documented.
