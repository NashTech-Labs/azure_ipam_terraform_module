variable "azure_client_id" {
  description = "Service Principal Client id details"
}
variable "azure_client_secret" {
  description = "Service Principal Client Secrets details"
}
variable "azure_tenant_id" {
  description = "Service Principal tenant id details"
}

variable "azure_subscription_id" {
  description = "Service Principal subsription id details"
}

variable "ipam_url" {
  description = "URL of IPAM instance"
}

variable "ipam_apiId" {
  description = "api ID of IPAM instance"
}

variable "space" {
  description = "name of the existing space in the IPAM application."
}

variable "block" {
  description = "name of the existing block, related to the specified space, in which the reservation is to be made."
}

variable "size" {
  description = "subnet mask bits, which defines the size of the vnet to reserve"
}

variable "description" {
  description = "description text that describe the reservation,"
}

variable "vnet_name" {
  description = "Name of the VNet which will be created"
}

variable "rg_name" {
  description = "Name of the Resource Group"
}

variable "rg_location" {
  description = "Location of the Resource Group"
}