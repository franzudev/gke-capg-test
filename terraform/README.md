## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 6.33.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.17.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.36.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.33.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.17.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.36.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | ~> 11.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.capi-operator](https://registry.terraform.io/providers/hashicorp/helm/2.17.0/docs/resources/release) | resource |
| [helm_release.cert-manager](https://registry.terraform.io/providers/hashicorp/helm/2.17.0/docs/resources/release) | resource |
| [kubernetes_manifest.bootstrpa_provider](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.control_plane_provider](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.core_provider](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.gcp_infrastructure_provider](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.gcpcl](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.gcpmt](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.gcpmt2](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.gke](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.kadmcpt](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.kadmct](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.md](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/manifest) | resource |
| [kubernetes_secret.gcp-credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/secret) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/6.33.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gke_network_name"></a> [gke\_network\_name](#input\_gke\_network\_name) | The name of your GCP network | `string` | `"capg-vpc"` | no |
| <a name="input_gke_subnets"></a> [gke\_subnets](#input\_gke\_subnets) | The subnets of your GCP network | `list(map(string))` | <pre>[<br/>  {<br/>    "subnet_ip": "10.10.10.0/24",<br/>    "subnet_name": "capg-subnet",<br/>    "subnet_region": "europe-west1"<br/>  }<br/>]</pre> | no |
| <a name="input_gke_zones"></a> [gke\_zones](#input\_gke\_zones) | The zones of your GCP network | `list(string)` | <pre>[<br/>  "europe-west1-b"<br/>]</pre> | no |
| <a name="input_google_project_id"></a> [google\_project\_id](#input\_google\_project\_id) | The ID of your GCP project | `string` | `"secure-answer-458706-p7"` | no |
| <a name="input_google_region"></a> [google\_region](#input\_google\_region) | The region of your GCP project | `string` | `"europe-west1"` | no |

## Outputs

No outputs.
