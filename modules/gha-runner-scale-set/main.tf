resource "helm_release" "scale_set_release" {
  name             = var.release_name
  chart            = var.chart_name
  repository       = var.chart_repository
  version          = var.chart_version
  namespace        = var.chart_namespace
  create_namespace = var.chart_namespace_create

  max_history = var.max_history
  timeout     = var.chart_timeout

  values = [templatefile("${path.module}/templates/values.yaml", local.values)]

}

locals {
  values = {

    min_runners           = var.min_runners
    max_runners           = var.max_runners
    runner_group          = var.runner_group
    runner_scale_set_name = var.runner_scale_set_name

    github_config_url = var.github_config_url

    auth_method = var.auth_method

    github_app_id              = var.github_app_id
    github_app_installation_id = var.github_app_installation_id
    github_app_private_key     = var.github_app_private_key
    github_token               = var.github_token

    container_mode_type        = var.container_mode_type
    listener_template_spec     = yamlencode(var.listener_podspec_map)
    template_spec              = yamlencode(var.custom_podspec_map)
    controller_service_account = yamlencode(var.controller_service_account)
  }

}
