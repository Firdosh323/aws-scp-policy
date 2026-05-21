variable "aws_region" {
  description = "AWS region used by the provider for Organizations API calls."
  type        = string
  default     = "us-east-1"
}

variable "policy_directory" {
  description = "Relative path from this module to the SCP JSON files."
  type        = string
  default     = ".."
}

variable "policy_targets" {
  description = "Map of policy file paths to target IDs for attachment. Paths are relative to the repository root."
  type = map(object({
    name        = optional(string)
    description = optional(string)
    target_ids  = list(string)
  }))
  default = {}
}
