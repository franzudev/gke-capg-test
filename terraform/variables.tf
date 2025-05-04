variable "google_project_id" {
  type        = string
  description = "The ID of your GCP project"
  default     = "secure-answer-458706-p7"
}

variable "google_region" {
  type        = string
  description = "The region of your GCP project"
  default     = "europe-west1"
}

variable "gke_network_name" {
  type        = string
  description = "The name of your GCP network"
  default     = "capg-vpc"
}

variable "gke_subnets" {
  type        = list(map(string))
  description = "The subnets of your GCP network"
  default = [
    {
      subnet_name   = "capg-subnet"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "europe-west1"
    }
  ]
}

variable "gke_zones" {
  type        = list(string)
  description = "The zones of your GCP network"
  default     = ["europe-west1-b"]
}
