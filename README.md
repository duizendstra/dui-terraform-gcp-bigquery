# dui-terraform-gcp-bigquery
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.40.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 5.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_dataset.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset) | resource |
| [google_bigquery_table.tables](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datasets"></a> [datasets](#input\_datasets) | Configuration for BigQuery datsets | <pre>list(object({<br>    dataset_id    = string<br>    friendly_name = string<br>    location      = string<br>    description   = optional(string, "")<br>  }))</pre> | `[]` | no |
| <a name="input_project"></a> [project](#input\_project) | The project object containing the project ID and project number. | <pre>object({<br>    project_id       = string<br>    project_number   = string<br>    project_services = map(object({}))<br>  })</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where Cloud Run service will be deployed | `string` | `"europe-west1"` | no |
| <a name="input_tables"></a> [tables](#input\_tables) | Configuration for BigQuery tables | <pre>list(object({<br>    table_id                 = string<br>    schema_file              = string<br>    table_type               = string<br>    dataset_id               = string<br>    deletion_protection      = optional(bool, true)<br>    require_partition_filter = optional(bool, false)<br>    partition_field          = optional(string, "")<br>    partition_type           = optional(string, "")<br>    source_uris              = optional(list(string), [])<br>    sheet_range              = optional(string, "")<br>    source_format            = optional(string, "")<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bigquery"></a> [bigquery](#output\_bigquery) | Details of the bigquer setup |
<!-- END_TF_DOCS -->