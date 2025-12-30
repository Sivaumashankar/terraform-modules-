data "aws_availability_zones" "available" {
state = "available"
  
}
data "aws_vpc" "default_vpc" {
  default = true
}
#terraform data source aws_route_table main route table
data "aws_route_table" "main" {
  vpc_id = local.default_vpc
  filter {
    name = "association.main"
    values = ["true"]
  }
}
