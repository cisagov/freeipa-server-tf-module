# cloud-init commands for configuring a freeipa master

data "template_cloudinit_config" "cloud_init_tasks" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/cloud-init/download-certificates.py", {
        cert_bucket_name   = "cool-certificates"
        cert_read_role_arn = var.cert_read_role_arn
        server_fqdn        = var.hostname
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
    "${path.module}/cloud-init/convert_certificates.sh", {})
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/cloud-init/setup_freeipa.sh", {
        directory_service_pw = var.directory_service_pw
        admin_pw             = var.admin_pw
        domain               = var.domain
        hostname             = var.hostname
        realm                = var.realm
    })
  }
}
