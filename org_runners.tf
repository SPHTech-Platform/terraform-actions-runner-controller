resource "kubernetes_manifest" "github_org_runners" {
  for_each = { for org in var.github_org_runners : org.name => org }
  # depends_on = [helm_release.release]

  manifest = {
    apiVersion = "actions.summerwind.dev/v1alpha1"
    kind       = "RunnerDeployment"

    metadata = {
      name      = "${lower(each.value.name)}-runner-deployment"
      namespace = var.chart_namespace
    }

    spec = {
      replicas = each.value.replicas
      template = {
        spec = {
          organization       = each.value.name
          serviceAccountName = var.service_account_name
          group              = each.value.group
          imagePullPolicy    = "IfNotPresent"
          securityContext = {
            fsGroup = 1000
          }
          labels      = [each.value.label]
          resources   = each.value.resources
          tolerations = each.value.tolerations
          affinity    = each.value.affinity
        }
      }
    }
  }
}

# resource "helm_release" "github_org_runners" {
#   for_each   = { for org in var.github_org_runners : org.name => org }
#   depends_on = [helm_release.release]

#   name       = "github-org-runners"
#   repository = "https://charts.itscontained.io"
#   chart      = "raw"
#   version    = "0.2.5"

#   values = [
#     <<-EOF
#     apiVersion: actions.summerwind.dev/v1alpha1
#     kind: RunnerDeployment
#     metadata:
#       name: "${lower(each.value.name)}-runner-deployment"
#       namespace: "${var.chart_namespace}"
#     spec:
#       replicas: "${each.value.replicas}"
#       template:
#         spec:
#           organization: "${each.value.name}"
#           serviceAccountName: "${var.service_account_name}"
#           group: "${each.value.group}"
#           imagePullPolicy: IfNotPresent
#           securityContext:
#             fsGroup: 1000
#           labels: "${each.value.label}"
#           resources:
#             requests:
#               cpu: "500m"
#               memory: "2Gi"
#             limits:
#               cpu: "500m"
#               memory: "4Gi"
#           tolerations:
#           - key: "dedicated"
#             operator: "Equal"
#             value: "cicd"
#             effect: "NoSchedule"
#           affinity:
#             podAffinity:
#               requiredDuringSchedulingIgnoredDuringExecution:
#               - nodeSelectorTerms:
#                   matchExpressions:
#                   - key: dedicated
#                     operator: In
#                     values:
#                     - cicd
#             podAntiAffinity:
#               preferredDuringSchedulingIgnoredDuringExecution:
#               - weight: 100
#                 podAffinityTerm:
#                   labelSelector:
#                     matchExpressions:
#                     - key: dedicated
#                       operator: In
#                       values:
#                       - cicd
#                   topologyKey: topology.kubernetes.io/zone
#     EOF
#   ]
# }
