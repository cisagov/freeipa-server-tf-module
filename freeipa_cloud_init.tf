# cloud-init commands for configuring ssh and the report volume

# data "template_file" "freeipa_disk_setup" {
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

data "template_file" "set_hostname" {
  template = file("${path.module}/scripts/set_hostname.sh")
}

data "template_cloudinit_config" "freeipa_cloud_init_tasks" {
  gzip          = true
  base64_encode = true

  # part {
  #   content_type = "text/x-shellscript"
  #   content      = data.template_file.freeipa_disk_setup.rendered
  # }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.set_hostname.rendered
  }
}
