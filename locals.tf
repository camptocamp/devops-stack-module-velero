locals {
  helm_values = [{
    velero = {
      namespace        = "${var.namespace}"
      snapshotsEnabled = false
      metrics = {
		enabled = true
        serviceMonitor = {
          autodetect = true
          enabled    = true
        }
      }
    }
    grafana_dashboard = {
      enabled = false
    }
  }]
}
