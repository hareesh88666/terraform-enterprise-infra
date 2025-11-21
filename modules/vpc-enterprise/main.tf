terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
  required_version = ">= 1.3.0"
}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(var.tags, { "Name" = "${var.environment}-${var.name_suffix}-vpc" })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = merge(var.tags, { "Name" = "${var.environment}-${var.name_suffix}-igw" })
}

resource "aws_eip" "nat" {
  count = var.create_nat_gateway && var.nat_gateway_count > 0 ? var.nat_gateway_count : 0
  vpc   = true
  tags  = merge(var.tags, { "Name" = "${var.environment}-${var.name_suffix}-nat-eip-${count.index}" })
}

resource "aws_nat_gateway" "this" {
  count         = var.create_nat_gateway && var.nat_gateway_count > 0 ? var.nat_gateway_count : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(aws_subnet.public[*].id, count.index % length(aws_subnet.public[*].id))
  tags          = merge(var.tags, { "Name" = "${var.environment}-${var.name_suffix}-nat-${count.index}" })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags   = merge(var.tags, { "Name" = "${var.environment}-${var.name_suffix}-public-rt" })
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table" "private" {
  count  = length(aws_subnet.private) > 0 ? length(aws_subnet.private) : 0
  vpc_id = aws_vpc.this.id
  tags   = merge(var.tags, { "Name" = "${var.environment}-${var.name_suffix}-private-rt-${count.index}" })
}

resource "aws_route" "private_nat_route" {
  count                   = length(aws_route_table.private) > 0 && length(aws_nat_gateway.this) > 0 ? length(aws_route_table.private) : 0
  route_table_id          = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id          = element(aws_nat_gateway.this.*.id, count.index % length(aws_nat_gateway.this.*.id))
  depends_on              = [aws_nat_gateway.this]
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = length(var.availability_zones) > 0 ? element(var.availability_zones, count.index % length(var.availability_zones)) : null
  map_public_ip_on_launch = true
  tags = merge(var.tags, { "Name" = "${var.environment}-${var.name_suffix}-public-${count.index}" })
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = length(var.availability_zones) > 0 ? element(var.availability_zones, count.index % length(var.availability_zones)) : null
  map_public_ip_on_launch = false
  tags = merge(var.tags, { "Name" = "${var.environment}-${var.name_suffix}-private-${count.index}" })
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_assoc" {
  count          = length(aws_subnet.private)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
  # associate each private subnet with a private RT (could be 1:1 or shared)
}

resource "aws_flow_log" "vpc_flow" {
  count           = var.create_flow_logs ? 1 : 0
  vpc_id          = aws_vpc.this.id
  iam_role_arn    = var.flow_log_iam_role_arn
  traffic_type    = var.flow_log_traffic_type
  log_destination = var.flow_log_destination
  tags            = merge(var.tags, { "Name" = "${var.environment}-${var.name_suffix}-flowlog" })
}

# Optional DHCP options association
resource "aws_vpc_dhcp_options" "this" {
  count = var.create_dhcp_options ? 1 : 0
  domain_name_servers = var.dhcp_domain_name_servers
  tags = merge(var.tags, { "Name" = "${var.environment}-${var.name_suffix}-dhcp" })
}

resource "aws_vpc_dhcp_options_association" "this" {
  count = var.create_dhcp_options ? 1 : 0
  vpc_id = aws_vpc.this.id
  dhcp_options_id = aws_vpc_dhcp_options.this[0].id
}
