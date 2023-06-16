output "id" {
  description = "ID to pass other modules in order to refer to this module as a dependency."
  value       = resource.null_resource.this.id
}

output "restic_repo_password" {
  description = "the password to access the restic repositories"
  value       = random_password.restic_repo_password
}
