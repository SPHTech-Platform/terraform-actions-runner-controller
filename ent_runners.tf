resource "kubernetes_manifest" "github_ent_runners" {
  for_each = { for ent in var.github_ent_runners : ent.name => ent }

  manifest = {
    apiVersion = "actions.summerwind.dev/v1alpha1"
    kind       = "RunnerDeployment"

    metadata = {
      name      = "${lower(each.value.name)}-runner-deployment"
      namespace = helm_release.release.namespace
    }

    spec = {
      template = {
        spec = {
          enterprise         = each.value.name
          serviceAccountName = var.service_account_name
          group              = each.value.group
          imagePullPolicy    = "IfNotPresent"
          securityContext = {
            fsGroup = 1000
          }
          labels      = [each.value.label]
          resources   = each.value.resources
          tolerations = each.value.tolerations
          affinity    = each.value.affinity
        }
      }
    }
  }
}

resource "kubernetes_manifest" "github_ent_runners_horizontal_autoscaler" {
  for_each = { for ent in var.github_ent_runners : ent.name => ent }

  manifest = {
    apiVersion = "actions.summerwind.dev/v1alpha1"
    kind       = "HorizontalRunnerAutoscaler"

    metadata = {
      name      = "${lower(each.value.name)}-runner-deployment"
      namespace = helm_release.release.namespace
    }

    spec = {
      minReplicas = each.value.min_replicas
      maxReplicas = each.value.max_replicas
      scaleTargetRef = {
        kind = "RunnerDeployment"
        name = "${lower(each.value.name)}-runner-deployment"
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
}