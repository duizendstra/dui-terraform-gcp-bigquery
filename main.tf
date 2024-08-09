terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.40.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.40.0"
    }
  }
}

resource "google_bigquery_dataset" "main" {
  for_each = { for dataset in var.datasets : dataset.dataset_id => dataset }

  project = var.project.project_id

  dataset_id    = each.value.dataset_id
  friendly_name = each.value.friendly_name
  description   = each.value.description
  location      = each.value.location
}

resource "google_bigquery_table" "tables" {
  for_each = { for table in var.tables : table.table_id => table }

  project             = var.project.project_id
  dataset_id          = each.value.dataset_id
  table_id            = each.value.table_id
  deletion_protection = each.value.deletion_protection

  schema = file("bigquery-schemas/${each.value.schema_file}")

  dynamic "time_partitioning" {
    for_each = each.value.partition_field != "" && each.value.partition_type != "" ? [1] : []
    content {
      field = each.value.partition_field
      type  = each.value.partition_type
    }
  }

  dynamic "external_data_configuration" {
    for_each = each.value.table_type == "external" ? [1] : []
    content {
      autodetect    = true
      source_format = each.value.source_format

      google_sheets_options {
        range = each.value.sheet_range
      }

      source_uris = ["https://docs.google.com/spreadsheets/d/${each.value.source_uris}"]
    }
  }
  depends_on = [google_bigquery_dataset.main]
}