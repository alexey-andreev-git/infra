module "network" {
    source = "./network"
    projects = var.projects
}

module "gke" {
    source = "./gke"
    projects     = var.projects
    vpc_networks = module.network.networks
    vpc_subnets  = module.network.subnets
}
