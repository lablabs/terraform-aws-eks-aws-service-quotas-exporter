# IMPORTANT: Add addon specific variables here
variable "exporter_config" {
  type        = any
  default     = {}
  description = "The configuration for the exporter, see https://github.com/lablabs/aws-service-quotas-exporter/blob/main/config/example.yaml"
}
