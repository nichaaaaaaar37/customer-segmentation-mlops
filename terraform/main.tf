# Define which Terraform plugins (providers) this project needs
# Similar to requirements.txt in Python
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google" # Download GCP plugin from Terraform registry
      version = "~> 5.0"          # Use version 5.x (~> means 5.0, 5.1, 5.2 are ok but NOT 6.0)
    }
  }
}

# Tell Terraform HOW to connect to GCP
# credentials = service account key we created earlier
# project + region = pulled from variables.tf using var.
provider "google" {
  credentials = file("~/.config/gcloud/customer-seg-sa-key.json")
  project     = var.project_id   # "customer-segmentation-mlops"
  region      = var.region       # "asia-southeast1"
}

# Create a GCS Bucket (like a folder on cloud storage)
# Used to store: raw CSV from Kaggle + silver parquet after cleaning
# "google_storage_bucket" = resource type (GCP)
# "raw_bucket" = internal Terraform name to reference this resource
resource "google_storage_bucket" "raw_bucket" {
  name          = var.bucket_name  # Bucket name on GCP
  location      = var.region       # Store data in Singapore region
  force_destroy = true             # Allow bucket deletion even if it has files (good for dev)

  # Enforce permissions at bucket level
  # Prevents accidental public access
  uniform_bucket_level_access = true
}

# Create a BigQuery Dataset
# Dataset = like a "database" that holds tables inside
# Our ML predictions + transformed data will live here
resource "google_bigquery_dataset" "customer_seg" {
  dataset_id = "customer_segmentation"  # Dataset name in BigQuery
  location   = var.region               # Must match GCS region to avoid data transfer costs
}