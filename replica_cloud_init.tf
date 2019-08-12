# cloud-init commands for configuring a freeipa replica

data "template_cloudinit_config" "replica_cloud_init_tasks" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/scripts/setup_freeipa_replica.sh", {
        directory_service_pw = var.directory_service_pw
        admin_pw             = var.admin_pw
        domain               = var.domain
        hostname             = var.hostname
        realm                = var.realm
    })
  }
}
