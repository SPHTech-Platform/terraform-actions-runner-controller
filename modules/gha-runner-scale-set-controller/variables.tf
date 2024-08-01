############################
##### Chart Variables ######
############################
variable "release_name" {
  description = "Helm release name."
  type        = string
  default     = "gha-runner-scale-set-controller"
}

variable "chart_name" {
  description = "Helm chart name to provision."
  type        = string
  default     = "gha-runner-scale-set-controller"
}

variable "chart_repository" {
  description = "Helm repository for the chart."
  type        = string
  default     = "oci://ghcr.io/actions/actions-runner-controller-charts"
}

variable "chart_version" {
  description = "Version of Chart to install. Set to empty to install the latest version."
  type        = string
  default     = "0.9.3"
}

variable "chart_namespace" {
  description = "Namespace to install the chart into."
  type        = string
  default     = "arc-systems"
}

variable "chart_namespace_create" {
  description = "Create the namespace if it does not yet exist."
  type        = bool
  default     = true
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
#  Values For Controller
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

variable "controller_repository" {
  description = "The repository/image of the controller container."
  type        = string
  default     = "ghcr.io/actions/gha-runner-scale-set-controller"
}

variable "controller_resources" {
  description = "Set the controller pod resources."
  type        = map(any)
  default = {
    requests = {
      cpu    = "100m"
      memory = "128Mi"
    }
    limits = {
      cpu    = "100m"
      memory = "128Mi"
    }
  }
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
  default     = "actions-runner-controller"
}

variable "controller_pod_annotations" {
  description = "Set annotations for the controller pod."
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
  type        = any
  default     = {}
}

variable "controller_priority_class_name" {
  description = "Set the controller pod priorityClassName."
  type        = string
  default     = ""
}

variable "log_level" {
  description = "Set the log level of the controller container."
  type        = string
  default     = "info"
}

variable "controller_image_tag" {
  description = "The tag of the controller container. If not specified, it's the appVersion inside Chart.yaml"
  type        = string
  default     = ""
}
