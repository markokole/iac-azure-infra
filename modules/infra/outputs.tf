output "resource_group_name" {
    value = "${azurerm_resource_group.main.name}"
}

output "resource_group_id" {
    value = "${azurerm_resource_group.main.id}"
}

output "location" {
    value = "${azurerm_resource_group.main.location}"
}

output "subnet_id" {
    value = "${azurerm_subnet.internal.id}"
}