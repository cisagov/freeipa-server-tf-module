# cloud-init commands for configuring freeipa and its data volume

# data "template_file" "disk_setup" {
#   template = file("${path.module}/scripts/disk_setup.sh")

#   vars = {
#     num_disks     = 2
#     device_name   = "/dev/xvdb"
#     mount_point   = "/var/cyhy/orchestrator/output"
#     label         = "ipa_data"
#     fs_type       = "xfs"
#     mount_options = "defaults"
#   }
# }

data "template_cloudinit_config" "cloud_init_tasks" {
  gzip          = true
  base64_encode = true

  # part {
  #   content_type = "text/x-shellscript"
  #   content      = data.template_file.disk_setup.rendered
  # }

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/scripts/setup_freeipa.sh", {
        directory_service_pw = var.directory_service_pw
        admin_pw             = var.admin_pw
        domain               = var.domain
        hostname             = var.hostname
        realm                = var.realm
    })
  }
}
