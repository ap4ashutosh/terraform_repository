# Here in this lab we will install the AWS provider

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 3.0"
        }
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= 2.0"
        }
        random = {
            source = "hashicorp/random"
        }
    }
}