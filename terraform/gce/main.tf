resource "google_compute_address" "appflowy-cloud" {
  project      = var.project
  region       = var.region
  name         = var.name
  network_tier = var.network_tier
}

resource "google_compute_instance" "appflowy-cloud" {
  name         = var.name
  machine_type = var.machine_type
  project      = var.project
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.os_image
      size  = var.disk_size
      type  = var.disk_type
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
      network_tier = var.network_tier
      nat_ip       = google_compute_address.appflowy-cloud.address
    }
  }

  metadata = {
    "ssh-keys" = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  tags = var.tags
}
