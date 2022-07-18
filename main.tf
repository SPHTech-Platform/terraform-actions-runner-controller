resource "helm_release" "release" {
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

    sync_period           = var.sync_period
    leader_election_id    = var.leader_election_id
    github_enterprise_url = var.github_enterprise_url
    log_level             = var.log_level

    # Can only choose 1 authentication method at a time:
    # either GitHub App or Personal Access Token
    auth_secret_enabled        = var.auth_secret_enabled
    auth_secret_created        = var.auth_secret_created
    auth_method                = var.auth_method
    auth_secret_name           = var.auth_secret_name
    auth_secret_annotations    = jsonencode(var.auth_secret_annotations)
    github_app_id              = var.github_app_id
    github_app_installation_id = var.github_app_installation_id
    github_app_private_key     = var.github_app_private_key
    github_token               = var.github_token

    docker_registry_mirror    = var.docker_registry_mirror
    controller_repository     = var.controller_repository
    controller_image_tag      = var.controller_image_tag
    runner_repository         = var.runner_repository
    runner_image_tag          = var.runner_image_tag
    runner_image_pull_secrets = jsonencode(var.runner_image_pull_secrets)
    dind_sidecar_repository   = var.dind_sidecar_repository
    dind_sidecar_image_tag    = var.dind_sidecar_image_tag
    image_pull_policy         = var.image_pull_policy
    image_pull_secrets        = jsonencode(var.image_pull_secrets)

    service_account_created     = var.service_account_created
    service_account_annotations = jsonencode(var.service_account_annotations)
    service_account_name        = var.service_account_name

    pod_annotations      = jsonencode(var.controller_pod_annotations)
    pod_labels           = jsonencode(var.controller_pod_labels)
    pod_security_context = jsonencode(var.controller_pod_security_context)
    security_context     = jsonencode(var.controller_security_context)
    resources            = jsonencode(var.controller_resources)
    node_selector        = jsonencode(var.controller_node_selector)
    tolerations          = jsonencode(var.controller_tolerations)
    affinity             = jsonencode(var.controller_affinity)
    env                  = jsonencode(var.controller_env)
    priority_class_name  = var.controller_priority_class_name

    pod_disruption_budget = jsonencode(var.controller_pod_disruption_budget)

    scope_single_namespace_enabled = var.scope_single_namespace_enabled
    scope_watch_namespace          = var.scope_watch_namespace

    service_type       = var.controller_service_type
    service_port       = var.controller_service_port
    service_annotation = jsonencode(var.controller_service_annotation)

    metrics_service_monitor_enabled = var.metrics_service_monitor_enabled
    metrics_service_port            = var.metrics_service_port
    metrics_service_annotation      = jsonencode(var.metrics_service_annotation)
    metrics_service_monitor_labels  = jsonencode(var.metrics_service_monitor_labels)

    metrics_proxy_enabled          = var.metrics_proxy_enabled
    metrics_proxy_image_repository = var.metrics_proxy_image_repository
    metrics_proxy_image_tag        = var.metrics_proxy_image_tag

    webhook_server_enabled     = var.webhook_server_enabled
    webhook_server_replicas    = var.webhook_server_replicas
    webhook_server_sync_period = var.webhook_server_sync_period
    webhook_server_log_level   = var.webhook_server_log_level

    webhook_server_secret_created = var.webhook_server_secret_created
    webhook_server_secret_name    = var.webhook_server_secret_name
    webhook_server_secret_token   = var.webhook_server_secret_token

    webhook_server_image_pull_secrets = jsonencode(var.webhook_server_image_pull_secrets)

    webhook_server_service_account_created     = var.webhook_server_service_account_created
    webhook_server_service_account_annotations = jsonencode(var.webhook_server_service_account_annotations)
    webhook_server_service_account_name        = var.webhook_server_service_account_name

    webhook_server_pod_annotations      = jsonencode(var.webhook_server_pod_annotations)
    webhook_server_pod_labels           = jsonencode(var.webhook_server_pod_labels)
    webhook_server_pod_security_context = jsonencode(var.webhook_server_pod_security_context)
    webhook_server_security_context     = jsonencode(var.webhook_server_security_context)
    webhook_server_resources            = jsonencode(var.webhook_server_resources)
    webhook_server_node_selector        = jsonencode(var.webhook_server_node_selector)
    webhook_server_toleration           = jsonencode(var.webhook_server_toleration)
    webhook_server_affinity             = jsonencode(var.webhook_server_affinity)
    webhook_server_priority_class_name  = var.webhook_server_priority_class_name

    webhook_server_pod_disruption_budget = jsonencode(var.webhook_server_pod_disruption_budget)

    webhook_server_service_type        = var.webhook_server_service_type
    webhook_server_service_annotations = jsonencode(var.webhook_server_service_annotations)
    webhook_server_service_port        = var.webhook_server_service_port
    webhook_server_service_node_port   = var.webhook_server_service_node_port

    webhook_server_ingress_enabled     = var.webhook_server_ingress_enabled
    webhook_ingress_class_name         = var.webhook_ingress_class_name
    webhook_server_ingress_annotations = jsonencode(var.webhook_server_ingress_annotations)
    webhook_server_ingress_hosts       = jsonencode(var.webhook_server_ingress_hosts)
    webhook_server_ingress_tls         = jsonencode(var.webhook_server_ingress_tls)
  }
}
