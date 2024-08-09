variable "project" {
  description = "The project object containing the project ID and project number."
  type = object({
    project_id       = string
    project_number   = string
    project_services = map(object({}))
  })
  validation {
    condition     = length(var.project.project_id) >= 6 && length(var.project.project_id) <= 30 && can(regex("^[a-z][a-z0-9-]*[a-z0-9]$", var.project.project_id))
    error_message = "The project ID must be between 6 and 30 characters, including the suffix, and can only contain lowercase letters, digits, and hyphens. It must start with a letter and cannot end with a hyphen."
  }

  validation {
    condition = alltrue([
      contains(keys(var.project.project_services), "bigquery.googleapis.com")
    ])
    error_message = "The project_services map must include the bigquery.googleapis.com service."
  }
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