output "networks" {
  value = google_compute_network.shared_vpc_network
}

output "subnets" {
  value = google_compute_subnetwork.shared_vpc_subnet
}
