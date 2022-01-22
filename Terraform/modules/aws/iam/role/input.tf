variable "name" {
  description = "Policy Name"
}

variable "assume_role_policy" {
  description = "Assume Policy JSON"
}

variable "policy_to_attach" {
  description = "Policy ARN to attach"
}

variable "description" {
  description = "The description of the role"
  default     = ""
}
