
variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_id" {
}

variable "availablity_domain_name" {
  default = ""
}
variable "sandbox_name" { 
  default = "mosip" 
}
variable "console_network_security_group_display_name" {

    default = "console_nsg"  
}
variable "volume_attachment_is_shareable" {

    default = "true"  
}
variable "kube_network_security_group_display_name" {

    default = "kube_nsg"  
}


variable "VCN_CIDR" {
  default = "10.20.0.0/16"
}

variable "vcn_display_name" {
  default = "mosip_vcn"
}

variable "private_subnet_display_name" {
  default = "private_subnet"
}

variable "private_subnet" {
  default = "10.20.20.0/24"
}

variable "install_image"{
  default = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaak2j32pigqfpvzcc5mxvo3jhwtna677appkb4vcd3vuongbrsyija"
}

variable "route_table_route_rules_description" {
  default = "description"
}

variable "console_volume_display_name" {
  default = "console_block_volume"
}

variable "console_volume_vpus_per_gb" {
  default = "20"
}

variable "console_volume_size_in_gbs" {
  default = "128"
}


variable "private_key" {
  type = map(string)
  default = {
    "name" = "ssh_private_key" 
    "local_path" = "private_key" // Location on the machine from where you are running terraform
  } 
}

variable "public_key" {
  type = map(string)
  default = {
     
    "local_path" = "dbkey.pub" // Location on the machine from where you are running terraform
  } 
}

/* Recommended not to change names */
variable "console_name" {
  default =  {
    "name" : "console.sb",
    "private_ip": "10.20.20.10"
  }
}

/* Recommended not to change names */
variable "kube_names" {
   type = map(string)

   default = {
     "mzmaster.sb": "10.20.20.99",
     "mzworker0.sb": "10.20.20.100",
     "mzworker1.sb": "10.20.20.101",
     "mzworker2.sb": "10.20.20.102",
     "mzworker3.sb": "10.20.20.103",
     "mzworker4.sb": "10.20.20.104",
     "mzworker5.sb": "10.20.20.105",
     "mzworker6.sb": "10.20.20.106",
     "mzworker7.sb": "10.20.20.107",
     "mzworker8.sb": "10.20.20.108",
     "dmzmaster.sb": "10.20.20.199",
     "dmzworker0.sb": "10.20.20.200"
   }
}

variable "instance_ocpus" {
  default = 2
}

variable "instance_shape" {
  description = "Instance Shape"
  default     = "VM.Standard.E4.Flex"
}

variable "instance_shape_config_memory_in_gbs" {
  default = 8
}
