resource "kubernetes_manifest" "argo_root_app" {
  manifest = {
    "apiVersion" : "argoproj.io/v1alpha1",
    "kind" : "Application",
    "metadata" : {
      "name" : "root",
      "namespace" : "argocd"
    },
    "spec" : {
      "destination" : {
        "name" : "in-cluster",
        "namespace" : "argocd"
      },
      "project" : "default",
      "source" : {
        "repoURL" : "https://github.com/franzudev/gke-capg-test.git",
        "targetRevision" : "HEAD",
        "path" : "gitops"
      }
    }
  }
}
