terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">= 0.9.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.74.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "azuredevops" {
  # Configuration options
  org_service_url = ""
  personal_access_token = ""
}

provider "azurerm" {
  # Configuration options
}