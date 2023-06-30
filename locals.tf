locals {
  helm_values = [{
    velero = {
      namespace        = "${var.namespace}"
      snapshotsEnabled = true
    }
    grafana_dashboard = {
      enabled = false
    }
  }]
}
