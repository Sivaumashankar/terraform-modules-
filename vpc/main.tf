resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "dedicated"
  enable_dns_hostnames = var.enable_dns_hostnames
    
    #expense-dev
  tags = merge(
    var.commontags,
    var.vpc_tags,
    {
        Name= local.resource_name
    }
  )
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.aws_internet_gateway_tag,
    var.commontags,{
        Name= local.resource_name
    }
  )
}

#subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
 map_public_ip_on_launch = true
 availability_zone = local.az_names[count.index]

  tags = merge(
    var.public_subnet_tag,
    var.commontags,
    {
      Name="${local.resource_name}-public-${local.az_names[count.index]}"
    }
  )
}

#private subnet
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
availability_zone = local.az_names[count.index]  
tags = merge(
  var.commontags, var.private_subnet_tags,
  {
    Name= "${local.resource_name}-private-${local.az_names[count.index]}"
  }
)
}

#db subnet
resource "aws_subnet" "db_subnet" {
 vpc_id = aws_vpc.main.id
 count = length(var.db_subnet_cidrs)
 cidr_block = var.db_subnet_cidrs[count.index]
 availability_zone = local.az_names[count.index]
 tags = merge(
  var.commontags,var.db_subnet_tags,
  {
    Name= "${local.resource_name}-db-${local.az_names[count.index]}"
  }
 )
  
}

#route tabel creation  3tabels
#public route
resource "aws_route_table" "public_route_tabel" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.public_route_tabel_tags,
    var.commontags,
    {
      Name= "${local.resource_name}-public"
    }
  )
  
}
#privae route
resource "aws_route_table" "private_route_tabel" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.private_route_tabel_tags,
    var.commontags,
    {
      Name= "${local.resource_name}-private"
    }
  )
}
#db  route
resource "aws_route_table" "db_route_tabel" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.db_route_tabel_tags,
    var.commontags,
    {
      Name= "${local.resource_name}-db"
    }
  )
}

#subnet assosaction with route tabel 
#public
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  route_table_id = aws_route_table.public_route_tabel.id
  subnet_id = aws_subnet.public[count.index].id
  
}
#private
resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.private_route_tabel.id
  count = length(var.private_subnet_cidrs)
  subnet_id = aws_subnet.private_subnet[count.index].id
  
}
#db
resource "aws_route_table_association" "db" {
  route_table_id = aws_route_table.db_route_tabel.id
  count = length(var.db_subnet_cidrs)
  subnet_id = aws_subnet.db_subnet[count.index].id
  
}

#igw attached to public subnets route tabel
resource "aws_route" "public" {
  route_table_id = aws_route_table.public_route_tabel.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}
# elastic ip created
resource "aws_eip" "example" {
  domain = "vpc"
  
}
# nat gateway creation
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.example.id
  #vpc_id = aws_vpc.main.id
  subnet_id =aws_subnet.public[0].id

    tags = merge(
    var.commontags,
    var.nat_gateway_tags,
    {
      Name = local.resource_name
    }
  )
  depends_on = [ aws_internet_gateway.gw ]
}
resource "aws_route" "private" {
  route_table_id            = aws_route_table.private_route_tabel.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw.id
}

resource "aws_route" "database" {
  route_table_id            = aws_route_table.db_route_tabel.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw.id
}



