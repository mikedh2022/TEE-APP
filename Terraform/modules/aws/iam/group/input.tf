variable "administrator_users" {
  description = "list of administrator users"
  default     = [""]
  type        = "list"
}

variable "devops_users" {
  description = "list of devops users"
  default     = [""]
  type        = "list"
}

variable "back_office_users" {
  description = "list of back-office users"
  default     = [""]
  type        = "list"
}

variable "developers_users" {
  description = "list of developers users"
  type        = "list"
}
