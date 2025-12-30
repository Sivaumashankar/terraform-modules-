locals {
  resource_name = "${var.project}-${var.environment}"
  az_names= slice(data.aws_availability_zones.available.names,0,2)
  default_vpc= data.aws_vpc.default_vpc.id
  default_cidr= data.aws_vpc.default_vpc.cidr_block
} 