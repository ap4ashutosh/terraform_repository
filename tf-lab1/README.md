# LAB 1 creating an infra using IaC

# AWS VPC Terraform Lab

## Overview

This Terraform project sets up a comprehensive Virtual Private Cloud (VPC) infrastructure in AWS. It demonstrates the use of Terraform to create a scalable and secure network architecture.

## Architecture
![The architecture of infrastructure](https://github.com/ap4ashutosh/terraform_repository/blob/main/tf-lab1/diagram-export-7-4-2024-10_34_38-PM.png)

The infrastructure includes:

1. A custom VPC
2. Multiple public and private subnets across different Availability Zones
3. An Internet Gateway for public internet access
4. A NAT Gateway for outbound internet access from private subnets
5. Separate route tables for public and private subnets

## Components

### VPC
- Custom CIDR block
- DNS hostnames enabled
- DNS support enabled

### Subnets
- Public subnets with auto-assign public IP enabled
- Private subnets for internal resources
- Distributed across multiple Availability Zones for high availability

### Internet Gateway
- Attached to the VPC to allow public internet access

### NAT Gateway
- Placed in a public subnet
- Allows outbound internet access for resources in private subnets

### Route Tables
- Public route table with route to Internet Gateway
- Private route table with route to NAT Gateway

### Elastic IP
- Associated with the NAT Gateway

## Usage

1. Ensure you have Terraform installed and AWS credentials configured.
2. Clone this repository.
3. Navigate to the project directory.
4. Initialize Terraform: