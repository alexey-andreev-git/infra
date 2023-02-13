# GKE cluster
resource "google_container_cluster" "gke_cluster" {
    count = length( var.projects )
    name                     = "${var.projects[count.index].id}-gke-cluster"
    location                 = var.projects[count.index].region
    remove_default_node_pool = true
    initial_node_count       = var.projects[count.index].gke.nodes_count
    network                  = var.vpc_networks[count.index].self_link
    subnetwork               = var.vpc_subnets[count.index].self_link
    logging_service          = "logging.googleapis.com/kubernetes"
    monitoring_service       = "monitoring.googleapis.com/kubernetes"

    # Optional, if you want multi-zonal cluster
    node_locations = [
        var.projects[count.index].zone
    ]

    addons_config {
        http_load_balancing {
            disabled = true
        }
        horizontal_pod_autoscaling {
            disabled = false
        }
    }
    private_cluster_config {
        enable_private_nodes    = var.projects[count.index].gke.enable_private_nodes
        enable_private_endpoint = var.projects[count.index].gke.enable_private_endpoint
        master_ipv4_cidr_block  = var.projects[count.index].gke.master_ipv4_cidr_block
    }
}

resource "google_container_node_pool" "gke_node" {
    count = length( var.projects )
    name            = "${var.projects[count.index].id}-node"
    cluster         = google_container_cluster.gke_cluster[count.index].name
    location        = var.projects[count.index].region
    node_count      = var.projects[count.index].gke.nodes_count
    management {
        auto_repair  = true
        auto_upgrade = true
    }

    node_config {
        preemptible     = false
        machine_type    = var.projects[count.index].gke.machine_type
        disk_size_gb    = var.projects[count.index].gke.disk_size_gb
        labels = {
            project = "${var.projects[count.index].id}"
        }
        oauth_scopes = [
            "https://www.googleapis.com/auth/cloud-platform"
        ]
    }
}

resource "null_resource" "configure_kubectl" {
    count = length( var.projects )
    provisioner "local-exec" {
        command = "gcloud container clusters get-credentials ${google_container_cluster.gke_cluster[count.index].name} --region ${var.projects[count.index].region}"
    }
}