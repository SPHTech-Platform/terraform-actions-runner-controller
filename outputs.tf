output "helm_release" {
  description = "Output of the helm release"
  value       = helm_release.release
}

output "org_runners" {
  description = "Output of Github Org Runners"
  value       = helm_release.github_org_runners
}
