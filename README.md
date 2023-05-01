# GitHub Actions Runner Controller

Deploys [actions-runner-controller](https://github.com/actions-runner-controller/actions-runner-controller).

## Additonal Note:

This runs version 1 of ARC, the following files are only applied the following objects are not empty within the module:
- `org_runners.tf` for `github_org_runners`
- `ent_runners.tf` for `github_ent_runners`
- `ent_runners_dind.tf` for `github_ent_runners_dind`

They are required for creating the necessary CRDs for deploying the runners.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.7.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_action_runner_irsa"></a> [action\_runner\_irsa](#module\_action\_runner\_irsa) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.1.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.github_org_runners](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_method"></a> [auth\_method](#input\_auth\_method) | GitHub authentication method to be deployed. | `string` | `"pat"` | no |
| <a name="input_auth_secret_annotations"></a> [auth\_secret\_annotations](#input\_auth\_secret\_annotations) | Set the annotations of the auth secret. | `map(string)` | `{}` | no |
| <a name="input_auth_secret_created"></a> [auth\_secret\_created](#input\_auth\_secret\_created) | Create Kubernetes secrets to authenticate with GitHub API. | `bool` | `false` | no |
| <a name="input_auth_secret_enabled"></a> [auth\_secret\_enabled](#input\_auth\_secret\_enabled) | Expose GITHUB\_* Environment variables manager container | `bool` | `true` | no |
| <a name="input_auth_secret_name"></a> [auth\_secret\_name](#input\_auth\_secret\_name) | Set the name of the auth secret. | `string` | `"controller-manager"` | no |
| <a name="input_cert_manager_enabled"></a> [cert\_manager\_enabled](#input\_cert\_manager\_enabled) | Whether to enable the cert manager. | `bool` | `true` | no |
| <a name="input_chart_labels"></a> [chart\_labels](#input\_chart\_labels) | Set labels to apply to all resources in the chart. | `map(string)` | `{}` | no |
| <a name="input_chart_name"></a> [chart\_name](#input\_chart\_name) | Helm chart name to provision. | `string` | `"actions-runner-controller"` | no |
| <a name="input_chart_namespace"></a> [chart\_namespace](#input\_chart\_namespace) | Namespace to install the chart into. | `string` | `"default"` | no |
| <a name="input_chart_namespace_create"></a> [chart\_namespace\_create](#input\_chart\_namespace\_create) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_chart_repository"></a> [chart\_repository](#input\_chart\_repository) | Helm repository for the chart. | `string` | `"https://actions-runner-controller.github.io/actions-runner-controller"` | no |
| <a name="input_chart_timeout"></a> [chart\_timeout](#input\_chart\_timeout) | Timeout to wait for the Chart to be deployed. | `number` | `300` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of Chart to install. Set to empty to install the latest version. | `string` | `"0.20.0"` | no |
| <a name="input_controller_affinity"></a> [controller\_affinity](#input\_controller\_affinity) | Set the controller pod affinity rules. | `any` | `{}` | no |
| <a name="input_controller_env"></a> [controller\_env](#input\_controller\_env) | Set environment variables for the controller container. | `map(any)` | `{}` | no |
| <a name="input_controller_image_tag"></a> [controller\_image\_tag](#input\_controller\_image\_tag) | The tag of the controller container. If not specified, it's the appVersion inside Chart.yaml | `string` | `"v0.25.0"` | no |
| <a name="input_controller_node_selector"></a> [controller\_node\_selector](#input\_controller\_node\_selector) | Set the controller pod nodeSelector. | `map(any)` | `{}` | no |
| <a name="input_controller_pod_annotations"></a> [controller\_pod\_annotations](#input\_controller\_pod\_annotations) | Set annotations for the controller pod. | `map(string)` | `{}` | no |
| <a name="input_controller_pod_disruption_budget"></a> [controller\_pod\_disruption\_budget](#input\_controller\_pod\_disruption\_budget) | Pod disruption budget for controller | `any` | <pre>{<br>  "enabled": true,<br>  "minAvailable": 1<br>}</pre> | no |
| <a name="input_controller_pod_labels"></a> [controller\_pod\_labels](#input\_controller\_pod\_labels) | Set labels for the controller pod. | `map(string)` | `{}` | no |
| <a name="input_controller_pod_security_context"></a> [controller\_pod\_security\_context](#input\_controller\_pod\_security\_context) | Set the security context to controller pod. | `map(any)` | `{}` | no |
| <a name="input_controller_priority_class_name"></a> [controller\_priority\_class\_name](#input\_controller\_priority\_class\_name) | Set the controller pod priorityClassName. | `string` | `""` | no |
| <a name="input_controller_repository"></a> [controller\_repository](#input\_controller\_repository) | The repository/image of the controller container. | `string` | `"summerwind/actions-runner-controller"` | no |
| <a name="input_controller_resources"></a> [controller\_resources](#input\_controller\_resources) | Set the controller pod resources. | `map(any)` | <pre>{<br>  "limits": {<br>    "cpu": "100m",<br>    "memory": "128Mi"<br>  },<br>  "requests": {<br>    "cpu": "100m",<br>    "memory": "128Mi"<br>  }<br>}</pre> | no |
| <a name="input_controller_security_context"></a> [controller\_security\_context](#input\_controller\_security\_context) | Set the security context for each container in the controller pod. | `map(any)` | `{}` | no |
| <a name="input_controller_service_annotation"></a> [controller\_service\_annotation](#input\_controller\_service\_annotation) | Set annotations for the provisioned webhook service resource. | `map(any)` | `{}` | no |
| <a name="input_controller_service_port"></a> [controller\_service\_port](#input\_controller\_service\_port) | Set controller service ports. | `string` | `"443"` | no |
| <a name="input_controller_service_type"></a> [controller\_service\_type](#input\_controller\_service\_type) | Set controller service type. | `string` | `"ClusterIP"` | no |
| <a name="input_controller_tolerations"></a> [controller\_tolerations](#input\_controller\_tolerations) | Set the controller pod tolerations. | `list(any)` | `[]` | no |
| <a name="input_dind_sidecar_image_tag"></a> [dind\_sidecar\_image\_tag](#input\_dind\_sidecar\_image\_tag) | The tag of the dind sidecar container. | `string` | `"dind"` | no |
| <a name="input_dind_sidecar_repository"></a> [dind\_sidecar\_repository](#input\_dind\_sidecar\_repository) | The repository/image of the dind sidecar container. | `string` | `"docker"` | no |
| <a name="input_docker_registry_mirror"></a> [docker\_registry\_mirror](#input\_docker\_registry\_mirror) | The default Docker Registry Mirror used by runners. | `string` | `""` | no |
| <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id) | GitHub App ID. This can't be set at the same time as github\_token | `string` | `""` | no |
| <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id) | GitHub App Installation ID. This can't be set at the same time as github\_token | `string` | `""` | no |
| <a name="input_github_app_private_key"></a> [github\_app\_private\_key](#input\_github\_app\_private\_key) | The multiline string of your GitHub App's private key. This can't be set at the same time as github\_token | `string` | `""` | no |
| <a name="input_github_enterprise_url"></a> [github\_enterprise\_url](#input\_github\_enterprise\_url) | The URL of your GitHub Enterprise server, if you're using one. | `string` | `""` | no |
| <a name="input_github_org_runners"></a> [github\_org\_runners](#input\_github\_org\_runners) | Github organization for deploying org runner | <pre>list(object({<br>    name        = string           # Organization Name<br>    group       = optional(string) # Runner group needs to be created first<br>    replicas    = number<br>    label       = string<br>    tolerations = optional(list(any))<br>    affinity    = optional(any)<br>    resources   = optional(map(any))<br>  }))</pre> | `[]` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | Your chosen GitHub PAT token. This can't be set at the same time as github\_app\_* | `string` | `""` | no |
| <a name="input_image_pull_policy"></a> [image\_pull\_policy](#input\_image\_pull\_policy) | The pull policy of the controller image. | `string` | `"IfNotPresent"` | no |
| <a name="input_image_pull_secrets"></a> [image\_pull\_secrets](#input\_image\_pull\_secrets) | Specifies the secret to be used when pulling the controller pod containers. | `list(any)` | `[]` | no |
| <a name="input_leader_election_id"></a> [leader\_election\_id](#input\_leader\_election\_id) | Set the election ID for the controller group. | `string` | `"actions-runner-controller"` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Set the log level of the controller container. | `string` | `""` | no |
| <a name="input_max_history"></a> [max\_history](#input\_max\_history) | Max History for Helm. | `number` | `20` | no |
| <a name="input_metrics_proxy_enabled"></a> [metrics\_proxy\_enabled](#input\_metrics\_proxy\_enabled) | Deploy kube-rbac-proxy container in controller pod. | `bool` | `true` | no |
| <a name="input_metrics_proxy_image_repository"></a> [metrics\_proxy\_image\_repository](#input\_metrics\_proxy\_image\_repository) | The repository/image of the kube-proxy container. | `string` | `"quay.io/brancz/kube-rbac-proxy"` | no |
| <a name="input_metrics_proxy_image_tag"></a> [metrics\_proxy\_image\_tag](#input\_metrics\_proxy\_image\_tag) | The tag of the kube-proxy container. | `string` | `"v0.13.0"` | no |
| <a name="input_metrics_service_annotation"></a> [metrics\_service\_annotation](#input\_metrics\_service\_annotation) | Set annotations for the provisioned metrics service resource. | `map(string)` | `{}` | no |
| <a name="input_metrics_service_monitor_enabled"></a> [metrics\_service\_monitor\_enabled](#input\_metrics\_service\_monitor\_enabled) | Whether to deploy serviceMonitor kind for for use with prometheus-operator CRDs. | `bool` | `false` | no |
| <a name="input_metrics_service_monitor_labels"></a> [metrics\_service\_monitor\_labels](#input\_metrics\_service\_monitor\_labels) | Set labels to apply to ServiceMonitor resources. | `map(string)` | `{}` | no |
| <a name="input_metrics_service_port"></a> [metrics\_service\_port](#input\_metrics\_service\_port) | Set port of metrics service. | `string` | `"8443"` | no |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | OIDC Provider ARN for IRSA | `string` | `""` | no |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | Helm release name. | `string` | `"actions-runner-controller"` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Set the number of controller pods. | `number` | `1` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the iam role to be created. | `string` | `""` | no |
| <a name="input_role_policy_arns"></a> [role\_policy\_arns](#input\_role\_policy\_arns) | ARNs of any policies to attach to the IAM role | `map(string)` | `{}` | no |
| <a name="input_runner_image_pull_secrets"></a> [runner\_image\_pull\_secrets](#input\_runner\_image\_pull\_secrets) | Specifies the secret to be used when pulling the runner pod containers. | `list(any)` | `[]` | no |
| <a name="input_runner_image_tag"></a> [runner\_image\_tag](#input\_runner\_image\_tag) | The tag of the actions runner container. | `string` | `"latest"` | no |
| <a name="input_runner_repository"></a> [runner\_repository](#input\_runner\_repository) | The repository/image of the actions runner container. | `string` | `"summerwind/actions-runner"` | no |
| <a name="input_scope_single_namespace_enabled"></a> [scope\_single\_namespace\_enabled](#input\_scope\_single\_namespace\_enabled) | Limit the controller to watch a single namespace. | `bool` | `false` | no |
| <a name="input_scope_watch_namespace"></a> [scope\_watch\_namespace](#input\_scope\_watch\_namespace) | Tells the controller and the GitHub webhook server which namespace to watch if scope.singleNamespace is true. | `string` | `""` | no |
| <a name="input_service_account_annotations"></a> [service\_account\_annotations](#input\_service\_account\_annotations) | Annotations to add to the service account. | `map(string)` | `{}` | no |
| <a name="input_service_account_created"></a> [service\_account\_created](#input\_service\_account\_created) | Specifies whether a service account should be created. | `bool` | `true` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | The name of the service account to use. | `string` | `"actions-runner-controller"` | no |
| <a name="input_sync_period"></a> [sync\_period](#input\_sync\_period) | Set the period in which the controler reconciles the desired runners count. | `string` | `"10m"` | no |
| <a name="input_webhook_ingress_class_name"></a> [webhook\_ingress\_class\_name](#input\_webhook\_ingress\_class\_name) | Ingress Class name for the Github Webhook Server | `string` | `""` | no |
| <a name="input_webhook_server_affinity"></a> [webhook\_server\_affinity](#input\_webhook\_server\_affinity) | Set environment variables for the githubWebhookServer container. | `any` | `{}` | no |
| <a name="input_webhook_server_enabled"></a> [webhook\_server\_enabled](#input\_webhook\_server\_enabled) | Whether to deploy the webhook server pod. | `bool` | `false` | no |
| <a name="input_webhook_server_image_pull_secrets"></a> [webhook\_server\_image\_pull\_secrets](#input\_webhook\_server\_image\_pull\_secrets) | Specifies the secret to be used when pulling the githubWebhookServer pod containers. | `list(any)` | `[]` | no |
| <a name="input_webhook_server_ingress_annotations"></a> [webhook\_server\_ingress\_annotations](#input\_webhook\_server\_ingress\_annotations) | Set annotations for the githubWebhookServer ingress kind. | `map(string)` | `{}` | no |
| <a name="input_webhook_server_ingress_enabled"></a> [webhook\_server\_ingress\_enabled](#input\_webhook\_server\_ingress\_enabled) | Whether to deploy an ingress kind for the githubWebhookServer. | `bool` | `false` | no |
| <a name="input_webhook_server_ingress_hosts"></a> [webhook\_server\_ingress\_hosts](#input\_webhook\_server\_ingress\_hosts) | Set hosts for the githubWebhookServer ingress kind. | `list(any)` | `[]` | no |
| <a name="input_webhook_server_ingress_tls"></a> [webhook\_server\_ingress\_tls](#input\_webhook\_server\_ingress\_tls) | Set tls configuration for the githubWebhookServer ingress kind. | `list(any)` | `[]` | no |
| <a name="input_webhook_server_log_level"></a> [webhook\_server\_log\_level](#input\_webhook\_server\_log\_level) | Set the log level of the githubWebhookServer container. | `string` | `""` | no |
| <a name="input_webhook_server_node_selector"></a> [webhook\_server\_node\_selector](#input\_webhook\_server\_node\_selector) | Set the githubWebhookServer pod nodeSelector. | `map(any)` | `{}` | no |
| <a name="input_webhook_server_pod_annotations"></a> [webhook\_server\_pod\_annotations](#input\_webhook\_server\_pod\_annotations) | Set annotations for the githubWebhookServer pod. | `map(string)` | `{}` | no |
| <a name="input_webhook_server_pod_disruption_budget"></a> [webhook\_server\_pod\_disruption\_budget](#input\_webhook\_server\_pod\_disruption\_budget) | Pod disruption budget for webhook server | `any` | <pre>{<br>  "enabled": true,<br>  "minAvailable": 1<br>}</pre> | no |
| <a name="input_webhook_server_pod_labels"></a> [webhook\_server\_pod\_labels](#input\_webhook\_server\_pod\_labels) | Set labels for the githubWebhookServer pod. | `map(string)` | `{}` | no |
| <a name="input_webhook_server_pod_security_context"></a> [webhook\_server\_pod\_security\_context](#input\_webhook\_server\_pod\_security\_context) | Set the security context to githubWebhookServer pod. | `map(any)` | `{}` | no |
| <a name="input_webhook_server_priority_class_name"></a> [webhook\_server\_priority\_class\_name](#input\_webhook\_server\_priority\_class\_name) | Set the githubWebhookServer pod priorityClassName. | `string` | `""` | no |
| <a name="input_webhook_server_replicas"></a> [webhook\_server\_replicas](#input\_webhook\_server\_replicas) | Set the number of webhook server pods. | `number` | `1` | no |
| <a name="input_webhook_server_resources"></a> [webhook\_server\_resources](#input\_webhook\_server\_resources) | Set the githubWebhookServer pod resources. | `map(any)` | <pre>{<br>  "limits": {<br>    "cpu": "100m",<br>    "memory": "128Mi"<br>  },<br>  "requests": {<br>    "cpu": "100m",<br>    "memory": "128Mi"<br>  }<br>}</pre> | no |
| <a name="input_webhook_server_secret_created"></a> [webhook\_server\_secret\_created](#input\_webhook\_server\_secret\_created) | Whether to deploy the webhook hook secret. | `bool` | `false` | no |
| <a name="input_webhook_server_secret_enabled"></a> [webhook\_server\_secret\_enabled](#input\_webhook\_server\_secret\_enabled) | Whether to enable the webhook hook secret. | `bool` | `false` | no |
| <a name="input_webhook_server_secret_name"></a> [webhook\_server\_secret\_name](#input\_webhook\_server\_secret\_name) | Set the name of the webhook hook secret. | `string` | `"github-webhook-server"` | no |
| <a name="input_webhook_server_secret_token"></a> [webhook\_server\_secret\_token](#input\_webhook\_server\_secret\_token) | Set the webhook secret token value. | `string` | `""` | no |
| <a name="input_webhook_server_security_context"></a> [webhook\_server\_security\_context](#input\_webhook\_server\_security\_context) | Set the security context for each container in the githubWebhookServer pod. | `map(any)` | `{}` | no |
| <a name="input_webhook_server_service_account_annotations"></a> [webhook\_server\_service\_account\_annotations](#input\_webhook\_server\_service\_account\_annotations) | Set annotations for the githubWebhookServer service account. | `map(string)` | `{}` | no |
| <a name="input_webhook_server_service_account_created"></a> [webhook\_server\_service\_account\_created](#input\_webhook\_server\_service\_account\_created) | Whether to deploy the githubWebhookServer under a service account. | `bool` | `true` | no |
| <a name="input_webhook_server_service_account_name"></a> [webhook\_server\_service\_account\_name](#input\_webhook\_server\_service\_account\_name) | The name of the githubWebhookServer service account to use. | `string` | `""` | no |
| <a name="input_webhook_server_service_annotations"></a> [webhook\_server\_service\_annotations](#input\_webhook\_server\_service\_annotations) | Set annotations for the githubWebhookServer service. | `map(string)` | `{}` | no |
| <a name="input_webhook_server_service_node_port"></a> [webhook\_server\_service\_node\_port](#input\_webhook\_server\_service\_node\_port) | Set githubWebhookServer service nodePort. | `string` | `""` | no |
| <a name="input_webhook_server_service_port"></a> [webhook\_server\_service\_port](#input\_webhook\_server\_service\_port) | Set githubWebhookServer service port. | `string` | `"80"` | no |
| <a name="input_webhook_server_service_type"></a> [webhook\_server\_service\_type](#input\_webhook\_server\_service\_type) | Set githubWebhookServer service type. | `string` | `"ClusterIP"` | no |
| <a name="input_webhook_server_sync_period"></a> [webhook\_server\_sync\_period](#input\_webhook\_server\_sync\_period) | Set the period in which the controller reconciles the resources. | `string` | `"10m"` | no |
| <a name="input_webhook_server_tolerations"></a> [webhook\_server\_tolerations](#input\_webhook\_server\_tolerations) | Set the githubWebhookServer pod tolerations. | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_helm_release"></a> [helm\_release](#output\_helm\_release) | Output of the helm release |
| <a name="output_org_runners"></a> [org\_runners](#output\_org\_runners) | Output of Github Org Runners |
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.7.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_action_runner_irsa"></a> [action\_runner\_irsa](#module\_action\_runner\_irsa) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.1.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.github_ent_runners](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.github_ent_runners_dind](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.github_ent_runners_dind_rootless](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.github_ent_runners_horizontal_autoscaler](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.github_ent_runners_horizontal_autoscaler_dind](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.github_ent_runners_horizontal_autoscaler_dind_rootless](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.github_org_runners](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.github_org_runners_horizontal_autoscaler](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_method"></a> [auth\_method](#input\_auth\_method) | GitHub authentication method to be deployed. | `string` | `"pat"` | no |
| <a name="input_auth_secret_annotations"></a> [auth\_secret\_annotations](#input\_auth\_secret\_annotations) | Set the annotations of the auth secret. | `map(string)` | `{}` | no |
| <a name="input_auth_secret_created"></a> [auth\_secret\_created](#input\_auth\_secret\_created) | Create Kubernetes secrets to authenticate with GitHub API. | `bool` | `false` | no |
| <a name="input_auth_secret_enabled"></a> [auth\_secret\_enabled](#input\_auth\_secret\_enabled) | Expose GITHUB\_* Environment variables manager container | `bool` | `true` | no |
| <a name="input_auth_secret_name"></a> [auth\_secret\_name](#input\_auth\_secret\_name) | Set the name of the auth secret. | `string` | `"controller-manager"` | no |
| <a name="input_cert_manager_enabled"></a> [cert\_manager\_enabled](#input\_cert\_manager\_enabled) | Whether to enable the cert manager. | `bool` | `true` | no |
| <a name="input_chart_labels"></a> [chart\_labels](#input\_chart\_labels) | Set labels to apply to all resources in the chart. | `map(string)` | `{}` | no |
| <a name="input_chart_name"></a> [chart\_name](#input\_chart\_name) | Helm chart name to provision. | `string` | `"actions-runner-controller"` | no |
| <a name="input_chart_namespace"></a> [chart\_namespace](#input\_chart\_namespace) | Namespace to install the chart into. | `string` | `"default"` | no |
| <a name="input_chart_namespace_create"></a> [chart\_namespace\_create](#input\_chart\_namespace\_create) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_chart_repository"></a> [chart\_repository](#input\_chart\_repository) | Helm repository for the chart. | `string` | `"https://actions-runner-controller.github.io/actions-runner-controller"` | no |
| <a name="input_chart_timeout"></a> [chart\_timeout](#input\_chart\_timeout) | Timeout to wait for the Chart to be deployed. | `number` | `300` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of Chart to install. Set to empty to install the latest version. | `string` | `"0.23.1"` | no |
| <a name="input_controller_affinity"></a> [controller\_affinity](#input\_controller\_affinity) | Set the controller pod affinity rules. | `any` | `{}` | no |
| <a name="input_controller_env"></a> [controller\_env](#input\_controller\_env) | Set environment variables for the controller container. | `map(any)` | `{}` | no |
| <a name="input_controller_image_tag"></a> [controller\_image\_tag](#input\_controller\_image\_tag) | The tag of the controller container. If not specified, it's the appVersion inside Chart.yaml | `string` | `"v0.27.2"` | no |
| <a name="input_controller_node_selector"></a> [controller\_node\_selector](#input\_controller\_node\_selector) | Set the controller pod nodeSelector. | `map(any)` | `{}` | no |
| <a name="input_controller_pod_annotations"></a> [controller\_pod\_annotations](#input\_controller\_pod\_annotations) | Set annotations for the controller pod. | `map(string)` | `{}` | no |
| <a name="input_controller_pod_disruption_budget"></a> [controller\_pod\_disruption\_budget](#input\_controller\_pod\_disruption\_budget) | Pod disruption budget for controller | `any` | <pre>{<br>  "enabled": true,<br>  "minAvailable": 1<br>}</pre> | no |
| <a name="input_controller_pod_labels"></a> [controller\_pod\_labels](#input\_controller\_pod\_labels) | Set labels for the controller pod. | `map(string)` | `{}` | no |
| <a name="input_controller_pod_security_context"></a> [controller\_pod\_security\_context](#input\_controller\_pod\_security\_context) | Set the security context to controller pod. | `map(any)` | `{}` | no |
| <a name="input_controller_priority_class_name"></a> [controller\_priority\_class\_name](#input\_controller\_priority\_class\_name) | Set the controller pod priorityClassName. | `string` | `""` | no |
| <a name="input_controller_repository"></a> [controller\_repository](#input\_controller\_repository) | The repository/image of the controller container. | `string` | `"summerwind/actions-runner-controller"` | no |
| <a name="input_controller_resources"></a> [controller\_resources](#input\_controller\_resources) | Set the controller pod resources. | `map(any)` | <pre>{<br>  "limits": {<br>    "cpu": "100m",<br>    "memory": "128Mi"<br>  },<br>  "requests": {<br>    "cpu": "100m",<br>    "memory": "128Mi"<br>  }<br>}</pre> | no |
| <a name="input_controller_security_context"></a> [controller\_security\_context](#input\_controller\_security\_context) | Set the security context for each container in the controller pod. | `map(any)` | `{}` | no |
| <a name="input_controller_service_annotation"></a> [controller\_service\_annotation](#input\_controller\_service\_annotation) | Set annotations for the provisioned webhook service resource. | `map(any)` | `{}` | no |
| <a name="input_controller_service_port"></a> [controller\_service\_port](#input\_controller\_service\_port) | Set controller service ports. | `string` | `"443"` | no |
| <a name="input_controller_service_type"></a> [controller\_service\_type](#input\_controller\_service\_type) | Set controller service type. | `string` | `"ClusterIP"` | no |
| <a name="input_controller_tolerations"></a> [controller\_tolerations](#input\_controller\_tolerations) | Set the controller pod tolerations. | `list(any)` | `[]` | no |
| <a name="input_dind_sidecar_image_tag"></a> [dind\_sidecar\_image\_tag](#input\_dind\_sidecar\_image\_tag) | The tag of the dind sidecar container. | `string` | `"dind"` | no |
| <a name="input_dind_sidecar_repository"></a> [dind\_sidecar\_repository](#input\_dind\_sidecar\_repository) | The repository/image of the dind sidecar container. | `string` | `"docker"` | no |
| <a name="input_docker_registry_mirror"></a> [docker\_registry\_mirror](#input\_docker\_registry\_mirror) | The default Docker Registry Mirror used by runners. | `string` | `""` | no |
| <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id) | GitHub App ID. This can't be set at the same time as github\_token | `string` | `""` | no |
| <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id) | GitHub App Installation ID. This can't be set at the same time as github\_token | `string` | `""` | no |
| <a name="input_github_app_private_key"></a> [github\_app\_private\_key](#input\_github\_app\_private\_key) | The multiline string of your GitHub App's private key. This can't be set at the same time as github\_token | `string` | `""` | no |
| <a name="input_github_ent_runners"></a> [github\_ent\_runners](#input\_github\_ent\_runners) | Github enterprise for deploying enterprise runner | <pre>list(object({<br>    name                      = string           # Enterprise Name<br>    group                     = optional(string) # Runner group needs to be created first<br>    min_replicas              = number<br>    max_replicas              = number<br>    scale_up_trigger_duration = string<br>    label                     = string<br>    tolerations               = optional(list(any))<br>    affinity                  = optional(any)<br>    resources                 = optional(map(any))<br>  }))</pre> | `[]` | no |
| <a name="input_github_ent_runners_dind"></a> [github\_ent\_runners\_dind](#input\_github\_ent\_runners\_dind) | Github enterprise for deploying enterprise dind runner | <pre>list(object({<br>    name                      = string           # Enterprise Name<br>    group                     = optional(string) # Runner group needs to be created first<br>    min_replicas              = number<br>    max_replicas              = number<br>    scale_up_trigger_duration = string<br>    label                     = string<br>    tolerations               = optional(list(any))<br>    affinity                  = optional(any)<br>    resources                 = optional(map(any))<br>  }))</pre> | `[]` | no |
| <a name="input_github_ent_runners_dind_rootless"></a> [github\_ent\_runners\_dind\_rootless](#input\_github\_ent\_runners\_dind\_rootless) | Github enterprise for deploying enterprise dind runner | <pre>list(object({<br>    name                      = string           # Enterprise Name<br>    group                     = optional(string) # Runner group needs to be created first<br>    min_replicas              = number<br>    max_replicas              = number<br>    scale_up_trigger_duration = string<br>    label                     = string<br>    tolerations               = optional(list(any))<br>    affinity                  = optional(any)<br>    resources                 = optional(map(any))<br>  }))</pre> | `[]` | no |
| <a name="input_github_enterprise_url"></a> [github\_enterprise\_url](#input\_github\_enterprise\_url) | The URL of your GitHub Enterprise server, if you're using one. | `string` | `""` | no |
| <a name="input_github_org_runners"></a> [github\_org\_runners](#input\_github\_org\_runners) | Github organization for deploying org runner | <pre>list(object({<br>    name                      = string           # Organization Name<br>    group                     = optional(string) # Runner group needs to be created first<br>    min_replicas              = number<br>    max_replicas              = number<br>    scale_up_trigger_duration = string<br>    label                     = string<br>    tolerations               = optional(list(any))<br>    affinity                  = optional(any)<br>    resources                 = optional(map(any))<br>  }))</pre> | `[]` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | Your chosen GitHub PAT token. This can't be set at the same time as github\_app\_* | `string` | `""` | no |
| <a name="input_image_pull_policy"></a> [image\_pull\_policy](#input\_image\_pull\_policy) | The pull policy of the controller image. | `string` | `"IfNotPresent"` | no |
| <a name="input_image_pull_secrets"></a> [image\_pull\_secrets](#input\_image\_pull\_secrets) | Specifies the secret to be used when pulling the controller pod containers. | `list(any)` | `[]` | no |
| <a name="input_leader_election_id"></a> [leader\_election\_id](#input\_leader\_election\_id) | Set the election ID for the controller group. | `string` | `"actions-runner-controller"` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Set the log level of the controller container. | `string` | `""` | no |
| <a name="input_max_history"></a> [max\_history](#input\_max\_history) | Max History for Helm. | `number` | `20` | no |
| <a name="input_metrics_proxy_enabled"></a> [metrics\_proxy\_enabled](#input\_metrics\_proxy\_enabled) | Deploy kube-rbac-proxy container in controller pod. | `bool` | `true` | no |
| <a name="input_metrics_proxy_image_repository"></a> [metrics\_proxy\_image\_repository](#input\_metrics\_proxy\_image\_repository) | The repository/image of the kube-proxy container. | `string` | `"quay.io/brancz/kube-rbac-proxy"` | no |
| <a name="input_metrics_proxy_image_tag"></a> [metrics\_proxy\_image\_tag](#input\_metrics\_proxy\_image\_tag) | The tag of the kube-proxy container. | `string` | `"v0.13.0"` | no |
| <a name="input_metrics_service_annotation"></a> [metrics\_service\_annotation](#input\_metrics\_service\_annotation) | Set annotations for the provisioned metrics service resource. | `map(string)` | `{}` | no |
| <a name="input_metrics_service_monitor_enabled"></a> [metrics\_service\_monitor\_enabled](#input\_metrics\_service\_monitor\_enabled) | Whether to deploy serviceMonitor kind for for use with prometheus-operator CRDs. | `bool` | `false` | no |
| <a name="input_metrics_service_monitor_labels"></a> [metrics\_service\_monitor\_labels](#input\_metrics\_service\_monitor\_labels) | Set labels to apply to ServiceMonitor resources. | `map(string)` | `{}` | no |
| <a name="input_metrics_service_port"></a> [metrics\_service\_port](#input\_metrics\_service\_port) | Set port of metrics service. | `string` | `"8443"` | no |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | OIDC Provider ARN for IRSA | `string` | `""` | no |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | Helm release name. | `string` | `"actions-runner-controller"` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Set the number of controller pods. | `number` | `1` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the iam role to be created. | `string` | `""` | no |
| <a name="input_role_policy_arns"></a> [role\_policy\_arns](#input\_role\_policy\_arns) | ARNs of any policies to attach to the IAM role | `map(string)` | `{}` | no |
| <a name="input_runner_image_pull_secrets"></a> [runner\_image\_pull\_secrets](#input\_runner\_image\_pull\_secrets) | Specifies the secret to be used when pulling the runner pod containers. | `list(any)` | `[]` | no |
| <a name="input_runner_image_tag"></a> [runner\_image\_tag](#input\_runner\_image\_tag) | The tag of the actions runner container. | `string` | `"ubuntu-22.04"` | no |
| <a name="input_runner_repository"></a> [runner\_repository](#input\_runner\_repository) | The repository/image of the actions runner container. | `string` | `"summerwind/actions-runner"` | no |
| <a name="input_scope_single_namespace_enabled"></a> [scope\_single\_namespace\_enabled](#input\_scope\_single\_namespace\_enabled) | Limit the controller to watch a single namespace. | `bool` | `false` | no |
| <a name="input_scope_watch_namespace"></a> [scope\_watch\_namespace](#input\_scope\_watch\_namespace) | Tells the controller and the GitHub webhook server which namespace to watch if scope.singleNamespace is true. | `string` | `""` | no |
| <a name="input_service_account_annotations"></a> [service\_account\_annotations](#input\_service\_account\_annotations) | Annotations to add to the service account. | `map(string)` | `{}` | no |
| <a name="input_service_account_created"></a> [service\_account\_created](#input\_service\_account\_created) | Specifies whether a service account should be created. | `bool` | `true` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | The name of the service account to use. | `string` | `"actions-runner-controller"` | no |
| <a name="input_sync_period"></a> [sync\_period](#input\_sync\_period) | Set the period in which the controler reconciles the desired runners count. | `string` | `"10m"` | no |
| <a name="input_webhook_ingress_class_name"></a> [webhook\_ingress\_class\_name](#input\_webhook\_ingress\_class\_name) | Ingress Class name for the Github Webhook Server | `string` | `""` | no |
| <a name="input_webhook_server_affinity"></a> [webhook\_server\_affinity](#input\_webhook\_server\_affinity) | Set environment variables for the githubWebhookServer container. | `any` | `{}` | no |
| <a name="input_webhook_server_enabled"></a> [webhook\_server\_enabled](#input\_webhook\_server\_enabled) | Whether to deploy the webhook server pod. | `bool` | `false` | no |
| <a name="input_webhook_server_image_pull_secrets"></a> [webhook\_server\_image\_pull\_secrets](#input\_webhook\_server\_image\_pull\_secrets) | Specifies the secret to be used when pulling the githubWebhookServer pod containers. | `list(any)` | `[]` | no |
| <a name="input_webhook_server_ingress_annotations"></a> [webhook\_server\_ingress\_annotations](#input\_webhook\_server\_ingress\_annotations) | Set annotations for the githubWebhookServer ingress kind. | `map(string)` | `{}` | no |
| <a name="input_webhook_server_ingress_enabled"></a> [webhook\_server\_ingress\_enabled](#input\_webhook\_server\_ingress\_enabled) | Whether to deploy an ingress kind for the githubWebhookServer. | `bool` | `false` | no |
| <a name="input_webhook_server_ingress_hosts"></a> [webhook\_server\_ingress\_hosts](#input\_webhook\_server\_ingress\_hosts) | Set hosts for the githubWebhookServer ingress kind. | `list(any)` | `[]` | no |
| <a name="input_webhook_server_ingress_tls"></a> [webhook\_server\_ingress\_tls](#input\_webhook\_server\_ingress\_tls) | Set tls configuration for the githubWebhookServer ingress kind. | `list(any)` | `[]` | no |
| <a name="input_webhook_server_log_level"></a> [webhook\_server\_log\_level](#input\_webhook\_server\_log\_level) | Set the log level of the githubWebhookServer container. | `string` | `""` | no |
| <a name="input_webhook_server_node_selector"></a> [webhook\_server\_node\_selector](#input\_webhook\_server\_node\_selector) | Set the githubWebhookServer pod nodeSelector. | `map(any)` | `{}` | no |
| <a name="input_webhook_server_pod_annotations"></a> [webhook\_server\_pod\_annotations](#input\_webhook\_server\_pod\_annotations) | Set annotations for the githubWebhookServer pod. | `map(string)` | `{}` | no |
| <a name="input_webhook_server_pod_disruption_budget"></a> [webhook\_server\_pod\_disruption\_budget](#input\_webhook\_server\_pod\_disruption\_budget) | Pod disruption budget for webhook server | `any` | <pre>{<br>  "enabled": true,<br>  "minAvailable": 1<br>}</pre> | no |
| <a name="input_webhook_server_pod_labels"></a> [webhook\_server\_pod\_labels](#input\_webhook\_server\_pod\_labels) | Set labels for the githubWebhookServer pod. | `map(string)` | `{}` | no |
| <a name="input_webhook_server_pod_security_context"></a> [webhook\_server\_pod\_security\_context](#input\_webhook\_server\_pod\_security\_context) | Set the security context to githubWebhookServer pod. | `map(any)` | `{}` | no |
| <a name="input_webhook_server_priority_class_name"></a> [webhook\_server\_priority\_class\_name](#input\_webhook\_server\_priority\_class\_name) | Set the githubWebhookServer pod priorityClassName. | `string` | `""` | no |
| <a name="input_webhook_server_replicas"></a> [webhook\_server\_replicas](#input\_webhook\_server\_replicas) | Set the number of webhook server pods. | `number` | `1` | no |
| <a name="input_webhook_server_resources"></a> [webhook\_server\_resources](#input\_webhook\_server\_resources) | Set the githubWebhookServer pod resources. | `map(any)` | <pre>{<br>  "limits": {<br>    "cpu": "100m",<br>    "memory": "128Mi"<br>  },<br>  "requests": {<br>    "cpu": "100m",<br>    "memory": "128Mi"<br>  }<br>}</pre> | no |
| <a name="input_webhook_server_secret_created"></a> [webhook\_server\_secret\_created](#input\_webhook\_server\_secret\_created) | Whether to deploy the webhook hook secret. | `bool` | `false` | no |
| <a name="input_webhook_server_secret_enabled"></a> [webhook\_server\_secret\_enabled](#input\_webhook\_server\_secret\_enabled) | Whether to enable the webhook hook secret. | `bool` | `false` | no |
| <a name="input_webhook_server_secret_name"></a> [webhook\_server\_secret\_name](#input\_webhook\_server\_secret\_name) | Set the name of the webhook hook secret. | `string` | `"github-webhook-server"` | no |
| <a name="input_webhook_server_secret_token"></a> [webhook\_server\_secret\_token](#input\_webhook\_server\_secret\_token) | Set the webhook secret token value. | `string` | `""` | no |
| <a name="input_webhook_server_security_context"></a> [webhook\_server\_security\_context](#input\_webhook\_server\_security\_context) | Set the security context for each container in the githubWebhookServer pod. | `map(any)` | `{}` | no |
| <a name="input_webhook_server_service_account_annotations"></a> [webhook\_server\_service\_account\_annotations](#input\_webhook\_server\_service\_account\_annotations) | Set annotations for the githubWebhookServer service account. | `map(string)` | `{}` | no |
| <a name="input_webhook_server_service_account_created"></a> [webhook\_server\_service\_account\_created](#input\_webhook\_server\_service\_account\_created) | Whether to deploy the githubWebhookServer under a service account. | `bool` | `true` | no |
| <a name="input_webhook_server_service_account_name"></a> [webhook\_server\_service\_account\_name](#input\_webhook\_server\_service\_account\_name) | The name of the githubWebhookServer service account to use. | `string` | `""` | no |
| <a name="input_webhook_server_service_annotations"></a> [webhook\_server\_service\_annotations](#input\_webhook\_server\_service\_annotations) | Set annotations for the githubWebhookServer service. | `map(string)` | `{}` | no |
| <a name="input_webhook_server_service_node_port"></a> [webhook\_server\_service\_node\_port](#input\_webhook\_server\_service\_node\_port) | Set githubWebhookServer service nodePort. | `string` | `""` | no |
| <a name="input_webhook_server_service_port"></a> [webhook\_server\_service\_port](#input\_webhook\_server\_service\_port) | Set githubWebhookServer service port. | `string` | `"80"` | no |
| <a name="input_webhook_server_service_type"></a> [webhook\_server\_service\_type](#input\_webhook\_server\_service\_type) | Set githubWebhookServer service type. | `string` | `"ClusterIP"` | no |
| <a name="input_webhook_server_sync_period"></a> [webhook\_server\_sync\_period](#input\_webhook\_server\_sync\_period) | Set the period in which the controller reconciles the resources. | `string` | `"10m"` | no |
| <a name="input_webhook_server_tolerations"></a> [webhook\_server\_tolerations](#input\_webhook\_server\_tolerations) | Set the githubWebhookServer pod tolerations. | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_helm_release"></a> [helm\_release](#output\_helm\_release) | Output of the helm release |
| <a name="output_org_runners"></a> [org\_runners](#output\_org\_runners) | Output of Github Org Runners |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
