variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "availability_zones" {
  description = "List of AZs to spread subnets across"
  type        = list(string)
  default     = []
}

variable "create_nat_gateway" {
  description = "Whether to create NAT Gateways for private subnets to reach internet"
  type        = bool
  default     = true
}

variable "nat_gateway_count" {
  description = "Number of NAT Gateways to create (usually number of public subnets/AZs)"
  type        = number
  default     = 2
}

variable "create_flow_logs" {
  description = "Whether to enable VPC Flow Logs"
  type        = bool
  default     = false
}

variable "flow_log_iam_role_arn" {
  description = "IAM role ARN for flow logs (if using CloudWatch or Kinesis)"
  type        = string
  default     = ""
}

variable "flow_log_destination" {
  description = "Flow log destination (cloudwatch/log-group arn or kinesis arn)"
  type        = string
  default     = ""
}

variable "flow_log_traffic_type" {
  description = "Type of traffic to capture for flow logs"
  type        = string
  default     = "ALL"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "name_suffix" {
  description = "A short suffix used in resource names (e.g. project, app)"
  type        = string
  default     = "core"
}

variable "environment" {
  description = "Environment label (dev/qa/prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {
    "Owner" = "team-infra"
    "Project" = "terraform-enterprise"
  }
}

variable "create_dhcp_options" {
  description = "Create custom DHCP options and associate with VPC"
  type        = bool
  default     = false
}

variable "dhcp_domain_name_servers" {
  description = "DNS servers for DHCP options"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}
