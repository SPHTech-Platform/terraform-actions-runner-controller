resource "kubectl_manifest" "github_org_runners" {
  for_each  = { for org in var.github_organizations : org.name => org }
  yaml_body = <<YAML
apiVersion: actions.summerwind.dev/v1alpha1
kind: RunnerDeployment
metadata:
  name: ${lower(each.value.name)}-runner-deployment
  namespace: ${var.chart_namespace}
spec:
  replicas: ${each.value.replicas}
  template:
    spec:
      organization: ${each.value.name}
      serviceAccountName: ${var.service_account_name}
      group: %{if each.value.group != null}${each.value.group}%{else}"Default"%{endif}
      imagePullPolicy: IfNotPresent
      securityContext:
        fsGroup: 1000
      labels:
        - ${each.value.label}
      tolerations: %{if each.value.tolerations != null}${jsonencode(each.value.tolerations)}%{else}{}%{endif}
      affinity: %{if each.value.affinity != null}${jsonencode(each.value.affinity)}%{else}{}%{endif}
YAML

  depends_on = [helm_release.release]
}
