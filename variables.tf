variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region where Cloud Run service will be deployed"
  type        = string
  default     = "europe-west1"
}

variable "datasets" {
  description = "Configuration for BigQuery datsets"
  type = list(object({
    dataset_id    = string
    friendly_name = string
    location      = string
    description   = optional(string, "")
  }))

  default = [
  ]
}

variable "tables" {
  description = "Configuration for BigQuery tables"
  type = list(object({
    table_id                 = string
    schema_file              = string
    table_type               = string
    dataset_id               = string
    deletion_protection      = optional(bool, true)
    require_partition_filter = optional(bool, false)
    partition_field          = optional(string, "")
    partition_type           = optional(string, "")
    source_uris              = optional(list(string), [])
    sheet_range              = optional(string, "")
    source_format            = optional(string, "")
  }))

  default = [
  ]
}