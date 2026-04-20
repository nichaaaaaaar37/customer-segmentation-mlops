# variables.tf — Define all reusable values for this Terraform project
# Think of this like constants in Python: PROJECT_ID = "customer-segmentation-mlops"
# Referenced in main.tf using var.variable_name (e.g. var.project_id)

# Used in main.tf → provider "google" { project = var.project_id }
# Also used in → google_bigquery_dataset { location = var.region }
variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "customer-segmentation-mlops"
}

# Used in main.tf → provider "google" { region = var.region }
# Also used in → google_storage_bucket { location = var.region }
# Also used in → google_bigquery_dataset { location = var.region }
# asia-southeast1 = Singapore — closest region to Thailand, lower latency + cost
variable "region" {
  description = "GCP Region"
  type        = string
  default     = "asia-southeast1"
}

# Used in main.tf → google_storage_bucket { name = var.bucket_name }
# GCS bucket names must be globally unique across ALL GCP users worldwide
# If this name is taken, change to something unique e.g. "customer-seg-mlops-bucket-nicha"
variable "bucket_name" {
  description = "GCS Bucket name"
  type        = string
  default     = "customer-seg-mlops-bucket"
}