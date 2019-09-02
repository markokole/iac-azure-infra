# Write values to consul
resource "consul_keys" "app" {
  datacenter = "${local.datacenter}"

  key {
    path  = "${local.path_to_generated_azure_properties}/resource_group_name"
    value = "${azurerm_resource_group.main.name}"
  }

  key {
    path = "${local.path_to_generated_azure_properties}/virtual_network_id"
    value = "${azurerm_virtual_network.main.id}"
  }

  key {
    path = "${local.path_to_generated_azure_properties}/subnet_id"
    value = "${azurerm_subnet.internal.id}"
  }
}