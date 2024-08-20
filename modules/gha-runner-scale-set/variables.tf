############################
##### Chart Variables ######
############################
variable "release_name" {
  description = "Helm release name."
  type        = string
  default     = "arc-runner-set"
}

variable "chart_name" {
  description = "Helm chart name to provision."
  type        = string
  default     = "gha-runner-scale-set"
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
  default     = "arc-runners"
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
#  Values For Runner Set
##################################
variable "github_config_url" {
  description = "githubConfigUrl is the GitHub url for where you want to configure runners"
  type        = string
  default     = "https://github.com/enterprises/singapore-press-holdings"
}

variable "github_token" {
  description = "Set Github PAT Token"
  type        = string
  default     = ""
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

variable "container_mode_type" {
  description = "Set container type mode"
  type        = string
  default     = "dind"
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

variable "min_runners" {
  description = "Minimum number of replicas of the runner set."
  type        = number
  default     = 1
}

variable "max_runners" {
  description = "Maxium number of replicas of the runner set."
  type        = number
  default     = 3
}

variable "runner_group" {
  description = "Runner group name"
  type        = string
  default     = "arc-runner-set"
}

variable "runner_scale_set_name" {
  description = "Runner scale set name"
  type        = string
  default     = "arc-runner-set"
}

variable "listener_podspec_map" {
  description = "Listener podspec map"
  type = object({
    metadata = any
    spec     = any
  })
  default = {
    metadata = {
      annotations = {
        "prometheus.io/scrape" = "true"
        "prometheus.io/path"   = "/metrics"
        "prometheus.io/port"   = "8080"
      }
      labels = {}
    }
    spec = {
      containers = [
        {
          name = "listener"
        }
      ]
    }
  }
}

# Default spec map for dind container mode
variable "custom_podspec_map" {
  description = "Custom podspec map"
  type = object({
    metadata = any
    spec     = any
  })
  default = {
    metadata = {
      labels = {
      }
    }
    spec = {
      # imagePullSecrets = [
      #   {
      #     name = "regcred"
      #   }
      # ]
      initContainers = [
        {
          name    = "init-dind-externals",
          image   = "206977323828.dkr.ecr.ap-southeast-1.amazonaws.com/ghcr/actions/actions-runner:latest",
          command = ["cp", "-r", "-v", "/home/runner/externals/.", "/home/runner/tmpDir/"],
          volumeMounts = [
            {
              name      = "dind-externals",
              mountPath = "/home/runner/tmpDir"
            }
          ]
        }
      ]
      topology_spread_constraints = []

      tolerations = []
      affinity    = {}
      containers = [
        {
          name    = "runner",
          image   = "206977323828.dkr.ecr.ap-southeast-1.amazonaws.com/ghcr/actions/actions-runner:latest",
          command = ["/home/runner/run.sh"],
          env = [
            {
              name  = "DOCKER_HOST",
              value = "unix:///var/run/docker.sock"
            }
          ],
          volumeMounts = [
            {
              name      = "work",
              mountPath = "/home/runner/_work"
            },
            {
              name      = "dind-sock",
              mountPath = "/var/run",
              readOnly  = true
            }
          ]
        },
        {
          name  = "dind",
          image = "206977323828.dkr.ecr.ap-southeast-1.amazonaws.com/docker-hub/library/docker:dind",
          args  = ["dockerd", "--host=unix:///var/run/docker.sock", "--group=$(DOCKER_GROUP_GID)"],
          env = [
            {
              name  = "DOCKER_GROUP_GID",
              value = "123"
            }
          ],
          securityContext = {
            privileged = true
          },
          volumeMounts = [
            {
              name      = "work",
              mountPath = "/home/runner/_work"
            },
            {
              name      = "dind-sock",
              mountPath = "/run/docker"
            },
            {
              name      = "dind-externals",
              mountPath = "/home/runner/externals"
            }
          ]
        }
      ],
      volumes = [
        {
          name     = "work",
          emptyDir = {}
        },
        {
          name     = "dind-sock",
          emptyDir = {}
        },
        {
          name     = "dind-externals",
          emptyDir = {}
        }
      ]
    }
  }

}

variable "controller_service_account" {
  description = "Service account for the controller."
  type        = map(any)
  default = {
    namespace = "arc-systems"
    name      = "actions-runner-controller"
  }
}
