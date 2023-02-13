variable "projects" {
  type = list(object({
    id            = string
    region        = string
    zone          = string
    ip_cidr_range = string
    firwall_rules = list(object({
        name          = string
        protocol      = string
        ports         = list(string)
        source_ranges = list(string)
    }))
    gke = object({
        nodes_count             = number
        enable_private_nodes    = bool
        enable_private_endpoint = bool
        enable_private_nodes    = bool
        master_ipv4_cidr_block  = string
        machine_type            = string
        disk_size_gb            = string
    })
  }))
  default = [
    {
        id            = "my-project-1"
        region        = "us-central1"
        zone          = "us-central1-a"
        ip_cidr_range = "10.0.0.0/16"
        firwall_rules = [
            {
                name     = "allow-ssh"
                protocol = "tcp"
                ports    = ["22"]
                source_ranges = ["0.0.0.0/0"]
            },
            {
                name     = "allow-http"
                protocol = "tcp"
                ports    = ["80"]
                source_ranges = ["0.0.0.0/0"]
            },
            {
                name     = "allow-https"
                protocol = "tcp"
                ports    = ["443"]
                source_ranges = ["0.0.0.0/0"]
            }
        ]
        gke           = {
            nodes_count             = 2
            enable_private_nodes    = true
            enable_private_endpoint = false
            master_ipv4_cidr_block  = "172.16.0.0/28"
            machine_type            = "e2-small"
            disk_size_gb            = "50"
        }
    },
    {
        id            = "my-project-2"
        region        = "northamerica-northeast2"
        zone          = "northamerica-northeast2-c"
        ip_cidr_range = "10.0.0.0/16"
        firwall_rules = [
            {
                name     = "allow-http"
                protocol = "tcp"
                ports    = ["80"]
                source_ranges = ["10.0.0.0/16"]
            }
        ]
        gke           = {
            nodes_count             = 1
            enable_private_nodes    = true
            enable_private_endpoint = false
            master_ipv4_cidr_block  = "172.16.0.0/24"
            machine_type            = "e2-small"
            disk_size_gb            = 20
        }
    }
  ]
}
