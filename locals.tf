locals {
  helm_values = [{
    velero = {
      namespace = "${var.namespace}"
      snapshotsEnabled = true
    }
  }]
}
