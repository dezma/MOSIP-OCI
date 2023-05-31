
resource "oci_core_vcn" "mosip_vcn" {
    #Required
    compartment_id = var.compartment_id

    cidr_block = var.VCN_CIDR
    display_name = var.vcn_display_name
    //dns_label = var.vcn_dns_label
}

resource "oci_core_subnet" "private_subnet" {
    #Required
    cidr_block = var.private_subnet
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.mosip_vcn.id

    #Optional
    display_name = var.private_subnet_display_name
    route_table_id = oci_core_route_table.mosip_route_table.id
}


resource "oci_core_internet_gateway" "mosip_ig" {
    compartment_id = var.compartment_id
    display_name   = "${var.vcn_display_name}_gw"
    vcn_id         = oci_core_vcn.mosip_vcn.id
}

resource "oci_core_route_table" "mosip_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.mosip_vcn.id
  display_name   =  "${var.vcn_display_name}_route_table"

  route_rules {
    description       = var.route_table_route_rules_description
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.mosip_ig.id
  }
  
}







