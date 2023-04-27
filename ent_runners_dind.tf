resource "kubernetes_manifest" "github_ent_runners_dind" {
  for_each = { for ent in var.github_ent_runners_dind : ent.label => ent }

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
          # dockerdWithinRunnerContainer = true
          # this removes the privilege flag
          dockerdWithinRunnerContainer = true
          image                        = "summerwind/actions-runner-dind"
          serviceAccountName           = var.service_account_name
          group                        = each.value.group
          imagePullPolicy              = "IfNotPresent"
          labels                       = [each.value.label]
          resources                    = each.value.resources
          tolerations                  = each.value.tolerations
          affinity                     = each.value.affinity
          volumeMounts = [
            # {
            #   mountPath = "/home/runner/.docker/config.json"
            #   subPath   = "config.json"
            #   name      = "docker-secret"
            # },
            {
              mountPath = "/home/runner/.docker"
              name      = "docker-config-volume"
            },
          ]
          volumes = [
            # {
            #   name = "docker-secret"
            #   secret = {
            #     secretName = "regcred"
            #     items = [
            #       {
            #         key  = ".dockerconfigjson"
            #         path = "config.json"
            #       }
            #     ]
            #   }
            # },
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

resource "kubernetes_manifest" "github_ent_runners_horizontal_autoscaler_dind" {
  for_each = { for ent in var.github_ent_runners_dind : ent.label => ent }

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

  depends_on = [
    helm_release.release
  ]
}
