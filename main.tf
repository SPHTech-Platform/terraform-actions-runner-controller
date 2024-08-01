module "action_runner_scale_set_controller" {

  source        = "./modules/gha-runner-scale-set-controller"
  chart_version = var.action_runner_scale_set_controller_chart_version

  release_name = var.controller_helm_release_name

}

module "action_runner_scale_set" {

  source        = "./modules/gha-runner-scale-set"
  chart_version = var.action_runner_scale_set_chart_version
  release_name  = var.scale_set_release_name

  github_config_url = var.github_config_url

  github_token               = var.github_token
  github_app_id              = var.github_app_id
  github_app_installation_id = var.github_app_installation_id
  github_app_private_key     = var.github_app_private_key

  runner_group          = var.runner_group
  runner_scale_set_name = var.runner_scale_set_name

  auth_method = var.auth_method

  depends_on = [module.action_runner_scale_set_controller]

  min_runners = var.min_runners
  max_runners = var.max_runners
}
