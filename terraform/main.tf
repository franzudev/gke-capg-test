module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 11.0"

  project_id   = var.google_project_id
  network_name = var.gke_network_name
  routing_mode = "GLOBAL"

  subnets = var.gke_subnets

  secondary_ranges = {
    capg-subnet = [
      {
        range_name    = "default-pods-range"
        ip_cidr_range = "192.168.64.0/24"
      },
      {
        range_name    = "default-service-range"
        ip_cidr_range = "192.168.65.0/24"
      }
    ]
  }

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    },
  ]
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = "secure-answer-458706-p7"
  name                       = "capg"
  region                     = var.google_region
  zones                      = var.gke_zones
  network                    = module.vpc.network_name
  subnetwork                 = module.vpc.subnets_names[0]
  ip_range_pods              = module.vpc.subnets_secondary_ranges[0][0].range_name
  ip_range_services          = module.vpc.subnets_secondary_ranges[0][1].range_name
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = false
  filestore_csi_driver       = false
  dns_cache                  = false
  deletion_protection        = false

  node_pools = [
    {
      name               = "general-purpose"
      machine_type       = "e2-standard-2"
      node_locations     = "europe-west1-b"
      min_count          = 1
      max_count          = 1
      local_ssd_count    = 0
      spot               = false
      disk_size_gb       = 50
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      enable_gvnic       = false
      logging_variant    = "DEFAULT"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = module.gke.service_account
      preemptible        = false
      initial_node_count = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    general-purpose = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-type = "general-purpose"
    }
  }

  node_pools_taints = {
    all = []

    general-purpose = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    general-purpose = [
      "capg-testing",
    ]
  }
}
