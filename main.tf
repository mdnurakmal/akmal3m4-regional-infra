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


resource "google_compute_backend_service" "game-server-backend-service" {
  provider = google-beta
  project = var.project_id
  name                            = "game-server-backend-service-${var.multiregion}"
  enable_cdn                      = true
  connection_draining_timeout_sec = 10

  backend {
  group = "projects/${var.project_id}/regions/${var.region}/networkEndpointGroups/game-server-${var.multiregion}-neg"
  }

}

resource "google_compute_backend_service" "game-client-backend-service" {
  provider = google-beta
  project = var.project_id
  name                            = "game-client-backend-service-${var.multiregion}"
  enable_cdn                      = true
  connection_draining_timeout_sec = 10

  backend {
    group = "projects/${var.project_id}/regions/${var.region}/networkEndpointGroups/game-client-${var.multiregion}-neg"
  }
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

# creating backend bucket
resource "google_compute_backend_bucket" "web-static-files-backend-bucket" {
  name        = "web-static-files-backend-bucket"
  bucket_name = google_storage_bucket.web-static-files-bucket.name
  enable_cdn  = true
}

resource "google_compute_backend_bucket" "game-assets-backend-bucket" {
  name        = "game-assets-backend-bucket"
  bucket_name = google_storage_bucket.game-assets-bucket.name
  enable_cdn  = true
}


