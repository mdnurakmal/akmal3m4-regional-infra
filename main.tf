terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.53"
    }
  }

    backend "gcs" {
  }

}


provider "google" {
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  project     = var.project_id
  region      = var.region
}

# creating buckets

resource "google_compute_backend_bucket" "web-static-files-backend-bucket" {
  name        = "web-static-files-backend-bucket-${var.multiregion}"
  bucket_name = google_storage_bucket.web-static-files-bucket.name
  enable_cdn  = true
}

resource "google_storage_bucket" "web-static-files-bucket" {
  name     = "dronegaga-web-static-files-${var.multiregion}"
  location = "${var.multiregion}"
}

resource "google_compute_backend_bucket" "game-assets-backend-bucket" {
  name        = "game-assets-backend-bucket-${var.multiregion}"
  bucket_name = google_storage_bucket.game-assets-bucket.name
  enable_cdn  = true
}

resource "google_storage_bucket" "game-assets-bucket" {
  name     = "dronegaga-game-assets-${var.multiregion}"
  location = "${var.multiregion}"
}

