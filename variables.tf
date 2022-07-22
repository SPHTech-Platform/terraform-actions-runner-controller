variable "release_name" {
  description = "Helm release name."
  type        = string
  default     = "actions-runner-controller"
}

variable "chart_name" {
  description = "Helm chart name to provision."
  type        = string
  default     = "actions-runner-controller"
}

variable "chart_repository" {
  description = "Helm repository for the chart."
  type        = string
  default     = "https://actions-runner-controller.github.io/actions-runner-controller"
}

variable "chart_version" {
  description = "Version of Chart to install. Set to empty to install the latest version."
  type        = string
  default     = "0.20.0"
}

variable "chart_namespace" {
  description = "Namespace to install the chart into."
  type        = string
  default     = "default"
}

variable "chart_namespace_create" {
  description = "Create the namespace if it does not yet exist."
  type        = bool
  default     = false
}

variable "chart_timeout" {
  description = "Timeout to wait for the Chart to be deployed."
  type        = number
  default     = 300
}

variable "max_history" {
  description = "Max History for Helm."
  type        = number
  default     = 20
}

##################################
# Actions Runner Controller Values
##################################
variable "chart_labels" {
  description = "Set labels to apply to all resources in the chart."
  type        = map(string)
  default     = {}
}

variable "replicas" {
  description = "Set the number of controller pods."
  type        = number
  default     = 1
}

variable "sync_period" {
  description = "Set the period in which the controler reconciles the desired runners count."
  type        = string
  default     = "10m"
}

variable "leader_election_id" {
  description = "Set the election ID for the controller group."
  type        = string
  default     = "actions-runner-controller"
}

variable "github_enterprise_url" {
  description = "The URL of your GitHub Enterprise server, if you're using one."
  type        = string
  default     = ""
}

variable "auth_secret_enabled" {
  description = "Expose GITHUB_* Environment variables manager container"
  type        = bool
  default     = true
}

variable "auth_secret_created" {
  description = "Create Kubernetes secrets to authenticate with GitHub API."
  type        = bool
  default     = false
}

variable "auth_method" {
  description = "GitHub authentication method to be deployed."
  type        = string
  default     = "pat"

  validation {
    condition     = contains(["github-app", "pat"], var.auth_method)
    error_message = "Only `github-app` or `pat` auth methods are supported."
  }
}

variable "auth_secret_name" {
  description = "Set the name of the auth secret."
  type        = string
  default     = "controller-manager"
}

variable "auth_secret_annotations" {
  description = "Set the annotations of the auth secret."
  type        = map(string)
  default     = {}
}

variable "github_app_id" {
  description = "GitHub App ID. This can't be set at the same time as github_token"
  type        = string
  default     = ""
}

variable "github_app_installation_id" {
  description = "GitHub App Installation ID. This can't be set at the same time as github_token"
  type        = string
  default     = ""
}

variable "github_app_private_key" {
  description = "The multiline string of your GitHub App's private key. This can't be set at the same time as github_token"
  type        = string
  default     = ""
}

variable "github_token" {
  description = "Your chosen GitHub PAT token. This can't be set at the same time as github_app_*"
  type        = string
  default     = ""
}

variable "log_level" {
  description = "Set the log level of the controller container."
  type        = string
  default     = ""
}

variable "docker_registry_mirror" {
  description = "The default Docker Registry Mirror used by runners."
  type        = string
  default     = ""
}

variable "controller_repository" {
  description = "The repository/image of the controller container."
  type        = string
  default     = "summerwind/actions-runner-controller"
}

variable "controller_image_tag" {
  description = "The tag of the controller container. If not specified, it's the appVersion inside Chart.yaml"
  type        = string
  default     = "v0.25.0"
}

variable "runner_repository" {
  description = "The repository/image of the actions runner container."
  type        = string
  default     = "summerwind/actions-runner"
}

variable "runner_image_tag" {
  description = "The tag of the actions runner container."
  type        = string
  default     = "latest"
}

variable "runner_image_pull_secrets" {
  description = "Specifies the secret to be used when pulling the runner pod containers."
  type        = list(any)
  default     = []
}

variable "dind_sidecar_repository" {
  description = "The repository/image of the dind sidecar container."
  type        = string
  default     = "docker"
}

variable "dind_sidecar_image_tag" {
  description = "The tag of the dind sidecar container."
  type        = string
  default     = "dind"
}

variable "image_pull_policy" {
  description = "The pull policy of the controller image."
  type        = string
  default     = "IfNotPresent"
}

variable "image_pull_secrets" {
  description = "Specifies the secret to be used when pulling the controller pod containers."
  type        = list(any)
  default     = []
}

variable "service_account_created" {
  description = "Specifies whether a service account should be created."
  type        = bool
  default     = true
}

variable "service_account_annotations" {
  description = "Annotations to add to the service account."
  type        = map(string)
  default     = {}
}

variable "service_account_name" {
  description = "The name of the service account to use."
  type        = string
  default     = ""
}

variable "controller_pod_annotations" {
  description = "Set annotations for the controller pod."
  type        = map(string)
  default     = {}
}

variable "controller_pod_labels" {
  description = "Set labels for the controller pod."
  type        = map(string)
  default     = {}
}

variable "controller_pod_security_context" {
  description = "Set the security context to controller pod."
  type        = map(any)
  default     = {}
}

variable "controller_security_context" {
  description = "Set the security context for each container in the controller pod."
  type        = map(any)
  default     = {}
}

variable "controller_resources" {
  description = "Set the controller pod resources."
  type        = map(any)
  default     = {}
}

variable "controller_node_selector" {
  description = "Set the controller pod nodeSelector."
  type        = map(any)
  default     = {}
}

variable "controller_tolerations" {
  description = "Set the controller pod tolerations."
  type        = list(any)
  default     = []
}

variable "controller_affinity" {
  description = "Set the controller pod affinity rules."
  type        = map(any)
  default     = {}
}

variable "controller_pod_disruption_budget" {
  description = "Pod disruption budget for controller"
  type        = any
  default = {
    enabled      = true
    minAvailable = 1
  }
}

variable "controller_env" {
  description = "Set environment variables for the controller container."
  type        = map(any)
  default     = {}
}

variable "controller_priority_class_name" {
  description = "Set the controller pod priorityClassName."
  type        = string
  default     = ""
}

variable "scope_single_namespace_enabled" {
  description = "Limit the controller to watch a single namespace."
  type        = bool
  default     = false
}

variable "scope_watch_namespace" {
  description = "Tells the controller and the GitHub webhook server which namespace to watch if scope.singleNamespace is true."
  type        = string
  default     = ""
}

variable "cert_manager_enabled" {
  description = "Whether to enable the cert manager."
  type        = bool
  default     = true
}

variable "controller_service_type" {
  description = "Set controller service type."
  type        = string
  default     = "ClusterIP"
}

variable "controller_service_port" {
  description = "Set controller service ports."
  type        = string
  default     = "443"
}

variable "controller_service_annotation" {
  description = "Set annotations for the provisioned webhook service resource."
  type        = map(any)
  default     = {}
}

variable "metrics_service_monitor_enabled" {
  description = "Whether to deploy serviceMonitor kind for for use with prometheus-operator CRDs."
  type        = bool
  default     = false
}

variable "metrics_service_port" {
  description = "Set port of metrics service."
  type        = string
  default     = "8443"
}

variable "metrics_service_annotation" {
  description = "Set annotations for the provisioned metrics service resource."
  type        = map(string)
  default     = {}
}

variable "metrics_service_monitor_labels" {
  description = "Set labels to apply to ServiceMonitor resources."
  type        = map(string)
  default     = {}
}

variable "metrics_proxy_enabled" {
  description = "Deploy kube-rbac-proxy container in controller pod."
  type        = bool
  default     = true
}

variable "metrics_proxy_image_repository" {
  description = "The repository/image of the kube-proxy container."
  type        = string
  default     = "quay.io/brancz/kube-rbac-proxy"
}

variable "metrics_proxy_image_tag" {
  description = "The tag of the kube-proxy container."
  type        = string
  default     = "v0.13.0"
}

##############################
# GitHub Webhook Server Values
##############################
variable "webhook_server_enabled" {
  description = "Whether to deploy the webhook server pod."
  type        = bool
  default     = false
}

variable "webhook_server_replicas" {
  description = "Set the number of webhook server pods."
  type        = number
  default     = 1
}

variable "webhook_server_sync_period" {
  description = "Set the period in which the controller reconciles the resources."
  type        = string
  default     = "10m"
}

variable "webhook_server_log_level" {
  description = "Set the log level of the githubWebhookServer container."
  type        = string
  default     = ""
}

variable "webhook_server_secret_enabled" {
  description = "Whether to enable the webhook hook secret."
  type        = bool
  default     = false
}

variable "webhook_server_secret_created" {
  description = "Whether to deploy the webhook hook secret."
  type        = bool
  default     = false
}

variable "webhook_server_secret_name" {
  description = "Set the name of the webhook hook secret."
  type        = string
  default     = "github-webhook-server"
}

variable "webhook_server_secret_token" {
  description = "Set the webhook secret token value."
  type        = string
  default     = ""
}

variable "webhook_server_image_pull_secrets" {
  description = "Specifies the secret to be used when pulling the githubWebhookServer pod containers."
  type        = list(any)
  default     = []
}

variable "webhook_server_service_account_created" {
  description = "Whether to deploy the githubWebhookServer under a service account."
  type        = bool
  default     = true
}

variable "webhook_server_service_account_annotations" {
  description = "Set annotations for the githubWebhookServer service account."
  type        = map(string)
  default     = {}
}

variable "webhook_server_service_account_name" {
  description = "The name of the githubWebhookServer service account to use."
  type        = string
  default     = ""
}

variable "webhook_server_pod_annotations" {
  description = "Set annotations for the githubWebhookServer pod."
  type        = map(string)
  default     = {}
}

variable "webhook_server_pod_labels" {
  description = "Set labels for the githubWebhookServer pod."
  type        = map(string)
  default     = {}
}

variable "webhook_server_pod_security_context" {
  description = "Set the security context to githubWebhookServer pod."
  type        = map(any)
  default     = {}
}

variable "webhook_server_security_context" {
  description = "Set the security context for each container in the githubWebhookServer pod."
  type        = map(any)
  default     = {}
}

variable "webhook_server_resources" {
  description = "Set the githubWebhookServer pod resources."
  type        = map(any)
  default     = {}
}

variable "webhook_server_node_selector" {
  description = "Set the githubWebhookServer pod nodeSelector."
  type        = map(any)
  default     = {}
}

variable "webhook_server_toleration" {
  description = "Set the githubWebhookServer pod tolerations."
  type        = list(any)
  default     = []
}

variable "webhook_server_affinity" {
  description = "Set environment variables for the githubWebhookServer container."
  type        = map(any)
  default     = {}
}

variable "webhook_server_priority_class_name" {
  description = "Set the githubWebhookServer pod priorityClassName."
  type        = string
  default     = ""
}

variable "webhook_server_service_type" {
  description = "Set githubWebhookServer service type."
  type        = string
  default     = "ClusterIP"
}

variable "webhook_server_service_annotations" {
  description = "Set annotations for the githubWebhookServer service."
  type        = map(string)
  default     = {}
}

variable "webhook_server_service_port" {
  description = "Set githubWebhookServer service port."
  type        = string
  default     = "80"
}

variable "webhook_server_service_node_port" {
  description = "Set githubWebhookServer service nodePort."
  type        = string
  default     = ""
}

variable "webhook_server_ingress_enabled" {
  description = "Whether to deploy an ingress kind for the githubWebhookServer."
  type        = bool
  default     = false
}

variable "webhook_ingress_class_name" {
  description = "Ingress Class name for the Github Webhook Server"
  type        = string
  default     = ""
}

variable "webhook_server_ingress_annotations" {
  description = "Set annotations for the githubWebhookServer ingress kind."
  type        = map(string)
  default     = {}
}

variable "webhook_server_ingress_hosts" {
  description = "Set hosts for the githubWebhookServer ingress kind."
  type        = list(any)
  default     = []
}

variable "webhook_server_ingress_tls" {
  description = "Set tls configuration for the githubWebhookServer ingress kind."
  type        = list(any)
  default     = []
}

variable "webhook_server_pod_disruption_budget" {
  description = "Pod disruption budget for webhook server"
  type        = any
  default = {
    enabled      = true
    minAvailable = 1
  }
}

variable "github_organizations" {
  description = "Github organization for deploying org runner"
  type = list(object({
    name     = string
    replicas = number
    label    = string
  }))
  default = []
}

variable "create_iam_role" {
  description = "Whether to create iam role."
  type        = bool
  default     = true
}

variable "role_name" {
  description = "Name of the iam role to be created."
  type        = string
  default     = ""
}
