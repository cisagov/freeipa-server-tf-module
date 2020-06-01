# cloud-init commands for configuring a freeipa master

data "template_cloudinit_config" "cloud_init_tasks" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/cloud-init/setup_freeipa.sh", {
        admin_pw             = var.admin_pw
        directory_service_pw = var.directory_service_pw
        domain               = var.domain
        hostname             = var.hostname
        realm                = var.realm
    })
  }
}
