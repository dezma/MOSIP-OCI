## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# This Terraform script provisions a compute instance


resource "oci_core_instance" "console" {
  availability_domain = var.availablity_domain_name == "" ? data.oci_identity_availability_domains.ADs.availability_domains[0]["name"] : var.availablity_domain_name
  compartment_id      = var.compartment_id
  display_name        = lookup(var.console_name, "name")
  shape               = var.instance_shape
  fault_domain        = "FAULT-DOMAIN-1"
  preserve_boot_volume = false
  shape_config {
    ocpus        = var.instance_ocpus
    memory_in_gbs = var.instance_shape_config_memory_in_gbs
  }
  metadata = {

    ssh_authorized_keys = file(lookup(var.public_key, "local_path"))
  //  ssh_authorized_keys = var.ssh_public_key == "" ? tls_private_key.public_private_key_pair.public_key_openssh : var.ssh_public_key
  }
  create_vnic_details {
    subnet_id                 = oci_core_subnet.private_subnet.id
    display_name              = "primaryvnic"
    private_ip = lookup(var.console_name, "private_ip")
    //hostname_label = var.hosted_domain_name
   // nsg_ids = oci_core_network_security_group.console_network_security_group.id
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
    source = "private_key"
    destination = "/tmp/id_rsa"
    connection {
      type     = "ssh"
      user     = "opc"
      host     =  self.public_ip
      private_key = file(lookup(var.private_key, "local_path"))
    }
  }

  provisioner "file" {
    source = "console_auth.sh"
    destination = "/tmp/console_auth.sh"
    connection {
      type     = "ssh"
      user     = "opc"
      host     =  self.public_ip
      private_key = file(lookup(var.private_key, "local_path"))
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/console_auth.sh",
      format("%s %s", "sudo /tmp/console_auth.sh", lookup(var.console_name, "name"))
    ]
  }
    connection {
      type     = "ssh"
      user     = "opc"
      host     =  self.public_ip
      private_key = file(lookup(var.private_key, "local_path"))
    }

  depends_on  =  [oci_core_network_security_group.console_network_security_group] 
}
resource "oci_core_volume" "console_block_volume" {
  availability_domain = var.availablity_domain_name == "" ? data.oci_identity_availability_domains.ADs.availability_domains[0]["name"] : var.availablity_domain_name
  compartment_id      = var.compartment_id
  display_name        = var.console_volume_display_name
  size_in_gbs         = var.console_volume_size_in_gbs
  vpus_per_gb         = var.console_volume_vpus_per_gb
}
resource "oci_core_volume_attachment" "console_block_attach" {
  attachment_type = "iscsi"
  instance_id     = "${oci_core_instance.console.id}"
  //device          =  "/dev/sdf"
  is_shareable = var.volume_attachment_is_shareable
  volume_id       = "${oci_core_volume.console_block_volume.id}"  
  connection {
    type        = "ssh"
    host        = "${oci_core_instance.console.public_ip}"
    user        = "opc"
   // private_key = "${file("~/.ssh/id_rsa")}"

    private_key = file(lookup(var.private_key, "local_path"))
  }  
  provisioner "remote-exec" {
    inline = [
      "sudo iscsiadm -m node -o new -T ${self.iqn} -p ${self.ipv4}:${self.port}",
      "sudo iscsiadm -m node -o update -T ${self.iqn} -n node.startup -v automatic",
      "sudo iscsiadm -m node -T ${self.iqn} -p ${self.ipv4}:${self.port} -l",
    ]
  }
  # provisioner "remote-exec" {
  #   when       = "destroy"
  #   on_failure = "continue"    
  #   cdinline = [
  #     "sudo iscsiadm -m node -T ${self.iqn} -p ${self.ipv4}:${self.port} -u",
  #     "sudo iscsiadm -m node -o delete -T ${self.iqn} -p ${self.ipv4}:${self.port}",
  #   ]
  # }
}



