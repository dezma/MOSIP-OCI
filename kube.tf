resource "oci_core_instance" "kube" {
  for_each      = var.kube_names 
  availability_domain = var.availablity_domain_name == "" ? data.oci_identity_availability_domains.ADs.availability_domains[0]["name"] : var.availablity_domain_name
  compartment_id      = var.compartment_id
  display_name        = each.key
  shape               = var.instance_shape
  fault_domain        = "FAULT-DOMAIN-1"



  
  preserve_boot_volume = false

  shape_config {
    ocpus         = var.instance_ocpus
    memory_in_gbs = var.instance_shape_config_memory_in_gbs
  }

  metadata = {
    ssh_authorized_keys = file(lookup(var.public_key, "local_path"))
    //ssh_authorized_keys = var.ssh_public_key == "" ? tls_private_key.public_private_key_pair.public_key_openssh : var.ssh_public_key
  }

  create_vnic_details {


    subnet_id                 = oci_core_subnet.private_subnet.id
    display_name              = "primaryvnic"
    private_ip                = each.value
   // hostname_label            = var.hosted_domain_name
 //   nsg_ids                   = oci_core_network_security_group.kube_network_security_group.id
    assign_public_ip          = true
  
  }
 

  source_details {
    source_type             = "image"
    source_id               = var.install_image
    boot_volume_size_in_gbs = "50"
  }

  provisioner "file" {
    source = "dbkey.pub"
    destination = "/tmp/id_rsa.pub"
    connection {
      type     = "ssh"
      user     = "opc"
      host     =  self.public_ip
      private_key = file(lookup(var.private_key, "local_path"))
    }
  }

  provisioner "file" {
    source = "kube_auth.sh"
    destination = "/tmp/kube_auth.sh"
    connection {
      type     = "ssh"
      user     = "opc"
      host     =  self.public_ip
      private_key = file(lookup(var.private_key, "local_path"))
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/kube_auth.sh",
      format("%s %s", "sudo /tmp/kube_auth.sh", each.key)
    ]
  }
    connection {
      type     = "ssh"
      user     = "opc"
      host     =  self.public_ip
      private_key = file(lookup(var.private_key, "local_path"))
    }

  depends_on =  [oci_core_network_security_group.kube_network_security_group]

}




