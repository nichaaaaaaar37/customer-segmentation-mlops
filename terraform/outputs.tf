# Output values displayed after "terraform apply" finishes
# Useful to quickly see what was created without going to GCP Console

output "bucket_name" {
  description = "GCS bucket name for storing raw and silver data"
  value       = google_storage_bucket.raw_bucket.name
}

output "bucket_url" {
  description = "Full GCS bucket URL"
  value       = google_storage_bucket.raw_bucket.url
}

output "bigquery_dataset" {
  description = "BigQuery dataset ID for storing ML results"
  value       = google_bigquery_dataset.customer_seg.dataset_id
}