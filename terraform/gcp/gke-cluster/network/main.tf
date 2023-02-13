# Shared VPC network
resource "google_compute_network" "shared_vpc_network" {
    count = length( var.projects )
    name = "${var.projects[count.index].id}-shared-vpc-network"
}

locals {
    firewall_rules = flatten([
        for proj_index, project in var.projects : [
            for fw_rule in project.firwall_rules : {
                network_id         = proj_index
                project_id         = project.id
                rule_name          = fw_rule.name
                rule_protocol      = fw_rule.protocol
                rule_ports         = fw_rule.ports
                rule_source_ranges = fw_rule.source_ranges
            }
        ]
    ])
}

# Shared VPC firewall rules
resource "google_compute_firewall" "firwall_rules" {
    for_each = { for rule in local.firewall_rules: "${rule.project_id}-${rule.rule_name}"=>rule }
    network = google_compute_network.shared_vpc_network[each.value.network_id].self_link
    name = "${each.value.project_id}-${each.value.rule_name}"
    allow {
        protocol = each.value.rule_protocol
        ports = each.value.rule_ports
    }
    source_ranges = each.value.rule_source_ranges
}

# Shared VPC subnet
resource "google_compute_subnetwork" "shared_vpc_subnet" {
    count = length( var.projects )
    network = google_compute_network.shared_vpc_network[count.index].self_link
    name = "${var.projects[count.index].id}-shared-vpc-subnet"
    ip_cidr_range = "${var.projects[count.index].ip_cidr_range}"
    region = "${var.projects[count.index].region}"
}

resource "google_compute_router" "router" {
    count = length( var.projects )
    network = google_compute_network.shared_vpc_network[count.index].id
    name    = "${var.projects[count.index].id}-router"
    region  = "${var.projects[count.index].region}"
}

resource "google_compute_router_nat" "nat" {
    count = length( var.projects )
    name   = "${var.projects[count.index].id}-nat"
    router = google_compute_router.router[count.index].name
    region = "${var.projects[count.index].region}"
    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
    nat_ip_allocate_option             = "MANUAL_ONLY"
    subnetwork {
        name                    = google_compute_subnetwork.shared_vpc_subnet[count.index].id
        source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
    nat_ips = [google_compute_address.nat[count.index].self_link]
}

resource "google_compute_address" "nat" {
    count = length( var.projects )
    name         = "${var.projects[count.index].id}-nat-ca"
    address_type = "EXTERNAL"
    network_tier = "PREMIUM"
    region = "${var.projects[count.index].region}"
}

