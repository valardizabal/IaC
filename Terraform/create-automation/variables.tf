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

variable "az_aa_name" {
  description = "Your Azure Automation Account Name"
  type        = string
}

variable "az_st_name" {
  description = "Your Azure Storage Account Name"
  type        = string
}

variable "az_rb_name" {
  description = "Your Azure Automaion Run Book Name"
  type        = string
}