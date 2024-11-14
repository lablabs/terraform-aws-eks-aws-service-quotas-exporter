# IMPORTANT: Add addon specific variables here
variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "exporter_config" {
  type        = any
  default     = {}
  description = "The configuration for the exporter, see https://github.com/lablabs/aws-service-quotas-exporter/blob/main/config/example.yaml"
}
