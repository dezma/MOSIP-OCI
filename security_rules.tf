

resource "oci_core_network_security_group_security_rule" "console_network_security_group_security_rule_1" {
  network_security_group_id = oci_core_network_security_group.console_network_security_group.id

  direction   = "EGRESS"
  protocol    = "all"
  destination = "0.0.0.0/0"
}


resource "oci_core_network_security_group_security_rule" "console_network_security_group_security_rule_2" {
  network_security_group_id = oci_core_network_security_group.console_network_security_group.id

  direction   = "INGRESS"
  protocol    = "all"
  source = var.VCN_CIDR
}



resource "oci_core_network_security_group_security_rule" "console_network_security_group_security_rule_3" {
  network_security_group_id = oci_core_network_security_group.console_network_security_group.id
  protocol                  = "6"
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"


  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_network_security_group_security_rule" "console_network_security_group_security_rule_4" {
  network_security_group_id = oci_core_network_security_group.console_network_security_group.id
  protocol                  = "6"
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"


  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_network_security_group_security_rule" "console_network_security_group_security_rule_5" {
  network_security_group_id = oci_core_network_security_group.console_network_security_group.id
  protocol                  = "6"
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"


  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
}

resource "oci_core_network_security_group_security_rule" "console_network_security_group_security_rule_6" {
  network_security_group_id = oci_core_network_security_group.console_network_security_group.id
  protocol                  = "6"
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"


  tcp_options {
    destination_port_range {
      min =  30090
      max =  30090
    }
  }
}

resource "oci_core_network_security_group_security_rule" "console_network_security_group_security_rule_7" {
  network_security_group_id = oci_core_network_security_group.console_network_security_group.id
  protocol                  = "6"
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"


  tcp_options {
    destination_port_range {
      min =  30616
      max =  30616
    }
  }
}


resource "oci_core_network_security_group_security_rule" "console_network_security_group_security_rule_8" {
  network_security_group_id = oci_core_network_security_group.console_network_security_group.id
  protocol                  = "1"
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"


  # icmp_options {
  #       #Required
  #       type = "all"

     
  #   }
}

resource "oci_core_network_security_group_security_rule" "kube_network_security_group_security_rule_1" {
  network_security_group_id = oci_core_network_security_group.kube_network_security_group.id
  protocol                  = "1"
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"


  # icmp_options {
  #       #Required
  #       type = "all"

     
  #   }
}

resource "oci_core_network_security_group_security_rule" "kube_network_security_group_security_rule_2" {
  network_security_group_id = oci_core_network_security_group.kube_network_security_group.id

  direction   = "EGRESS"
  protocol    = "all"
  destination = "0.0.0.0/0"
}

resource "oci_core_network_security_group_security_rule" "kube_network_security_group_security_rule_3" {
  network_security_group_id = oci_core_network_security_group.kube_network_security_group.id

  direction   = "INGRESS"
  protocol    = "all"
  source = var.VCN_CIDR
}

resource "oci_core_network_security_group_security_rule" "kube_network_security_group_security_rule_4" {
  network_security_group_id = oci_core_network_security_group.kube_network_security_group.id
  protocol                  = "6"
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"


  tcp_options {
    source_port_range {
      min = 22
      max = 22
    }
  }
}



