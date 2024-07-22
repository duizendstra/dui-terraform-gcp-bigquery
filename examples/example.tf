terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.38.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.38.0"
    }
  }
}

module "bigquery" {
  source     = "./.."
  project_id = "your-project-id"
  datasets = [{
    dataset_id    = "your_dataset_id"
    friendly_name = "your_friendly_name"
    description   = "your_description"
    location      = "EU"
  }]
  tables = [{
    dataset_id  = "my_dataset"
    table_id    = "example"
    schema_file = "example.json"
    table_type  = "basic"
    }
  ]
}





