locals {
  normalized_policy_targets = {
    for policy_path, config in var.policy_targets : policy_path => {
      name        = coalesce(try(config.name, null), trimsuffix(basename(policy_path), ".json"))
      description = coalesce(try(config.description, null), format("Service control policy sourced from %s", policy_path))
      target_ids  = config.target_ids
      content     = file("${path.module}/${var.policy_directory}/${policy_path}")
    }
  }

  attachment_matrix = flatten([
    for policy_path, config in local.normalized_policy_targets : [
      for target_id in config.target_ids : {
        key         = "${policy_path}:${target_id}"
        policy_path = policy_path
        target_id   = target_id
      }
    ]
  ])

  attachments = {
    for item in local.attachment_matrix : item.key => item
  }
}

resource "aws_organizations_policy" "scp" {
  for_each = local.normalized_policy_targets

  name        = each.value.name
  description = each.value.description
  content     = each.value.content
  type        = "SERVICE_CONTROL_POLICY"
}

resource "aws_organizations_policy_attachment" "scp" {
  for_each = local.attachments

  policy_id = aws_organizations_policy.scp[each.value.policy_path].id
  target_id = each.value.target_id
}
