# aws-scp-policy

AWS Service Control Policies (SCPs) are organization-level guardrails that define the maximum permissions for member accounts in AWS Organizations.

This repository provides a practical enterprise starter set for security, governance, and cost-control baselines:

- `deny-policies/` for hard-deny protections against unsafe actions
- `guardrail-policies/` for baseline security and cost-control guardrails
- `compliance/` for framework-oriented policy mapping notes
- `terraform/` for publishing and attaching policies with AWS Organizations
- `examples/` for common OU and account attachment profiles
- `docs/` and `diagrams/` for rollout and operational guidance

## Repository Structure

```text
aws-scp-policy/
|-- deny-policies/
|-- guardrail-policies/
|-- compliance/
|   |-- pci-dss/
|   |-- hipaa/
|   |-- cis-benchmark/
|   \-- iso27001/
|-- terraform/
|   |-- main.tf
|   |-- policies.tf
|   |-- variables.tf
|   |-- outputs.tf
|   \-- terraform.tfvars.example
|-- examples/
|   |-- production-ou/
|   |-- sandbox-ou/
|   |-- security-ou/
|   \-- developer-account/
|-- diagrams/
|-- docs/
|-- README.md
\-- LICENSE
```

## Included Policies

### Security SCPs

- `deny-root-user.json`
- `deny-leaving-org.json`
- `deny-disable-cloudtrail.json`
- `deny-public-s3.json`
- `deny-unencrypted-ebs.json`
- `deny-region-restriction.json`
- `deny-iam-user-creation.json`
- `deny-security-group-open.json`
- `deny-wildcard-iam-policies.json`
- `restrict-admin-role-creation.json`
- `mandatory-tagging.json`
- `enforce-mfa.json`
- `enforce-encryption.json`

### Cost Control SCPs

- `restrict-instance-types.json`
- `restrict-expensive-resources.json`
- `restrict-expensive-regions.json`

Recommended future additions are documented in [docs/policy-catalog.md](docs/policy-catalog.md).

## Quick Start

1. Review the policy JSON files and adjust conditions such as allowed regions, required tags, and instance type allowlists.
2. Copy `terraform/terraform.tfvars.example` to a local `.tfvars` file and replace the sample target IDs.
3. Run Terraform from `terraform/` to publish and attach policies.

```bash
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

The Terraform module expects `policy_targets` keyed by repository-relative paths, for example:

```hcl
policy_targets = {
	"deny-policies/deny-root-user.json" = {
		target_ids = ["ou-abcd-production"]
	}
}
```

## Notes

- SCPs do not grant permissions. They only limit what IAM principals in member accounts can do.
- Always test new policies in a sandbox OU before attaching them to production.
- Some condition keys are service-specific. Validate each policy against the AWS documentation before broad rollout.
- Global services such as IAM, Route 53, CloudFront, and Organizations often need exceptions in region-restriction policies.
- Terraform generates one `aws_organizations_policy` resource per mapped JSON file and attaches it to every listed target ID.
- The enterprise IAM policies use example exempt roles such as `IdentityPlatformAdmin` and `SecurityRoleProvisioner`; replace these with your real platform role names before rollout.

## Examples

- Production OU baseline: [examples/production-ou/README.md](examples/production-ou/README.md)
- Sandbox OU baseline: [examples/sandbox-ou/README.md](examples/sandbox-ou/README.md)
- Security OU baseline: [examples/security-ou/README.md](examples/security-ou/README.md)
- Developer account baseline: [examples/developer-account/README.md](examples/developer-account/README.md)

## Compliance Mapping

- PCI DSS: [compliance/pci-dss/README.md](compliance/pci-dss/README.md)
- HIPAA: [compliance/hipaa/README.md](compliance/hipaa/README.md)
- CIS Benchmark: [compliance/cis-benchmark/README.md](compliance/cis-benchmark/README.md)
- ISO 27001: [compliance/iso27001/README.md](compliance/iso27001/README.md)

## Additional Documentation

- Policy catalog: [docs/policy-catalog.md](docs/policy-catalog.md)
- Implementation notes: [docs/implementation-notes.md](docs/implementation-notes.md)

## Validation

- GitHub Actions validates SCP JSON syntax and Terraform formatting and configuration on pushes and pull requests via [.github/workflows/validate.yml](.github/workflows/validate.yml).
