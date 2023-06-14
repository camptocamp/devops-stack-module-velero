locals {
  helm_values = [{
    velero = {
      initContainers = [{
        name  = "velero-plugin-for-aws"
        image = "velero/velero-plugin-for-aws"
        volumeMounts = [{
          name      = "plugins"
          mountPath = "/target"
        }]
      }]
      snapshotsEnabled = true
    }
  }]
}
