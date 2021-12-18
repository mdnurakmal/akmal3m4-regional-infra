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
  group = "projects/${var.project_id}/regions/${var.region}/networkEndpointGroups/game-server-asia-neg"
  }

}

resource "google_compute_backend_service" "game-client-backend-service" {
  provider = google-beta
  project = var.project_id
  name                            = "game-client-backend-service-${var.multiregion}"
  enable_cdn                      = true
  connection_draining_timeout_sec = 10

  backend {
    group = "projects/${var.project_id}/regions/${var.region}/networkEndpointGroups/game-client-asia-neg"
  }
}

# creating buckets

resource "google_compute_backend_bucket" "web-static-files-backend-bucket-asia" {
  name        = "web-static-files-backend-bucket-asia"
  bucket_name = google_storage_bucket.web-static-files-bucket-asia.name
  enable_cdn  = true
}

resource "google_storage_bucket" "web-static-files-bucket-asia" {
  name     = "dronegaga-web-static-files-asia"
  location = "asia"
}

resource "google_compute_backend_bucket" "game-assets-backend-bucket-asia" {
  name        = "game-assets-backend-bucket-asia"
  bucket_name = google_storage_bucket.game-assets-bucket-asia.name
  enable_cdn  = true
}

resource "google_storage_bucket" "game-assets-bucket-asia" {
  name     = "dronegaga-game-assets-asia"
  location = "asia"
}




