# Variables
variable "az_region" {
  description = "The region to deploy the CTF lab"
  type        = string
  default     = "Southeast Asia"
}

variable "subscription_id" {
  description = "Your Azure Subscription ID"
  type        = string
}

variable "az_rg_name" {
  description = "Your Azure Resource Group Name"
  type        = string
}

variable "az_vm_nsg_name" {
  description = "Your Azure NSG Name"
  type        = string
}

variable "az_vm_vnet_name" {
  description = "Your Azure Virtual Network Name"
  type        = string
}

variable "az_vm_subnet_name" {
  description = "Your Azure Subnet Name"
  type        = string
}

variable "az_vm_ip_name" {
  description = "Your Azure Public IP Name"
  type        = string
}

variable "az_vm_ntc_name" {
  description = "Your Azure NTC Name"
  type        = string
}

variable "az_vm_name" {
  description = "Your Azure VM Name"
  type        = string
}