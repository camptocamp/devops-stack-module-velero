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
        prometheusRule = {
          enabled = true
          spec = [
            {
              alert = "VeleroBackupPartialFailures"
              annotations = {
                message = "Velero backup {{ $labels.schedule }} has {{ $value | humanizePercentage }} partially failed backups."
              }
              expr = "velero_backup_partial_failure_total{schedule!=\"\"} / velero_backup_attempt_total{schedule!=\"\"} > 0.25"
              for  = "15m"
              labels = {
                severity = "warning"
              }
            },
            {
              alert = "VeleroBackupFailures"
              annotations = {
                message = "Velero backup {{ $labels.schedule }} has {{ $value | humanizePercentage }} failed backups."
              }
              expr = "velero_backup_partial_failure_total{schedule!=\"\"} / velero_backup_attempt_total{schedule!=\"\"} > 0.25"
              for  = "15m"
              labels = {
                severity = "warning"
              }
            }
          ]
        }
      }
    }
    grafana_dashboard = {
      enabled = false
    }
  }]
}
