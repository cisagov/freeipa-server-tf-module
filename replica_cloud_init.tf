# cloud-init commands for configuring a freeipa replica

data "template_cloudinit_config" "replica_cloud_init_tasks" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/scripts/setup_freeipa_replica.sh", {
        admin_pw = var.admin_pw
        hostname = var.hostname
    })
  }
}
