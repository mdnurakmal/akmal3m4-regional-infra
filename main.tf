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
  name                            = "game-server-backend-service-${var.multiregion}"
  enable_cdn                      = true
  timeout_sec                     = 10
  connection_draining_timeout_sec = 10

  backend {
    group = google_compute_region_network_endpoint_group.game-server-neg.id
  }

  backend {
    group = google_compute_region_network_endpoint_group.game-client-neg.id
  }
}