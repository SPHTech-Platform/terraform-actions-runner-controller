module "action_runner_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.1.0"

  count = var.irsa_enabled ? 1 : 0

  role_name        = var.role_name
  role_name_prefix = var.role_name != "" ? null : "iam-gh-runner"

  oidc_providers = {
    runner = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["${var.chart_namespace}:${var.service_account_name}"]
    }
  }

  role_policy_arns = var.role_policy_arns
}
