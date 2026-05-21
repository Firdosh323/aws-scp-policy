# HIPAA Mapping

Representative policy coverage for healthcare workloads:

- `deny-disable-cloudtrail.json`: preserves auditability.
- `deny-public-s3.json`: reduces risk of unauthorized disclosure.
- `deny-unencrypted-ebs.json`: supports encrypted storage expectations.
- `enforce-encryption.json`: supports encryption controls for managed storage.
- `deny-security-group-open.json`: reduces broad network exposure.

Pair these SCPs with service configuration controls, logging, and workload-specific safeguards.
