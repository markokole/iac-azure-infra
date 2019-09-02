variable "path_in_consul" {
  default   = "test/master/azure"
}

variable "consul_server" {
  default   = "34.200.245.90"
}

variable "consul_port" {
  default   = "8500"
}

variable "datacenter" {
  default   = "dc1"
}

data "consul_keys" "conf" {
    key {
    name    = "path_to_generated_azure_properties"
    path    = "${var.path_in_consul}/path_to_generated_azure_properties"
  }
}