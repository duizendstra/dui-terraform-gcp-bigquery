output "bigquery" {
  description = "Details of the bigquer setup"
  value = {
    datasets = {
      for k, v in google_bigquery_dataset.main : k => {
        dataset_id    = v.dataset_id
        friendly_name = v.friendly_name
        description   = v.description
        location      = v.location
      }
    }
    tables = {
      for table_id, table in google_bigquery_table.tables : table_id => {
        table_id = table_id
        id       = "${table.project}.${table.dataset_id}.${table_id}"
      }
    }
  }
}
