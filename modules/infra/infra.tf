locals {

  infra_name = "terraform"
  datacenter = "${var.datacenter}"
  path_to_generated_azure_properties = "${var.path_in_consul}/${data.consul_keys.conf.var.path_to_generated_azure_properties}"
}

resource "azurerm_resource_group" "main" {
  name     = "${local.infra_name}-resources"
  location = "westeurope"
}

resource "azurerm_virtual_network" "main" {
  name                = "${local.infra_name}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.2.0/24"
}
