terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    azureipam = {
      version = "0.1.1"
      source  = "xtratuscloud/azureipam"
    }
  }
}

provider "azurerm" {
  features {}
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
}

# Configure the Azure IPAM provider
provider "azureipam" {
  api_url = local.ipam_url
  token   = data.external.get_access_token.result.accessToken
}