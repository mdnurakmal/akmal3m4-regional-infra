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
    group = game-server-asia-neg
  }

}

resource "google_compute_backend_service" "game-client-backend-service" {
  provider = google-beta
  project = var.project_id
  name                            = "game-client-backend-service-${var.multiregion}"
  enable_cdn                      = true
  connection_draining_timeout_sec = 10

  backend {
    group = game-client-asia-neg
  }
}