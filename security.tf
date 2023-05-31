resource "oci_core_network_security_group" "console_network_security_group" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.mosip_vcn.id

    #Optional
    display_name = var.console_network_security_group_display_name
    
}


resource "oci_core_network_security_group" "kube_network_security_group" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.mosip_vcn.id

    #Optional
    display_name = var.kube_network_security_group_display_name
    
}