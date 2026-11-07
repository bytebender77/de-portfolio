variable "region" {
  type    = string
  default = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix for all resources; the account id suffix keeps the S3 name globally unique."
  type        = string
  default     = "de-portfolio"
}

variable "monthly_budget_usd" {
  type    = number
  default = 5
}

variable "alert_email" {
  description = "Receives budget alerts. Set in an untracked terraform.tfvars."
  type        = string
}

variable "athena_scan_limit_bytes" {
  description = "Per-query data-scanned cutoff for the workgroup (cost guard)."
  type        = number
  default     = 1073741824 # 1 GiB
}
