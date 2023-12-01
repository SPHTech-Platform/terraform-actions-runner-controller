resource "helm_release" "scale_set_controller_release" {
  name             = var.release_name
  chart            = var.chart_name
  repository       = var.chart_repository
  version          = var.chart_version
  namespace        = var.chart_namespace
  create_namespace = var.chart_namespace_create

  max_history = var.max_history
  timeout     = var.chart_timeout

  values = [
    templatefile("${path.module}/templates/values.yaml", local.values),
  ]
}

locals {
  values = {
    labels   = jsonencode(var.chart_labels)
    replicas = var.replicas

    log_level             = var.log_level
    controller_repository = var.controller_repository
    controller_image_tag  = var.controller_image_tag
    image_pull_policy     = var.image_pull_policy
    image_pull_secrets    = jsonencode(var.image_pull_secrets)

    service_account_created     = var.service_account_created
    service_account_annotations = jsonencode(var.service_account_annotations)
    service_account_name        = var.service_account_name

    controller_pod_annotations      = jsonencode(var.controller_pod_annotations)
    controller_pod_security_context = jsonencode(var.controller_pod_security_context)
    controller_security_context     = jsonencode(var.controller_security_context)
    controller_resources            = jsonencode(var.controller_resources)
    controller_node_selector        = jsonencode(var.controller_node_selector)
    controller_tolerations          = jsonencode(var.controller_tolerations)
    controller_affinity             = jsonencode(var.controller_affinity)
    priority_class_name             = var.controller_priority_class_name

  }
}
