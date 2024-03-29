#######################
## Standard variables
#######################

variable "cluster_name" {
  description = "Name given to the cluster. Value used for naming some the resources created by the module."
  type        = string
}

variable "base_domain" {
  description = "Base domain of the cluster. Value used for the ingress' URL of the application."
  type        = string
}

variable "argocd_namespace" {
  description = "Namespace used by Argo CD where the Application and AppProject resources should be created."
  type        = string
  default     = "argocd"
}

variable "target_revision" {
  description = "Override of target revision of the application chart."
  type        = string
  default     = "v1.0.1" # x-release-please-version
}

variable "cluster_issuer" {
  description = "SSL certificate issuer to use. Usually you would configure this value as `letsencrypt-staging` or `letsencrypt-prod` on your root `*.tf` files."
  type        = string
  default     = "ca-issuer"
}

variable "namespace" {
  description = "Namespace where the applications's Kubernetes resources should be created. Namespace will be created in case it doesn't exist."
  type        = string
  default     = "velero"
}

variable "helm_values" {
  description = "Helm chart value overrides. They should be passed as a list of HCL structures."
  type        = any
  default     = []
}

variable "app_autosync" {
  description = "Automated sync options for the Argo CD Application resource."
  type = object({
    allow_empty = optional(bool)
    prune       = optional(bool)
    self_heal   = optional(bool)
  })
  default = {
    allow_empty = false
    prune       = true
    self_heal   = true
  }
}

variable "dependency_ids" {
  description = "IDs of the other modules on which this module depends on."
  type        = map(string)
  default     = {}
}

#######################
## Module variables
#######################

variable "backup_schedules" {
  description = "TBD" # TODO: do
  type = map(object({
    disabled    = optional(bool, false)
    labels      = optional(map(string), {})
    annotations = optional(map(string), {})
    schedule    = string
    template = object({
      # labels             = optional(map(string), {}) # TODO: test
      # annotations        = optional(map(string), {}) # TODO: test
      storageLocation    = optional(string)
      ttl                = optional(string)
      includedNamespaces = list(string)
      includedResources  = list(string)
      # enableSnapshot     = optional(bool, true)
    })
  }))
  default = null
}

variable "enable_monitoring_dashboard" {
  description = "Boolean to enable the provisioning of a Velero dashboard for Grafana."
  type        = bool
  default     = true
}

variable "alert_partially_failed_ratio" {
  description = "Percentage of partially failed backups before triggering a Prometheus alert"
  type        = number
  default     = 0.25
}

variable "alert_failed_ratio" {
  description = "Percentage of failed backups before triggering a Prometheus alert"
  type        = number
  default     = 0.25
}

variable "alert_backup_timeout" {
  description = "Timeout in seconds before triggering the last successful backup alert"
  type        = number
  default     = 60 * 60 * 24
}
