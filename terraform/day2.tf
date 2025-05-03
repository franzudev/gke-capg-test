# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

locals {

  gcp_credentials_secret_name = "gcp-credentials"
  capi_operator_namespace     = "capi-operator-system"
}

resource "kubernetes_secret" "gcp-credentials" {
  metadata {
    name      = local.gcp_credentials_secret_name
    namespace = local.capi_operator_namespace
  }

  data = {
    "GCP_B64ENCODED_CREDENTIALS" = base64encode(file("capg-sa.json"))
  }

  depends_on = [helm_release.capi-operator]
}

resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "crds.enabled"
    value = "true"
  }
}

resource "helm_release" "capi-operator" {
  name             = "capi-operator"
  chart            = "cluster-api-operator"
  repository       = "https://kubernetes-sigs.github.io/cluster-api-operator"
  namespace        = local.capi_operator_namespace
  create_namespace = true

  set {
    name  = "configSecret.name"
    value = local.gcp_credentials_secret_name
  }

  set {
    name  = "configSecret.namespace"
    value = local.capi_operator_namespace
  }

  depends_on = [helm_release.cert-manager]
}

resource "kubernetes_manifest" "core_provider" {
  manifest = {
    "apiVersion" : "operator.cluster.x-k8s.io/v1alpha2",
    "kind" : "CoreProvider",
    "metadata" : {
      "name" : "cluster-api",
      "namespace" : helm_release.capi-operator.namespace
    }
  }
}

resource "kubernetes_manifest" "bootstrpa_provider" {
  manifest = {
    "apiVersion" : "operator.cluster.x-k8s.io/v1alpha2",
    "kind" : "BootstrapProvider",
    "metadata" : {
      "name" : "kubeadm",
      "namespace" : helm_release.capi-operator.namespace
    },
    "spec" : {
      "version" : "v1.10.1"
    }
  }
}

resource "kubernetes_manifest" "control_plane_provider" {
  manifest = {
    "apiVersion" : "operator.cluster.x-k8s.io/v1alpha2",
    "kind" : "ControlPlaneProvider",
    "metadata" : {
      "name" : "kubeadm",
      "namespace" : helm_release.capi-operator.namespace
    },
    "spec" : {
      "version" : "v1.10.1"
    }
  }
}

resource "kubernetes_manifest" "gcp_infrastructure_provider" {
  manifest = {
    "apiVersion" : "operator.cluster.x-k8s.io/v1alpha2",
    "kind" : "InfrastructureProvider",
    "metadata" : {
      "name" : "gcp",
      "namespace" : helm_release.capi-operator.namespace
    },
    "spec" : {
      "version" : "v1.9.0",
      "configSecret" : {
        "name" : kubernetes_secret.gcp-credentials.metadata[0].name,
        "namespace" : kubernetes_secret.gcp-credentials.metadata[0].namespace
      }
    }
  }
}
