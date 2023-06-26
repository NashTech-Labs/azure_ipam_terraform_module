locals {
  ipam_url   = var.ipam_url
  ipam_apiId = var.ipam_apiId #ApplicationId of the Engine Azure AD Application, see also the [IPAM deployment documentation](https://github.com/Azure/ipam/tree/main/docs/deployment)
}

## Get an access token for ipam engine application
data "external" "get_access_token" {
  program = ["az", "account", "get-access-token", "--resource", "api://${local.ipam_apiId}"]
}

# Create an ipam reservation
resource "azureipam_reservation" "multiclient-vnet" {
  space = var.space
  block = var.block
  size  = var.size
  description = var.description
}


module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = azureipam_reservation.multiclient-vnet.cidr
  networks = [
    {
      name     = "iac-subnet-a"
      new_bits = 8
    },
    {
      name     = "iac-subnet-b"
      new_bits = 8
    },
  ]
}

# Deploy the azurerm vnet
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  address_space = [azureipam_reservation.multiclient-vnet.cidr]
  tags          = azureipam_reservation.multiclient-vnet.tags ##add the auto-generated `X-IPAM-RES-ID` tag to the vnet.

  dynamic "subnet" {
    for_each = module.subnet_addrs.networks
    content {
      name           = subnet.value["name"]
      address_prefix = subnet.value["cidr_block"]
    }
  }
}
