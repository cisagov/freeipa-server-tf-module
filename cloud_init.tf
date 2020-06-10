data "template_cloudinit_config" "configure_freeipa" {
  gzip          = true
  base64_encode = true

  #-----------------------------------------------------------------------------
  # Cloud Config parts
  #-----------------------------------------------------------------------------

  # Note: All the cloud-config parts will write to the same file on
  # the instance at boot. To prevent one part from clobbering another,
  # you must specify a merge_type.  See:
  # https://cloudinit.readthedocs.io/en/latest/topics/merging.html#built-in-mergers
  #
  # The filename parameters are only used to identify the mime-part
  # headers in the user-data.

  part {
    filename     = "freeipa-vars.yml"
    content_type = "text/cloud-config"
    content = templatefile(
      "${path.module}/cloud-init/freeipa-vars.tpl.yml", {
        domain   = var.domain
        hostname = var.hostname
        realm    = var.realm
    })
    merge_type = "list(append)+dict(recurse_array)+str()"
  }
}
