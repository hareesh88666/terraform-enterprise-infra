# Enterprise VPC Module (vpc-enterprise)

## Purpose
This module creates an enterprise-grade VPC with options for public/private subnets, NAT Gateways, Flow Logs, DHCP options, and standard tagging. It's designed to be reusable across environments (dev/qa/stage/prod).

## Features
- Custom CIDR block
- Multiple public / private subnets (AZ-aware)
- Internet Gateway + NAT Gateway(s)
- Route tables for public and private subnets
- Optional VPC Flow Logs
- Optional DHCP options
- Standardized tagging

## Example usage

```hcl
module "vpc" {
  source = "../../modules/vpc-enterprise"

  cidr_block = "10.10.0.0/16"
  public_subnet_cidrs  = ["10.10.101.0/24", "10.10.102.0/24"]
  private_subnet_cidrs = ["10.10.1.0/24", "10.10.2.0/24"]
  availability_zones   = ["ap-south-1a", "ap-south-1b"]
  create_nat_gateway   = true
  nat_gateway_count    = 2
  environment          = "dev"
  name_suffix          = "healthcare"
  tags = {
    Project = "healthcare-platform"
    Owner   = "platform-team"
  }
}
```

## Notes
- For production, set `nat_gateway_count` equal to number of AZs for high availability.
- Provide `flow_log_iam_role_arn` and `flow_log_destination` if enabling flow logs.
