output "helm_release" {
  description = "Output of the helm release"
  value       = helm_release.release
}

output "org_runners" {
  description = "Output of Github Org Runners"
  value       = kubernetes_manifest.github_org_runners
}
