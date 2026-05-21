output "policy_ids" {
  description = "Map of repository policy paths to created AWS Organizations policy IDs."
  value = {
    for policy_path, resource in aws_organizations_policy.scp : policy_path => resource.id
  }
}

output "policy_attachment_ids" {
  description = "Map of attachment keys to AWS Organizations attachment IDs."
  value = {
    for key, resource in aws_organizations_policy_attachment.scp : key => resource.id
  }
}
