resource "kubernetes_manifest" "github_ent_runners_dind_rootless" {
  for_each = { for ent in var.github_ent_runners_dind_rootless : ent.label => ent }

  manifest = {
    apiVersion = "actions.summerwind.dev/v1alpha1"
    kind       = "RunnerDeployment"

    metadata = {
      name      = "${lower(each.value.label)}-runner-deployment"
      namespace = helm_release.release.namespace
    }

    spec = {
      template = {
        spec = {
          enterprise = each.value.name
          initContainers = [
            {
              command = ["sh", "-c", "cat /home/runner/config.json > /home/runner/.docker/config.json"]
              image   = "alpine"
              securityContext = {
                fsGroup = 1000
              }
              name = "dockerconfigwriter"
              volumeMounts = [
                {
                  mountPath = "/home/runner/config.json"
                  subPath   = "config.json"
                  name      = "docker-secret"
                },
                {
                  mountPath = "/home/runner/.docker"
                  name      = "docker-config-volume"
                },
              ]
            }
          ]
          dockerdWithinRunnerContainer = true
          image                        = "summerwind/actions-runner-dind-rootless"
          serviceAccountName           = var.service_account_name
          group                        = each.value.group
          imagePullPolicy              = "IfNotPresent"
          labels                       = [each.value.label]
          resources                    = each.value.resources
          tolerations                  = each.value.tolerations
          affinity                     = each.value.affinity
          volumeMounts = [
            {
              mountPath = "/home/runner/config.json"
              subPath   = "config.json"
              name      = "docker-secret"
            },
            {
              mountPath = "/home/runner/.docker"
              name      = "docker-config-volume"
            },
          ]
          volumes = [
            {
              name = "docker-secret"
              secret = {
                secretName = "regcred"
                items = [
                  {
                    key  = ".dockerconfigjson"
                    path = "config.json"
                  }
                ]
              }
            },
            {
              name     = "docker-config-volume"
              emptyDir = {}
            },
          ]

        }
      }
    }
  }

  depends_on = [
    helm_release.release
  ]
}

resource "kubernetes_manifest" "github_ent_runners_horizontal_autoscaler_dind_rootless" {
  for_each = { for ent in var.github_ent_runners_dind_rootless : ent.label => ent }

  manifest = {
    apiVersion = "actions.summerwind.dev/v1alpha1"
    kind       = "HorizontalRunnerAutoscaler"

    metadata = {
      name      = "${lower(each.value.label)}-runner-deployment"
      namespace = helm_release.release.namespace
    }

    spec = {
      minReplicas = each.value.min_replicas
      maxReplicas = each.value.max_replicas
      scaleTargetRef = {
        kind = "RunnerDeployment"
        name = "${lower(each.value.label)}-runner-deployment"
      }
      scaleUpTriggers = [
        {
          githubEvent = {
            workflowJob = {}
          }
          duration = each.value.scale_up_trigger_duration
        },
      ]
    }
  }

  field_manager {
    force_conflicts = true
  }

  depends_on = [
    helm_release.release
  ]
}
